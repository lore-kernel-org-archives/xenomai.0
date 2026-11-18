Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010803;
	b=tukIqPt4xUp4raFnCtq5S/s7JskdLAaVovFcnoARV8tuDOWcYqM2YdOfdCjWg0vtaYDQ
	 AIQ+a94r1zXH8O12sd5Balw2rOPPQusAa1fd+bYQYGhxUp1WQGELCag5tRrGBDp6h18JA
	 NCkU3vnZwL0kif/tZjUXWU/XvTf8a1l/QpdW9DVaBfCJUHvpZc47SYDausmIyZK0DG/wh
	 IQq3I3KJesx9fibNTkFW6ZDCxUfhL+4ZBcof7x774aWZFpNDizYSXMwbqQLdK/MelyKx7
	 e2k3rhCCboVir2uGmuDsxuNEd/4OucLS+LY/WEutfnTURssnpWQSeXdhTxS+jb3prkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/hvcH8klzTffDabk3aGpZYTQAOinAuI/zE+W/Zmsvlw=;
	b=l0yDVHg0b0BEkLG8Ge6n1AQAINQs6fHOWtAhV3y9oECWLg6iUXd8xlKsjpmCs/IUroFg
	 LnKM+S/jcqkujlwBIhfrYDgUyI419Fg1nfu7+svttiDVeDt8oy1cTCFt/4QhymbUHWGqu
	 B2ZXzVYQSPfatCHPGLHgpoaokfLZcHiHETfd1/LxIMSS8YcfSbL25ArMz+Y1kUG9fPRsW
	 0deZ4+9fbZtWkZuUsQzh43z8K5vkkikPP/Sd2S2k4wfULc6E4PPclJs2h1pfoQF5O2UbJ
	 uijVPtSnSbWMPFO44bdxT+xeLvsQETbSht+RyeJdIwjjRAndgrtLUQ8CAGMU/N0VmIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=ERsyzzCn;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5660606A336
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 14:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5660606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=ERsyzzCn
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b7ddb99db4so1444464a12.0
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 06:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795010801; x=1795615601; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/hvcH8klzTffDabk3aGpZYTQAOinAuI/zE+W/Zmsvlw=;
        b=ERsyzzCnGamgK5in+QUaQvX0FAnl+8k3sjWk+hS8fRevAPLIZjfHNpLl/3ue8FOc8M
         6HBxU8LRBiMiUTw/kEgh47/9NHSWc4i5KRE5NvDDCIf09QHd9QHLIP2NlVze4d/TzRay
         ehDcSM6K/V2ApUfE1Bhitbbxz8E1ps/TxfgoF0zXPgYqaBxPK5hF7xyqdOp5hA37EhAh
         xLySes3VFuRid83t4rV7LpmQHsYnKYH5Urw+cdSTnWrqAnWaYPj5JRVXtHyNhcFN2SeV
         RNhZkv2tSeMMZei7/5IW8ts870q/S45VC2um7T22vqC+hr4wTeOCzJvC7Mx0vGlLSFBn
         9ejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010801; x=1795615601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/hvcH8klzTffDabk3aGpZYTQAOinAuI/zE+W/Zmsvlw=;
        b=leEGKxno+iXbVG/tGoYZ/avNAj1OSfd4LSCSsmjCVkkB6F0TJ0StaoYZjdh1XVaNSd
         WICsYAs1MjSLUR99iI1hyKRf2+STZiivAHL2Hp4qK9l0jWSVSHxYl15t9GT2/RMaqkmO
         U2mgJDZLzecwU1xVdJ+53iBCGQ5vtJLs96QvSka2YNaGNFV6LhTZLDdt81HFGOQ0hrtE
         Jswdczi1s9yhiahxz1ZkjoD+tzm0Okj/ctdCKXRlNfH5lQUGfuE1C0hxgb7d1ZSJj68M
         B+84bDpL1Ty8AsAQ2QaV6dMO3Irr8JqpSbIHLypOdlUw11dB9IsHQW4XChwK0mnw66dk
         Usrg==
X-Gm-Message-State: APuU4Z8nRJ/X4hE7ezbuEXNH3M+cGB8wt7KTaGTaElrXv5T/I3MmnUDv
	VoDwJ0c8HKHE54MfgYa6nVAuc4lj9aMlWzr4pzsESAcU2rToPEFKONTT
X-Gm-Gg: AYBFou3t2ZbIieYfGEKboOcGUrdbuhs5cuol6ZI9U9yNHndC2l9vy16aCi52IeDXei1
	BiomNUpUgH9sgzbRHu5Y9smTaONzRyjCvotlliZrnycPVYHNvemHfewTtGRPDALWqOtRlSy2klx
	+vKSFzc+IWPAQBOAfdwS6J5y84hojNHBVjA+OjNBy4IIi5hZJ5CdmxVQ3JZFFQ0au9PkZCL1Lql
	h9lgtf9iFZeoyfCYZdAIcql86cX8lOvkZ6oNy1RZRK+3k9tXqLE99Dwj1UfSVa9GkywAW/nkvbu
	HXxQwnEJpKv0CXc3l+W7ldDCaBKgMa4DVa3tmUEUERqvpiUv5q7l7m+SR/nYa/hHeWnCAM53T+L
	EEP5O9Y/8Tq1SzfjVDMytXYR71Lqcq5P/Pnqc+KwH9Q4D+Fe/nU24TenxNMs2Tf5pWp/fLj8Ixr
	gGLQa8AHL/JETZXD/p865IjmtHHMOXOB33/J3EdTwZnyEwpgd5TlHqjPeKQBxOceay+vAvqraqZ
	hSzPsoL6IeIniK0w8F2LEdDiJuRDOzWO46kG8FmaJBQlx9FgcLB47zcOjoPJ6JWKtCkIFmJuXuT
	YLEW3gWrhJdvVs7OW1K6+olH/631EUy57Ihx/ef2FpxxXXoctz6KiE0Ul6FoT00NQWZ89g2bRWH
	5itjhg9UK
X-Received: by 2002:a05:6402:a514:10b0:6b7:6485:23cf with SMTP id 4fb4d7f45d1cf-6b887ef57f2mr1694848a12.42.1795010800961;
        Wed, 18 Nov 2026 06:06:40 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889c24bc2sm1073816a12.20.2026.11.18.06.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:06:40 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: [PATCH 0/5] Build fixes for Mercury, GCC 16 and glibc 2.43
Date: Wed, 18 Nov 2026 15:06:39 +0100
Message-Id: <20261118140639.1080228-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <90eddfb3-0a7c-4f14-b718-e77662527fae@siemens.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com> <90eddfb3-0a7c-4f14-b718-e77662527fae@siemens.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jan,

On 18.11.26 12:54, Jan Kiszka wrote:
> Means you validated the next branch with your fixes?

Not for v1, sorry: I only tested on top of v3.3.3 and missed the next
branch. Patches 2, 3 and 5 duplicate Florian's GCC 16 fixes already in
next, so please drop them.

I have now built next with Buildroot. The Mercury core and its
testsuite still need patches 1 and 4, plus two more missing includes,
so I'll send a v2 based on next.

> Fixing all these is primarily driven by your desire to fix the build
> recipes, or do you also have a use case for Mercury?

Mainly the build recipe: Mercury is the default core in Buildroot, so
it's what the Buildroot autobuilders and most users without a Dovetail
kernel build, and with v3.3.x it doesn't build at all.

Thanks,
Yegor
