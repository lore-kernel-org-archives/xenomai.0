From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 7/8] drivers/net: Kconfig: fix help stanzas in configuration
 blocks
Date: Sat, 20 Feb 2021 13:45:26 +0100
Message-Id: <20210220124527.401015-7-rpm@xenomai.org>
In-Reply-To: <20210220124527.401015-1-rpm@xenomai.org>
References: <20210220124527.401015-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Philippe Gerum <rpm@xenomai.org>

The Kconfig parser became stricter, help stanzas must be introduced by
the naked "help" keyword, period. Let's drop all decorations.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/Kconfig                   |  2 +-
 kernel/drivers/net/addons/Kconfig            |  6 +++---
 kernel/drivers/net/drivers/Kconfig           |  6 +++---
 kernel/drivers/net/stack/Kconfig             |  6 +++---
 kernel/drivers/net/stack/ipv4/Kconfig        | 14 +++++++-------
 kernel/drivers/net/stack/ipv4/tcp/Kconfig    |  4 ++--
 kernel/drivers/net/stack/ipv4/udp/Kconfig    |  2 +-
 kernel/drivers/net/stack/packet/Kconfig      |  2 +-
 kernel/drivers/net/stack/rtcfg/Kconfig       |  4 ++--
 kernel/drivers/net/stack/rtmac/Kconfig       |  2 +-
 kernel/drivers/net/stack/rtmac/nomac/Kconfig |  2 +-
 kernel/drivers/net/stack/rtmac/tdma/Kconfig  |  4 ++--
 12 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/drivers/net/Kconfig b/kernel/drivers/net/Kconfig
index ac3bced25..2e8032464 100644
--- a/kernel/drivers/net/Kconfig
+++ b/kernel/drivers/net/Kconfig
@@ -10,7 +10,7 @@ if XENO_DRIVERS_NET
 config XENO_DRIVERS_RTNET_CHECKED
     bool "Internal Bug Checks"
     default n
-    ---help---
+    help
     Switch on if you face crashes when RTnet is running or if you suspect
     any other RTnet-related issues. This feature will add a few sanity
     checks at critical points that will produce warnings on the kernel
diff --git a/kernel/drivers/net/addons/Kconfig b/kernel/drivers/net/addons/Kconfig
index baa6cbcb9..e92f6d8ca 100644
--- a/kernel/drivers/net/addons/Kconfig
+++ b/kernel/drivers/net/addons/Kconfig
@@ -6,7 +6,7 @@ config XENO_DRIVERS_NET_ADDON_RTCAP
     select ETHERNET
     tristate "Real-Time Capturing Support"
     default n
-    ---help---
+    help
     This feature allows to capture real-time packets traversing the RTnet
     stack. It can both be used to sniff passively on a network (in this
     case you may want to enable the promisc mode of your real-time NIC via
@@ -22,7 +22,7 @@ config XENO_DRIVERS_NET_ADDON_PROXY
     select ETHERNET
     tristate "IP protocol proxy for Linux"
     default n
-    ---help---
+    help
     Enables a forward-to-Linux module for all IP protocols that are not
     handled by the IPv4 implemenation of RTnet (TCP, UDP, etc.). Only use
     when you know what you are doing - it can easily break your real-time
@@ -34,7 +34,7 @@ config XENO_DRIVERS_NET_ADDON_PROXY_ARP
     depends on XENO_DRIVERS_NET_ADDON_PROXY
     bool "Enable ARP handling via protocol proxy"
     default n
-    ---help---
+    help
     Enables ARP support for the IP protocol proxy. Incoming ARP replies
     are then delivered to both, the RTnet and the Linux network stack,
     but only answered by Linux. The IP protocol proxy gets attached to
diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
index b2df1110f..6889a500d 100644
--- a/kernel/drivers/net/drivers/Kconfig
+++ b/kernel/drivers/net/drivers/Kconfig
@@ -24,7 +24,7 @@ config XENO_DRIVERS_NET_DRV_EEPRO100_CMDTIMEOUT
     int "Command Timeout"
     depends on XENO_DRIVERS_NET_DRV_EEPRO100
     default 20
-    ---help---
+    help
     Timeout in microseconds of transmission or configuration commands that
     are issued in real-time contexts.
 
@@ -32,7 +32,7 @@ config XENO_DRIVERS_NET_DRV_EEPRO100_DBG
     depends on XENO_DRIVERS_NET && PCI
     bool "Enable debugging and instrumentation"
     depends on XENO_DRIVERS_NET_DRV_EEPRO100
-    ---help---
+    help
     This option switches on internal debugging code of the EEPRO/100 driver.
     It also enables the collection of worst-case command delays in real-time
     contexts in order to reduce the command timeout (which, effectively, will
@@ -127,7 +127,7 @@ config XENO_DRIVERS_NET_DRV_MACB
     depends on XENO_DRIVERS_NET
     select AT91_PROGRAMMABLE_CLOCKS if ARCH_AT91
     tristate "Cadence MACB/GEM devices"
-    ---help---
+    help
     Driver for internal MAC-controller on AT91SAM926x microcontrollers.
     Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
 
diff --git a/kernel/drivers/net/stack/Kconfig b/kernel/drivers/net/stack/Kconfig
index 830cec5ad..996536cc5 100644
--- a/kernel/drivers/net/stack/Kconfig
+++ b/kernel/drivers/net/stack/Kconfig
@@ -7,7 +7,7 @@ config XENO_DRIVERS_NET_RX_FIFO_SIZE
     int "Size of central RX-FIFO"
     depends on XENO_DRIVERS_NET
     default 32
-    ---help---
+    help
     Size of FIFO between NICs and stack manager task. Must be power
     of two! Effectively, only CONFIG_RTNET_RX_FIFO_SIZE-1 slots will
     be usable.
@@ -15,7 +15,7 @@ config XENO_DRIVERS_NET_RX_FIFO_SIZE
 config XENO_DRIVERS_NET_ETH_P_ALL
     depends on XENO_DRIVERS_NET
     bool "Support for ETH_P_ALL"
-    ---help---
+    help
     Enables core support for registering listeners on all layer 3
     protocols (ETH_P_ALL). Internally this is currently realised by
     clone-copying incoming frames for those listners, future versions
@@ -26,7 +26,7 @@ config XENO_DRIVERS_NET_ETH_P_ALL
 config XENO_DRIVERS_NET_RTWLAN
     depends on XENO_DRIVERS_NET
     bool "Real-Time WLAN"
-    ---help---
+    help
     Enables core support for real-time wireless LAN. RT-WLAN is based
     on low-level access to 802.11-compliant adapters and is currently
     in an experimental stage.
diff --git a/kernel/drivers/net/stack/ipv4/Kconfig b/kernel/drivers/net/stack/ipv4/Kconfig
index 8fb3c1acc..d5a6cd6d7 100644
--- a/kernel/drivers/net/stack/ipv4/Kconfig
+++ b/kernel/drivers/net/stack/ipv4/Kconfig
@@ -2,7 +2,7 @@ config XENO_DRIVERS_NET_RTIPV4
     depends on XENO_DRIVERS_NET
     tristate "Real-Time IPv4"
     default y
-    ---help---
+    help
     Enables the real-time capable IPv4 support of RTnet. The protocol is
     implemented as a separate module. Supplementing tools (rtroute,
     rtping) and examples are provided as well. Moreover, RTcfg will
@@ -15,7 +15,7 @@ config XENO_DRIVERS_NET_RTIPV4_ICMP
     bool "ICMP support"
     depends on XENO_DRIVERS_NET_RTIPV4
     default y
-    ---help---
+    help
     Enables ICMP support of the RTnet Real-Time IPv4 protocol.
 
     When the RTnet-Proxy is enabled while this feature is disabled, ICMP
@@ -25,7 +25,7 @@ config XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES
     int "Maximum host routing table entries"
     depends on XENO_DRIVERS_NET_RTIPV4
     default 32
-    ---help---
+    help
     Each IPv4 supporting interface and each remote host that is directly
     reachable via via some output interface requires a host routing table
     entry. If you run larger networks with may hosts per subnet, you may
@@ -34,7 +34,7 @@ config XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES
 config XENO_DRIVERS_NET_RTIPV4_NETROUTING
     bool "IP Network Routing"
     depends on XENO_DRIVERS_NET_RTIPV4
-    ---help---
+    help
     Enables routing across IPv4 real-time networks. You will only require
     this feature in complex networks, while switching it off for flat,
     single-segment networks improves code size and the worst-case routing
@@ -46,7 +46,7 @@ config XENO_DRIVERS_NET_RTIPV4_NET_ROUTES
     int "Maximum network routing table entries"
     depends on XENO_DRIVERS_NET_RTIPV4_NETROUTING
     default 16
-    ---help---
+    help
     Each route describing a target network reachable via a router
     requires an entry in the network routing table. If you run very
     complex realtime networks, you may have to increase this limit. Must
@@ -55,7 +55,7 @@ config XENO_DRIVERS_NET_RTIPV4_NET_ROUTES
 config XENO_DRIVERS_NET_RTIPV4_ROUTER
     bool "IP Router"
     depends on XENO_DRIVERS_NET_RTIPV4
-    ---help---
+    help
     When switched on, the RTnet station will be able to forward IPv4
     packets that are not directed to the station itself. Typically used in
     combination with CONFIG_RTNET_RTIPV4_NETROUTING.
@@ -67,7 +67,7 @@ config XENO_DRIVERS_NET_RTIPV4_DEBUG
     depends on XENO_DRIVERS_NET_RTIPV4
     default n
     
-    ---help---
+    help
     Enables debug message output of the RTipv4 layer. Typically, you
     may want to turn this on for tracing issues in packet delivery.
 
diff --git a/kernel/drivers/net/stack/ipv4/tcp/Kconfig b/kernel/drivers/net/stack/ipv4/tcp/Kconfig
index 5b1182d72..a69d34679 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/Kconfig
+++ b/kernel/drivers/net/stack/ipv4/tcp/Kconfig
@@ -1,7 +1,7 @@
 config XENO_DRIVERS_NET_RTIPV4_TCP
     tristate "TCP support"
     depends on XENO_DRIVERS_NET_RTIPV4
-    ---help---
+    help
     Enables TCP support of the RTnet Real-Time IPv4 protocol.
 
     When the RTnet IPv4 is enabled while this feature is disabled, TCP
@@ -10,7 +10,7 @@ config XENO_DRIVERS_NET_RTIPV4_TCP
 config XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION
     bool "TCP error injection"
     depends on XENO_DRIVERS_NET_RTIPV4_TCP
-    ---help---
+    help
     Enables error injection for incoming TCP packets. This can be used
     to test both protocol as well as application behavior under error
     conditions. The per-socket error rate is 0 by default and can be
diff --git a/kernel/drivers/net/stack/ipv4/udp/Kconfig b/kernel/drivers/net/stack/ipv4/udp/Kconfig
index 77779a1a1..a23279411 100644
--- a/kernel/drivers/net/stack/ipv4/udp/Kconfig
+++ b/kernel/drivers/net/stack/ipv4/udp/Kconfig
@@ -2,5 +2,5 @@ config XENO_DRIVERS_NET_RTIPV4_UDP
     tristate "UDP support"
     depends on XENO_DRIVERS_NET_RTIPV4
     default y
-    ---help---
+    help
     Enables UDP support of the RTnet Real-Time IPv4 protocol.
diff --git a/kernel/drivers/net/stack/packet/Kconfig b/kernel/drivers/net/stack/packet/Kconfig
index 1424ffb6b..4c83b73c2 100644
--- a/kernel/drivers/net/stack/packet/Kconfig
+++ b/kernel/drivers/net/stack/packet/Kconfig
@@ -2,7 +2,7 @@ config XENO_DRIVERS_NET_RTPACKET
     depends on XENO_DRIVERS_NET
     tristate "Real-Time Packet Socket Support"
     default y
-    ---help---
+    help
     Enables real-time packet sockets for RTnet. This support is
     implemented in a separate module. When loaded, application programs
     can send and received so-called "cooked" packets directly at OSI layer
diff --git a/kernel/drivers/net/stack/rtcfg/Kconfig b/kernel/drivers/net/stack/rtcfg/Kconfig
index d5af3b826..38c484046 100644
--- a/kernel/drivers/net/stack/rtcfg/Kconfig
+++ b/kernel/drivers/net/stack/rtcfg/Kconfig
@@ -2,7 +2,7 @@ config XENO_DRIVERS_NET_RTCFG
     depends on XENO_DRIVERS_NET
     tristate "RTcfg Service"
     default y
-    ---help---
+    help
     The Real-Time Configuration service configures and monitors nodes in
     a RTnet network. It works both with plain MAC as well as with IPv4
     addresses (in case CONFIG_RTNET_RTIPV4 has been switched on). RTcfg
@@ -18,6 +18,6 @@ config XENO_DRIVERS_NET_RTCFG_DEBUG
     bool "RTcfg Debugging"
     depends on XENO_DRIVERS_NET_RTCFG
     default n
-    ---help---
+    help
     Enables debug message output of the RTcfg state machines. Switch on if
     you have to trace some problem related to RTcfg.
diff --git a/kernel/drivers/net/stack/rtmac/Kconfig b/kernel/drivers/net/stack/rtmac/Kconfig
index 604cb4bc1..a97b316b0 100644
--- a/kernel/drivers/net/stack/rtmac/Kconfig
+++ b/kernel/drivers/net/stack/rtmac/Kconfig
@@ -2,7 +2,7 @@ menuconfig XENO_DRIVERS_NET_RTMAC
     depends on XENO_DRIVERS_NET
     tristate "RTmac Layer"
     default y
-    ---help---
+    help
     The Real-Time Media Access Control layer allows to extend the RTnet
     stack with software-based access control mechanisms (also called
     disciplines) for nondeterministic transport media. Disciplines can be
diff --git a/kernel/drivers/net/stack/rtmac/nomac/Kconfig b/kernel/drivers/net/stack/rtmac/nomac/Kconfig
index 868673935..e706d4a96 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/Kconfig
+++ b/kernel/drivers/net/stack/rtmac/nomac/Kconfig
@@ -2,7 +2,7 @@ config XENO_DRIVERS_NET_NOMAC
     tristate "NoMAC discipline for RTmac"
     depends on XENO_DRIVERS_NET_RTMAC
     default n
-    ---help---
+    help
     This no-operation RTmac discipline is intended to act as a template
     for new implementations. However, it can be compiled and used (see
     nomaccfg management tool), but don't expect any improved determinism
diff --git a/kernel/drivers/net/stack/rtmac/tdma/Kconfig b/kernel/drivers/net/stack/rtmac/tdma/Kconfig
index b56f8251a..4444661f2 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/Kconfig
+++ b/kernel/drivers/net/stack/rtmac/tdma/Kconfig
@@ -2,7 +2,7 @@ config XENO_DRIVERS_NET_TDMA
     tristate "TDMA discipline for RTmac"
     depends on XENO_DRIVERS_NET_RTMAC
     default y
-    ---help---
+    help
     The Time Division Multiple Access discipline is the default RTmac
     protocol for Ethernet networks. It consists of a master synchronising
     the access of the slaves to the media by periodically issuing frames.
@@ -16,6 +16,6 @@ config XENO_DRIVERS_NET_TDMA_MASTER
     bool "TDMA master support"
     depends on XENO_DRIVERS_NET_TDMA
     default y
-    ---help---
+    help
     Enables TDMA master and backup master support for the node. This can
     be switched of to reduce the memory footprint of pure slave nodes.
-- 
2.26.2


