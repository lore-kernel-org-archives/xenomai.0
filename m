Message-ID: <48353340.9090306@domain.hid>
Date: Thu, 22 May 2008 10:48:00 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48349D40.9070707@domain.hid>
In-Reply-To: <48349D40.9070707@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in mpc836x_mds
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Galea <michaelgalea@domain.hid>
Cc: xenomai@xenomai.org

Michael Galea wrote:
> I'm trying to bring xenomai up on an Freescale mpc836x_mds board. I'm 
> using the ipipe-2.6.24-powerpc-2.1-02 branch of the git tree at Denx.
> 
> The kernel boots fine with ipipe disabled, nfs root mounting its file 
> system.  But as soon as I enable ipipe in the kernel I get..
> 
> ...
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> IP-Config: Complete:
>        device=eth0, addr=10.128.10.234, mask=255.0.0.0, gw=10.128.0.253,
>       host=10.128.10.234, domain=, nis-domain=(none),
>       bootserver=10.128.10.10, rootserver=10.128.10.10, rootpath=
> Looking up port of RPC 100003/2 on 10.128.10.10
> irq 33, desc: c02746c0, depth: 0, count: 0, unhandled: 0
> irq 33, desc: c02746c0, depth: 0, count: 0, unhandled: 0
> 
> And it hangs.  Since this is the place where the kernel usually finds 
> its PHY, I might suspect its an issue with that..
>

Something may be missing in the IPIC code to fully support the interrupt
pipeline too. A dump of /proc/interrupts when the board boots properly would
help here.

> I'm currently trying to get Denx's 2.6.20 branch running but its 
> freezing after loading the device tree, so I have some issues there.
> 
> Can anyone having success with this board report what kernel they are using?
> 
> Thanks
> 


-- 
Philippe.

