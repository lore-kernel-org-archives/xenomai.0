Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041F3ED135
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432629; cv=none; b=h9VH4qnw24k+mHaizHMJfnqgbVnWOnpVl2TaJBdG+c10s5bk496pCQqniSFQkkB+MuUNVaH8A0kSFrH+BSB1qICgwrjh0nI/7Rd4XcbIX7HaDhw+5wjVoVW5Goh7beiGMLK0AMIRUv0mQNcD4/nfYPuhufOw2NOZv+/XZoMzzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432629; c=relaxed/simple;
	bh=LZBkpl4JTREWMyK996085BWL4MMypKi53F5iUACijO0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YuIzivByiyl6OhITYi510Hvs+MSam9Tu1jNArkzy+DOvY5isWaGsSBV/NFBHhrMPAR0Wd/Tgh7VSDCKfuglOQ9L8uwTNxn1emQqINDCCmo5c6eRBhd2XzPfPVzF9Zm+2sQCkTw9yRAmrXyZwszXvwpNbjwqV7f3MlpJqvYkmr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LJMRMc8L; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LJMRMc8L"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260707135700810113d7e400020747
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 15:57:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LZBkpl4JTREWMyK996085BWL4MMypKi53F5iUACijO0=;
 b=LJMRMc8LZRz+rOWUSxR3/vno4jNI00U/Lv6vHGih24MOymsKpe4Fdfybuyvhishn1Rpvmy
 eG4AKndZZ//0LgN3ILQ0dG1O+1we3nMcCMYeeCN9VCoHRpHYSn42LsC5XSyVYRbARIaTfYbx
 GgeYquJGtqfC3cXpdq0XjhbGYhLFJM71vfBb+OuzONRBVEd+9HuOpFqjwEFW/0kfzYPJsUgf
 KEFLYZ/i8ukBmza6GiXU9mPREGv8ZItKoVaO4k0mUa37DqmWWoz0NZFX9kAGul/makQ553d7
 i6mNdN2FHO6BUotX5atuydq075kk5H8EWThOPUUbjMXOM1tXd8TIajxA==;
Message-ID: <2fff81a403bcd74efac90a1f66ed6d7e8e235c86.camel@siemens.com>
Subject: Re: [PATCH Dovetail v4 0/8] Dovetail: arm: Finalize review results
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>, Tobias
 Schaffner <tobias.schaffner@siemens.com>
Date: Tue, 07 Jul 2026 15:57:00 +0200
In-Reply-To: <875x2qx64u.fsf@xenomai.org>
References: 
	<20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
	 <875x2qx64u.fsf@xenomai.org>
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

On Tue, 2026-07-07 at 15:48 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > Hi Philippe,
> >=20
> > This is the first try to fully process the feedback on the
> > interrupts_enabled() issue mentioned in the former patch series.
> >=20
> > Input welcome.
> >=20
> > I tried hard to keep everything easy, but changing the current
> > implementation triggered a lot of unexpected include / build problems,=
=20
> > especially within the arch/arm/include/asm folder.
> >=20
>=20
> LGTM now.
>=20

Nice. Should I apply it to the 7.1-wip branch already?
