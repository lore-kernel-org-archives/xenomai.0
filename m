Message-ID: <48349D40.9070707@domain.hid>
Date: Wed, 21 May 2008 18:08:00 -0400
From: Michael Galea <michaelgalea@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Enable I-PIPE - kernel boot hangs in mpc836x_mds
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I'm trying to bring xenomai up on an Freescale mpc836x_mds board. I'm 
using the ipipe-2.6.24-powerpc-2.1-02 branch of the git tree at Denx.

The kernel boots fine with ipipe disabled, nfs root mounting its file 
system.  But as soon as I enable ipipe in the kernel I get..

...
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
IP-Config: Complete:
       device=eth0, addr=10.128.10.234, mask=255.0.0.0, gw=10.128.0.253,
      host=10.128.10.234, domain=, nis-domain=(none),
      bootserver=10.128.10.10, rootserver=10.128.10.10, rootpath=
Looking up port of RPC 100003/2 on 10.128.10.10
irq 33, desc: c02746c0, depth: 0, count: 0, unhandled: 0
irq 33, desc: c02746c0, depth: 0, count: 0, unhandled: 0

And it hangs.  Since this is the place where the kernel usually finds 
its PHY, I might suspect its an issue with that..

I'm currently trying to get Denx's 2.6.20 branch running but its 
freezing after loading the device tree, so I have some issues there.

Can anyone having success with this board report what kernel they are using?

Thanks

-- 
Michael Galea
30 Whitmore Road
Woodbridge, Ontario, Canada, L4L 7Z4
Ph: (905) 266-1745
Fx: (905) 856-1995
www.ruggedcom.com



