Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E4728DAB
	for <xenomai@lists.linux.dev>; Fri,  9 Feb 2024 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478643; cv=none; b=QH26jKmWM7XbesDEJEWCWB1ZWN+jKL/dw3wGE4RDyyQ5NAPqLjeIwA5bIyrJfsL6nxJi3bfduuVw5Rwb1JcR9rD0xYeB9If2eeF1fyj9dMD84+UlV++Vxy1pG+vDcsdpxZNMiFOGWMSd7avs31/z98auf3j3E1N7pScr44bSidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478643; c=relaxed/simple;
	bh=CYV9dtYmI05DzJUw7hKpfn9poGseOrXWTutxG3nHbtY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jKrUIUGPEH+J+mlAAiqw+04PbQVMSWLVRBm+5dSQlyburh9zRgr6Br0UiNowogTlfPdil95iKITvenywTYs58aV4Gp7Ag8IWuk2pH9AjmLh+cVcR0m4c57gc09LxdXMxEh/KZuteBI6iVNNis/fvcccvge0gqdGZsCS6EH06Tp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 19BA4622F57C;
	Fri,  9 Feb 2024 12:32:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id pj9oSmgf-Mjj; Fri,  9 Feb 2024 12:32:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 517EA626FAE3;
	Fri,  9 Feb 2024 12:32:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K5l0q7tcKG4b; Fri,  9 Feb 2024 12:32:07 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 07E7D622F57C;
	Fri,  9 Feb 2024 12:32:07 +0100 (CET)
Date: Fri, 9 Feb 2024 12:32:06 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1330920185.29223.1707478326700.JavaMail.zimbra@nod.at>
In-Reply-To: <AS5PR10MB8173A658B41A9D7BC1788F25934B2@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com> <20240122160105.2452024-8-clara.kowalsky@siemens.com> <CAFLxGvyuksoHCnYm0hWCby64QNSaQ0LbJ0kkRJp=KaN-1tRNuw@mail.gmail.com> <AS5PR10MB8173A658B41A9D7BC1788F25934B2@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v1 7/7] compat support: cobalt/arm64: Enable compat
 support for arm64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: compat support: cobalt/arm64: Enable compat support for arm64
Thread-Index: AQHaTUxN6eb3ZCHdT0G3ekhZPkxEkbD3YEmAgAqVhsBnkR2FQQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>
> CC: "xenomai" <xenomai@lists.linux.dev>, "Philippe Gerum" <rpm@xenomai.or=
g>, "Jan Kiszka" <jan.kiszka@siemens.com>
> Gesendet: Freitag, 9. Februar 2024 12:09:31
> Betreff: RE: [PATCH v1 7/7] compat support: cobalt/arm64: Enable compat s=
upport for arm64

> Thank you for your comments, Richard. I will add the dependency.

You're welcome. :-)

BTW: Yesterday, I have backported your changes to my internal 3.2.4 tree an=
d have it a try.
So far the application is happy and seems to work.

Thanks,
//richard
