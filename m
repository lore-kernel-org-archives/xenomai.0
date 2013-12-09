From: "Andreas Gareis" <andreas.gareis@hs-augsburg.de>
Date: Mon, 9 Dec 2013 19:17:47 +0100
Message-ID: <001d01cef50a$f6d44e70$e47ceb50$@hs-augsburg.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: de
Subject: Re: [Xenomai] rtdm can on mpc5121e - no rtcan devices detected
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Von: Tom Evans
 Gesendet: Sonntag, 8. Dezember 2013 23:07
> 
> On 09/12/13 06:44, Andreas Gareis wrote:
> > Hi Wolfgang,
> >
> > Thanks for your answer.
>  > ...
> >> RTCAN devices are not visible in /dev. It's not a character device.
> >> You can find more informations in /proc/rtnet.
> >
> > The files "devices" and "sockets" which are located in /proc/rtcan 
> > don't have any entries. (/proc/rtnet doesn't exist on my system)
> 
> Did the CAN devices work before you installed Xenomai? Get them 
> working there first.
> 
> On the device I'm using (Freescale i.MX53), the CAN drivers are 
> connected via NETWORKING. So they don't show up in /dev, just as 
> Ethernet doesn't show there either (/dev is so 1980's :-).
> 
> root@triton1:~# ls /proc/net/can
> rcvlist_all  rcvlist_err  rcvlist_inv  reset_stats  version 
> rcvlist_eff  rcvlist_fil rcvlist_sff  stats root@triton1:~# ifconfig
> can0      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>            UP RUNNING NOARP  MTU:16  Metric:1
>            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:256
>            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>            Interrupt:82
> 
> can1      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>            UP RUNNING NOARP  MTU:16  Metric:1
>            RX packets:2527 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:256
>            RX bytes:19583 (19.1 KiB)  TX bytes:0 (0.0 B)
>            Interrupt:83
> 
> eth0      Link encap:Ethernet  HWaddr 00:0C:C6:79:6C:6E
> ... And so on.
> 
> Check for interrupts:
> 
> root@triton1:~# cat /proc/interrupts
>             CPU0
>    6:          0      tzic  sdma
> ...
>   64:          0      tzic  imx-i2c.2
>   82:          0      tzic  can0
>   83:       5832      tzic  can1
>   87:     124900      tzic  imx25-fec.0
> 
> 
> Tom
> 

Yes, the CAN devices worked before Xenomai installation. They were shown in
ifconfig and communication with other CAN-devices was possible.

When I select normal (non rt) CAN-support and xenomai kernel (without
RT-CAN) in the kernelconfig, working CAN devices are also available.

Now I want to use RT-CAN with xenomai. So, I activated "RT-Socket-CAN" and
"MSCAN driver for MPC52xx and MPC512x" in the kernelconfig. When "normal"
CAN support (Networking support => CAN bus subsystem support => CAN Device
Drivers Freescale MPC5xxx onboard CAN controller) is disabled, the xenomai
module "xeno_can_mscan.ko" isn't able to start. When "normal" CAN support is
enabled, the xenomai module "xeno_can_mscan.ko" can be loaded without errors
in dmesg, but there are no rtcan devices.


Andreas



