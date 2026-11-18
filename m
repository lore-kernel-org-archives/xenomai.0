Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028712;
	b=KDCBbH1NirVd1rP0Ch7/76RN5QYP7NVHZKrM5jaYZ7VxCDMWTgtOLx2HHhmRga3RQEfR
	 lzIY9igUfIbeFMxvQaNfZ4OA+YaKmQ5f+qotBNXq9jls6JPcPx9lGe12F0HhPhR0vhqbr
	 Mp3/+liI5hcnkhIJyE9YQby4krRnXmOxiq4Vr0XXaoHrpvZqC85FjatDKVshhIQk/JSn+
	 nCRdnLelDvIi1X0AlxVbTmd6pyGD8mk0qRjLsJ/xTwvPLIvfFG+5U0BjE4SgSbsevlibE
	 sKg7AcO75wT6vm/9QopSS1GOfr4YB60q1M0DzDZXmt7sEcih0kzuO62BxsvI4ywp4yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028712;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=T/u+ixgl/9vQVfnA7VCxGT+NyehQ+hltSrQVPGXgeYs=;
	b=yRTEpadGdhH5+01dQnZNapWssPQ/wWcWc+GopPM/Z1S9e3PVBch/hQ5WOA/AKEGkB+9D
	 Tz5E4mmJsrVqxt/UVJNHc30dQX3dv2Wx+PeBUh644+aI3ydAePQegJXKxFRf3zGX/3neS
	 2GxW2PJLp2KzlUDPyVMHb+dBJhDsnHmCp4mKLq0Rz5qIi1ymEYIwe/2WzDj92SsJCJzDw
	 QMBynhXveC1Btv//9k67H9BSu9OM7UEBWXId+K9+EzNpKIt0AedPmXeMyHA5geBJS7+JR
	 CbxRXFEaCh3r3I+8iuWYGahfIOK1+/JxNS70wCVRiXkBtuKDRbpJ0t+ybGsl8Dglu0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=Okpyt0GY;
	arc=none smtp.remote-ip=185.136.65.228
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F248606A331
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 19:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F248606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=Okpyt0GY
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202611181905071e728248910002075f
        for <xenomai@lists.linux.dev>;
        Wed, 18 Nov 2026 20:05:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=T/u+ixgl/9vQVfnA7VCxGT+NyehQ+hltSrQVPGXgeYs=;
 b=Okpyt0GYMIq0IQe/PiTxWargfJRjOb4PaCVL06PnQqUuOudH8V8lWQO9IjqV8Xvk/2Fqpo
 JhD2Wds9D2Y7//JTgGeFFqgoh9kM9JbUh2LtIazQnkpGS4ob5t+Av4M+Ybnof4X1ad6yIz+T
 N0kPwWbQ19NFyAoEWKVXy3Q1wC2tHcvWoez+SzvmNjwx4sEO0K/eqX/aq45ARS8dgoWq0OuY
 RUT5Ev3KelxrJwuukeds3ewLR8VQ1GsGxA6Xz1E+rNlFTJso8VBqs8rK7wZp2SDrZpZeB1yp
 dvvdh0H7SAMjbvF4RUd5IoCWK6f/gi72Q6GC9mdvR3B4v5FUjdhk9dcw==;
Message-ID: <9222017bd591f01dd92d6cbfd34b90f5e7abe93a.camel@siemens.com>
Subject: Re: [PATCH v2 0/4] Mercury build fixes
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yegor Yefremov <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 18 Nov 2026 20:05:06 +0100
In-Reply-To: <20261118140632.1080213-1-yegorslists@googlemail.com>
References: <20261118140632.1080213-1-yegorslists@googlemail.com>
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

On Wed, 2026-11-18 at 15:06 +0100, Yegor Yefremov wrote:
> The Mercury core and its testsuite no longer build on next, as several
> includes are only pulled in indirectly with Cobalt. This series fixes
> that, based on next this time.
>=20
> Tested by building next plus this series with Buildroot:
> - Mercury, with and without the testsuite and the Alchemy, pSOS and
>   VxWorks skins, for armv5 (uClibc), armv7 (glibc), aarch64 (glibc,
>   GCC 6) and a static uClibc arm toolchain. The Mercury testsuite
>   also needs Florian's 454ae865 ("testsuite/smokey/alchemytests: Fix
>   build failure with core !cobalt") from wip/flo/refactor-includes,
>   which I applied for testing.

Feel free to integrate that patch into your series already.

> - Cobalt with the testsuite and all skins for armv7 and aarch64, and
>   for x86_64 with GCC 16 together with a 6.12 Dovetail kernel. With
>   uClibc, Cobalt fails as before on __OPEN_NEEDS_MODE in rtdm.c and
>   on the missing <sys/auxv.h> in parse_vdso.c, which this series
>   doesn't touch.
>=20
> Patches 1, 2 and 4 also apply to stable/v3.3.x, patch 3 only partly,
> as most of the affected bool users were added after v3.3.

Could you please share the exact build configuration (./configure
arguments) and glibc version that you are using?

I want to learn if the missing includes are related to the glibc version
or not. Should be easy to figure out. I want to make sure the ongoing
refactoring doesn't introduce any regression.

Thanks!

Florian
