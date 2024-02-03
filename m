Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EA12E50
	for <xenomai@lists.linux.dev>; Sat,  3 Feb 2024 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707001338; cv=none; b=TFDmvRs4Vg16aQEuXkfqVCDgo53VtElNABDhWibDR41XGhSS1TlZ4th1sE5cq6dJLVAC9RpJ7qii98xtsNgSfPo3kBgTZN/KtC0uUb6NTtcga9GYH1pcH/AhTP2Ec59WWJQUN5a/N8BhzWeCBZ4rYubyhvR2/TZxwoVw9pXccLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707001338; c=relaxed/simple;
	bh=s9a7w6HJiiOKcnqQQhjr5ebMZmFfaXrJugCo+dfMhhI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJ/21G3PkcUMPOzzPIhis/DmxQWKhr3DJipYtL+bOxX1GWKdseirYrXnJDPyf0w3WZoSiozrZkzqIIO4VheHkJWOKz/1tE1Kh8EXAyWuR+tA9bUDjvx3CHT2EA1PqVsZ8iX8j4RMqNXeevFFJjvq894Ip39KYxJWGi11VTbUssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Dp5RUuZs; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Dp5RUuZs"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024020323021001be9ae547721a22ab
        for <xenomai@lists.linux.dev>;
        Sun, 04 Feb 2024 00:02:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=s9a7w6HJiiOKcnqQQhjr5ebMZmFfaXrJugCo+dfMhhI=;
 b=Dp5RUuZsWOB+HJnNbpKpQrfKtak66CXaa7uCD8PVY1GipI+8xHN3TgYyOVmzDRUHpWh5IZ
 dTDvz6QaRenYL7cGgobfwGBFTwxAX8zyfZb4rHqcub7GrwE/Udz4ReFKoXMur5uVKWXeGH7l
 R/vrYuOMNov+E6FyBU1EFzzbzOAWg=;
Message-ID: <3020e412aeca8625d054d72bed65c1a16128db7e.camel@siemens.com>
Subject: Re: [PATCH v1 0/7] Add 32-bit compat support for arm64 to xenomai
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>, Clara Kowalsky
	 <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Date: Sun, 04 Feb 2024 00:02:09 +0100
In-Reply-To: <CAFLxGvyy2r5dWUVNbXHtT6W=60DAByh63hi+1U_ynjrECtHvLA@mail.gmail.com>
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
	 <CAFLxGvyy2r5dWUVNbXHtT6W=60DAByh63hi+1U_ynjrECtHvLA@mail.gmail.com>
Autocrypt: =?US-ASCII?Q?addr=3Dflorian.bezdeka@siemen?=
 =?US-ASCII?Q?s.com;_prefer-encrypt=3Dmutual?=
 =?US-ASCII?Q?;_keydata=3DmQENBFwsf8QBCAC2f4AQWu92LZC4bKyUYRxWIpWqGz790s?=
 =?US-ASCII?Q?pcYkXO7M8kfea4iC8qMxv2hT4HT0LTncRP6WiovVN2PeoOBfN5BSa5z?=
 =?US-ASCII?Q?LIrZGVXh7KmbdKhwhVU+ynoTq9G5uaO2Kos7Vv7nNCuatIq8tSNILuoB?=
 =?US-ASCII?Q?DFTAZnJW3y1V7YOwhDCPl5gbLSYqUY3OE0yksbtCcVI5istT4ED6mjQ?=
 =?US-ASCII?Q?9W+3uH1LrgFeEF0oxTjrEPxO5ZYATz0f/TYC8WiM0sMrV+n0eMDntlzA?=
 =?US-ASCII?Q?63D6lcRi5mNp2jPsJkq3tbWqyCrAe1sKPVJB44ekFwCk0kDIuhR13Q3R?=
 =?US-ASCII?Q?HE4Or/9sznhMUQjYueWXvTZfzH/VsQJHABEBAAG0LUZsb3JpYW4gQmV6?=
 =?US-ASCII?Q?ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPokBVAQTAQg?=
 =?US-ASCII?Q?APhYhBAzL4P3jiTHdthsq4cj0O1fnOEBVBQJcLH/FAhsDBQkB4TOABQs?=
 =?US-ASCII?Q?JCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMj0O1fnOEBVc6YIAJ8oO4x?=
 =?US-ASCII?Q?TjOCpjxaS8XQE6VW50HE9I6ShbQVWUEGhF4qzJaACTQDjdg/aio7qNRa?=
 =?US-ASCII?Q?mnAy83Hy9sAxKVhXs+1R1fstN+JO8zgD3tJspucUkCiXlYu+Qcv2d6C?=
 =?US-ASCII?Q?ostv+h4nv8fkSoeLfsQu3GJt6W0RN7t+8H/9fUMXyuB8GWo4bhaZcti6?=
 =?US-ASCII?Q?78CotGLs6UGZpYEGiAMto8+9zVO/tdY1BkREM6bCVeQ9FnnpTRQy/tU5?=
 =?US-ASCII?Q?xemMWJI64UUP92TUIbQ3TZKAz4iG/Mle+YjiHBGrJM7TxjE3sDg5J2Fa?=
 =?US-ASCII?Q?HX4wmZPKGdB6wANKupf6HMMt2y7gduVmMKzgb8PDMLPZwWBSvjELQqz?=
 =?US-ASCII?Q?hiZAQ0EYLSqZwEIAIR4HMTQC4F4YxatIl6MIDY03zD4M3ZQpgyQ6QFL9?=
 =?US-ASCII?Q?Dq0I+PGc7A6z5rsGl76+D8pDFSN2BBJiLLlQadxKc3ZyTTlRp4bc=09bf?=
 =?US-ASCII?Q?FZRmsAXwVfLtBauXxGo9pkyhk8Vcjb2EJm6XR8PH99buGOXlFfTLsmeA?=
 =?US-ASCII?Q?ji/F4jU3qlUnwZMBvHZwRSFqOGdwKPMvW3FppfmREQ0o4xJ4b/bxGXx?=
 =?US-ASCII?Q?ko21uyR/S5rEJx6X8Ukw95h3JinXHx/g2cjbKHrWBDKoqtX9IZCamDny?=
 =?US-ASCII?Q?R+sfLWQbOKOrLNYLwLAQwOTVlZWTgue10G1q6Zi0r8RQ2T1Uy+ZLYagv?=
 =?US-ASCII?Q?Cbzp/lT7p3mv3ba68llX896c0AEQEAAbQ/QmV6ZGVrYSwgRmxvcmlhbj?=
 =?US-ASCII?Q?sgQmV6ZGVrYSBGbG9yaWFuIDxmbG9yaWFuLmJlemRla2FAc2llbWVuc?=
 =?US-ASCII?Q?y5jb20+iQEcBBABCAAGBQJgtKpnAAoJEEoHyE9rG1dPpJYH+gPnqpu7h?=
 =?US-ASCII?Q?4fsWOxco38e74MsazoUdfndTYP5tgaYTVE51ZhOZBl+4jYaywsmmFm9g?=
 =?US-ASCII?Q?6N4Tw3GiMEDB4YU1X7gQZ60fDKpYL5SnCu5qZirJ4RCV4LDA0789ir+6?=
 =?US-ASCII?Q?8/zfwXBTV5QoMH0+MkXB4BL+Km3f7X/GdN5oRoItAyKDBcEfGJo6afT?=
 =?US-ASCII?Q?PtcUdI9n7ExCSfJwb0SBvvkvUsdNppFDGOOHSioINbEHBs2VUvE43toM?=
 =?US-ASCII?Q?4mPLfhFIAtDcn5Byt80/kotU8v3Iyf86NYCa+0h77xTsKHcCUqe8Rvow?=
 =?US-ASCII?Q?bCIbig9GGbbd54TasfqQQOiAkn/WeGl33+UIVX1Q8zo7eyMJHzLJQ3I=3D?=
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

Hi Richard,

On Fri, 2024-02-02 at 18:08 +0100, Richard Weinberger wrote:
> I don't know how I missed your patches but I spent yesterday the whole
> day with the very same cleanup. :-S
> What I miss in your changes is the VDSO handling.
> By default aarm64 does not offer AT_SYSINFO_EHDR, so
> cobalt_lookup_vdso() will fail.
> Enabling CONFIG_COMPAT_VDSO on aarm64 is tricky because you need
> wither clang or a second cross compiler.
> In my version I'm using a fallback to sc_cobalt_clock_gettime/64().

just forgot: I can't recall the correct / concrete names, but we simply
set something like CONFIG_CROSS_COMPILE_COMPAT or
CONFIG_CROSS_COMPILE_COMPAT_VDSO.

IIRC, the debian build process (or the Makefile machinery of Linux)
takes care when you set CROSS_COMPILE in combination with COMPAT_VDSO.

Thanks for all your input! Very valuable!

To Clara: We should double-check everything around CONFIG_COMPAT_VDSO
again...

Best regards,
Florian

>=20
> --=20
> Thanks,
> //richard

