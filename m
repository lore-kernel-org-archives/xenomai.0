Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3881D5CFB
	for <xenomai@lists.linux.dev>; Thu, 30 Oct 2025 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841037; cv=none; b=WZb7+cDwyFXkKKmtT58/y2KivOCXGaHryN7Ykdlx6hTDZas8HAZ8g6nzIzKZ9zTnC3KrVwA2XUIfV3cumrtHZ6cTcs4tLExvbnmoXFROJ9cg7TtDqJLEHu81etirsjFdg/Ax0Uj7vnWbcqjDLYla/3obLz+NdNW3Np+lid4m+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841037; c=relaxed/simple;
	bh=vRvYnx2c1l2D1WPQEEH64OtnWTWHEISQNziU6iKHexw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gcMl1a3l6Dv5DA/800tGvBIvcPrbzCfIFJi/CGPc1X4f2g4uYt9q+jCOaGTxHmL57S39KfoEGuRqyBRyFfvN63Le4qjuKjyPd4jDKsrfexH84dHgQisgr+IkfsGuDFNK4MQxETAhdjn4SbWCgc8IGrtiizE8iyokhIisptBWIw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=fubEgL8R; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="fubEgL8R"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E41FD4437C;
	Thu, 30 Oct 2025 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1761841027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qxTWDnRVatK0cxdORsBe+iw9KTvtJbv9HOvLf+4iPs=;
	b=fubEgL8RFPcd1mD5dwcOdRSgX1Mmi76dhPYS8hkL1X04J7iPW7LqrbQP91VzBNqKe3pE19
	Q9vZnNZtbdXOoIlQVm6COtwjp9fh3HJj7Smx0GRTc3ZA/SeutrmYDy905qoI7e8jU65ZIl
	58NHdsfXrBEP/hXunhmiC/ZIzMHmRfXA6IlPTcRFlmTRumQd0YQAy1ItLZVa7Wy92SkT+h
	sFDYfNd3jZFh3Yyr+bZk1Em7pljirDjS7fC0kPsV7knZQ/kXAml2HOxCIQ0iwxR5nlIoFj
	RvgAH/JWXr9JXg8JHLw8S8qM9ii8l1uFZ43u01O8C1oLIFtmYT+K+hHY/qFSEQ==
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>
Cc: Giulio Moro <giulio@bela.io>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <20251030132602.2d1ccfcc@wsk> (=?utf-8?Q?=22=C5=81ukasz?=
 Majewski"'s message of
	"Thu, 30 Oct 2025 13:26:02 +0100")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org> <20251023155439.0170f987@wsk>
	<87a51djuor.fsf@xenomai.org> <20251027120535.7933c720@wsk>
	<20251027172505.29eecfb2@wsk> <875xbyawx7.fsf@xenomai.org>
	<20251029145125.71debaab@wsk> <20251030132602.2d1ccfcc@wsk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 30 Oct 2025 17:17:06 +0100
Message-ID: <87qzukuzy5.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepudejieegtdfffeevjeekieegheduieeuueelhfelfffgtdetvdfhledujeeguedvnecuffhomhgrihhnpehsfihuphgurghtvgdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhiuhhlihhosegsvghlrgdrihhopdhrtghpthhtoheplhhukhhmrgesnhgrsghlrgguvghvrdgtohhm
X-GND-Sasl: rpm@xenomai.org


Hi =C5=81ukasz,

=C5=81ukasz Majewski <lukma@nabladev.com> writes:

>> > Could you get me a trace which goes back up to two secs before the
>> > time reported by evl about the inband switch of the timer responder?
>> > e.g.
>
> Why is it 2 seconds? Is it related to latmus "refresh time"? (which is
> 1s)
>

Picking this delay is purely heuristical. Such a long backlog is likely
going to include the smoking gun, if any.

>> >=20
>> > [   75.214527] EVL: timer-responder:743 switching in-band [pid=3D745,
>> > excpt=3D14, user_pc=3D0x77d08492a5fe]
>> >=20
>> > In the above case, I would need a trace going back to 73.214527 or
>> > so.=20
>>=20
>> Apparently the ftrace buffer was too small. I will adjust it to store
>> more data and share results.
>
> It is also interesting, that:
>
> bash-5.2# echo 16384 > /sys/kernel/debug/tracing/buffer_size_kb
> bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
> 16387
> bash-5.2# evl trace -eirq -f
> tracing enabled
> bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
> 131
>
> Reduces the buffer size...
>

Yeah, the evl-trace script is not that smart. I can see the issue
causing this, will fix.

> Hence, I've used the "normal" ftrace with enabled evl functions - the

FWIW, EVL relies on the normal ftrace. However, evl-trace fiddles with
the sysfs entries manually, and may be a bit naive at times. As Jan
pointed out long ago, relying on the trace-cmd front-end would be a
better approach than tweaking ftrace's sysfs-based controls manually at
the very least. evl-trace adds EVL semantics to the tracing
configuration which is handy, but the way it is done today may deserve a
revamping, or maybe drop it entirely in favor of trace-cmd if we have
enough flexibility there in order to introduce some EVL specifics.

> detailed information about the ftrace config is with log files:
> https://nextcloud.swupdate.org/index.php/s/czBd3Ydq9B9noZ7
>
>
> To extract the cpu2 specific data:
> bash-5.2# grep -rnE '\[002\]' Xenomai4-ISW-trace-6.6-logs.txt > cpu2.txt
>
> Here again the ISW happens in the cpu2 execution "hole":
> [  128.466459] EVL: timer-responder:736 switching in-band [pid=3D738,
> excpt=3D14, user_pc=3D0x7588e71985fe]
>
> Happens for cpu2 between:
>
> 11832546:          <idle>-0     [002] *..2.   128.466438:
> 	sched_idle_set_state <-cpuidle_enter_state
> 11832547:          <idle>-0     [002] *..2.   128.466468:
> 	handle_irq_pipelined_prepare <-arch_pipeline_entry
>
> However, now the log is large enough to inspect what has happened in
> the system for ~4s before.
>
>
> With the logs:
> timer-responder-738     [002] *.~2.   128.466214: evl_timer_shot:
> [proxy-timer/2] at 128.466467 (delay: 253 us, 66918 cycles)
>
> and after ISW:
>
> <idle>-0       [002] *.~1.   128.466469: evl_timer_shot:
> latmus_pulse_handler at 128.467208 (delay: 739 us, 195206 cycles)
>
> Why there is such increase in "delay" (253 vs 739 us) ?=20
>
> It looks like we have only 2us delay as the timer has fired on
> 128.466469 vs. expected 128.466467.
>

Ok, so the issue is still the same: for some reason, the timer-responder
thread is taking a (minor) fault when accessing some memory, on its way
back from the ioctl(EVL_LATIOC_PULSE) syscall, or right after. This
seems to be valid memory though, just not immediately accessible,
otherwise we'd have received SEGV, which we did not.

--
          <idle>-0       [002] #.~2.   129.084225: fpu__suspend_inband <-do=
vetail_context_switch
          <idle>-0       [002] #.~2.   129.084225: switch_mm_irqs_off <-dov=
etail_context_switch
 timer-responder-738     [002] *.~3.   129.084225: switch_fpu_return <-dove=
tail_context_switch
 timer-responder-738     [002] *.~2.   129.084225: evl_switch_tail: { curre=
nt=3Dtimer-responder:736[738] }
 timer-responder-738     [002] d.~2.   129.084225: evl_finish_wait: wchan=
=3D&wf->wait
 timer-responder-738     [002] d.~2.   129.084225: evl_oob_sysexit: result=
=3D0
--

The responder is resuming from a wait on the EVL_LATIOC_PULSE flag,
leaving the kernel, all seems fine so far.. I'm trying to find some
rationale for taking a fault in the syscall return path from the
assembly section which would explain a lack of trace _and_ the faulting
instruction living in a user-space mapping (this is no vDSO call
anyway), but cannot find any so far. A corruption of the register frame
used in restoring the calling user context would most likely have
triggered a major fault, not a minor one. Hopefully.

--
 timer-responder-738     [002] *.~3.   129.084226: handle_oob_trap_entry <-=
__oob_trap_notify
 timer-responder-738     [002] *.~2.   129.084227: evl_thread_fault: ip=3D0=
x7588e71985fe trapnr=3D0xe
 timer-responder-738     [002] *.~3.   129.084227: _printk <-handle_oob_tra=
p_entry
--

We need more information from the register file passed to us upon
trap. Could you apply the following quick patch to the test kernel? (not
to be upstreamed as-is, this is x86-specific unlike the file it applies
to). TIA,

diff --git a/include/trace/events/evl.h b/include/trace/events/evl.h
index 7136437d00227..3deeafb17e0fc 100644
--- a/include/trace/events/evl.h
+++ b/include/trace/events/evl.h
@@ -443,17 +443,26 @@ TRACE_EVENT(evl_thread_fault,
 	TP_ARGS(trapnr, regs),
=20
 	TP_STRUCT__entry(
+		__field(long,	sp)
+		__field(long,	flags)
 		__field(long,	ip)
+		__field(long,	orig_ax)
+		__field(u16,	cs)
 		__field(unsigned int, trapnr)
 	),
=20
 	TP_fast_assign(
+		__entry->sp =3D regs->sp;
+		__entry->flags =3D regs->flags;
 		__entry->ip =3D instruction_pointer(regs);
+		__entry->orig_ax =3D regs->orig_ax;
+		__entry->cs =3D regs->cs;
 		__entry->trapnr =3D trapnr;
 	),
=20
-	TP_printk("ip=3D%#lx trapnr=3D%#x",
-		  __entry->ip, __entry->trapnr)
+	TP_printk("ip=3D%#lx trapnr=3D%#x, sp=3D%#lx, flags=3D%#lx, orig_ax=3D%#l=
x, cs=3D%#hx",
+		__entry->ip, __entry->trapnr,
+		__entry->sp, __entry->flags, __entry->orig_ax, __entry->cs)
 );
=20
 TRACE_EVENT(evl_thread_set_current_prio,

--=20
Philippe.
