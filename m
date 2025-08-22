Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041E2C0267
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872030; cv=none; b=pfP5UPJ0r4TC9QYzxih0VfzFUVsPq2THcT4eqD8ZJGL8xZfFQ+2i+/qXV1jVomw4zaskXVhPp7vArMx04lOgjACzcviddbx3/jLF8ka/pM9987gVWJWvW9WQRainYiJW8tDhvkCAIhEFywQbfnkSplVkeWay90u0o4y4yeZVk8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872030; c=relaxed/simple;
	bh=7HAit8P5ShKyI4BYkwdih1O5nEQRE/fsbMJMU2HQsXA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Do58OTZ3QbuzpbvC9aGOGQHWiRI4PE2/Ar8lRGfH5pX9F3kCiKNtWluJpuBfYLoqQXhEf6LT+b+CLB6CHpAPeUVvmdMgah1z/9/rhKFegFz52vQpPkMVVjBgBojfsY1Z9MzUJL3S7V81yt7IrAja17iFf8OHQTsZ/HkElE5BP3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZmV3Ojy9; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZmV3Ojy9"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250822141336881009cb916b07dbc3
        for <xenomai@lists.linux.dev>;
        Fri, 22 Aug 2025 16:13:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=YVWeQIqesh0stZ+E0m0apddiOei2mmecBLfN+IMZvY0=;
 b=ZmV3Ojy941QgbkPTs0qI3BjSWhyLQ3Pabjh/SHW8B++ZTyXXNZLm1EPBdZQQzsmYtc/Skt
 onAgLalLlWBxrbb/mIKqfnjn+Hq0gVnWLfSKWUxqjiSdin/8CvcPnTS273GsgmUzldLS7OkD
 fHnCuJWwHV9/b1LFd7vfHPhNaOL4+wAHO+znQA0aNeiToDg+D+y/PPxa5RWQew5wb4yOG2yV
 LFy8Iu1kKH/DMfIpNA0/eDKKV9a8HEWgF5hQ1MTXWfVOTx3G/4bt6jKK1xZFfAGrpRP9goq+
 ng/QwM4MbvCV94EQJOBcNJQM+js2fwql5pQjotOCcwzBOoElXT/CfcpQ==;
Message-ID: <c8f9594940352723cc44310c3170d98f259eb72f.camel@siemens.com>
Subject: Re: Xenomai Meetup at OSS Amsterdam in August
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>, Xenomai
	 <xenomai@lists.linux.dev>
Date: Fri, 22 Aug 2025 16:13:36 +0200
In-Reply-To: <CAFLxGvyLoamDw-u64ahzU9OPrOMuCqLFOdvFNpPeSsOx0ZWKPA@mail.gmail.com>
References: 
	<CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
	 <CAFLxGvyLoamDw-u64ahzU9OPrOMuCqLFOdvFNpPeSsOx0ZWKPA@mail.gmail.com>
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

On Mon, 2025-08-18 at 11:15 +0200, Richard Weinberger wrote:
> On Wed, Jul 9, 2025 at 4:55=E2=80=AFPM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
> >=20
> > Like last year, I expect that some members of the Xenomai community
> > will be attending
> > the upcoming Open Source Summit in Amsterdam. If there's enough interes=
t,
> > we could arrange an in-person community meeting at a local beer
> > garden?
>=20
> Finding a place was more work than expected.
> But here it is:
> When: to start at 19:00 after the booth crawl
> Where:  d'Overkant (Scheldestraat 101-105, 1078 GJ Amsterdam,
> Netherlands), about 7 minute walk from OSS Europe venue
>=20
> See you there!

Thanks for organizing that!

I might have missed that, but which day?
