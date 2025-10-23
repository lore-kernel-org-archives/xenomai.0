Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD94315D57
	for <xenomai@lists.linux.dev>; Thu, 23 Oct 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227696; cv=none; b=VMUKZ/n5dI0i3ceL2r1CGxCqMd6b14Ag2KIk/4wkyHFOmilf21F7Ur/OyDlaGz2K+h4wIKJLjfEehCS4JscJhE3KjjLP8JTrqZ1RZnQF8qZI8S64Xn34SXNx1vmHcZfymdeEBKqJiCeQUefMiWjuhHdq48Xpdk/mUmq7n65Gt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227696; c=relaxed/simple;
	bh=vlBxEhADYDa2TcFegGTG3dySMluFjyKumXDJdGYX1Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYXllYnvDT2fo0FN3ck/dO74A4fGFM54teHFP8AvcKhJHUp9GpAajhGgWjSeKEwNSvTNzXprFw3Sxp+xupsu9JbSr51uLERXVTtGQtfKCxkRmiw3Fh6nMSFO4La/XPuHB9/ugJNbqSfjSnSU20iuMynKIGoUsdxH9GiFNGFiRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=GXqiaf+D; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="GXqiaf+D"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C73781031D9;
	Thu, 23 Oct 2025 15:54:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1761227685;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vlBxEhADYDa2TcFegGTG3dySMluFjyKumXDJdGYX1Fg=;
	b=GXqiaf+D3XfqAuM/nCY/dcd0UgSRJ6y3Ehr7M9NKROmUKndbAx3fFkpNXlaXzsCzIvK8y/
	kcIjO+YurXjlxtmn79NCGwxWlUVVSjJnPGGAkFgWwVbMbvBpOLz0eJPf6LW7GKr6ujUSIF
	2wyBgVBu6vo3cbicQt9VavRfv4oLJHazxmkGbBafLBDTtl1fT9O0prIyEUMOsn5Q6Jv3/h
	QASldrWJZJbdgk7wefMggPa+qjwGbFaLASzpJO+5R43jquWuSuycH65DItHHq8ZqMfPyxV
	K6lfqESAMfU0k4nK98rb5NaPzDqLU2iPMEGMRseVe6M7puJBScWin5M+Fk4RKQ==
Date: Thu, 23 Oct 2025 15:54:39 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Giulio Moro <giulio@bela.io>, Xenomai  <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251023155439.0170f987@wsk>
In-Reply-To: <87o6q1ad07.fsf@xenomai.org>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org>
	<87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org>
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

> Giulio Moro <giulio@bela.io> writes:
>=20
> > =C5=81ukasz Majewski wrote on 20/10/2025 02:47:
> > =20
> >> Could you share which version of libevl do you use? =20
> >
> > I was using the latest release of libevl that was compatible with
> > the kernel UAPI. Sorry I haven't provided more details on the
> > issue; I am focusing on building an image around 6.1 for a deadline
> > coming up next month so I haven't been able to get into tracing yet.
> >
> > The only additional finding I have so far is that there seems to be
> > something on the Linux side that "breaks real-time" which affects
> > both linux and evl. In the below list, "evl bad" means that the
> > above mentioned ISW are observed. "Linux bad" means that I see a
> > disproportionate number of underruns under stress on a Linux program
> > running with SCHED_FIFO and priority 95 with a period of 360us. I
> > understand "disproportionate" is a very subjective term but, to give
> > an idea, over a 10 minutes test I get a couple of underruns with
> > "linux good" and I get hundreds of underruns with "linux good"
> >
> > v6.12.y-evl-rebase: evl bad, linux bad
> > v6.11.y-evl-rebase: evl bad, linux untested
> > v6.10.y-evl-rebase: evl bad, linux untested
> > v6.9.y-evl-rebase: evl bad, linux bad
> > v6.6.y-evl-rebase: evl bad, linux bad
> > v6.3.y-evl-rebase: evl bad, linux bad on startup only
> > v6.2.y-evl-rebase: libevl r42, evl good, linux good
> > v6.1.y-cip-evl-rebase: libevl master, evl good, linux good
> >
> > Not sure if this is of any help; I hope to be able to get back on
> > this soon. Best,
> > Giulio =20
>=20
> If someone could send me the relevant portion of a trace file with a
> 'latspot' tracepoint triggered on a latmus run, I could investigate
> this issue. I'd need the function tracer active on all CPUs, with all
> traces dumped to a single trace file ('evl trace -ef' should do).
>=20

Please find tar'ed output for the trace(s).

Please, however be aware that - I've fall back to 6.6 (as it is the
version in which I can reproduce the issue in the fastest way).

Customer also reported, that they can reproduce with their SW stack the
issue on 6.1-slts and 6.12, but it takes considerably longer than for
6.6 (in which I can use simple programs to "allocate" memory).

I've used pretty standard set of ftrace CONFIG_* options enabled.

However, it seems like there is a "hole" around the time when in-band
switch has been reported (in dmesg) and in ftrace output.

I'm going to do the same with all available tracers enabled.

Last but not least, the latspot event is not present in my ftrace
output (although I've enabled all the CONFIG_EVL*DEBUG options).

Is there any special set of options to required for EVL tracig?

Tars with logs:
https://nextcloud.swupdate.org/index.php/s/FgiMsHG9xG8frk3
https://nextcloud.swupdate.org/index.php/s/XcW75xsQPMXm3zg


--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
