Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4313C693
	for <xenomai@lists.linux.dev>; Thu, 23 May 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473988; cv=none; b=Z8Bhjo+FZo/pRlZX9vEtu2s0/cUAznY9gO1QX6uv3gRlz7g/gt40EAF617PB9YwNwza3ypWr2R2s2dfqq9G+mXoqkp3iWRAULWjIH6WjYpdNRB2R90RC5mEL7mk3YEf1G8dxabf1NadIQxPuBBr1ylK6BvRUI7LJkoPigE/p4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473988; c=relaxed/simple;
	bh=o2czNdYcHUKD/70/ekkCGW510mrSADqApMI5t5894QM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0qjNYBESzjT4cYOEDdNy1zcy8A450T9qgyzn/6859nCqoi9VcdbvIbX4hawoN9+VNTBWQ+oSXdm0hdazFCuae7cqmouIAMoNU7Ro+Dq/4lJtw9H5m+UwBSLnMC8s8pcqaf6M8Ox6PjinuRPInPx3wtqmMeV119Y1QrXCu+LIEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=mrfObnsP; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="mrfObnsP"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202405231419332a19dcd953c9c44afe
        for <xenomai@lists.linux.dev>;
        Thu, 23 May 2024 16:19:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=o2czNdYcHUKD/70/ekkCGW510mrSADqApMI5t5894QM=;
 b=mrfObnsP81jWmUalHOa5pAIX+AyItdN/5g6RHMaUEOICE478sFYadN/P7Chbj0SMc+SdiQ
 trYwWhAM7ypigarf88CzxD345nrTOH1hD3QFNkrv+3m2J11nbdGUZZ+aQweY+fAUt5OUs6Yj
 MN2/9Fu4PdAoS7NSO73Sb7dvWvRkM=;
Message-ID: <a3559a390cd0299167fcc8dbb8228ac3721b5343.camel@siemens.com>
Subject: Re: [PATCH 2/3] rpi4: Add rpi4 (Raspberry Pi 4) as target platform
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Jiang, Yi (T CED OES-DE)"
 <yi.jiang@siemens.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Date: Thu, 23 May 2024 16:19:32 +0200
In-Reply-To: <5a165aa5-b50d-43d0-bc2e-a9f831604557@siemens.com>
References: <20240521134841.21749-1-yi.jiang@siemens.com>
	 <20240521134841.21749-2-yi.jiang@siemens.com>
	 <81ab4ff0-6eff-4944-83fe-336c965b9ed3@siemens.com>
	 <dafbc406f9f93c4a77d3e95fcd5f5d8fa2f792c5.camel@siemens.com>
	 <92eb843ac00112e48b460f6b87e4c615dc8fb943.camel@siemens.com>
	 <82b54361348112dc220d25db6c12f284898ddd2d.camel@siemens.com>
	 <5a165aa5-b50d-43d0-bc2e-a9f831604557@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Thu, 2024-05-23 at 16:16 +0200, Jan Kiszka wrote:
> On 23.05.24 10:46, Florian Bezdeka wrote:
> > On Wed, 2024-05-22 at 12:35 +0000, Jiang, Yi (T CED OES-DE) wrote:
> > > > Confused.
> > > >=20
> > > > - My original patch did not touch the arm64 defconfig.
> > > > =C2=A0 So I'm still listed as author ("From:" inside the body) but =
the
> > > > patch
> > > > =C2=A0 content is different.
> > > >=20
> > >=20
> > > Yes, we do not need to keep rpi4.cfg any more, because the original
> > > content of rpi4.cfg has been merged to arm64_defconfig.
> >=20
> > If that really works (especially for the older ipipe kernels for
> > tersting xenomai stable branches) the patch needs some reworking.
> >=20
>=20
> We don't support older than 5.10 with the RPi, thus also no I-pipe.

Sure, but IIRC one of the options triggered a build failure for older
kernels (or other machines) when present in the defconfig. That was the
reason for the machine specific configuration file back then. If the
problem does not exist anymore: problem solved.

Florian

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

