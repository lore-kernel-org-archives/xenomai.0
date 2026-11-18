Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003363;
	b=3L46tj7R7M2DraBsns2r5K9nU5sOb4ouijh6MGZDCFXkMxrZB7IzcutwKIxTagL4JQNW
	 NSOMqmJSCqOjRih830DdahsGf06BwX/4PQUuJyn2F2bwml8WvPIr6fIh33CRjCPvDwITn
	 zRmltl6oArKhepDbvmJRBtlxfp/tvJhkK7tPFx1oRvz0ciPyvzyAfTUid3oqyATg6l3LO
	 nHyp1PGXmLusk6ORWPGNTQH7+nHkC1FKm6kcLZ0fYFhpsqEHsQwf3XChO1b605KRCbM2Y
	 Rg+QviTKEzqSZ8qPMSQ9WSft1RwkmrET2DneMmrWWtewBPUt13+/o0uaInD2NKhRcRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003363;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=PH8agYCB1qLUUZKPoaoEG0Ceqk+UZoQtV1M/sM7gvVQ=;
	b=d0VdHXD3VN8QxVOR7lzzHRnCY3qECyAbQlJymCnFTmVKXg8KuxpHY/KCoFr0MfBFYM0M
	 od3/k98THjxpO5qsUDCleCLgMqLykePBvZ4TxnVb+GqIpE5Me9tGS7bvmj80dLSws+41u
	 6SyuBTEoRBHupu1tp59nElvoE+G5LWgza51BkyuXVaWCxwTHmz+i2vBfTjy+qWocw9hht
	 NX1x6tDb1mHYg2vuSALYcXFg6ZuO9WiA+ICogmv/ybko5CLNyp1mFO2wLmyP2YH9zyO5O
	 JV3+dwkMxgoCDlEAyz9NxCNtN7uja1q8JqcqzKJGEYEkO1zj4JzZNCZJ6vjS8TZH25Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b="bj2ueN/A";
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE365606A325
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 12:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE365606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=bj2ueN/A
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20261118120235dc5efae5390002079c
        for <xenomai@lists.linux.dev>;
        Wed, 18 Nov 2026 13:02:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PH8agYCB1qLUUZKPoaoEG0Ceqk+UZoQtV1M/sM7gvVQ=;
 b=bj2ueN/Ae+bSuTXhl7LkcSxI9jCOsYpZT5FogEO3tqFNhNlT8hoNM6OhW4HFO30Tv79NrU
 mpgR8CywP8rkt1r7yY0t486K2y0AmInE/nascsvCbIyQ7ckHgYKQUZLIfPzj4STWkC5cOi+K
 2ozjTI7zBQmOBhbfdbVnK48z92utkk0w+OeK3uDPtYyEOgaFIJyYBrGLf9hRcnilZuqHrKkj
 3/+EM6eBN4njxKCZmXi93fgSFcmLJaP4XxUcp7ZZ4rRewq4KvAcXmrlZGrsl270oFTSg4If3
 LjWjwdC369DKZz6xK+1v9PEMBefkNkmnHcRTbmCIG8KeWyEHtxDpcUPA==;
Message-ID: <b15f902cee6017dd0eddc10312979fe555c2d6ae.camel@siemens.com>
Subject: Re: [PATCH 3/5] testsuite/smokey/sched-tp: Fix build with C23
 strstr()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yegor Yefremov <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 18 Nov 2026 13:02:35 +0100
In-Reply-To: <20261118114909.3030884-4-yegorslists@googlemail.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com>
	 <20261118114909.3030884-4-yegorslists@googlemail.com>
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

On Wed, 2026-11-18 at 12:49 +0100, Yegor Yefremov wrote:
> Since glibc 2.43, strstr() returns a const pointer when passed a const
> string in C23 mode, which is the default since GCC 15. As
> ref_schedule is const, assigning the result to a non-const pointer
> fails due to -Werror:
>=20
>   sched-tp.c:233:11: error: assignment discards 'const' qualifier from po=
inter target type [-Werror=3Ddiscarded-qualifiers]
>=20
> The result is only compared, so make s a const pointer.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  testsuite/smokey/sched-tp/sched-tp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Already done. See commit 8109051556b438cd4c280e75c2a45ae3b43d7f7e
