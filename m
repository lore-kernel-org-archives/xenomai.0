Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606102;
	b=zDiKILvprRZJITdanGWwfrfvkWQnnlYQ89AW0cVUqiKLZjVcKaRP1D4GNTOWCqEzJT6u
	 X6B0C9J6GDwIiRrHpwX6cHthd6iIhYvAxQhBmGLHvDupEOGEImGPgLk8k6347tZIXSbh9
	 FzYGXzgQGYbkMQAWZCBl8I0Vzsi7TdJ3xXbh2kn3yVI6V2TSH9IwK/+UC0dAvi2+Uk/8t
	 S0eUr7224JlN4I30+vTVsiHJBRWPMWc0tDoZF9l1IiWr1ujsr5DF3yo4xYNYOkFEjaix4
	 6TJj4GszDty1bKpTyBqGvB+RimEyCFWHWVPGm2+KLIjXf9hvAqtV0qawtNgXiHlqiAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606102;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=SToqulA/w2LyhHb2/OpjZe4WPtIy8ern1srRz869zNo=;
	b=wfyOGIA5yJeDyU3dRoBV37vd/TsY1lbAhwSlGX9hYWthZsdLDYPXuKKbs7xVfJux5Ek+
	 XO/KdwLFTf+JaAv/q5+CTgtfmyXo8Gak0ltjIoIur2fgUgbkOhXvts+tdnFBifgsJ6SME
	 CPMTOTIcy+rPewnXTl37FBWmCKJntJ6p9gGtKJb+UVE5TVExjcaxnjgFNR8zUVo86+I+Q
	 SYeldNz9i1TQcUfLEjLeeurG2gs082nKzHmhte1rXw2IxbnSu6M0xzy/li4MpycARGMGj
	 jq7VRXxrmP/COyOcxQZpASZx6oL8cjgsL//uMYmD3vOa7ikWHQXRrxy/fXMEnVDoKDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=Rx7avG0i;
	arc=none smtp.remote-ip=185.136.65.225
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDA606A323
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 11:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72EDA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=Rx7avG0i
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20261125112811a115d6580f00020702
        for <xenomai@lists.linux.dev>;
        Wed, 25 Nov 2026 12:28:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=SToqulA/w2LyhHb2/OpjZe4WPtIy8ern1srRz869zNo=;
 b=Rx7avG0iOPQ0DlQvvj4u3f789ihZ4u65/gSVcf3s06B8eXyxXpTetdOzXpkdlQeX8iaQfq
 NqtxjbA5SMFaS6UAOi25I1vQ38CVd0BIJxKtlLg4zYD8wfOmXCUb++u2UrzCIfvO596IAsHb
 Q2OUk5wCOIjPiw+qF3xO9UISW3xyl0FjKEpuqHscSk+L6QviI7kdo512ivTHkzJaXXOYmzNS
 aT83AgRfPDnHVzkD+TVTwZxS/B/EajxtZsw6M07HKnka6fQfUUrjHbPTLEHFIRxTUkoQYMP5
 To6oDU8LSKmr7a3kbb9XMM4vSbFUq86zBvdH5RoYijCUfxl4AQ2R4jMg==;
Message-ID: <6b1b6c71d1bb9b7838a3ba07797df7aeae9efa5e.camel@siemens.com>
Subject: Re: [PATCH 0/4] Cobalt build fixes for uClibc-ng
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Yegor Yefremov
	 <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Date: Wed, 25 Nov 2026 12:28:10 +0100
In-Reply-To: <a1f798da-7535-4cf2-aae5-412953ccabe0@siemens.com>
References: <20261124140303.3336015-1-yegorslists@googlemail.com>
	 <a1f798da-7535-4cf2-aae5-412953ccabe0@siemens.com>
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

On Tue, 2026-11-24 at 15:24 +0100, Jan Kiszka wrote:
> On 24.11.26 15:02, Yegor Yefremov wrote:
> > Cobalt has not built with uClibc-ng since v3.1.1. These patches fix
> > the build, plus the clock_gettime() vDSO selection, which picks the
> > 32-bit call for uClibc-ng with 64-bit time_t. They complement Jan's
> > mmap() off_t fix for uClibc-ng >=3D 1.0.58, now in next.
> >=20
> > Patch 2 is only needed for uClibc-ng releases before 1.0.43, which lack
> > getauxval(). The Buildroot autobuilders still use such a toolchain
> > (br-arm-full-static, uClibc-ng 1.0.36).
>=20
> See my comment on patch 2: This is too old to be still supported. If
> there are active ucLibc users (independent of Xenomai), there should be
> also recent versions supported.
>=20
> >=20
> > Tested with Buildroot's test-pkg on next plus this series, building
> > Cobalt with the testsuite, RTCAN, Analogy and the pSOS and VxWorks
> > skins:
> > - armv5 uClibc-ng 1.0.59 (time64), GCC 15
> > - arm static uClibc-ng 1.0.36, GCC 9 (getauxval() fallback in use)
> > - armv7 glibc 2.44, GCC 16
> > - aarch64 glibc 2.24, GCC 6
> >=20
> > Without the series, both uClibc-ng builds fail on __OPEN_NEEDS_MODE,
> > and the older one also fails on <sys/auxv.h>. The ADJ_SETOFFSET error
> > only showed up once these were fixed.
> >=20
> > For patch 3, I compared the vDSO symbol the preprocessor picks before
> > and after: __vdso_clock_gettime64 instead of __vdso_clock_gettime on
> > uClibc-ng time64, and no change for armv7 glibc with or without
> > _TIME_BITS=3D64. I have not run it on uClibc-ng hardware.
> >=20
> > musl is not covered. It defines neither __USE_TIME_BITS64 nor
> > __TIMESIZE, so libcobalt would use the 32-bit time syscalls there as
> > well. That needs a separate look.
> >=20
> > Yegor Yefremov (4):
> >   lib/cobalt: Don't rely on glibc's __OPEN_NEEDS_MODE
> >   lib/cobalt: Provide getauxval() fallback for the vDSO parser
> >   lib/cobalt: Select the time64 vDSO call without __TIMESIZE
> >   testsuite/smokey/y2038: Define ADJ_SETOFFSET if missing
> >=20
> >  configure.ac                                  |  3 +-
> >  .../arch/arm/include/asm/xenomai/time.h       |  8 ++++-
> >  .../arch/arm64/include/asm/xenomai/time.h     |  8 ++++-
> >  .../arch/x86/include/asm/xenomai/time.h       |  8 ++++-
> >  lib/cobalt/parse_vdso.c                       | 31 ++++++++++++++++++-
> >  lib/cobalt/rtdm.c                             | 14 ++++++---
> >  testsuite/smokey/y2038/syscall-tests.c        |  5 +++
> >  7 files changed, 68 insertions(+), 9 deletions(-)
> >=20
>=20
> While asking the AI for ucLibc fixes, could you please also let it
> cross-check if the fixes will work with musl as well? It should be able
> to do that without BR as environment (it did micro-builds for my other
> path on its own when given a cross-compiler).
>=20

I did some "tests" with musl at the time working on time64_t support. If
I remember correctly - happy for a cross check again - the build was
broken for that libc since a long time.


