Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795167625;
	b=wzoi/WvZHElAOKndEikYGlhANVDueWpsx6v8EfqVgE3JG8Sk36pI14J1ZwQ3y1k4hxXR
	 BqM9M88PF1NZQ/8wzAxoXqFBJ0QOorjn+QTfYLwXSmAbkmEyGJ1UolI+c32RIpAe2i4mz
	 z0E/Qte4uIsmhu/DgMAjjlkseIz8wMh44Klpso1OZX+iRGkib7yENHsdlrnCb5Dbp/aEh
	 QaeyUTucd2uwiQjBbZp/yu/VzKZQgqaKT3+sjn0qKLSj//8a3vkMlAK3HXi+3gMAKeYal
	 uTyu0KFp5AcCTTX7/c5dTgz0J7xr6Q7OE3JOkMQCRbLGE6JNjoWDFy2a8vgkv5gBOBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167625;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=FCJFChkFZASatLUZQAvMzx8T4P2iSTbjmQpDKQD9Jxo=;
	b=S/tGksLmBtILfDq3G609LjTs4GgkP6OqKIQbM6z9L3ML0qATYBvsHj06Me9dvfGhqkj1
	 FBd33IBCUCEuyMaWNn1nVi006V80tJCRwmwPX9IVIANH9Jec14p7RHDl66S0keJi7VZEF
	 KI52Ms9KGsw91YwPUfPqj6TyiOUveQXYrfC52QSic9107uAiviZYUtt6qdzQmA1405xI/
	 HhLEDnfhEmlwuhpCUJYPinVutW8c604K5nMzs7SMI/M3S75C4wq/lD//y0YCFhU+bDClq
	 2bue4T6qFeAHAZFA8Lp4/7Zx0H0Wt1Ld1fgga1sHnN5ws9FS4gjAT6yRmVOWA0zBpWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=RYJsjzsm;
	arc=none smtp.remote-ip=185.136.65.227
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52015606A320
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 09:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52015606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=RYJsjzsm
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202611200940198fe70df8ea0002078c
        for <xenomai@lists.linux.dev>;
        Fri, 20 Nov 2026 10:40:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FCJFChkFZASatLUZQAvMzx8T4P2iSTbjmQpDKQD9Jxo=;
 b=RYJsjzsmqlZ4FJXO6UaJX/JlrwjEPfQFVQRlh8ckwyw5fx/RSwz8c8oNAPlYiRfugo6jUY
 dwUMtjiPA791rEBt4UCcfpK006sl0Ex3Y19Um/cJRdKo3wj2asA4sO3mPGa4KA9ECFzvEAHF
 ug3E4AUs7pB4gRQVtpyaYexTZtjffuBtN+aVFmQlLKfb3ZO37uKeADVjZtsvriGcqk+/d5dZ
 gD2wxFS6HPvw32OlrPUhbGZCY911lGnHg8qXTdslz9tOBjkiaeTl9NdiGbgakXyn3eowDAOg
 ArT0qFSceeRsB3pf0rt9UMS6UOOy8ph3c4Q4z7HeFnOBtnWqbSFs9snQ==;
Message-ID: <231ed4e64e4210b736a9ef7eb41a9b86abfd5ebe.camel@siemens.com>
Subject: Re: [PATCH v2 0/4] Mercury build fixes
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 20 Nov 2026 10:40:19 +0100
In-Reply-To: <20261118214521.2292680-1-yegorslists@googlemail.com>
References: <20261118140632.1080213-1-yegorslists@googlemail.com>
	 <9222017bd591f01dd92d6cbfd34b90f5e7abe93a.camel@siemens.com>
	 <20261118214521.2292680-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2026-11-18 at 22:45 +0100, Yegor Yefremov wrote:
> On Wed, Nov 18, 2026 at 8:05 PM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> > > The Mercury testsuite
> > > also needs Florian's 454ae865 ("testsuite/smokey/alchemytests: Fix
> > > build failure with core !cobalt") from wip/flo/refactor-includes,
> > > which I applied for testing.
> >=20
> > Feel free to integrate that patch into your series already.
>=20
> OK, I'll include it in v3.
>=20
> > Could you please share the exact build configuration (./configure
> > arguments) and glibc version that you are using?
> >=20
> > I want to learn if the missing includes are related to the glibc versio=
n
> > or not. Should be easy to figure out. I want to make sure the ongoing
> > refactoring doesn't introduce any regression.
>=20
> Buildroot runs (apart from the usual --host/--prefix/... options):
>=20
>   ./configure --with-core=3Dmercury --enable-smp --disable-registry \
>       --enable-testsuite --includedir=3D/usr/include/xenomai/

Thanks! Just wondering if mercury is really (still) used. At least from
my perspective I/we did not care much about this in the recent past.

>=20
> and only "-O2 -D_FILE_OFFSET_BITS=3D64 -D_FORTIFY_SOURCE=3D1" in CFLAGS.
>=20
> To answer the glibc question, I built next plus 454ae865 outside of
> Buildroot with these options, plain "-O2" and "make -k", so that all
> errors show up:
>=20
>   aarch64, glibc 2.24, GCC 6
>   armv7, glibc 2.44, GCC 16
>   armv5, uClibc-ng 1.0.59, GCC 15
>   x86_64 host, glibc 2.35, GCC 11

Thanks for that matrix.

- All, especially armv5, uClibc-ng 1.0.59, GCC 15
What is the situation regarding time64_t in this scenario? Is that
properly handled? (relevant mapping, libc macros, ...)

- All:
We mainly test and build for the current Debian releases, with default
compiler/toolchain versions.

If you need more than that, we have to make sure that we build and test
against those versions as well. At least some build tests should be
added. Otherwise, we will most likely break it again.

Will you look into that?

I'm normally ahead of time and try to compile with recent gcc as soon as
they are released. Older versions run out of scope at the moment.

>=20
> The missing includes are not related to the C library. Every toolchain
> fails on the same lines:
>=20
>   lib/boilerplate/setup.c: mlockall, MCL_CURRENT, MCL_FUTURE
>   lib/copperplate/internal.c: __NR_tkill
>   alchemytests.c: fprintf, stderr
>   alchemytests task-2.c: compiler_barrier
>   gpiobench.c: va_start, va_end (with uClibc also va_list)
>=20
> The only one that depends on the toolchain is bool. It is missing with
> GCC 6 and GCC 11 (in event-1.c, mq-2.c, task-11.c and task-2.c), but
> not with GCC 15 and 16, which default to C23, where bool is a keyword.
>=20
> With the v2 series on top, the GCC 6 and GCC 11 builds complete
> without errors.
>=20
> Regards,
> Yegor
