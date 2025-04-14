Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD371DB128
	for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666034; cv=none; b=cG5ZrSq6oO7CuFp6LFIajsRdtIGCOxIJyq6bMb4+ljJPCnU2kM2NuKr/X6uFwOpwXgJrvNuXyTH8aEUUHSTUAc2eIVD6xDJBNO2zKPWOhV4DZc/AZgN9P1iczpanpGMj1SrWuEKRwsFAdmxeIO51XnCwpx1ODMF3RtpmBuPo2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666034; c=relaxed/simple;
	bh=p62kPdbMXYFgbqopenYuAiy89EC0eGX9ncyfqZyLk/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQ7DtY2JeySHmX1AgekRa7OUOCG2vvBo/8VsIT9mBLJsuta0tDIVxvbgBNCQUU6aVVoJFPaRUMujxX5xciyiixC7V7sIL0GPieh9k1js3K4GpHEkURVStEnzsiuFoxoo873KN1sFEgTpaHnW+YEm4uHDuDdhryWz/QZ159fVDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Mbojt4wF; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Mbojt4wF"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250414212706725eb9952fbff54cc6
        for <xenomai@lists.linux.dev>;
        Mon, 14 Apr 2025 23:27:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=p62kPdbMXYFgbqopenYuAiy89EC0eGX9ncyfqZyLk/I=;
 b=Mbojt4wFJGOp0hdBEwJafiHQq91UZRgEMRvODOET6z8XOJNU+ACVn4DU6FCDXJaG0StsYk
 BeYpE1GtjD6xE7cq7XuFJr4BBeQZIxZ9M15FqwOoNSIGzZbSlYCihe5fJiUpE64uWqUU17rk
 1uS3JXroaicAAZy675Ymgwipoe/1j8iJZ43kyDTRLu9FYlXoFuBURbSSB3vAP4JN3mGcsVeV
 kuIaaT5AL2Dy6ydBxaE/nTbdl3jPnkay+TKY4l8UDYdB7/88nRAR2LwZwvXqlsk76GtANu2H
 j31+s7I8I01VSi5Z42ZNMBiaBV244o74rlQCasySnanQ0tBmb+BiyU3A==;
Message-ID: <30c3e78254942075c7811336c90a4fbe9e12d5e0.camel@siemens.com>
Subject: Re: [PATCH v2] prepare-kernel.sh: expand tilde in --outpatch path
 parameter
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Haiyang He <aspirestro@163.com>, jan.kiszka@siemens.com, richard@nod.at,
 	xenomai@lists.linux.dev
Date: Mon, 14 Apr 2025 23:27:06 +0200
In-Reply-To: <CAFLxGvw+YK=4pW6+jcVt-_=ZjpikiQpc1m_XwiG5Lkxj--Q4zw@mail.gmail.com>
References: <20250414153817.1829100-1-aspirestro@163.com>
	 <89584308d4044af665ec7ed2ce71258edc237ca9.camel@siemens.com>
	 <3e4268139f9fb21608367b46d939b8d1c93e1f88.camel@siemens.com>
	 <CAFLxGvxC+TZKfQ90Q29fh1kQxjqLruUWezdHtjD-OKw=fJBVjg@mail.gmail.com>
	 <cc0b3c1d50ccb79828cfa12058265119b663b1f7.camel@siemens.com>
	 <CAFLxGvw+YK=4pW6+jcVt-_=ZjpikiQpc1m_XwiG5Lkxj--Q4zw@mail.gmail.com>
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

On Mon, 2025-04-14 at 23:13 +0200, Richard Weinberger wrote:
> On Mon, Apr 14, 2025 at 11:02=E2=80=AFPM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> > > We are already in this hell.
> > > Both --linux and --dovetail use eval.
> > > AFAIK, this is the only way to fully support tilde expansion.
> >=20
> > Ouch... With that said, I think v2 can be merged.
>=20
> I'm not sure. v1 does exactly what we do already for --linux and --doveta=
il.
> No realpath needed.
> We should provide the very same semantics for --linux, --dovetail and
> --outpatch.

Yes, v1 is more consistent in that regard.

>=20
> --=20
> Thanks,
> //richard

