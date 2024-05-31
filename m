Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D71103
	for <xenomai@lists.linux.dev>; Fri, 31 May 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717139513; cv=none; b=q2q/45br8ulSvw7ofiTnCm3sai5QGGKZL8EOJs3R9SLkfWRqK8Q9JyTdRf+Fzfm6qNnW+mBtH1R3BtdTwPg86HwILykpzs95HJkeOOQfOq9pGjQVRWWEkySPBD/24U4uFqJDBspo0dmVklNlwJ6zzUyBJTB/75Ax5jPZ3Lweks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717139513; c=relaxed/simple;
	bh=T0CrQPWBRdJyLK3OtpUsHxEexY+ZjZszivc97bIYn3A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HHGb5J0PvDb7MuO+fNGRmjPNliCUyGXTem43RdLNQsStuTr0L4ywAT2SKHNk9mlY5ZE6T39u5+7KKzc3tSOfuvYCpEZJsLFmPVjCTT+zgSfGU5UgjPwPgGV6gmnbmmAxlcBtX9TCvMbkF3PLWnHP8HBIsIEk5SYULJzchL7Ok68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BEDB8uE5; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BEDB8uE5"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024053107113988c72faef65e0e6cf9
        for <xenomai@lists.linux.dev>;
        Fri, 31 May 2024 09:11:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Y6Hoh79E40tT1GAckploNyfNh2P388oStJTilXSYTTw=;
 b=BEDB8uE5LC0RjpiRyX6fie7kXa8Fr8Syccm9jdENzjJ1VlG1UuldRuuauL0CJsdQvzOE90
 Nrn2+Sd4Wk7lvz09wIR3R8OEsO4yU7eKZYM7ibW4HSfbIPV6/D0/upPo+2p836jXX5KoAN2R
 mWomoaOKis1BjL3brSM3OQxfnfLM0=;
Message-ID: <207f29ba1fe51a1656c5f72cb719ba0fab5b2e6d.camel@siemens.com>
Subject: Re: Dowload URL for ipipe patches?
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Norbert Lange <nolange79@gmail.com>, xenomai@lists.linux.dev
Date: Fri, 31 May 2024 09:11:38 +0200
In-Reply-To: <CADYdroMJCeW_UNvc6K1p_2dc2-hCDWyATXcDq6iHL5pVSrFknA@mail.gmail.com>
References: 
	<CADYdroMJCeW_UNvc6K1p_2dc2-hCDWyATXcDq6iHL5pVSrFknA@mail.gmail.com>
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

Hi Norbert,

On Thu, 2024-05-23 at 09:32 +0200, Norbert Lange wrote:
> Hello,
>=20
> the older URL's dont work, and I did not find any reference to the
> replacement, even rather recent releases have non-working URLs [0].
> So the links dont work, and the gitlab repository doesnt offer them
> either, eg  [1].
>=20
> Whats the plan going forward?

the main point is: I-Pipe is "dead" / in maintenance only mode. The
last supported Linux version was 5.4. We have dovetail for modern
kernels, so the way forward is "use dovetail".

That said, we have a downloads archive [2] here. That might help to
some degree, "newer" I-Pipe versions are available through the
architecture specific ipipe git repositories, so no "ready for
download" patches anymore (as far as I know). For x86 it's [3].


Best regards,
Florian

[2] https://source.denx.de/Xenomai/download-archive
[3] https://source.denx.de/Xenomai/ipipe-x86

>=20
> Regards, Norbert
>=20
> [0] - https://lore.kernel.org/xenomai/E1qVdKL-0003yN-Ua@xenomai.org/T/#u
> [1] - https://source.denx.de/Xenomai/ipipe-x86/-/tags/ipipe-core-5.4.255-=
x86-15
>=20

