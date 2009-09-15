From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AAFFC58.5040701@domain.hid>
References: <4AAFFC58.5040701@domain.hid>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 22:58:48 +0200
Message-Id: <1253048328.2676.120.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai for MPC8572DS
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nikhil Gupta <gupta.nikhil83@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-09-15 at 15:43 -0500, Nikhil Gupta wrote:
> Hi all,
> 
> This is my first post to the list. I've been trying to compile the Linux 
> kernel with the Xenomai patches for the Freescale MPC8572DS system. I am 
> using ELDK version 4.2 for ppc_85xx Build 2008-04-01. But during boot 
> the system hangs with the following message:
> 
> audit: initializing netlink socket (disabled)
> type=2000 audit(0.496:1): initialized
> 
> Specifically, I've tried the following versions from the DENX repositories:
> 
> ipipe-2.6.git:         ipipe-2.6.28, ipipe-2.6.30-powerpc-2.7-00,
> linux-2.6-denx.git:    DENX-v2.6.27.30, DENX-v2.6.29.4
> 
> Without the scripts/prepare-kernel.sh step, the kernel boots fine. Can 
> someone please help me with this issue?

Not supported.
http://www.xenomai.org/index.php/Embedded_Device_Support#PowerPC

> 
> Regards,
> Nikhil Gupta.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



