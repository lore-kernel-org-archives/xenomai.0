Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35C3D3B8
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716590149; cv=none; b=dc2tziZzS+LAF3475pRXmIWSgFwuiBvYkz9Y+AjqWi5EZbBlozdb2gOvFnEmXfRTVoapE5PEht8pLEGF7DD9QNFkO78eFX4MBftiZxL+BT3xB6lCZAt1lkMDl2DW9zuQTZekfei4Wd2Q1kPE5afm1bDoNzFhjvHzqrgC+98xH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716590149; c=relaxed/simple;
	bh=hvtBAHxc5C3QCoBGejCdsC6kkteVdNZ3fUKr5kNjyN8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nhDTo5GTCfBrpx6hmtb7YHuYYywFqpvp2Mi8xGVlN1VXAVzAzaFR+rFMhUuZhIn7hvyTYPQAmfkWrpAHtCIUHRpHE4ccW2EiWm5IbaYmGOgyH7vTZJXGY5+wr3Rb9X1kfD8kFxbokFWTr+BGilPc4D1l/BQK0vOHBIyhSGyw0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AC95662348A5;
	Sat, 25 May 2024 00:35:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id mj--0TfpTUDu; Sat, 25 May 2024 00:35:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4C5EC61B8F3E;
	Sat, 25 May 2024 00:35:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qNhTPgP6jOvc; Sat, 25 May 2024 00:35:43 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2F7996093341;
	Sat, 25 May 2024 00:35:43 +0200 (CEST)
Date: Sat, 25 May 2024 00:35:43 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <1615728829.144867.1716590143069.JavaMail.zimbra@nod.at>
In-Reply-To: <3e8c206d-b730-495e-b204-13087853fd46@siemens.com>
References: <20240518112703.30713-1-richard@nod.at> <ba5e0fc8-e2fa-4495-9cf2-69f0ed2d1621@siemens.com> <1792993044.132105.1716360194595.JavaMail.zimbra@nod.at> <770b74df-11fc-482a-9d2b-119b92e7097a@siemens.com> <784543910.133534.1716384735664.JavaMail.zimbra@nod.at> <3e8c206d-b730-495e-b204-13087853fd46@siemens.com>
Subject: Re: [PATCH] [RFC] prepare-kernel.sh: Add reverse mode
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: prepare-kernel.sh: Add reverse mode
Thread-Index: HMlbGVpOGW1edVhrwMlFph5pihXT0Q==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> The only difference of enforced linking might then be time updates in
> the metadata. But don't ask me about the pros and cons...

In 2006, Gilles changed the test from "-h" to "-ef" via
7098866e0 ("Fix prepare-kernel.sh when it is run in order to change the xen=
omai directory to which the kernel is linked").

So, the script no longer checked just for the directory entry being a symli=
nk,
it checked also whether the symlink points to the right location.
The use case was, you have an already prepared kernel and move/update the X=
enomai folder.
As as consequence the symlinks are still present but point to the wrong loc=
ation,
but prepare-kernel.sh didn't update them.

To avoid this state, --forcelink should have been used.
But looks like Gilles didn't like that and made --forcelink more or less
obsolete with his change.

Since make (and every other sane build system) follows symlinks, I don't se=
e
a reason to keep --forcelink.

Thanks,
//richard
