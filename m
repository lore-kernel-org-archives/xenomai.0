Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7F13C900
	for <xenomai@lists.linux.dev>; Thu,  6 Jun 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663078; cv=none; b=i/trN+m8gTyXbPb9uCwNn8taedLoMuYghGso73azGcn4MfTrpKOv+8fjuNiVXQMOciQXiltr5xtMan40Ml8oDrQT98evlh5X8xTds+I53tsGacHBSj/xJhlEY6pmd9eNTsGb0+dDzKBPGpZwVAIIogCgra+ryYYE8n+KDCixOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663078; c=relaxed/simple;
	bh=YCTcn9itIZiDJU/0KthE0py63TOLhy1IO7HPso4h73I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJz2jScuE0jpPs6XMfjpSCEIYsHAi+ucgnvaHbRqS3PZkoe5LNj0hb59ux+bfxtH/sjAfL8gWaymMR/5HQEdItJmIFA7XVoTxlOd7t48jP/l0UmvjU9jv4DLCSDRbH2UzYoNLDSkFSxtqKQYlPQ4QHOcdHJ/xlsILgYwMf9myE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=uliYYnNL; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="uliYYnNL"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240606083748160de3885fbd1ba28a
        for <xenomai@lists.linux.dev>;
        Thu, 06 Jun 2024 10:37:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YCTcn9itIZiDJU/0KthE0py63TOLhy1IO7HPso4h73I=;
 b=uliYYnNL/Fy0X4511uMWsDVMtpfTsIX1AIfRuMNg/eVgIXXQXNMIPysMe77FfzVb6hjokN
 7mtJGkh7OFKT7fbncUKgRpsbOwcET4OGesqdd5Ah0I29kRGSnlH5/hqeAgpp+JfnvLgzEbSb
 ne2PrYrG+lyybPmR6lfH6Eys1J/rs=;
Message-ID: <322a73aecb71efe92feaa607ad1ae745541d7127.camel@siemens.com>
Subject: Re: Dovetail/Xenomai 3: Timer tick locking problem
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 06 Jun 2024 10:37:47 +0200
In-Reply-To: <87wmn2eawl.fsf@xenomai.org>
References: <1a4aa9f3bfb30fe5b5955fea1486a5fb8b040ff2.camel@siemens.com>
	 <87wmn2eawl.fsf@xenomai.org>
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

On Thu, 2024-06-06 at 10:18 +0200, Philippe Gerum wrote:
> > [Xenomai] lock 00000000e04e7d2d already unlocked on CPU #3
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last owner=
 =3D kernel/xenomai/pipeline/intr.c:26
> > (xnintr_core_clock_handler(), CPU #-2)
>=20
> Mm, -2 looks pretty bad. This should be either a valid CPU#, or -1 if fre=
e (~0).

-2 is coming from the "last owner" member, the (current) owner is -1 at
that time. The lock has been released on CPU 2, but somehow CPU 3 is no
longer the owner. Right?

Means CPU 3 was the owner at some point (assuming there is no double
release), but when it comes to releasing the lock the CPU is no longer
the owner...
