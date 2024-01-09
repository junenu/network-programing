### netnsとネットワークインターフェースの設定

1. netnsの作成:
   ```bash
   sudo ip netns add host1
   sudo ip netns add router1
   sudo ip netns add router2
   sudo ip netns add router3
   sudo ip netns add host2
   ```

2. vethペア（仮想イーサネットペア）の作成と各名前空間への割り当て:
   ```bash
   sudo ip link add veth1 type veth peer name br-veth1
   sudo ip link add veth2 type veth peer name br-veth2
   sudo ip link add veth3 type veth peer name br-veth3
   sudo ip link add veth4 type veth peer name br-veth4

   sudo ip link set veth1 netns host1
   sudo ip link set br-veth1 netns router1
   sudo ip link set veth2 netns router1
   sudo ip link set br-veth2 netns router2
   sudo ip link set veth3 netns router2
   sudo ip link set br-veth3 netns router3
   sudo ip link set veth4 netns router3
   sudo ip link set br-veth4 netns host2
   ```

### IPv6アドレスの設定

1. 各インターフェースにIPv6アドレスを割り当てます（例示アドレスを使用）:
   ```bash
   sudo ip netns exec host1 ip -6 addr add 2001:db8:1::1/64 dev veth1
   sudo ip netns exec router1 ip -6 addr add 2001:db8:1::2/64 dev br-veth1
   sudo ip netns exec router1 ip -6 addr add 2001:db8:2::1/64 dev veth2
   sudo ip netns exec router2 ip -6 addr add 2001:db8:2::2/64 dev br-veth2
   sudo ip netns exec router2 ip -6 addr add 2001:db8:3::1/64 dev veth3
   sudo ip netns exec router3 ip -6 addr add 2001:db8:3::2/64 dev br-veth3
   sudo ip netns exec router3 ip -6 addr add 2001:db8:4::1/64 dev veth4
   sudo ip netns exec host2 ip -6 addr add 2001:db8:4::2/64 dev br-veth4
   ```

### インターフェースのアクティベート

1. すべてのvethインターフェースをアクティブ化:
   ```bash
   sudo ip netns exec host1 ip link set veth1 up
   sudo ip netns exec router1 ip link set br-veth1 up
   sudo ip netns exec router1 ip link set veth2 up
   sudo ip netns exec router2 ip link set br-veth2 up
   sudo ip netns exec router2 ip link set veth3 up
   sudo ip netns exec router3 ip link set br-veth3 up
   sudo ip netns exec router3 ip link set veth4 up
   sudo ip netns exec host2 ip link set br-veth4 up
   ```

### ルータでのIPv6転送の有効化

1. 各ルータでIPv6の転送を有効にします:

   ```bash
   sudo ip netns exec router1 sysctl -w net.ipv6.conf.all.forwarding=1
   sudo ip netns exec router2 sysctl -w net.ipv6.conf.all.forwarding=1
   sudo ip netns exec router3 sysctl -w net.ipv6.conf.all.forwarding=1
   ```

### ルーティングの設定

1. ルータ間およびホストからルータへのIPv6ルーティングを設定:
   ```bash
   # ホストからルータへ
   sudo ip netns exec host1 ip -6 route add default via 2001:db8:1::2
   sudo ip netns exec host2 ip -6 route add default via 2001:db8:4::1

   # ルータ間
   sudo ip netns exec router1 ip -6 route add 2001:db8:3::/64 via 2001:db8:2::2
   sudo ip netns exec router1 ip -6 route add 2001:db8:4::/64 via 2001:db8:2::2
   sudo ip netns exec router2 ip -6 route add 2001:db8:1::/64 via 2001:db8:2::1
   sudo ip netns exec router2 ip -6 route add 2001:db8:4::/64 via 2001:db8:3::2
   sudo ip netns exec router3 ip -6 route add 2001:db8:1::/64 via 2001:db8:3::1
   sudo ip netns exec router3 ip -6 route add 2001:db8:2::/64 via 2001:db8:3::1
   ```

### テストとクリーンアップ

1. 通信テスト:
   ```bash
   sudo ip netns exec host1 ping6 -c 3 2001:db8:4::2
   ```

2. クリーンアップ（すべての設定と名前空間の削除）:
   ```bash
   sudo ip netns del host1
   sudo ip netns del router1
   sudo ip netns del router2
   sudo ip netns del router3
   sudo ip netns del host2
   ```
