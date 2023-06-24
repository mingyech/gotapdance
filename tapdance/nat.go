package tapdance

import (
	"fmt"
	"net"
	"os"
	"syscall"
	"time"

	"github.com/pion/stun"
)

const ttl = 5
const defaultTTL = 64

type fileConn interface {
	File() (*os.File, error)
}

func openUDP(addr *net.UDPAddr) error {
	// Create a UDP connection
	conn, err := dialReuseUDP(addr)
	if err != nil {
		return err
	}

	// Get the file descriptor
	fd, err := conn.(fileConn).File()
	if err != nil {
		return err
	}
	// defer fd.Close()

	// Set the TTL
	err = syscall.SetsockoptInt(int(fd.Fd()), syscall.IPPROTO_IP, syscall.IP_TTL, ttl)
	if err != nil {
		return err
	}

	// Write data to the connection
	_, err = conn.Write([]byte(""))
	if err != nil {
		return err
	}

	// reset TTL
	err = syscall.SetsockoptInt(int(fd.Fd()), syscall.IPPROTO_IP, syscall.IP_TTL, defaultTTL)

	// No error
	return nil
}

var (
	privPortSingle int
	pubPortSingle  int
)

func reconnectUDPAddr(conn *net.UDPConn, addr *net.UDPAddr) error {
	file, err := conn.File()
	if err != nil {
		return fmt.Errorf("failed to get file descriptor: %v", err)
	}

	sa := &syscall.SockaddrInet4{Port: addr.Port}
	copy(sa.Addr[:], addr.IP.To4())

	err = syscall.Connect(int(file.Fd()), sa)
	if err != nil {
		return fmt.Errorf("failed to connect: %v", err)
	}

	return nil
}

func dialReuseUDP(addr *net.UDPAddr) (net.Conn, error) {
	if dialedConn != nil {
		err := reconnectUDPAddr(dialedConn, addr)
		return &reuseUDPConn{conn: dialedConn, raddr: addr}, err
	}

	conn, err := net.DialUDP("udp", nil, addr)
	if err != nil {
		return nil, err
	}

	dialedConn = conn
	return dialedConn, err
}

var dialedConn *net.UDPConn

type reuseUDPConn struct {
	conn  *net.UDPConn
	raddr *net.UDPAddr
}

func (c *reuseUDPConn) Write(b []byte) (int, error) {
	return c.conn.Write(b)
}

func (c *reuseUDPConn) Read(b []byte) (int, error) {
	return c.conn.Read(b)
}

func (c *reuseUDPConn) Close() error {
	return c.conn.Close()
}

func (c *reuseUDPConn) LocalAddr() net.Addr {
	return c.conn.LocalAddr()
}

func (c *reuseUDPConn) RemoteAddr() net.Addr {
	return c.raddr
}

func (c *reuseUDPConn) SetDeadline(t time.Time) error {
	return c.conn.SetDeadline(t)
}

func (c *reuseUDPConn) SetReadDeadline(t time.Time) error {
	return c.conn.SetReadDeadline(t)
}

func (c *reuseUDPConn) SetWriteDeadline(t time.Time) error {
	return c.conn.SetWriteDeadline(t)
}

func (c *reuseUDPConn) File() (*os.File, error) {
	return c.conn.File()
}

func PublicAddr(stunServer string) (privatePort int, publicPort int, err error) {

	if privPortSingle != 0 && pubPortSingle != 0 {
		return privPortSingle, pubPortSingle, nil
	}

	udpAddr, err := net.ResolveUDPAddr("udp", stunServer)
	if err != nil {
		return 0, 0, fmt.Errorf("error resolving UDP address: %v", err)
	}

	udpConn, err := dialReuseUDP(udpAddr)
	if err != nil {
		return 0, 0, fmt.Errorf("error connecting to STUN server: %v", err)
	}

	localAddr, err := net.ResolveUDPAddr(udpConn.LocalAddr().Network(), udpConn.LocalAddr().String())
	if err != nil {
		return 0, 0, fmt.Errorf("error resolving local address: %v", err)
	}

	client, err := stun.NewClient(udpConn)
	if err != nil {
		return 0, 0, fmt.Errorf("error creating STUN client: %v", err)
	}

	message := stun.MustBuild(stun.TransactionID, stun.BindingRequest)

	var xorAddr stun.XORMappedAddress

	err = client.Do(message, func(res stun.Event) {
		if res.Error != nil {
			err = res.Error
			return
		}

		err = xorAddr.GetFrom(res.Message)
		if err != nil {
			return
		}
	})

	if err != nil {
		return 0, 0, fmt.Errorf("error getting address from STUN: %v", err)
	}

	privPortSingle = localAddr.Port
	pubPortSingle = xorAddr.Port

	return localAddr.Port, xorAddr.Port, nil
}
