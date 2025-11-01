Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B0285CA3
	for <xenomai@lists.linux.dev>; Sat,  1 Nov 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761996699; cv=none; b=Zn2rhGpQVOrLGN5rvEu/jHnfKBld4Xg91ouy1nPnu8AgD+dw7XRBmSokiRBjbAx3FiaUlPG+Q120jdunisyxblS/Mmsd1uNrp0oYbjLkU7oD6ktN9olYijGJaPRx/XS2Rpc0T7G68mCsNVIkPevhqS6GMNk7gCxpg39EOFy9EqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761996699; c=relaxed/simple;
	bh=+B1ApxpkLyMWCkahtghw7rt0VPUJJ2ptQxb9Dg4q5iE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRQD5d2jO3qyJ957Xs/3rDZeBkFxbb0erRFTxEWVeM7APL1rNwKgG9Uwx/8sfLH0MvtLYc60u6JskPlWQxcOnbLPY5Qsm4OEgcVDYF1igibaVVtKPBOKLGMzWSOmb1OMnojJWAJfMgDiklKHspqhkCYWmLeWfetZRQdIEbTxoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=GcfhlRrQ; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="GcfhlRrQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28C7B102C48;
	Sat,  1 Nov 2025 12:31:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1761996694;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3cfwkhcjzHJpeAhgU3EVRBLMtfh+kqZLt3OGg3L3yDM=;
	b=GcfhlRrQoshKFortVMb/ZfpR5XGUc6/JIECGtoqrNhD2zKu24HJtXe0AqyqohjyrbIF8NQ
	L8CIrZg/JPcylwwVZhl0Lwv1LelZYKVdJR97mw4UO5xwK0pXcj2QuF8Wx04ANRyzzUlGy/
	qYIDkK0W+oChjVMS/UbY9e5EecxMHre2zuwdmD1x+mWcsxoY2R1wO6F/+74UVcRPXxqfd4
	HMgPS5nyQP8kKmdcznUn9okpHC9WYYMYryfKVfAPWlxD2EN5kRFh9GubVqxwRfWMlZyo8W
	UxD+Wrulm1sgDS+qqdmrcyo8UiSWtSpWrQSsIyk20hHA0vWgNvDSjqEH/BVlFA==
Date: Sat, 1 Nov 2025 12:31:30 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Giulio Moro <giulio@bela.io>,
 Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251101123130.2653e531@wsk>
In-Reply-To: <875xbvc5a3.fsf@xenomai.org>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org>
	<87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org>
	<20251023155439.0170f987@wsk>
	<87a51djuor.fsf@xenomai.org>
	<20251027120535.7933c720@wsk>
	<20251027172505.29eecfb2@wsk>
	<875xbyawx7.fsf@xenomai.org>
	<20251029145125.71debaab@wsk>
	<20251030132602.2d1ccfcc@wsk>
	<87qzukuzy5.fsf@xenomai.org>
	<20251031165615.2c9f72f5@wsk>
	<87bjlnc9u5.fsf@xenomai.org>
	<5c69758f-876b-4a56-99b7-09eb22537680@siemens.com>
	<875xbvc5a3.fsf@xenomai.org>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Philippe, Jan,

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
> > On 31.10.25 17:30, Philippe Gerum wrote: =20
> >> =C5=81ukasz Majewski <lukma@nabladev.com> writes:
> >>  =20
> >>> Hi Philippe,
> >>> =20
> >>>> Hi =C5=81ukasz,
> >>>>
> >>>> =C5=81ukasz Majewski <lukma@nabladev.com> writes:
> >>>> =20
> >>>>>>> Could you get me a trace which goes back up to two secs before
> >>>>>>> the time reported by evl about the inband switch of the timer
> >>>>>>> responder? e.g.   =20
> >>>>>
> >>>>> Why is it 2 seconds? Is it related to latmus "refresh time"?
> >>>>> (which is 1s)
> >>>>>   =20
> >>>>
> >>>> Picking this delay is purely heuristical. Such a long backlog is
> >>>> likely going to include the smoking gun, if any.
> >>>> =20
> >>>>>>>
> >>>>>>> [   75.214527] EVL: timer-responder:743 switching in-band
> >>>>>>> [pid=3D745, excpt=3D14, user_pc=3D0x77d08492a5fe]
> >>>>>>>
> >>>>>>> In the above case, I would need a trace going back to
> >>>>>>> 73.214527 or so.    =20
> >>>>>>
> >>>>>> Apparently the ftrace buffer was too small. I will adjust it to
> >>>>>> store more data and share results.   =20
> >>>>>
> >>>>> It is also interesting, that:
> >>>>>
> >>>>> bash-5.2# echo 16384 > /sys/kernel/debug/tracing/buffer_size_kb
> >>>>> bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
> >>>>> 16387
> >>>>> bash-5.2# evl trace -eirq -f
> >>>>> tracing enabled
> >>>>> bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
> >>>>> 131
> >>>>>
> >>>>> Reduces the buffer size...
> >>>>>   =20
> >>>>
> >>>> Yeah, the evl-trace script is not that smart. I can see the issue
> >>>> causing this, will fix.
> >>>> =20
> >>>>> Hence, I've used the "normal" ftrace with enabled evl functions
> >>>>> - the   =20
> >>>>
> >>>> FWIW, EVL relies on the normal ftrace. However, evl-trace
> >>>> fiddles with the sysfs entries manually, and may be a bit naive
> >>>> at times. As Jan pointed out long ago, relying on the trace-cmd
> >>>> front-end would be a better approach than tweaking ftrace's
> >>>> sysfs-based controls manually at the very least. evl-trace adds
> >>>> EVL semantics to the tracing configuration which is handy, but
> >>>> the way it is done today may deserve a revamping, or maybe drop
> >>>> it entirely in favor of trace-cmd if we have enough flexibility
> >>>> there in order to introduce some EVL specifics.
> >>>> =20
> >>>>> detailed information about the ftrace config is with log files:
> >>>>> https://nextcloud.swupdate.org/index.php/s/czBd3Ydq9B9noZ7
> >>>>>
> >>>>>
> >>>>> To extract the cpu2 specific data:
> >>>>> bash-5.2# grep -rnE '\[002\]' Xenomai4-ISW-trace-6.6-logs.txt >
> >>>>> cpu2.txt
> >>>>>
> >>>>> Here again the ISW happens in the cpu2 execution "hole":
> >>>>> [  128.466459] EVL: timer-responder:736 switching in-band
> >>>>> [pid=3D738, excpt=3D14, user_pc=3D0x7588e71985fe]
> >>>>>
> >>>>> Happens for cpu2 between:
> >>>>>
> >>>>> 11832546:          <idle>-0     [002] *..2.   128.466438:
> >>>>> 	sched_idle_set_state <-cpuidle_enter_state
> >>>>> 11832547:          <idle>-0     [002] *..2.   128.466468:
> >>>>> 	handle_irq_pipelined_prepare <-arch_pipeline_entry
> >>>>>
> >>>>> However, now the log is large enough to inspect what has
> >>>>> happened in the system for ~4s before.
> >>>>>
> >>>>>
> >>>>> With the logs:
> >>>>> timer-responder-738     [002] *.~2.   128.466214:
> >>>>> evl_timer_shot: [proxy-timer/2] at 128.466467 (delay: 253 us,
> >>>>> 66918 cycles)
> >>>>>
> >>>>> and after ISW:
> >>>>>
> >>>>> <idle>-0       [002] *.~1.   128.466469: evl_timer_shot:
> >>>>> latmus_pulse_handler at 128.467208 (delay: 739 us, 195206
> >>>>> cycles)
> >>>>>
> >>>>> Why there is such increase in "delay" (253 vs 739 us) ?=20
> >>>>>
> >>>>> It looks like we have only 2us delay as the timer has fired on
> >>>>> 128.466469 vs. expected 128.466467.
> >>>>>   =20
> >>>>
> >>>> Ok, so the issue is still the same: for some reason, the
> >>>> timer-responder thread is taking a (minor) fault when accessing
> >>>> some memory, on its way back from the ioctl(EVL_LATIOC_PULSE)
> >>>> syscall, or right after. This seems to be valid memory though,
> >>>> just not immediately accessible, otherwise we'd have received
> >>>> SEGV, which we did not. =20
> >>>
> >>> Yes, I also think so - like some "deferred allocation" despite of
> >>> mlockall.
> >>>
> >>> Please find the logs with the below patch applied:
> >>> https://nextcloud.swupdate.org/index.php/s/JXNW5bJrB3fQo5E
> >>> =20
> >>=20
> >> Thanks. I need to analyze the fault flags next week to see if I
> >> can make something of these, but I just stumbled on an obviously
> >> significant fact when looking at the multi-CPU view: the memory
> >> compaction daemon is running asynchronously on other cores while
> >> the responder is taking the fault. Compaction is all about moving
> >> memory around to free larger physical regions, so updating PTEs
> >> will happen as a result.
> >>=20
> >> Moreover, I could not reproduce the issue at hand, but I did not
> >> have CONFIG_COMPACTION enabled. In the meantime, could you try
> >> disabling this on your end, to see if the fault still appears? =20
> >
> > CONFIG_COMPACTION selects CONFIG_MIGRATION, and that is well-known
> > to be incompatible with RT. Xenomai 3 is warning about that that,
> > EVL does not?=20
>=20
> Dovetail should do that when CONFIG_DOVETAIL is set, this is by
> definition common to any rt core.
>=20

bash-5.2# evl check
CONFIG_ACPI_PROCESSOR_IDLE=3Dy
CONFIG_EVL_DEBUG_CORE=3Dy
CONFIG_EVL_DEBUG_MEMORY=3Dy
CONFIG_FTRACE=3Dy

And of course three last entries were enabled when I've been "hunting"
the ISW in latmus cause.

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
