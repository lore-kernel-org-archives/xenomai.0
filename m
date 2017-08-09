Date: Wed, 09 Aug 2017 16:06:51 +0000
Message-ID: <20170809160651.Horde.1WJa12dTVng5OanxpiLgcqG@office.mrmoco.com>
From: Paul Wilkinson <paul.w@mrmoco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"; delsp="Yes"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Description: Plaintext Message
Subject: [Xenomai] UDP comms via Xenomai 3.0.5 + RTnet ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm new to Xenomai and RTnet and would really appreciate some help and
guidance with the following.

I'm controlling an EtherCAT based robot arm via Linux + Xenomai + SOEM +
RTnet.

I additionally need to control an Ethernet based robot motor using UDP,
preferably using RTnet and it's associated nic.

Please could someone let me know how to configure RTnet to achieve this.

I've included some diagnostic info below.

Thanks,

Paul.

/In EtherCAT only case, RTnet is currently configured manually :-

    modprobe rtnet, rtipv4, rt_e1000e, rtpacket
    ifconfig rteth0 up

Attempting both EtherCAT and UDP I've loaded the rtudp module and
configured rteth0 with an IP address.

# ./rtifconfig
rtlo      Medium: Local Loopback
          UP LOOPBACK RUNNING  MTU: 1500

rteth0    Medium: Ethernet  Hardware address: 5C:F9:DD:74:9C:27
          IP address: 10.0.0.1  Broadcast address: 10.255.255.255
          UP BROADCAST RUNNING  MTU: 1500

but ....

# ./rtping 10.0.0.1
Real-time PING 10.0.0.1 56(84) bytes of data.
ioctl: No route to host

However, if I use 'rtnet start', rtping succeeds :-

# ./rtping 10.0.0.1
Real-time PING 10.0.0.1 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 time=4.8 us
64 bytes from 127.0.0.1: icmp_seq=2 time=4.4 us
64 bytes from 127.0.0.1: icmp_seq=3 time=3.4 us
64 bytes from 127.0.0.1: icmp_seq=4 time=3.7 us
64 bytes from 127.0.0.1: icmp_seq=5 time=4.2 us

 .... but EtherCAT timings change such that SOEM is not longer able to
configure
the EtherCAT slave, however 'simple_test rteth0' does still return slave
status.

In both cases demo/posix/cobalt/{rtt-sender,rtt-responder} fails in the
following way :-

# ./rtt-responder -d 10.0.0.1 -l 10.0.0.1
destination ip address: 10.0.0.1 = 0100000a
local ip address: 10.0.0.1 = 0100000a
reply size: 16

# ./rtt-sender -d 10.0.0.1 -l 10.0.0.1
destination ip address: 10.0.0.1 = 0100000a
local ip address: 10.0.0.1 = 0100000a
cycle: 50000 us
sendto failed: No route to host

# ./rtroute
Host Routing Table
Hash    Destination    HW Address        Device
00    0.0.0.0      00:00:00:00:00:00    rtlo
01    127.0.0.1      00:00:00:00:00:00    rtlo
02    10.0.0.2      00:00:00:00:00:00    rtlo
3F    10.255.255.255    FF:FF:FF:FF:FF:FF    rteth0

# lsmod
Module                  Size  Used by
tdma                   17250  1
rtcfg                  35996  0
rt_loopback             1325  1
rtmac                   7996  1 tdma
rtpacket                6714  0
rtudp                  10708  0
rtipv4                 22182  2 rtudp,rtcfg
rt_e1000e             100022  1
rtnet                  44399  8
rtipv4,rt_loopback,rtmac,rt_e1000e,rtpacket,rtudp,rtcfg,tdma/
