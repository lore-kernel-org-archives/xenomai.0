Message-ID: <48F3527E.6020908@domain.hid>
Date: Mon, 13 Oct 2008 15:51:58 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48F34E5A.60209@domain.hid>
In-Reply-To: <48F34E5A.60209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG?] mem leak on slab size-1024 with Xenomai
 processes
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Sigh, this is not my day: Can anyone confirm that we are leaking memory
> with current SVN head? I'm seeing a constant increase on slab
> "size-1024" on a x86_64 box when running arbitrary Xenomai apps in a loop.
> 
> [ Besides that, I have an occasional deadlock in xnpipe_wakeup_proc due
> to an inconsistent xnpipe_sleepq - likely a different story... :-/ ]
>

Any luck with CONFIG_XENOMAI_OPT_DEBUG_QUEUES on?

> Jan
> 


-- 
Philippe.

