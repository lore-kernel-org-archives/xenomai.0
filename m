Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB38C2E7651
	for <xenomai@lists.linux.dev>; Fri, 31 Oct 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926190; cv=none; b=bgKXsoWGODOHr3Xj59I8dQJUwQqUIJbL0UVediZKc9/vxIxpg5tnluKw+GCyJuCe2yWMmxSyf/7Nb0dT6M6Oc3uoEekhywb9nAcuhDTT9B/dyyIQfooNvrETA9QvniB5DJTXvOaZk6C+dvxUUuMYLEyf6yb3J4T1V0fUj6oYKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926190; c=relaxed/simple;
	bh=f8X87ugZ57MkfYE/CgsZ5vW8KoiAul43I56x3YvklEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTOXMRv0nPWlrm+wstZbC59lcPOiMJy4TabMN7q9qfm66P6CVlTlDHYiKEEexKyz14UP1wUISjRa0B+9w5kMnPWObk91X+m88gddPYBoO/6o/6nPHwr5fi7n7oOBTXPoF9vtceYpw5PbtF7KnfcDLBiX3XB+t1dmrTZGL8F181o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=fKvaO/+D; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="fKvaO/+D"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C203E10830B;
	Fri, 31 Oct 2025 16:56:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1761926179;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dYi5E60Ze4seY0pwIFLnQx23e9Fm0D7xDPXfGwEJHHE=;
	b=fKvaO/+Doxl0fK/gJBbgimbXS31NzFPsE79oyeo6cMwDF9JGTcfFLfNKN7me0r2JasXbLS
	ZCpkq8tx74ZMD/conI+9IJRWkjiB5xfkBBnEH9cqiPDLeUh1KMr6w6viFA787fr4zbxTtV
	jJ0K/V4gGw2E7xkTkAdoV6XfYkC93Wqv5SQdKHeZnMyQyR67yuCRw779YHt2c2L6VmCFl6
	GF/nvcWPhVcipLl9pXdbOKN+1lsj1ILldIMCT2pTE8c816IwXrgm0X/9Bq3+1f5wB6ORAG
	Q35mFcFgGFHY9OQV2csmBA/HcmaiGKvOK69XNPqnGajfehE0oHbFc7m5RkyBYA==
Date: Fri, 31 Oct 2025 16:56:15 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Giulio Moro <giulio@bela.io>, Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251031165615.2c9f72f5@wsk>
In-Reply-To: <87qzukuzy5.fsf@xenomai.org>
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

Hi Philippe,

> Hi =C5=81ukasz,
>=20
> =C5=81ukasz Majewski <lukma@nabladev.com> writes:
>=20
> >> > Could you get me a trace which goes back up to two secs before
> >> > the time reported by evl about the inband switch of the timer
> >> > responder? e.g. =20
> >
> > Why is it 2 seconds? Is it related to latmus "refresh time"? (which
> > is 1s)
> > =20
>=20
> Picking this delay is purely heuristical. Such a long backlog is
> likely going to include the smoking gun, if any.
>=20
> >> >=20
> >> > [   75.214527] EVL: timer-responder:743 switching in-band
> >> > [pid=3D745, excpt=3D14, user_pc=3D0x77d08492a5fe]
> >> >=20
> >> > In the above case, I would need a trace going back to 73.214527
> >> > or so.  =20
> >>=20
> >> Apparently the ftrace buffer was too small. I will adjust it to
> >> store more data and share results. =20
> >
> > It is also interesting, that:
> >
> > bash-5.2# echo 16384 > /sys/kernel/debug/tracing/buffer_size_kb
> > bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
> > 16387
> > bash-5.2# evl trace -eirq -f
> > tracing enabled
> > bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
> > 131
> >
> > Reduces the buffer size...
> > =20
>=20
> Yeah, the evl-trace script is not that smart. I can see the issue
> causing this, will fix.
>=20
> > Hence, I've used the "normal" ftrace with enabled evl functions -
> > the =20
>=20
> FWIW, EVL relies on the normal ftrace. However, evl-trace fiddles with
> the sysfs entries manually, and may be a bit naive at times. As Jan
> pointed out long ago, relying on the trace-cmd front-end would be a
> better approach than tweaking ftrace's sysfs-based controls manually
> at the very least. evl-trace adds EVL semantics to the tracing
> configuration which is handy, but the way it is done today may
> deserve a revamping, or maybe drop it entirely in favor of trace-cmd
> if we have enough flexibility there in order to introduce some EVL
> specifics.
>=20
> > detailed information about the ftrace config is with log files:
> > https://nextcloud.swupdate.org/index.php/s/czBd3Ydq9B9noZ7
> >
> >
> > To extract the cpu2 specific data:
> > bash-5.2# grep -rnE '\[002\]' Xenomai4-ISW-trace-6.6-logs.txt >
> > cpu2.txt
> >
> > Here again the ISW happens in the cpu2 execution "hole":
> > [  128.466459] EVL: timer-responder:736 switching in-band [pid=3D738,
> > excpt=3D14, user_pc=3D0x7588e71985fe]
> >
> > Happens for cpu2 between:
> >
> > 11832546:          <idle>-0     [002] *..2.   128.466438:
> > 	sched_idle_set_state <-cpuidle_enter_state
> > 11832547:          <idle>-0     [002] *..2.   128.466468:
> > 	handle_irq_pipelined_prepare <-arch_pipeline_entry
> >
> > However, now the log is large enough to inspect what has happened in
> > the system for ~4s before.
> >
> >
> > With the logs:
> > timer-responder-738     [002] *.~2.   128.466214: evl_timer_shot:
> > [proxy-timer/2] at 128.466467 (delay: 253 us, 66918 cycles)
> >
> > and after ISW:
> >
> > <idle>-0       [002] *.~1.   128.466469: evl_timer_shot:
> > latmus_pulse_handler at 128.467208 (delay: 739 us, 195206 cycles)
> >
> > Why there is such increase in "delay" (253 vs 739 us) ?=20
> >
> > It looks like we have only 2us delay as the timer has fired on
> > 128.466469 vs. expected 128.466467.
> > =20
>=20
> Ok, so the issue is still the same: for some reason, the
> timer-responder thread is taking a (minor) fault when accessing some
> memory, on its way back from the ioctl(EVL_LATIOC_PULSE) syscall, or
> right after. This seems to be valid memory though, just not
> immediately accessible, otherwise we'd have received SEGV, which we
> did not.

Yes, I also think so - like some "deferred allocation" despite of
mlockall.

Please find the logs with the below patch applied:
https://nextcloud.swupdate.org/index.php/s/JXNW5bJrB3fQo5E

>=20
> --
>           <idle>-0       [002] #.~2.   129.084225:
> fpu__suspend_inband <-dovetail_context_switch <idle>-0       [002]
> #.~2.   129.084225: switch_mm_irqs_off <-dovetail_context_switch
> timer-responder-738     [002] *.~3.   129.084225: switch_fpu_return
> <-dovetail_context_switch timer-responder-738     [002] *.~2.
> 129.084225: evl_switch_tail: { current=3Dtimer-responder:736[738] }
> timer-responder-738     [002] d.~2.   129.084225: evl_finish_wait:
> wchan=3D&wf->wait timer-responder-738     [002] d.~2.   129.084225:
> evl_oob_sysexit: result=3D0 --
>=20
> The responder is resuming from a wait on the EVL_LATIOC_PULSE flag,
> leaving the kernel, all seems fine so far.. I'm trying to find some
> rationale for taking a fault in the syscall return path from the
> assembly section which would explain a lack of trace _and_ the
> faulting instruction living in a user-space mapping (this is no vDSO
> call anyway), but cannot find any so far. A corruption of the
> register frame used in restoring the calling user context would most
> likely have triggered a major fault, not a minor one. Hopefully.
>=20
> --
>  timer-responder-738     [002] *.~3.   129.084226:
> handle_oob_trap_entry <-__oob_trap_notify timer-responder-738
> [002] *.~2.   129.084227: evl_thread_fault: ip=3D0x7588e71985fe
> trapnr=3D0xe timer-responder-738     [002] *.~3.   129.084227: _printk
> <-handle_oob_trap_entry --
>=20
> We need more information from the register file passed to us upon
> trap. Could you apply the following quick patch to the test kernel?
> (not to be upstreamed as-is, this is x86-specific unlike the file it
> applies to). TIA,
>=20
> diff --git a/include/trace/events/evl.h b/include/trace/events/evl.h
> index 7136437d00227..3deeafb17e0fc 100644
> --- a/include/trace/events/evl.h
> +++ b/include/trace/events/evl.h
> @@ -443,17 +443,26 @@ TRACE_EVENT(evl_thread_fault,
>  	TP_ARGS(trapnr, regs),
> =20
>  	TP_STRUCT__entry(
> +		__field(long,	sp)
> +		__field(long,	flags)
>  		__field(long,	ip)
> +		__field(long,	orig_ax)
> +		__field(u16,	cs)
>  		__field(unsigned int, trapnr)
>  	),
> =20
>  	TP_fast_assign(
> +		__entry->sp =3D regs->sp;
> +		__entry->flags =3D regs->flags;
>  		__entry->ip =3D instruction_pointer(regs);
> +		__entry->orig_ax =3D regs->orig_ax;
> +		__entry->cs =3D regs->cs;
>  		__entry->trapnr =3D trapnr;
>  	),
> =20
> -	TP_printk("ip=3D%#lx trapnr=3D%#x",
> -		  __entry->ip, __entry->trapnr)
> +	TP_printk("ip=3D%#lx trapnr=3D%#x, sp=3D%#lx, flags=3D%#lx,
> orig_ax=3D%#lx, cs=3D%#hx",
> +		__entry->ip, __entry->trapnr,
> +		__entry->sp, __entry->flags, __entry->orig_ax,
> __entry->cs) );
> =20
>  TRACE_EVENT(evl_thread_set_current_prio,
>=20



--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
