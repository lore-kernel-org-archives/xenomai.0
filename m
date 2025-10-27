Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89942FE07B
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563149; cv=none; b=j1RPRnEYqVshdglTrVRCiZvBJCl7dB50k1E141bW1/vUTKsNXSHhIlKrl0Y+g1PcV2fL/WzRVWVGYtF8kG6Wov8GQGm1WoM0r8IwbrlMwqckwBDKxkGQnf9wbVzSHQAb/kq7rihs4JNzoCTz2t3YnhOjo3XI/qRz/gE7YnqA1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563149; c=relaxed/simple;
	bh=1EKBRKh6cPoeFp0Utgl7ax+5YApKd54zcxN+CkvlROQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFis39Uld5BNFpaJtxqqjY7A92FyMhf+4prdzWCe61Z5L4WAnTGlVJ2FNZ12xhPTQQawMbW2ZGI5bpWGwyU8Bs/0gCVyWJcLNR/P57F7yMfPOTZ4bSLA7QWwunskNMhtVRnwUipwwkhBxu0JKwdvnMtBWCMJB6CN8iL1S/LdylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Q5gUdoWX; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Q5gUdoWX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 694061031CF;
	Mon, 27 Oct 2025 12:05:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1761563139;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=33R9rbC7O7mad91GMiZ2bNEGSGFpzPmgTxV9ElaQwYk=;
	b=Q5gUdoWXUSyyanLN5lxlFl7L0CzF8ZUIv0q3b1Emsumf9oES5YnYacUNSYO9LUwSlryyXj
	Vt0H71UjHJ26A7jcvCTvrdYXQjZoFKBo5sUyVT9AEBnlhbugzcxsZ1CQuyoVYBu5CD7JIn
	kdJL0ZFSx1tMCOEo4KJJgegkPDQiWPrmB0TokD810RbRF36mBsDJ+pldYgKfiQl2AePLZW
	PURZfSHXv0E+7+aO+ZjaY6gz+Ph38H+veQwrdUSADixQFO5YECS/pAGMzEWIkQB+R7i34K
	J7459oZrz4+9TuBvACGF/GGeQLXWHITKtnUzXoTZmuzO7JZpdjd81nTMp+TAbQ==
Date: Mon, 27 Oct 2025 12:05:35 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Giulio Moro <giulio@bela.io>, Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251027120535.7933c720@wsk>
In-Reply-To: <87a51djuor.fsf@xenomai.org>
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
> > Hi Philippe,
> > =20
> >> Giulio Moro <giulio@bela.io> writes:
> >>  =20
> >> > =C5=81ukasz Majewski wrote on 20/10/2025 02:47:
> >> >   =20
> >> >> Could you share which version of libevl do you use?   =20
> >> >
> >> > I was using the latest release of libevl that was compatible with
> >> > the kernel UAPI. Sorry I haven't provided more details on the
> >> > issue; I am focusing on building an image around 6.1 for a
> >> > deadline coming up next month so I haven't been able to get into
> >> > tracing yet.
> >> >
> >> > The only additional finding I have so far is that there seems to
> >> > be something on the Linux side that "breaks real-time" which
> >> > affects both linux and evl. In the below list, "evl bad" means
> >> > that the above mentioned ISW are observed. "Linux bad" means
> >> > that I see a disproportionate number of underruns under stress
> >> > on a Linux program running with SCHED_FIFO and priority 95 with
> >> > a period of 360us. I understand "disproportionate" is a very
> >> > subjective term but, to give an idea, over a 10 minutes test I
> >> > get a couple of underruns with "linux good" and I get hundreds
> >> > of underruns with "linux good"
> >> >
> >> > v6.12.y-evl-rebase: evl bad, linux bad
> >> > v6.11.y-evl-rebase: evl bad, linux untested
> >> > v6.10.y-evl-rebase: evl bad, linux untested
> >> > v6.9.y-evl-rebase: evl bad, linux bad
> >> > v6.6.y-evl-rebase: evl bad, linux bad
> >> > v6.3.y-evl-rebase: evl bad, linux bad on startup only
> >> > v6.2.y-evl-rebase: libevl r42, evl good, linux good
> >> > v6.1.y-cip-evl-rebase: libevl master, evl good, linux good
> >> >
> >> > Not sure if this is of any help; I hope to be able to get back on
> >> > this soon. Best,
> >> > Giulio   =20
> >>=20
> >> If someone could send me the relevant portion of a trace file with
> >> a 'latspot' tracepoint triggered on a latmus run, I could
> >> investigate this issue. I'd need the function tracer active on all
> >> CPUs, with all traces dumped to a single trace file ('evl trace
> >> -ef' should do).=20
> >
> > Please find tar'ed output for the trace(s).
> >
> > Please, however be aware that - I've fall back to 6.6 (as it is the
> > version in which I can reproduce the issue in the fastest way).
> >
> > Customer also reported, that they can reproduce with their SW stack
> > the issue on 6.1-slts and 6.12, but it takes considerably longer
> > than for 6.6 (in which I can use simple programs to "allocate"
> > memory).=20
>=20
> Ok, but 6.6 is definitely unmaintained Dovetail-wise, and has been so
> for several months now.

Yes, I'm aware of it ...

> So although this issue was observed with
> maintained releases too, debugging a current issue on an obsolete code
> base is a fragile process nevertheless.
>=20

It is fragile, yes - but:

1. I can reproduce it with minutes with fairly easy way

2. I do assume, that when we find the issue on 6.6, then we can
forward port it for 6.12 (and I will be more than happy to switch to
6.12+).

> > I've used pretty standard set of ftrace CONFIG_* options enabled.
> >
> > However, it seems like there is a "hole" around the time when
> > in-band switch has been reported (in dmesg) and in ftrace output.
> >
> > I'm going to do the same with all available tracers enabled.
> >
> > Last but not least, the latspot event is not present in my ftrace
> > output (although I've enabled all the CONFIG_EVL*DEBUG options).
> >
> > Is there any special set of options to required for EVL tracig?
> > =20
>=20
> Yes, you need to enable the evl/evl_latspot tracepoint.
> See [1].
>=20

I've been confused a bit.

With libevl r50 - I've used

evl trace -e -f
(and I've assumed that evl* specific traces will be added).

When I've check:
cat /sys/kernel/debug/tracing/events/evl/evl_latspot/enable

returned '1', so it shall be enabled as well.

However, when I run:

evl trace -eirq it now works as expected.


If I may made an observation - I would expect the following work flow
(according to [1]):

evl trace -eirq
evl trace -d
evl trace -p > foo.txt

However, evl trace -d disables tracing, yes, but also clears the buffer.
(instead of 'evl trace -d' I do use
'echo 0 > /sys/kernel/tracing/tracing_on')

> > Tars with logs:
> > https://nextcloud.swupdate.org/index.php/s/FgiMsHG9xG8frk3
> > https://nextcloud.swupdate.org/index.php/s/XcW75xsQPMXm3zg =20
>=20
> Ok, first observation, the logs reveal that we are in an OOM
> situation: the kernel strategy is best-effort there, to keep the
> system in the best possible state while sacrificing processes.

+1

> But
> honestly, although the VM_LOCKED pages are unevictable by definition,
> there are quite a few spots in the mm which might trigger the OOM
> reaper, including the inability to allocate page table information,
> insert new pages and so on. Although all the memory of an oob
> application is committed, with its VMAs populated once libevl has
> issued mlockall(), I genuinely don't know how this fares with an OOM
> situation.

I would expect that, the VM_LOCKED pages (and their entries to PTE)
would be the _last_ ones to be touched (if any).

However, maybe some "optimization" in mm was added to Linux kernel
recently and we do experience the consequences.

>=20
> Anyway, I still see a common pattern between the two set of traces,
> the unwanted inband switch happens during what seems to be time holes
> (assuming that traces of all CPUs are merged into each log):

Yes, those were traces for all cpus - added to a single file.

>=20
> [  285.166640] EVL: timer-responder:754 switching in-band [pid=3D756,
> excpt=3D14, user_pc=3D0x7be4dc59d5fe] <idle>-0       [022] *..1.
> 148.913052: rcu_dyntick: Start 1 0 0x8ec <idle>-0       [014] dN.1.
> 172.761906: rcu_dyntick: End 0 1 0x39c
>=20
> [  172.317009] EVL: timer-responder:743 switching in-band [pid=3D745,
> excpt=3D14, user_pc=3D0x7036049465fe] <idle>-0       [022] *..1.
> 148.913052: rcu_dyntick: Start 1 0 0x8ec <idle>-0       [014] dN.1.
> 172.761906: rcu_dyntick: End 0 1 0x39c
>=20
> A lot can be done in 24 =C2=B5s on such class of hardware,

For the record. Both Xenomai3 and Xenomai4 have been run on the
identical hardware.

On Xenomai3 there are no issues...

> so either some
> traces are missing,

I will check if I can add more tracing.

> or something happens at hardware level which the
> kernel does not know about, as it may be seen on x86 with some
> uncooperative BIOS (e.g. SMIs, thermal events come to mind).

IIRC - Giulio reported the issue on some ARM system...

> Hopefully
> this is not the case, but then we need to make sure that some traces
> are indeed missing. If such time hole is confirmed though, then the
> issue Giulio is seeing might be different.
>=20
> [1] https://v4.xenomai.org/core/commands/index.html#evl-trace-command
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
