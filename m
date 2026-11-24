Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795518776;
	b=mc/RcJWZr5gRRM8RWleQsCSvpvktgXkL5TewsNbsdxlWBJ91TWyHphxzkoYHWy/gblu8
	 IjSGIw3c1/9MvR/b7mwLDGInWtFMnGSe+j/yZ4G+nP8ujAtbnZt7Aej2lJBX9sxL3i0Dc
	 yEI7bsrx8BXB4/riNRX/JH5yzcgYTCruorX3t15JfimUm8DacD6iE5l8hWG5pY6YBLOTJ
	 Q9mC4PA2gcxD5wYn+TLunGb2GmL3c6YFR0eEmlndwXzzAx9C1dqwISyoEPo3DFnn+VYAU
	 QPtYTTqc9N/POk4CB8QcOfk54FospHkE2fiXLP+i5nssmZxviw1errRVSsPOnwgqhbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518776;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl:X-GND-Score:X-GND-Cause:
	 X-GND-State;
	bh=bgFhrrMzjfvFaVx64C6j5ffZ4oTSqglx4K+lhiA5oUY=;
	b=lMnOntvFergKalC26Z+6PPKALAtxKWeljTMlECZW1G08TPrD7pOTrTXd7x11eP6fMb/a
	 T7oxlc58kGKUd6OpifWzAsLCGSmlU+CyorNwltohLWHNIUL/fJBopfMjq6LPX/gJlbDnI
	 s91n00VqQWNRhBy8zNoOFMv18OCwPOf9avV1g5AS1RYRDH9fP4u/hUeJaYsK2eUk9K8SH
	 F0TQXWIqcUTne8rmuWoBtLAli3bwgd2ahC+0ejJ7rUJ51rQmxo6IRGeU4v+BmoRrLWPIG
	 LmlDWDDmbhK50tDgxwD2aYBF51dbuHpDtGkpuXLmOrFIE+NH5zSFMnkIScFMbADH0cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=JP7ib8yh;
	arc=none smtp.remote-ip=217.70.183.195
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6BF606A321
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 11:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA6BF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=JP7ib8yh
Received: by mail.gandi.net (Postfix) with ESMTPSA id 788691FCED;
	Tue, 24 Nov 2026 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795518772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgFhrrMzjfvFaVx64C6j5ffZ4oTSqglx4K+lhiA5oUY=;
	b=JP7ib8yhxwSuWC7pqgFgDQKDh1Tpfkk7Xh1JBarUiEWDFICi7mtO+EdG+l0fzJE4EwmqW5
	/teYm104MhHWBzuHSHQ0iF8YYOy0xUUaasOLPxUpPf3R1dtMU2ECQp7+wEe+fMmJbFyTIw
	8xD1gQPCyO70eRQF7EXO/3zWFaLv+x4YfJjHYo7Dl5h8TXIIck7p+cEisVDHEhqmO8Vgl7
	ZitSk7wFuuwIHhNyz8crUczQ98e4EEkxxX0lUcXUzLOLlX0bq//bdIiIlNz1alIPERNrpr
	0VCkrznRX98IX88BYbZxD8LIz9h7aw2O/huIu5KT+hHQqbz/g+X1Hvu3cyuJyg==
From: Philippe Gerum <rpm@xenomai.org>
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [RFC] symbol wrapping for libcobalt
In-Reply-To: <bb6109e28cbd8d8d90a9638644041980e731a22b.camel@sprinte.eu>
	(Julien Blanc's message of "Tue, 24 Nov 2026 07:58:11 +0000")
References: <877bi3thhu.fsf@xenomai.org>
	<bb6109e28cbd8d8d90a9638644041980e731a22b.camel@sprinte.eu>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 24 Nov 2026 12:12:51 +0100
Message-ID: <87wlq24h58.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTFJGicmkgWkGhhyhvOunq0GMl13yPScNGo4tge9sNBDZM3U0bUzgN1s+4gTNiLRVnTreOyd2NXT3uyjthciiUbRRSfaJlhcDVFPwGo7hyJMBfScxuWI38mOgYU0nnrdMZKohAGS6PqTiebj012xeEU+1aa26D3DVeP2Skf5IwA0UO6OtWSJJi+TTJEEnr+N1wcXiwYjmVgAkfsMgpJ48aU+t84loFNUve/Ij9WQDmUjL/mH3KHmJm3BgSrutwjTCCvn4Wcmpq++8VPreO4bTeD5DrlGkPKyO9q1+y81BNsF1/sqcfI3/BCpG4eVeOjan0fcTFgT48TQ0zVqAxuxXlekBM+6Fpl2CWm501m0Ict1ukbCbMcGqblT0wlVb5pnK/31jFWchzcw9Tl7ALZp8xOS3KGSQQMNJe5g3W4vbjQiI6/qdc61/8N8YqUeZvinVt0l67mYm95uPOnBAnUyyEeXTcytPIKqgCJxqGsCLmDaSvfAIJrn838qHZNev9IkzcxQNNv93NWtC31Yg5xk3GHuXXM29KPHwNGZHTN9LjEPtuhNEFSlctXb1NPxQx71D8qeJ5rWhiAfqC+Ps0xdzUhqKMvEn9TUnAeZMS6rUVehY1lLnBBCZIDbIRPBb6JN1dr/YOYk6uW2DsqCBCdW2LIdNnoza4doFQpfBE6re4a4FQ
X-GND-State: clean

Julien Blanc <julien.blanc@sprinte.eu> writes:

> Le lundi 23 novembre 2026 =C3=A0 21:33 +0100, Philippe Gerum a =C3=A9crit=
=C2=A0:
>>=20
>> Since its very inception, the POSIX API in xenomai3 enables automatic
>> wrapping of POSIX calls to their libcobalt counterpart using a linker
>> trick (-Wl,--wrap), so that applications can use the pristine POSIX
>> routine names to invoke Xenomai services. For instance, the following
>> snippet:
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pthread_create(&tid, &attr, foo_r=
outine, NULL);
>>=20
>> would translate internally to:
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D __wrap_pthread_create(&tid, &attr=
, foo_routine, NULL);
>>=20
>> which is a weak symbol alias to:
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D __cobalt_pthread_create(&tid, &at=
tr, foo_routine, NULL);
>>=20
>> The significant part of this wrapping is that we go from symbol_x in the
>> source code to __cobalt_symbol_x at link time, with libcobalt
>> implementing the latter.
>>=20
>> Over the years, we noticed several issues with this scheme:
>
>> [Snip]
>
> Just saying that as a xenomai user, we share all of these concerns. Anoth=
er
> issue is interop with eg rust code : i have no idea what happens when a r=
ust
> static lib is linked onto the executable regarding the calls it may do to=
 the
> pthread api (this one is actually a big concern for us for rust code inte=
gration
> into the rt domain, and even the non-rt domain as it's unsure how it will
> behave).
>

Rust's rlib format is basically a static ar(chive) in disguise, storing
one object file which contains some build metadata, and any number of
so-called "Rust codegen units", optionally with additional files
generated from other languages (C/C++), so we may assume that wrapping
is applicable. This said, you are likely going through other crates
which call the *libc eventually (e.g. std, libc, nix, rustix et al),
your own crates are unlikely to emit references to these symbols
directly, but to mangled Rust names implementing some FFI. For some of
the reasons explained in my RFC about link stage issues, I would not
expect wrapping to work out of the box in this case, especially with the
cargo toolchain in the loop, at least not in any intuitive and POLA
fashion.

This is why v4 comes with the 'revl' crate, which provides the bindings
required to leverage the libevl (original) API calls in Rust
abstractions. Extending revl to introduce abstractions covering the
portions of the POSIX API which were made oob-aware like syslog support
is a non-issue: these portions are based on the libevl intrinsics, which
are plain custom C functions, we'd need no wrapping there.

> We've gradually migrated to explicit calls everywhere, with the goal to g=
et rid
> of wrapping entirely. It looks to me that the wrapping process is too fra=
gile
> indeed. For us completely dropping the wrapping would be fine, as it's on=
 our
> roadmap anyway.
>
> Actually, there's one feature that we rely upon : being able to compile f=
or both
> an RT core and a standard kernel. But that is quite easy to do by just
> redifining the __RT and __STD macros, wrapping is not really relevant her=
e.

We are on the same page. Wrapping may have been a good idea on paper; v4
should provide complete support for it and even beyond what v3 is
capable of today (i.e. with guardrails and checkers), but only as an
opt-in feature I believe, because this is too much of a footgun.

--=20
Philippe.
