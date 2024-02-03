Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13F12E6D
	for <xenomai@lists.linux.dev>; Sat,  3 Feb 2024 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707000830; cv=none; b=E9Mwm8ryI192b3Ws6wvWgi87B1lehfo0umY1CgKkk2mO93KSo5J5udDS50WJ5pjIDvrNzkm52g9R5XBn4EUDO+wvH0DwZl/TplenoFMHPMN6WDwiDcKLzrcfW9kdDoeUAVl4dKBVr1P41+Mng/iKNVUpwOJaB8oovYXf71xAH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707000830; c=relaxed/simple;
	bh=SN6hta3tJ/ef2AdLKpqAonZaLe2perHUpLAOwXSuIwA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3W49Y6QyY0MvzV+4Qw12VXAs/74NTPNLHDb/mmjDqbymdm8Dx9zicZCkdgr9DV0RUMbN1FxhogmvDl62H7zHGPsoEY/Ur4MYYRe9cDwnP/5kUN9MGdE82KIxu2H+tNZuaffMFuic+qFZd4oMH8i7YwqZjTjvvqjcNiDfHMIqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fR4iCQ5O; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fR4iCQ5O"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024020322433413496cc843149474dd
        for <xenomai@lists.linux.dev>;
        Sat, 03 Feb 2024 23:43:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uj4Nogry4OCXlsHnRmkPSe6VGq3njCa10pRfefahiQ4=;
 b=fR4iCQ5OPbeykHKyM5UxhiXwLHBzSAOtnefbFEuotCYbJfOBcWfvj6jISOnhGNM3hYiqLs
 20II0LQ4X9ruHN0WiqHGtnYEhpV0hunWptCvwJFKFJZvnvRln8LA3+ZUcyDqo8nUOiPedW7C
 vGzFDYjg78SNl9pOzBFo3z4ytsN8Q=;
Message-ID: <fe53ed9bd299b56614d2d79f523aec7c2422a3d9.camel@siemens.com>
Subject: Re: [PATCH v1 4/7] compat support: cobalt/arm64: Update ABI
 revision level
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>, Clara Kowalsky
	 <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Date: Sat, 03 Feb 2024 23:43:33 +0100
In-Reply-To: <CAFLxGvzgbZdgzpwc8QSMxY0KJRDAKymmiMkPJ3WM4taogdmPKw@mail.gmail.com>
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
	 <20240122160105.2452024-5-clara.kowalsky@siemens.com>
	 <CAFLxGvzgbZdgzpwc8QSMxY0KJRDAKymmiMkPJ3WM4taogdmPKw@mail.gmail.com>
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

On Fri, 2024-02-02 at 18:26 +0100, Richard Weinberger wrote:
> On Mon, Jan 22, 2024 at 6:20=E2=80=AFPM Clara Kowalsky
> <clara.kowalsky@siemens.com> wrote:
> >=20
> > Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> > ---
> >  kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features=
.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> > index fba1db391..3060bcfae 100644
> > --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> > +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> > @@ -22,7 +22,7 @@
> >  #define _COBALT_ARM64_ASM_UAPI_FEATURES_H
> >=20
> >  /* The ABI revision level we use on this arch. */
> > -#define XENOMAI_ABI_REV   3UL
> > +#define XENOMAI_ABI_REV   19UL
>=20
> Doesn't this unnecessarily force everyone to rebuild their arm64 applicat=
ions?
> The ABI revision check could also test whether the calling task is in
> compat mode or not
> and then either compare against the arm64 or arm32 ABI revision.

This will hopefully never be backported to stable branches, so
rebuilding (for the new release) will be necessary anyhow.

But: Clara, I think this patch is wrong. We changed the armhf ABI
(independent from compat, for all armhf systems), but you're
incrementing the arm64 ABI revision here.

To Richard: As we changed the armhf ABI, we should increment the ABI
revision to protect users from running a mismatch between kernel and
userspace (on armhf systems, compat does not matter).

Does that make sense?

Best regards,
Florian

>=20
> --=20
> Thanks,
> //richard

