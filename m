Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B7BA49
	for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664539; cv=none; b=VD+4VIeFqk0AtZLC6pGfmJ11oKGU6jZpAS2/9P7dpiBfJ3NZ013rMu4K0FAc0go6MbK0WShgn7H4Hvydq7I5q73V/Lgt609FvfJiHxBpnQE40uZUKkt6dKzAzg/65BJ5NjbWmNMPzWt3g7nZcvy02EeYg1qQu8XVZvnVBEUIKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664539; c=relaxed/simple;
	bh=MTLGUOgqk7TGOTxSUdnKo+XRxxXiDRxb+33ncuYk0gQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5oN51U3uZPo68OwLnZGMDD44MRaMGecXfiNcT54GzkZDbOxip+rsJJEZSdIxFJodtAHbj+K/DbUhueMksRIpFiAXCvYWXG3wspnnfkzGWjBChhWprW+VdIvY9qZKrGIlssMwnF2L0K+hnMSd8SlAeJkFB5AvU1qAc+yRn3kP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=M04HDGm5; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="M04HDGm5"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250414210207fa22697afbe26976aa
        for <xenomai@lists.linux.dev>;
        Mon, 14 Apr 2025 23:02:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MTLGUOgqk7TGOTxSUdnKo+XRxxXiDRxb+33ncuYk0gQ=;
 b=M04HDGm50/sR4npQsa6EhsEEAupnjBCEuKw0SOuvm0+Oc+eSz++NR0LTDUXp/ex+BZl6uw
 +4xd1SRb3Zu0YqIjDTENNV51mM2jG9gTRovdsWt5l27JLBsfgWnoIaSFMYiVEHsA4Pgv7tBt
 wcIQYtR4CYbClR0g+sVulJAc+ywRVoLlk1Fg1j3q3oY+djOLPXFnKwPANI2vTToW1gDGNjHT
 enh+AZnnxEEVTsUkQ+thDv7wTtJ6DZ1Ewz5ITydWfKQSo62uYvl0s9RzGTTfwdzCz2KCz8Zy
 ZzvJKMEDlgkqMD8V9d9V+PkHCjrb91z+73X1D2dJGnI10Ho2T/Fh+NjA==;
Message-ID: <cc0b3c1d50ccb79828cfa12058265119b663b1f7.camel@siemens.com>
Subject: Re: [PATCH v2] prepare-kernel.sh: expand tilde in --outpatch path
 parameter
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Haiyang He <aspirestro@163.com>, jan.kiszka@siemens.com, richard@nod.at,
 	xenomai@lists.linux.dev
Date: Mon, 14 Apr 2025 23:02:06 +0200
In-Reply-To: <CAFLxGvxC+TZKfQ90Q29fh1kQxjqLruUWezdHtjD-OKw=fJBVjg@mail.gmail.com>
References: <20250414153817.1829100-1-aspirestro@163.com>
	 <89584308d4044af665ec7ed2ce71258edc237ca9.camel@siemens.com>
	 <3e4268139f9fb21608367b46d939b8d1c93e1f88.camel@siemens.com>
	 <CAFLxGvxC+TZKfQ90Q29fh1kQxjqLruUWezdHtjD-OKw=fJBVjg@mail.gmail.com>
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

On Mon, 2025-04-14 at 22:53 +0200, Richard Weinberger wrote:
> On Mon, Apr 14, 2025 at 8:50=E2=80=AFPM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> > My main point is that we should not use eval on user input. That might
> > bring us to security hell.
>=20
> We are already in this hell.
> Both --linux and --dovetail use eval.
> AFAIK, this is the only way to fully support tilde expansion.

Ouch... With that said, I think v2 can be merged.

Just learned that my proposed string replacement is undefined in POSIX
sh, (see shebang/first line).

There is obviously some room for improvements in this script...

--=20
Siemens AG, Foundational Technologies
Linux Expert Center



