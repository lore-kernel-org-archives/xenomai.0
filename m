Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380655;
	b=PcOR02jHanrmhYYhiI8wNiQcYAV0G4NwvNgEx4B8f2/VDwvuxbBRfLxsZeRtkC5BuARD
	 oB5bxB7/c/c7d2vrkILhv9R4BQ2TdE7AtO9HcSdHUoEI8MbEWV05nexNbSoNpUFrpcOjP
	 hbBl8btynGfRH57xn3TYNaiRIcskOWH8jO8elh+fttLWsI18bGPDt4du0xF/IEgk5djtE
	 4PkQ6GDlHipRx3nRWHVwziPq7k2M5S+UP/898Qak79lhGSOrE5uBXOhvhYfDoeDPfB9ba
	 PIB5FwC4G9SjbAQ7mTl33HCwtJXzxinwHLtLrTbk7bpOUZ3rbfUWUjhdp0AKpr48JWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380655;
	h=DMARC-Filter:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:References:In-Reply-To:X-Flowmailer-Platform:Feedback-ID;
	bh=RJykSc6kQKBBPrjQepqKxW9cmg1xbEB/HPME+AcI6CE=;
	b=U03uV1KUhj+f0k6jisUZiK7AR8ZZ0IaSGAud9MNS8OmqmsWalqB2dP49nAOBsAew58jR
	 Tauz10npkP9K3mUH33I6blVd1anPYpUpWtZKLp5HMt5qTuZnjXvwK1PScvC/IS/KgwSnj
	 x+7yuPag3kTpu39h6DmXhxyUU2PxihaXkby5SU6EqkdcK021tR9Ey87gO/TYQ4o076ZZ7
	 ofUSIn9zTWquw788h6mpSguL5xAZxySF9H/RP748AtBgzvLfjCIkv0PZTYUSC6WJThUvr
	 VpUNLGOJ+A+ePOZskNUCqq8H8fCursMidl976kz5OwYEJkMr/gZaLi3FOZanObgC7ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=pjS7mb44;
	arc=none smtp.remote-ip=185.136.65.225
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413EC606A31A
	for <xenomai@lists.linux.dev>; Sun, 22 Nov 2026 20:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 413EC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=pjS7mb44
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202611222050454b67842d510002077b
        for <xenomai@lists.linux.dev>;
        Sun, 22 Nov 2026 21:50:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RJykSc6kQKBBPrjQepqKxW9cmg1xbEB/HPME+AcI6CE=;
 b=pjS7mb44OKzEuGhsYF41UsfW3Q47mhaAblwNwj1WbXQ7l9AGJoKo4DO03zUBN1VCsGyoy9
 HtWtAyyN2sOQYOveEHH8lU5EtBpYQHPKy7i8yJZFhNIDDNKh10C/Nsd1qcW/6gLc/FHkwaZj
 ebemgG/5/863dYBlUAwCDpd3ip+eRXJBO6uYW9dst3RN7SF3e9QiuK4Sc5iXDZRnr4LYY3b0
 F4yOp9JDbRsf+Z5YAmA8AbDVTVqzBdR4xR21Bw6cHK3OROqZmOT5sLwcBQOJFaRFUuRhSK66
 YuWRk492HcCitks5HKbTST/nQw08Fns9VhVf1E9xqRUFpnc8u+gg/XCA==;
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Nov 2026 21:50:45 +0100
Message-Id: <DN21BM83I0WK.1YQJIYDJMMIU@siemens.com>
Cc: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: Re: [EVL] A POSIX interface has landed
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Philippe Gerum" <rpm@xenomai.org>, "Xenomai" <xenomai@lists.linux.dev>
References: <877bi4bobo.fsf@xenomai.org>
In-Reply-To: <877bi4bobo.fsf@xenomai.org>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe,

On Sun Nov 22, 2026 at 9:31 PM CET, Philippe Gerum wrote:
>
> After several iterations, pauses and rewrites, a POSIX-conforming
> interface is finally available with libevl, alongside the original EVL
> API. 'libcobalt.so' is generated and installed with its headers
> side-by-side with 'libevl.so'. We can use any of them or both,
> separately or combined in a single application. The main goal is to
> cover what x3's libcobalt provides feature-wise, and even more in some
> cases. An optional compat mode wraps some v3-specific services when
> needed. The target spec is a subset of POSIX.1-2024 for evl, although
> this only meant adding pthread_cond_clockwait(),
> pthread_mutex_clocklock() and sem_clockwait() so far.
>
> libcobalt is not an emulation of POSIX calls on top of the original API,
> it is a standalone implementation sharing a set of intrinsics with the
> latter. These low-level intrinsics talk to the evl core, keeping the
> nitty-gritty details out of the window dressing, i.e. the user-facing
> APIs.  They are part of libevl.so, and both APIs use them the way they
> see fit. If you plan to write your own real-time API leveraging the evl
> core services, go with the intrinsics in libevl, this is their basic
> purpose.
>
> Documentation is not there yet (how odd?!). This said, there is an
> ongoing work revamping the x4 website in order to introduce this new API
> and some kind of versioning as well, so everything will land in one go.
>
> Crash course: libevl builds the POSIX API by default, you only need to
> pass -Dcompat=3Dtrue to meson for enabling the full v3 compat shim. Once
> installed, use `pkgconfig --libs|--cflags cobalt` to retrieve the build
> flags for using libcobalt. evl-test runs the POSIX test suite if present
> along with the test suite of the original API.  That's it (_that_ was
> short!).
>
> The implementation required additional services from the core, so
> changes went to linux-evl as well. The core stays POSIX-free, but it
> does provide a couple of new general-purpose services which are
> convenient for implementing a POSIX API in user-space (e.g. see the new
> 'depot' element).
>
> NOTE: The code stops short of one aspect: it does not provide symbol
> wrapping like v3 does (using ld's --wrap trick); explicit annotation
> using __EVL(call), __COBALT(call) or __RT(call) [all aliases] is
> required at the moment. This is deliberate, this needs more thought
> because symbol wrapping the way v3 implements it proved to have nasty
> pitfalls over the years, as it comes with hidden edge cases. I plan to
> RFC on this in a separate thread.

Is that the only blocker for running the x3 testsuite over x4?

__RT() and __STD() kept me busy so often, I'm wondering if we should
really implement both of them - if at all - again.=20

Shouldn't be __STD() be enough? (You get __RT() by default, but there
should be a way to call the "hidden" libc services.)

>
> I merged the POSIX support and its test suite to the next/ branches in
> linux-evl and libevl; the kernel part should move to the plain rebase
> branches once the CI says that all is fine with its test configs. At the
> moment, evl-6.12.y-cip, evl-6.18.y and evl-7.2 are up to date with the
> POSIX support. evl-v7.3 is late, but almost ready and will appear in the
> coming days (I'm almost late for v7.4 which means that everything is
> going -*cough*- as planned). Keep Calm and Rebase.

I should try to reserve some time to look into this in more detail.
Sounds very promising so far.

Florian
