Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460990;
	b=0/Oevy5By6kHtAFqRfel6m2hZBMNcQrrDvimpARdf/HGI7r8bduD7/kdxyZgKkbFYFvx
	 kPCF+HqdUvkyzGdwQ/P3v7uwy+9qXeRmkbem9FhT6emzlTtdcbdNkmbpZZ5Dte7LObVJg
	 ynBh6tQd91ppWvMUt+CLD3tXTUHykEtwuslNR6q3YYrHG76eJTnipjNn4idORgRoE2ocO
	 V8KRXPnl18np1dz9pz7UmyBu8G3Ua8veVr/d8pCRohiotJ5uIeR2apZWMchG4GrfmCfRA
	 sNUcx6qylsBR0vzVi3c/6vPF2rrJyjQbQjL4R459IrawhJQoMwrtm6nzeZC67Xx7PEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460990;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=54veQJOpVxF6FH9MLgqyQoEg6FPjIfe22BcUjiu4BrA=;
	b=qXkc7QgrjIXrRsaCiIx0ssuucT758XD6u7ruS+6NN34/SACwEuOVBrX3h3UOznOCBa8V
	 XYAdwioYGQhVPrgJ2pmz94B4+Ijn4DaUXP85a6pleFl5BLzQgMlrYMacZtUGQCq9XaJCi
	 Q8U8e6FJ1sXA+MHlHl1OSpeTDHTGvKAJm0ORb0jpKXapuhxAJYXhoG53OAzMjr9+pqH5l
	 IdvuLXf/JwWpBk8szAIkyfJ239okI6o8uf/sCi2Pv3jFdwhHfCs4qZit35nMqJh6i7SKH
	 Zv+JL7r6H4DlUK8LbjF2RLxH7e+1p/w4YGvdHpd0l89SDAun8mFIbFsTWoZG4x3r87A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Ilx3Vsb1;
	arc=none smtp.remote-ip=217.70.183.195
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5401606A31A
	for <xenomai@lists.linux.dev>; Mon, 23 Nov 2026 19:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5401606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Ilx3Vsb1
Received: by mail.gandi.net (Postfix) with ESMTPSA id 688C022008;
	Mon, 23 Nov 2026 19:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795460980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54veQJOpVxF6FH9MLgqyQoEg6FPjIfe22BcUjiu4BrA=;
	b=Ilx3Vsb1/MESVxFSxpb8GWQSZK2GnfX4Qc850MJ9FMeYff2hObRlOAhI8ANKlZGh/1OeGU
	1ikYpawbVTO8ybpEX2tjMkh2ABzdgvg5UfRREv4Nw5/rinb04bsRz7QQ9qHzcduQ4RKPc2
	+xNRV9F++ajQOWEe8xgBQg6fMW6gzWdmoXbBrnLZUq5CYnbeJ907cPsCKywLeOENfvEFXu
	5zXgjb7opcwPcyReb2cMq3SLxsKpDW1IMpOSK04vtUAS3KYkNgOFXkc851BG87JjuPZjie
	tRQggTFeCQW7Dn7SYos8wGsqoxwS/a8y3QBtDQARvFQcBSVHLwjzQTpbiPBibg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "Xenomai" <xenomai@lists.linux.dev>,  "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: Re: [EVL] A POSIX interface has landed
In-Reply-To: <DN21BM83I0WK.1YQJIYDJMMIU@siemens.com> (Florian Bezdeka's
	message of "Sun, 22 Nov 2026 21:50:45 +0100")
References: <877bi4bobo.fsf@xenomai.org>
	<DN21BM83I0WK.1YQJIYDJMMIU@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 23 Nov 2026 20:09:38 +0100
Message-ID: <87y0aj5pql.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEApeqGdPdqWgoRbIPh7E7ms0nJAjPhbvfto9AUzT0Nb8dOAM4irSBodIi8+vABMLbqF5wrmoQtnrZgT8mf7b8rbBmY9GdtRao6UD6dQxD+dfeA8fnTyxEIcLOxcurdGIPZeEJgEu7P6r3jqniBLy+INCkI3VD7f1+k0nZIxWNxmNhQh7yxtqgUj3towb3Yf97gWuGuFQw6IwHMkI1fgVzQBH3FVFiLEcOhFMMdUoBjfrnTUjrOOqC5hPbP8X8KDNbQ+osIWUyWrza1YpmyVstGDlHxkDKrpARdrm1ayNllKm9BBdUS+RpU78S+jKzU2B/uSFmHteH2u9gwBnQO7BW1jgR1Pf+ySd/ZOz47FnfsVYm9Wf5XKOoZ6GLu+trgzwDaJ+KcLwdHvsOq6PtX6Fna5c5VufUs17sH5OgTGN/iO3fyqU7UPGluF9RfYugV3Cz26Y4rSnkB5wm2zr0mgJqn3n+nMs6wSxlOcE3xICdfDv/CP94i/2REXULMN2ef/gDf66gEkfHAjD2I0MUOpsffiEJFGHAD5Z9z6iTsC3hAGcOXjgjBYph8XSfBnxVrQ5xZRD9WwaWPnPUWEu0y2PuCTxs8FZIgOz/DNMV5F+MQitzNkl1TViBz/TyYPq4LR16uoeceL57LG3a8e+tfEpqisf6D7nJEIRoJ8MoWiUeT/Q
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> On Sun Nov 22, 2026 at 9:31 PM CET, Philippe Gerum wrote:
>>
>> After several iterations, pauses and rewrites, a POSIX-conforming
>> interface is finally available with libevl, alongside the original EVL
>> API. 'libcobalt.so' is generated and installed with its headers
>> side-by-side with 'libevl.so'. We can use any of them or both,
>> separately or combined in a single application. The main goal is to
>> cover what x3's libcobalt provides feature-wise, and even more in some
>> cases. An optional compat mode wraps some v3-specific services when
>> needed. The target spec is a subset of POSIX.1-2024 for evl, although
>> this only meant adding pthread_cond_clockwait(),
>> pthread_mutex_clocklock() and sem_clockwait() so far.
>>
>> libcobalt is not an emulation of POSIX calls on top of the original API,
>> it is a standalone implementation sharing a set of intrinsics with the
>> latter. These low-level intrinsics talk to the evl core, keeping the
>> nitty-gritty details out of the window dressing, i.e. the user-facing
>> APIs.  They are part of libevl.so, and both APIs use them the way they
>> see fit. If you plan to write your own real-time API leveraging the evl
>> core services, go with the intrinsics in libevl, this is their basic
>> purpose.
>>
>> Documentation is not there yet (how odd?!). This said, there is an
>> ongoing work revamping the x4 website in order to introduce this new API
>> and some kind of versioning as well, so everything will land in one go.
>>
>> Crash course: libevl builds the POSIX API by default, you only need to
>> pass -Dcompat=true to meson for enabling the full v3 compat shim. Once
>> installed, use `pkgconfig --libs|--cflags cobalt` to retrieve the build
>> flags for using libcobalt. evl-test runs the POSIX test suite if present
>> along with the test suite of the original API.  That's it (_that_ was
>> short!).
>>
>> The implementation required additional services from the core, so
>> changes went to linux-evl as well. The core stays POSIX-free, but it
>> does provide a couple of new general-purpose services which are
>> convenient for implementing a POSIX API in user-space (e.g. see the new
>> 'depot' element).
>>
>> NOTE: The code stops short of one aspect: it does not provide symbol
>> wrapping like v3 does (using ld's --wrap trick); explicit annotation
>> using __EVL(call), __COBALT(call) or __RT(call) [all aliases] is
>> required at the moment. This is deliberate, this needs more thought
>> because symbol wrapping the way v3 implements it proved to have nasty
>> pitfalls over the years, as it comes with hidden edge cases. I plan to
>> RFC on this in a separate thread.
>
> Is that the only blocker for running the x3 testsuite over x4?
>

To run it mostly unmodified, testbed apart? I believe so.  The POSIX
test scenarios in x3 have been implemented in the x4 test suite using
explicit annotation, and those tests are all green. So far, so good.

> __RT() and __STD() kept me busy so often, I'm wondering if we should
> really implement both of them - if at all - again. 
>
> Shouldn't be __STD() be enough? (You get __RT() by default, but there
> should be a way to call the "hidden" libc services.)
>

The issue with __STD() as the only explicit marker would be that we
would then exclusively rely on symbol wrapping to reach libcobalt
services, which raises some problems. I'll follow up on this in a
separate thread.

-- 
Philippe.
