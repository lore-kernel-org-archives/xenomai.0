Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40F134AB
	for <xenomai@lists.linux.dev>; Tue, 21 Oct 2025 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045218; cv=none; b=eUstm7aOjSMgzlgAIZoGE4HYYoS+fO3zRkAHl4SssMbTNXx5Iur13jcdN8IbcC9XCIVqvvg8zCweDu3VWXl9v1F1SDZEvhX571d27IB46hIRXFqY8YceGcogQRhC4bNjxPK6esIwPJ7CM726XzVOjZBFKtLPRzBG0TovFyMxkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045218; c=relaxed/simple;
	bh=uQwR61Ey4bQjzIugsViNUNP/9r3v5paQaOQwXsNAfDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRkW1BA/5/p1e8wmDoP0MztCw1QXoQq2zN/HibzRHjOXpESbgmYQtGuPT4ECwqTMF+PUKc6nUr6bLUZY1kVCBNsskH3njBivMcuoCQfFUcvlomZ3fHePtiNI7hdjG2XjdMIHU+Npw+04+um4rmAtxqH39WgdKjPC+b5k0E5BCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=EMDSMx6m; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="EMDSMx6m"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B174101EC7;
	Tue, 21 Oct 2025 13:13:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1761045208;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uQwR61Ey4bQjzIugsViNUNP/9r3v5paQaOQwXsNAfDA=;
	b=EMDSMx6m/0kQw+I9CTfvzIO5KCW598LFBCW1jILFRN+7/h8iOnxjS3IjgDfFOjAZHzKun0
	BKuSHxJ2Hl/XGFAvJTRR+gCzlyvZYktpt92R3K51yZBWYZSyZQcXb20Lk4pZHfy1UxIJW9
	pS8zvURa/6NHa9XGQcAy/WlpClMcZWJ1RtTL/0ioJDTY+TOAU0FsFyx5j9SNOqmfgH3Vvn
	ogKUe2KlFXA1QO6j0DwqX2p+Fw45uXM5yt9yax7sGbrhTttLuKbGhRI+MvkEQHXAWA/ndT
	Vik20wVp2o/QyZttsfLmopPQBGEQcG+Ykaq8uT9e7fLdIkRZ5E/hAX4RlFUhVQ==
Date: Tue, 21 Oct 2025 13:13:26 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Giulio Moro <giulio@bela.io>, Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251021131326.7c48b483@wsk>
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

Hi Philippe, Giulio,

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

The evl ps -l -> gives value of ISW 0 all the time.

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

When switching to 6.12.y-evl-rebase [1] (including the MMF_DOVETAIL bit
fix with libevl r55) I cannot catch the issue anymore. For comparison -
I've fallback to 6.6 (with r50 libevl) with the same setup and I can
catch it.

Giulio, on what system do you run the test setup:

echo 2 | sudo tee /proc/sys/vm/overcommit_memory
echo 0 | sudo tee /proc/sys/vm/overcommit_ratio
echo 1 | sudo tee /proc/sys/vm/oom_kill_allocating_task

I then have a C++ program allocating 50MiB, and I run 4 or more
instances of it, one per core:
 =20
while sleep 0.1; do ./alloc& ./alloc& ./alloc& ./alloc; done

Furthermore, I have four instance of dd in the background:

dd if=3D/dev/zero of=3D/dev/null

With that, I can trigger latmus's inband switch pretty reliably within
seconds (e.g.: latmus -m -K -p 360)

As on mine the write to:
echo 0 | sudo tee /proc/sys/vm/overcommit_ratio

just makes the system unusable:
./run_tst.sh: fork: Cannot allocate memory



>=20
> If someone could send me the relevant portion of a trace file with a
> 'latspot' tracepoint triggered on a latmus run, I could investigate
> this issue. I'd need the function tracer active on all CPUs, with all
> traces dumped to a single trace file ('evl trace -ef' should do).
>=20

I strive to have the issue reproductible on 6.12.

Links:
[1] -
https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commits/v6.12.y-evl-rebase?=
ref_type=3Dheads

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
