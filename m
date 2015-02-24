Date: Tue, 24 Feb 2015 10:34:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150224093434.GA10019@hermes.click-hack.org>
References: <CAB6vvjn7=j2LpfwVhVAQBPcYiK6a-owoCaFXqY00+JnU2jGm9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB6vvjn7=j2LpfwVhVAQBPcYiK6a-owoCaFXqY00+JnU2jGm9A@mail.gmail.com>
Subject: Re: [Xenomai] rtnet issue with xenomai-3.git next branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Hoarau <hoarau.robotics@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Feb 23, 2015 at 06:13:39PM +0000, Antoine Hoarau wrote:
> I'm actually not able to test it, but maybe this is a different problem.
> Here's my script :
> 
> cd /usr/xenomai/sbin/
> sudo ./rtifconfig rteth0 down
> sudo rmmod rtipv4
> sudo rmmod rt_e1000e
> sudo rmmod rtnet
> sudo mknod /dev/rtnet c 10 240
> sudo ./rtnet start # 1)
> sudo ./rtifconfig rteth0 up 192.168.100.101 netmask 255.255.255.0 # 2)
> sudo ./rtroute solicit 192.168.100.102 dev rteth0
> sudo ./rtifconfig # 4)
> sudo ./rtroute # 5)
> sudo ./rtping 192.168.100.102 # Stalls
> 
> 1) FATAL: Error inserting rtudp (/lib/modules/3.16.0-xenomai-
> 3rc3/kernel/drivers/xenomai/net/stack/ipv4/udp/rtudp.ko): Invalid argument

Please try the following patch:
diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index d6a7b7d..607bdbe 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -2118,6 +2118,7 @@ static struct rtdm_driver tcp_driver = {
                                        RTDM_CLASS_NETWORK,
                                        RTDM_SUBCLASS_RTNET,
                                        RTNET_RTDM_VER),
+    .device_count =     1,
     .device_flags =     RTDM_PROTOCOL_DEVICE,
     .context_size =     sizeof(struct tcp_socket),
 
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 3966e54..538712a 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -707,6 +707,7 @@ static struct rtdm_driver udp_driver = {
                                         RTDM_SUBCLASS_RTNET,
                                         RTNET_RTDM_VER),
     .device_flags =     RTDM_PROTOCOL_DEVICE,
+    .device_count =     1,
     .context_size =     sizeof(struct rtsocket),
 
     .protocol_family =  PF_INET,


> 
> dmesg :
> 
> [  146.895062] *** RTnet for Xenomai v3.0-rc3 ***
> [  146.895062]
> [  146.895064] RTnet: initialising real-time networking
> [  146.897459] rt_e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k-rt
> [  146.897461] rt_e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
> [  146.897475] rt_e1000e 0000:05:00.0: Disabling ASPM L0s
> [  146.897674] rt_e1000e 0000:05:00.0: irq 47 for MSI/MSI-X
> [  146.897677] rt_e1000e 0000:05:00.0: irq 48 for MSI/MSI-X
> [  146.897679] rt_e1000e 0000:05:00.0: irq 49 for MSI/MSI-X
> [  147.008138] RTnet: registered rteth0
> [  147.008141] rt_e1000e: (PCI Express:2.5GT/s:Width x1) 68:05:ca:32:c9:ab
> [  147.008142] rt_e1000e: Intel(R) PRO/1000 Network Connection
> [  147.008153] rt_e1000e: MAC: 3, PHY: 8, PBA No: E46981-008
> 
> 2) dmesg:
> [  308.518107] RTnet: dropping packet in rtnetif_rx()
> [  308.519118] RTnet: dropping packet in rtnetif_rx()
> [  308.520108] RTnet: dropping packet in rtnetif_rx()
> [  308.521119] RTnet: dropping packet in rtnetif_rx()
> [  308.522109] RTnet: dropping packet in rtnetif_rx()
> [  308.523119] RTnet: dropping packet in rtnetif_rx()
> 
> 
> 3)
> rteth0    Medium: Ethernet  Hardware address: 68:05:CA:32:C9:AB
>           IP address: 192.168.100.101  Broadcast address: 192.168.100.255
>           UP BROADCAST RUNNING  MTU: 1500
> 
> 4)
> Host Routing Table
> Hash Destination HW Address Device
> 26 192.168.100.102 90:E2:BA:26:72:15 rteth0
> 3F 192.168.100.255 FF:FF:FF:FF:FF:FF rteth0
> 
> The rtnet.conf :
> 
> RT_DRIVER="rt_e1000e"
> REBIND_RT_NICS=""
> IPADDR="192.168.100.101"
> NETMASK="255.255.255.0"
> RT_LOOPBACK="yes"
> RT_PROTOCOLS="udp packet"
> RTCAP="no"
> TDMA_MODE="master"
> TDMA_SLAVES="" # this worked in rtnet 0.9.13+xeno 2.4.3
> 
> Thank you for your help,
> 
> Antoine
> 
> EDIT : I just saw there's a kernel bug occuring, please find attached the
> log

Ok, maybe a consequence of the udp module bug. Please try again with
the patch applied, and if you still get the bug, we will investigate
further. Please try and enable frame pointers so as to get more
meaningful stack traces.

Please stay on the list.

-- 
					    Gilles.

