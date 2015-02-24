MIME-Version: 1.0
From: Antoine Hoarau <hoarau.robotics@gmail.com>
Date: Tue, 24 Feb 2015 10:39:48 +0000
Message-ID: <CAB6vvjmqqX1_NbPLDOmwkd=htsC+z3b99H8BwSYXgRYhXty+=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtnet issue with xenomai-3.git next branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

> Please stay on the list.
My bad.
>Ok, maybe a consequence of the udp module bug. Please try again with
>the patch applied, and if you still get the bug, we will investigate
>further. Please try and enable frame pointers so as to get more
>meaningful stack traces.
I tried the patch, rtudp is now correctly loaded, but et rtnet start, the
system hangs, and I can't print/see any kernel debug...



Le Tue Feb 24 2015 at 10:35:38 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> a =C3=A9crit :

On Mon, Feb 23, 2015 at 06:13:39PM +0000, Antoine Hoarau wrote:
> > I'm actually not able to test it, but maybe this is a different problem=
.
> > Here's my script :
> >
> > cd /usr/xenomai/sbin/
> > sudo ./rtifconfig rteth0 down
> > sudo rmmod rtipv4
> > sudo rmmod rt_e1000e
> > sudo rmmod rtnet
> > sudo mknod /dev/rtnet c 10 240
> > sudo ./rtnet start # 1)
> > sudo ./rtifconfig rteth0 up 192.168.100.101 netmask 255.255.255.0 # 2)
> > sudo ./rtroute solicit 192.168.100.102 dev rteth0
> > sudo ./rtifconfig # 4)
> > sudo ./rtroute # 5)
> > sudo ./rtping 192.168.100.102 # Stalls
> >
> > 1) FATAL: Error inserting rtudp (/lib/modules/3.16.0-xenomai-
> > 3rc3/kernel/drivers/xenomai/net/stack/ipv4/udp/rtudp.ko): Invalid
> argument
>
> Please try the following patch:
> diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> index d6a7b7d..607bdbe 100644
> --- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> +++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> @@ -2118,6 +2118,7 @@ static struct rtdm_driver tcp_driver =3D {
>                                         RTDM_CLASS_NETWORK,
>                                         RTDM_SUBCLASS_RTNET,
>                                         RTNET_RTDM_VER),
> +    .device_count =3D     1,
>      .device_flags =3D     RTDM_PROTOCOL_DEVICE,
>      .context_size =3D     sizeof(struct tcp_socket),
>
> diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c
> b/kernel/drivers/net/stack/ipv4/udp/udp.c
> index 3966e54..538712a 100644
> --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
> +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
> @@ -707,6 +707,7 @@ static struct rtdm_driver udp_driver =3D {
>                                          RTDM_SUBCLASS_RTNET,
>                                          RTNET_RTDM_VER),
>      .device_flags =3D     RTDM_PROTOCOL_DEVICE,
> +    .device_count =3D     1,
>      .context_size =3D     sizeof(struct rtsocket),
>
>      .protocol_family =3D  PF_INET,
>
>
> >
> > dmesg :
> >
> > [  146.895062] *** RTnet for Xenomai v3.0-rc3 ***
> > [  146.895062]
> > [  146.895064] RTnet: initialising real-time networking
> > [  146.897459] rt_e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k-rt
> > [  146.897461] rt_e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
> > [  146.897475] rt_e1000e 0000:05:00.0: Disabling ASPM L0s
> > [  146.897674] rt_e1000e 0000:05:00.0: irq 47 for MSI/MSI-X
> > [  146.897677] rt_e1000e 0000:05:00.0: irq 48 for MSI/MSI-X
> > [  146.897679] rt_e1000e 0000:05:00.0: irq 49 for MSI/MSI-X
> > [  147.008138] RTnet: registered rteth0
> > [  147.008141] rt_e1000e: (PCI Express:2.5GT/s:Width x1)
> 68:05:ca:32:c9:ab
> > [  147.008142] rt_e1000e: Intel(R) PRO/1000 Network Connection
> > [  147.008153] rt_e1000e: MAC: 3, PHY: 8, PBA No: E46981-008
> >
> > 2) dmesg:
> > [  308.518107] RTnet: dropping packet in rtnetif_rx()
> > [  308.519118] RTnet: dropping packet in rtnetif_rx()
> > [  308.520108] RTnet: dropping packet in rtnetif_rx()
> > [  308.521119] RTnet: dropping packet in rtnetif_rx()
> > [  308.522109] RTnet: dropping packet in rtnetif_rx()
> > [  308.523119] RTnet: dropping packet in rtnetif_rx()
> >
> >
> > 3)
> > rteth0    Medium: Ethernet  Hardware address: 68:05:CA:32:C9:AB
> >           IP address: 192.168.100.101  Broadcast address: 192.168.100.2=
55
> >           UP BROADCAST RUNNING  MTU: 1500
> >
> > 4)
> > Host Routing Table
> > Hash Destination HW Address Device
> > 26 192.168.100.102 90:E2:BA:26:72:15 rteth0
> > 3F 192.168.100.255 FF:FF:FF:FF:FF:FF rteth0
> >
> > The rtnet.conf :
> >
> > RT_DRIVER=3D"rt_e1000e"
> > REBIND_RT_NICS=3D""
> > IPADDR=3D"192.168.100.101"
> > NETMASK=3D"255.255.255.0"
> > RT_LOOPBACK=3D"yes"
> > RT_PROTOCOLS=3D"udp packet"
> > RTCAP=3D"no"
> > TDMA_MODE=3D"master"
> > TDMA_SLAVES=3D"" # this worked in rtnet 0.9.13+xeno 2.4.3
> >
> > Thank you for your help,
> >
> > Antoine
> >
> > EDIT : I just saw there's a kernel bug occuring, please find attached t=
he
> > log
>
> Ok, maybe a consequence of the udp module bug. Please try again with
> the patch applied, and if you still get the bug, we will investigate
> further. Please try and enable frame pointers so as to get more
> meaningful stack traces.
>
> Please stay on the list.
>
> --
>                                             Gilles.
>
