Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003286;
	b=xX4TB+KpuwCwVCLWf4k8A0d6VxTfvqAt9W/khlijcxSzkT04DITyM5alQNlafnnaZWqw
	 Ve61KruMwF+JHKOaFMXoUTbkykV2zdaLoxR4Wm4NS+ipGVtICY4SxTpEkwL1bGjMNk3Xp
	 Oor0ZY1cQfyhp3i9ki/g/D/NqAJD4DoAmPna2wixbdszzh7bYNYirWs0yYGniRuFoEVSx
	 ghzVRG+KElcMF4pa38OWG338tBa3k3WkpRHp60d61uD2qr7293a44+Q8fBlKRt7RLD0a3
	 cwLSPd+xPptjulaXaW2niK6pUF75wZjuueqHuxDuqD6J1+FYYZCHV31a0w9lBYJREdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003286;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=I3a9J2XRB9b0iWY12cOrYv7c3Gp5C7DYxmaUnqUeFSo=;
	b=LVdL8AQO4DVjOLv7UaRL8Wv3Nk+RIoAxJn2+5BHKoHoFC3/N4AR+dcOY4ouindaD25Pu
	 KrivGwA9iFNV32cIH0awjBeZ77XbMqf7SZ4+jjyCT7NFI9z6Hx3a/WSwWHuXESyDQ2vPU
	 0ur6en2z3s4Cj0CBCLCIiduPtYWep2oU/eaOfYw40DGQj6BYpT0xicPAfWdhfKMkPvBKm
	 vjQ2q+sP/39YMkYTBFJFzfiFK2IgK9SoWQ5///yWLTX603it4gy9NsnB4NdoEZ7k4KKhx
	 9iLcfhvLSA2BgG//4QV9/PMN3gEzWcG2q7W4W7VfKMrZ//AYhjXMPnXkCaBwbHSIiAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=lXh9d1eh;
	arc=none smtp.remote-ip=185.136.64.226
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D9606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 12:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA6D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=lXh9d1eh
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026111812011504e0fcb10800020761
        for <xenomai@lists.linux.dev>;
        Wed, 18 Nov 2026 13:01:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=I3a9J2XRB9b0iWY12cOrYv7c3Gp5C7DYxmaUnqUeFSo=;
 b=lXh9d1ehXjXnMoNeVLrhDedrt6V/vkqLQQisEVHylxbb1VScxwpzsyBrew5tqKiT6Mis49
 6D9DQ3rgiV46ud0Dfe8fP/F1mmUmmLebWu6899Ta2ozlKcOTDi/KbPm/wA4SpSQMkW8Rk/AG
 TyriNt6XbK8crmTdmrRGAlieRHoM7Jbuj5x6JAj7+dN5lD4BgZ3yeqzREU6PPKID4rSK2wTs
 WQNfn9kMGG4aECTRR1y7bUrGq2CdKjHeLPudhhM/LkkgsZrMgdbM434r68F45/iN9nTdnfQJ
 I2QL3GCt+KyMW5AqxK45Sq+ira6Nf9hMqgP0f5unBJdXN8BTTOvwapbw==;
Message-ID: <ce6cd672497809086cefbdedd591480329d1332c.camel@siemens.com>
Subject: Re: [PATCH 2/5] utils/autotune: Drop unused sample counter
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yegor Yefremov <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 18 Nov 2026 13:01:15 +0100
In-Reply-To: <20261118114909.3030884-3-yegorslists@googlemail.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com>
	 <20261118114909.3030884-3-yegorslists@googlemail.com>
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
> The n counter in sampler_thread() is only ever written. GCC 16 now
> warns about variables that are only incremented, which breaks the
> build due to -Werror:
>=20
>   autotune.c: In function 'sampler_thread':
>   autotune.c:95:34: error: variable 'n' set but not used [-Werror=3Dunuse=
d-but-set-variable=3D]
>=20
> Remove it.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Already done. See commit 2bc267a49541fea39eb230e9efd0820c87f8e990

This series is not targeting the next branch.

Florian
