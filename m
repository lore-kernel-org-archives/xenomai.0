Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40D1442FD
	for <xenomai@lists.linux.dev>; Fri,  5 Jul 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181038; cv=none; b=O0D+X2X3lcmxB1m/IW+QmcvBbsfoat0B1ufd3j1+pGh9zkkTRkxoEuKCU+QQylJ1Y2fCELsbmkcuY/CxWfSugxhDN2HMkY4vZYxcNovf21GRlrNlNTPdoWAzFTtR7jujfXorVsRsF25oF330oDJRFXzA0Fak72VlTFDCW3F4E0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181038; c=relaxed/simple;
	bh=XvTavI7goL5Rnt8ZwKOiMIUFbAXDABqjrB/7c+aWvTs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQseoATV6C1JXjyv22NpAAlhLFLGHNiRNu+67xEdpFNIkU6Qt0jOYGc1INjmkpNHwy0rXYteLb2QsosneLkRMGftg6ELXUCJ6z3HgOxwjvucYOlRQoGRdv8FrlRLpKnxboLSTWd6QiMx+07mWBx9hrKdq7T/hr9u8EZtvEpe8Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QoXJm2Dr; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QoXJm2Dr"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202407051202497f9c3554593e208cf8
        for <xenomai@lists.linux.dev>;
        Fri, 05 Jul 2024 14:03:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=XvTavI7goL5Rnt8ZwKOiMIUFbAXDABqjrB/7c+aWvTs=;
 b=QoXJm2DrZl1lut80K7TUniye4unA9F1TNAet4IRdEOhrz8nuTKjwUjq5wbyi684xgJvwi/
 JSFaKpXQ1gX18i9mJrtGtVTNfBXjdIYoLY0fB0V6l6Y3Kttba9+lyNz0uYFSmYGWo6NNzfEy
 Tp1S/8wbmsvHsrSziaRjFilaZ7fwI=;
Message-ID: <2d789cb5140ce510e47fbf8a5be6d9c426b8562e.camel@siemens.com>
Subject: Re: [PATCH 03/33] drivers/analogy: Migrate from rtdm_printk() and
 printk() to pr_*()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 05 Jul 2024 14:02:47 +0200
In-Reply-To: <bcddf6d2-fed5-4be0-88ed-1c3393465886@siemens.com>
References: 
	<20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
	 <20240702-flo-removal-of-rtdm_printk-v1-3-cc91bffdd063@siemens.com>
	 <56a2015f-c36d-4836-9b63-881ff98dda24@siemens.com>
	 <e5dfb611b7544f58adcdcac5e5f5051ab208df33.camel@siemens.com>
	 <bcddf6d2-fed5-4be0-88ed-1c3393465886@siemens.com>
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

On Fri, 2024-07-05 at 13:23 +0200, Jan Kiszka wrote:
> > > ...but not here?
> >=20
> > I think this never worked as expected. I will apply the same pattern as
> > above in v2.
>=20
> Missing KERN_CONT...

Yep, but as KERN_CONT / pr_cont() is limited to early bootup/arch code
I think we should avoid it.

Taken from the kernel doc around KERN_CONT:

Only to be used by core/arch code during early bootup (a continued line
is not SMP-safe otherwise).

Florian

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

