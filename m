From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1264695612.3279.39.camel@domain.hid>
References: <9b3e2dc20909111201m1b553420k5436a2da179e3279@domain.hid>
	<4AAAAD28.8060107@domain.hid>
	<9b3e2dc20909171041h56208c6aqc1cc36b3a021bc91@domain.hid>
	<1264695612.3279.39.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Jan 2010 21:47:52 +0100
Message-ID: <1264798073.16492.62.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CONFIG_NR_CPUS is too large
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Brian Zenowich <bz@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2010-01-28 at 11:20 -0500, Brian Zenowich wrote:
> Hello,
> 
> I am trying to install Xenomai on Ubuntu 9.10 Karmic (2.6.31 + Ubuntu
> patches) for x86-32. The adeos-ipipe-2.6.31.8-x86-2.4-09.patch included
> with xenomai-2.5.0 only had one failed chunk in process_32.c- and it
> just an #ifndef CONFIG_IPIPE block, which seems irrelevant since
> CONFIG_IPIPE *will* be defined.
> 
> I get the "CONFIG_NR_CPUS is too large, please lower it." error when
> making the kernel. As others have found, lowering CONFIG_NR_CPUS has no
> effect, and CONFIG_SPARSE_IRQ=n causes the "per_cpu__irq_stack_union"
> error.

This one is likely due to CONFIG_CC_STACKPROTECTOR. This is not yet
supported by Xenomai in 32bit mode (only 64 for now). Try disabling it;
that should work.

> 
> So, at this point I am stuck. Jan says "Removing this limitation is on
> our agenda.", but is there any workaround in the meantime? Has anyone
> managed to get Xenomai working by starting with the Ubuntu Karmic kernel
> source? If so, how?
> 
> Config attached.
> 
> Thanks,
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



