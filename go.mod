module github.com/refraction-networking/gotapdance

go 1.18

require (
	git.torproject.org/pluggable-transports/goptlib.git v1.3.0
	github.com/flynn/noise v1.0.0
	github.com/golang/protobuf v1.5.2
	github.com/jinzhu/copier v0.3.5
	github.com/keltia/ripe-atlas v0.0.0-20211221125000-f6eb808d5dc6
	github.com/pelletier/go-toml v1.9.5
	github.com/pion/stun v0.6.0
	github.com/pkg/errors v0.9.1
	github.com/pkg/profile v1.7.0
	github.com/refraction-networking/conjure v0.4.0
	github.com/refraction-networking/utls v1.2.0
	github.com/sergeyfrolov/bsbuffer v0.0.0-20180903213811-94e85abb8507
	github.com/sirupsen/logrus v1.9.0
	github.com/stretchr/testify v1.8.4
	gitlab.com/yawning/obfs4.git v0.0.0-20220904064028-336a71d6e4cf
	golang.org/x/crypto v0.9.0
	golang.org/x/net v0.10.0
	google.golang.org/protobuf v1.30.0
)

require (
	filippo.io/edwards25519 v1.0.0 // indirect
	github.com/BurntSushi/toml v1.2.1 // indirect
	github.com/andybalholm/brotli v1.0.4 // indirect
	github.com/cespare/xxhash/v2 v2.1.2 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/dchest/siphash v1.2.3 // indirect
	github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f // indirect
	github.com/felixge/fgprof v0.9.3 // indirect
	github.com/go-redis/redis/v8 v8.11.5 // indirect
	github.com/google/gopacket v1.1.19 // indirect
	github.com/google/pprof v0.0.0-20211214055906-6f57359322fd // indirect
	github.com/hashicorp/golang-lru v0.6.0 // indirect
	github.com/keltia/proxy v0.9.3 // indirect
	github.com/klauspost/compress v1.15.12 // indirect
	github.com/libp2p/go-reuseport v0.3.0 // indirect
	github.com/mingyech/dtls/v2 v2.0.0-20230612212344-55a590c00078 // indirect
	github.com/mingyech/transport/v2 v2.0.0-20230612212211-3c84742e27c5 // indirect
	github.com/mroth/weightedrand v1.0.0 // indirect
	github.com/oschwald/geoip2-golang v1.8.0 // indirect
	github.com/oschwald/maxminddb-golang v1.10.0 // indirect
	github.com/pebbe/zmq4 v1.2.9 // indirect
	github.com/pion/dtls/v2 v2.2.7 // indirect
	github.com/pion/logging v0.2.2 // indirect
	github.com/pion/randutil v0.1.0 // indirect
	github.com/pion/sctp v1.8.5 // indirect
	github.com/pion/transport/v2 v2.2.1 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	gitlab.com/yawning/edwards25519-extra.git v0.0.0-20220726154925-def713fd18e4 // indirect
	golang.org/x/sys v0.8.0 // indirect
	golang.org/x/text v0.9.0 // indirect
	golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)

replace github.com/refraction-networking/conjure => github.com/mingyech/conjure v0.2.1-0.20230629150807-1277be45960d
