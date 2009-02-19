Message-ID: <499DA01E.6040006@domain.hid>
Date: Thu, 19 Feb 2009 19:08:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <499B36C5.3060104@domain.hid> <499C5E49.90002@domain.hid>
	<20090219183812.6bslw8zfkk44sgko@domain.hid>
In-Reply-To: <20090219183812.6bslw8zfkk44sgko@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] BUG fs/buffer.c with Linux 2.6.26,27
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roman Pisl <rpisl@domain.hid>
Cc: xenomai@xenomai.org

Roman Pisl wrote:
> Hello Philippe, Jan and other experts,
> I did some tests on the desktop and the bug is still present.
> 
> I tried both disabling CONFIG_PREEMPT and applying __ipipe_syscall_root
> patch.
> 
> Unfortunately I couldn't test Xenomai from trunk with our application,
> because events are probably broken - attached example segfaults on
> rt_event_wait. So I still use 2.4.6.1 and that is the reason for the
> problem with void rthal_propagate_irq when
> adeos-ipipe-2.6.27.13-x86-2.2-05.patch is applied.

Mmm, we may see two bugs here, one triggering the other. Let's try to
understand both - will look into your test case.

> 
> Jan wrote:
> The tracer log for .27 looks strange - did you apply my
> ipipe-trace-over-ftrace patch or just enabled the existing code? In the
> latter case, the .26-based trace log would be nice to cross-check and
> exclude tracer artifacts.
> 
> Sorry, but I don't know where this patch comes from. I enabled existing
> code only.

Interesting that this "works"... But I don't trust the results. The
point is that 2.6.27 has no official tracer support due to conflicts
with the new ftrace subsystem in mainline. I once posted an update [1]
but it is not yet merged.

> 
> .configs and logs are attached.
> 
> Roman
> 

Thanks a lot,
Jan

[1] http://permalink.gmane.org/gmane.linux.kernel.adeos.general/1364

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

