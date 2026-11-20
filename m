Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213048;
	b=4n5GxVyjQXHenZ8lVwIlAou3lhEJOqPKad2U5MMB9cPPEDkHeHFPWVNWPLrhK6M3ZICy
	 BoGjIXewCgH1wAQg5OxFnNLfS1tBGdh5kYugdxVXAdFFHOGWNak96bE0vg1GAn7i7A73q
	 HAIROvmb6FThG4pDA5LLIO/98OTOHB/Fc3Bw2zIecuSLgUTXAUAduvSRnmSwBK1dRu0J5
	 UvSq1XCOe9kdKmpnboPFAfqg5+z4vcUNAqxUAOaoaih5VsCCsYcfcF5KxremUZElWkKeu
	 rTKajptVhUEZ6rTBFvvKdWOxD8wzZU8g1JwJBJn7pzfd3YKtxr3eiGDAd48A8IhpLqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213048;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=E0wesd2GRYi1EiAZVgH9bmyVUbin4SuntEomzOt+Jow=;
	b=kkPA/O+xO9kZ/Y63PMGRtfINF7c8TahpR118UhbuMib78/j8uwkuWJtOb5oRMIRTuui2
	 nef5+5bFEZGI7S+1bzoc7LE9IqCe+Eri1cFWu6nQEb5lmELV2JFLyb4lhPkMFCCxleDkJ
	 fHMmo1Ta8xUmT4/SRCccbfVNpXsyQrJ2xS/zdcKyefaFIVgfIneSWFmiuhHu593K8DlJ8
	 MIEMvlM7P0g/P4NYur2ugT5s45O9aq5gZqWwOSxc7EAnXYznuDbNC91uBsoPnGjk8LhJ3
	 crhwqu4/Ynu8ANsl5O/KOmR4+xhodFwMA8qkjBe85610eoZB+/LEX3Ch2TCrBU+0KuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=NpxTG7wk;
	arc=none smtp.remote-ip=185.136.65.225
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AB606A6AB
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 22:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 750AB606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=NpxTG7wk
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20261120221723af61ec9e1600020711
        for <xenomai@lists.linux.dev>;
        Fri, 20 Nov 2026 23:17:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=E0wesd2GRYi1EiAZVgH9bmyVUbin4SuntEomzOt+Jow=;
 b=NpxTG7wk5St+TYzQxYSCYluyqk4Xj65mvmJXVRSh732Ic6SjllUGwtwgj/POPg0/p427qZ
 Uy0XJ0+Aet1QB/tWkCxOyjF4obrv4SUfB89bcjXDtujVqN/1HTSNdZmfjoJa85yrCmhNDWYX
 wLSTMLfGDrpNiFVXwiwftpfgDZifnDmfnJSxjDfPctZAiTBm8YjtM006bZysWKaJTkmNAUUM
 s6iEuQk3f3L1sJTxpDt7Idpt2IPiV1/QGpjg2cELD1GYitL9WqgdmX7uvZkxMes04g1rFx73
 eDEPEZcpON+XihqnK9DpwvcY0h+fso4ZKRzY03np6Xnlgmb1lk9exfCQ==;
Message-ID: <9ce50b6edee8bf79bdb9bccb37decc9418857628.camel@siemens.com>
Subject: Re: [PATCH v2 0/4] Mercury build fixes
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 20 Nov 2026 23:17:23 +0100
In-Reply-To: <20261120214018.3745861-1-yegorslists@googlemail.com>
References: <20261118140632.1080213-1-yegorslists@googlemail.com>
	 <9222017bd591f01dd92d6cbfd34b90f5e7abe93a.camel@siemens.com>
	 <20261118214521.2292680-1-yegorslists@googlemail.com>
	 <231ed4e64e4210b736a9ef7eb41a9b86abfd5ebe.camel@siemens.com>
	 <20261120214018.3745861-1-yegorslists@googlemail.com>
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

Hi Yegor,

On Fri, 2026-11-20 at 22:40 +0100, Yegor Yefremov wrote:
> Hi Florian,
>=20
> On Fri, Nov 20, 2026 at 10:40 AM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> > Thanks! Just wondering if mercury is really (still) used. At least from
> > my perspective I/we did not care much about this in the recent past.
>=20
> Buildroot offers both cores, and Mercury is the only option on boards
> without a Dovetail kernel. The Buildroot autobuilders build it with
> random configurations, which is how these failures showed up.
>=20
> > - All, especially armv5, uClibc-ng 1.0.59, GCC 15
> > What is the situation regarding time64_t in this scenario? Is that
> > properly handled? (relevant mapping, libc macros, ...)
>=20
> uClibc-ng has no _TIME_BITS opt-in: with UCLIBC_USE_TIME64 (the default,
> enabled in Buildroot with kernel headers >=3D 5.1), time_t is always
> 64-bit on 32-bit targets. features.h then defines __USE_TIME_BITS64,
> but not __TIMESIZE. In the armv5 and armv7 uClibc-ng toolchains,
> sizeof(time_t) is 8 and sizeof(struct timespec) is 16.

Thanks for that information. That helps and explains why it "works".

>=20
> For Mercury this is fine: nothing outside lib/cobalt depends on these
> macros, so it uses the 64-bit time_t of the C library. The only issue is
> that configure only recognizes glibc >=3D 2.34, so on 32-bit uClibc-ng it
> sets CONFIG_XENO_LIBS_TIME64=3Dno and warns "You're affected by the time_=
t
> overflow in 2038", which is not true there.
>=20
> Since you asked, I also built the Cobalt libraries from next for armv7
> with uClibc-ng 1.0.59 (Bootlin armv7-eabihf uclibc stable-2026.08) and
> found two problems:
>=20
> 1. lib/cobalt/rtdm.c does not build: __OPEN_NEEDS_MODE() is a glibc
>    specific macro from <fcntl.h> that uClibc-ng doesn't have. This
>    has been there since 89f00a2e5 ("lib/cobalt: Wrap __open_2/__open64_2
>    to support _FORTIFY_SOURCE"), so Cobalt on uClibc-ng doesn't build
>    since v3.1.1.

That's from 2020...

I guess the first thing to clarify is: Do we want to support that? Seems
nobody is using it as it is broken for ~6 years already. I don't have an
opinion on that yet.

>=20
> 2. With a local fallback for that macro, libcobalt builds, but the vDSO
>    lookup and struct timespec don't match. lib/cobalt/wrappers_time64.c
>    checks only __USE_TIME_BITS64 and uses the 64-bit syscalls, which is
>    right. lib/cobalt/arch/{arm,x86}/include/asm/xenomai/time.h checks
>    "__USE_TIME_BITS64 && __TIMESIZE =3D=3D 32", which is false without
>    __TIMESIZE, so libcobalt resolves the 32-bit __vdso_clock_gettime
>    (with glibc it resolves __vdso_clock_gettime64). cobalt_read_ns(),
>    and therefore copperplate's clockobj, then passes a 16-byte struct
>    timespec to a function that fills an 8-byte old_timespec32. I could
>    not run it on Cobalt hardware, but calling a function with the same
>    ABI that way under qemu-arm gives 8680820741732130394 ns instead of
>    1000500000000 ns.

That one will need some more cycles here. Some input: The problem with
glibc is, that it changed between versions when __USE_TIME_BITS64 is
actually set. Older versions had it enabled only when compat (so time32)
applications explicitly requested time64_t support. Meanwhile it is also
set for architectures where the native time_t is 64 bit already.

Whenever we can re-use / share the time64_t services for the native case
it's enough to check for __USE_TIME_BITS64. If not - e.g. because of a
different ABI / memory layout we need to check for __TIMESIZE =3D=3D 32 to
identify the compat case.

For sure, that is still fixable, but needs some more thoughts (and
testing) first.

>=20
> I can send patches for both, e.g. falling back to __WORDSIZE =3D=3D 32 wh=
en
> __TIMESIZE is not defined, and teaching the configure check about
> uClibc-ng's __UCLIBC_USE_TIME64__, if that's the direction you prefer.

Thanks for that offer, once again the question is: Does someone really
need it...

>=20
> > - All:
> > We mainly test and build for the current Debian releases, with default
> > compiler/toolchain versions.
> >=20
> > If you need more than that, we have to make sure that we build and test
> > against those versions as well. At least some build tests should be
> > added. Otherwise, we will most likely break it again.
> >=20
> > Will you look into that?
>=20
> Yes. Buildroot's autobuilders build Xenomai with many toolchains (glibc,
> uClibc-ng, old and new GCC), so I'll report and fix breakages from
> there. I can also add a few build-only CI jobs, e.g. Mercury and Cobalt
> with a uClibc-ng toolchain and an older GCC, if you're fine with using
> Bootlin's prebuilt toolchains for that.

That's good, but too late.  We should know on "merge" or "before
release" if something got broken. Not afterwards. Or is that
infrastructure building regularly any next/development branches?

Best regards,
Florian
