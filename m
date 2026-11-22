Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380178;
	b=Mkm6CHQtNfAKylPLJVsY1zds6ETypPUmkM89qlYFjiGCaR5IrOiZmWzr3JnWgJJEe8Nl
	 lqc6uqOz5fWHDTt255avEDu13yboZQgOfbm8SWTWM347jLH5s3B6Bffzt8O4AuzVtGUgF
	 Im4HpFrlSPcCE50YGLyWqRInYAz2Nhv4PbS3HNyp92GvK4ksthZhJLcEIsU9Nse7Fis73
	 0JSpgKZ/at/JsNOt1aLC5UAcrJhYUSwAI9hjlAZWnFa3IOhXxQz/u/RcPXeOGHrjG6TXH
	 2ZIdBbO1GJ+WUsRW0flDVNvP+OoRyLKu/Hl3MzIb6Hok0fnLYWBYX5ubsZK0zjZQUtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380178;
	h=DMARC-Filter:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:References:In-Reply-To:X-Flowmailer-Platform:Feedback-ID;
	bh=CtiiQ77fA06AVyhRidgrkN186bmvJlNgd8Hvroy5LcM=;
	b=YWY0Jls96XDLrtvv0hqPQpfo8RH6g+PpTEsjimctS2+YakL/HRZ4RxuUmcItuPRu2X7/
	 uo4mjpX/TcM0EMXYn2mSGeqZvVKrVczA7h6ZhA5J0Qvm53qX5msNvsSVlzkA8TZzfLoo6
	 KuEZD/Wk6SVYX9OgIrSCNnRKFOyGDOGoTp+I3uWpWpIgUWLqtrdTuc5vsQT7/3sH5xq7P
	 iBRGFRT+nQnV29wSO19PEg97Ls4hrABdRQr4SX+cwtzfpb3cO4e0V1CUBrAxKs85x2XRx
	 6n5JFvUeQSIPPW+4J7zLdjnRmmYjml/xn8U/GqESVkEDoOq50fLXnzJb3rCsUmgMeQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=rez2fbwc;
	arc=none smtp.remote-ip=185.136.65.227
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F8606A31A
	for <xenomai@lists.linux.dev>; Sun, 22 Nov 2026 20:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 511F8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=rez2fbwc
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20261122204247f24d39f37d00020709
        for <xenomai@lists.linux.dev>;
        Sun, 22 Nov 2026 21:42:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CtiiQ77fA06AVyhRidgrkN186bmvJlNgd8Hvroy5LcM=;
 b=rez2fbwc8oPAnaYOAdwBknQK6H6j3+u/oqdHsw52pbvDWerYgn45fmBKs520pBs2ZY6n/v
 GsbZn1SKRVZh0zlzjcukRTt5tZk/n0zSptK0t7ERUqy/45JdKQ5eCXQBdDMKPgGLDSU+Zgwd
 QkH91mcyZG8njCpbXAJOm8HETTYC+oPpGM2wnf9F43doC0ye3ZvoCnbZ8nrsboszTKOSwcRP
 G2H7Ei/aFDJtTtCqMvjeJC77c3IrXMVrW0tEOSswQBLruOVvmDPoBD8LPuuT5O0Uut/6MOBJ
 0gUkEBVmjwOd4CIklWxVzrNb+lg+rCUeCsatBkUt1MWpx9932UlU6F6Q==;
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
Date: Sun, 22 Nov 2026 21:42:47 +0100
Message-Id: <DN215IH102NW.2BHKNDG4JR4VV@siemens.com>
Cc: "Philippe Gerum" <rpm@xenomai.org>
Subject: Re: [RFC][PATCH] smokey: Add traps test for trap routing of primary
 mode threads
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Tobias Schaffner" <tobias.schaffner@siemens.com>, "Jan Kiszka"
 <jan.kiszka@siemens.com>, "Xenomai" <xenomai@lists.linux.dev>
References: <31921289-e2ce-4370-bb21-97d66de8e566@siemens.com>
 <37fbdf8e-9116-4b36-840a-612d49fc7f55@siemens.com>
 <e78f2129-6875-4b5e-87c7-088950b69785@siemens.com>
 <4f118759-234c-4ed1-afe2-fbefe849e369@siemens.com>
 <b533b6ad250bf960948765d5829fea34f26b99c3.camel@siemens.com>
 <ba91a81f-a52a-4742-b4f9-4c9c3437ef8c@siemens.com>
 <6c4a73ca6be802d564e770baecd5d90220627d13.camel@siemens.com>
 <66709223-4a90-4073-8068-8f5d24118aca@siemens.com>
In-Reply-To: <66709223-4a90-4073-8068-8f5d24118aca@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Sun Nov 22, 2026 at 8:46 PM CET, Tobias Schaffner wrote:
>> Close to free is not acceptable for production systems. Depending on the
>> workload you could easily run into problems (pre 7.3).
>>=20
>> My own experiments (especially with the RV monitor), the discussions we
>> had at plumbers this year and especially John's talk about the RV at the
>> RT user forum in Prague (see
>> https://www.youtube.com/watch?v=3DjO4M5dx52Vw) would be he references yo=
u
>> are looking for.
>
> 1. Nobody is talking about using this in production. RV was proposed as
> a testing tool in this project.

Why not? Something similar to the rtapp RV monitor (as we have it for
PREEMPT_RT meanwhile) would be very valuable.

You compile it in, with zero impact, and enable it once you ran into a
problem.

> 2. John is talking about the rtapp RV monitor when talking about
> overhead in his talk not about RV in general. Are you mixing these two
> up?

Maybe to some degree, but the infrastructure behind is the same.

> 3. The improvements that have been merged into RV between 7.2 and 7.3
> are not measurable in my setups. Having a more sophisticated HA monitor
> in 7.2 enabled adds about 1us of overhead in my tests. That is not
> "unusable" from my point of view.

That highly depends on the workload and the scenario. Which non-rt=20
workloads are you running in parallel? Networking? Containers? GPU?
That is where the most challenges come in.

The rtapp RV monitor has made significant progress in 7.3 in this regard
already. Other parts of the RV infrastructure were discussed but that=20
will take some more cycles to arrive.

