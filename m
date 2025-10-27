Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17491FB1
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569684; cv=none; b=EuJLDRr+p6CRLBSt5JZyRei2DugfufoopA21o8K4fDZS1VVTtiGjiP28maSkGzagEuT1WTWFzaegj2cFhf2BmKbwv8CQ9y6kYBLAOGIzpTwgjc1uWQAjFNC+RrA0SD38ocI2K6dpTHH+TQYzo2sHXSNQ4F35V0+ENwAXDQ30L0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569684; c=relaxed/simple;
	bh=TbidxdJI7zTTXX3t40wMWGAAR+5tq87Zxr/bO5lL/5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2hztTShgX0Bb8yyLyrEULzhOkN8uMoQRvVuE8GNX4kJ9rtCXkMNvuk99Ka8gMK0ocBgYTNflmqQmJJJLZe/B9ZqWlE4/bUdtG+n9TWhb8EVB8GIIHAfWhRGVADOdw8yw+00hSrWfO1q+zbgC3Oyq9wBerbzGYdV0R8mWpym7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=P4iwP5gV; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="P4iwP5gV"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA3331015A9;
	Mon, 27 Oct 2025 13:54:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1761569679;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TbidxdJI7zTTXX3t40wMWGAAR+5tq87Zxr/bO5lL/5k=;
	b=P4iwP5gVsabWQYqSF+90M0pFKKTafF2yXDTvgnxEOxQUtdEHPBPJf7O+MhAbLjVd4EKPnq
	xvjkm7Hq5vk5WG8WwzEmy7D7vFzi0E5aFPgplU7jl8p3mdpEtGtFbsCRzOqUuc931AZEEO
	YCKEaDYPIcmUBoxokVeREjGTo+lyxZF4RGD2q6cvAQl/jGuD1Abd0DNyQTY+XlPIk8lkFQ
	2gYI7IY8Trpae2B+hq9IldnYQO788ucSZFUZm+15NLVrwZGh0wkH6UZHKfLt2lRZiyiuJT
	asJ5dlKu9kJc08eA+zXSkX1KY88MOsErRspljPAJO3qn+q3X5C/MksJAVRKsAA==
Date: Mon, 27 Oct 2025 13:54:35 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Giulio Moro <giulio@bela.io>, Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251027135435.6c2391f3@wsk>
In-Reply-To: <87h5vk7f2s.fsf@xenomai.org>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org>
	<87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org>
	<20251023155439.0170f987@wsk>
	<87a51djuor.fsf@xenomai.org>
	<20251027120535.7933c720@wsk>
	<87h5vk7f2s.fsf@xenomai.org>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Philippe,

> =C5=81ukasz Majewski <lukma@nabladev.com> writes:
>=20
> >
> > For the record. Both Xenomai3 and Xenomai4 have been run on the
> > identical hardware.
> >
> > On Xenomai3 there are no issues...
> > =20
>=20
> Dovetail deals with those things, and this layer is shared between
> xenomai3 and xenomai4. So the situation is still unclear.

Just to clarify - the Xenomai3/Cobalt setup with 5.4 kernel + ipipe
patch was used. That (old) setup was NOT using the dovetail.

>=20
> >> so either some
> >> traces are missing, =20
> >
> > I will check if I can add more tracing.
> > =20
> >> or something happens at hardware level which the
> >> kernel does not know about, as it may be seen on x86 with some
> >> uncooperative BIOS (e.g. SMIs, thermal events come to mind). =20
> >
> > IIRC - Giulio reported the issue on some ARM system...
> > =20
>=20
> Yes, but he also reported that he could observe the same issue on
> xenomai3/cobalt as well. So we cannot rule out two distinct issues
> just yet.
>=20



--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
