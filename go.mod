module github.com/refraction-networking/gotapdance

go 1.16

require (
	git.torproject.org/pluggable-transports/goptlib.git v1.2.0
	github.com/flynn/noise v1.0.0
	github.com/golang/protobuf v1.5.2
	github.com/jinzhu/copier v0.3.5
	github.com/keltia/ripe-atlas v0.0.0-20211221125000-f6eb808d5dc6
	github.com/pelletier/go-toml v1.9.4
	github.com/pion/stun v0.3.5
	github.com/pkg/errors v0.9.1
	github.com/pkg/profile v1.6.0
	github.com/refraction-networking/conjure v0.3.0
	github.com/refraction-networking/utls v1.1.0
	github.com/sergeyfrolov/bsbuffer v0.0.0-20180903213811-94e85abb8507
	github.com/sirupsen/logrus v1.9.0
	github.com/stretchr/testify v1.8.1
	gitlab.com/yawning/obfs4.git v0.0.0-20220204003609-77af0cba934d
	golang.org/x/crypto v0.3.0
	golang.org/x/net v0.2.0
	google.golang.org/protobuf v1.28.0
)

replace github.com/refraction-networking/conjure => github.com/mingyech/conjure v0.2.1-0.20221225005650-09aa9cc3b031
