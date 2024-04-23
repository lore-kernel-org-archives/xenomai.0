Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5E7E78E
	for <xenomai@lists.linux.dev>; Tue, 23 Apr 2024 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872576; cv=none; b=VDlIQK1Fjac4+a/TheSq9ZyBqL3AsWDb1rX063CMGHtWmE1ZdWqxtKcDVQC0n1TVifFoSaJYG228N6Q0AtGwoYkGl6cAk6faNMbxanxyoxIien6mEhRHjvLrjYFcNBMmbyq3Q99oZogmSjnIt2g5EZWAR5chjVCI2pub+jt31v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872576; c=relaxed/simple;
	bh=ylwWy7odBPqTqKippdpgc9YlSyWb6jMJTktVVHNvH50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U2urxkajF5UQmpSpWyqHs56iopUkX48ibYnna96JiXdxNV1QsiK/+2eyMLrqcJgTSjOX2/EZW+K2+O3/CsxExJMvlNsOTncAQTECaj+CK866ba9fnOdlx36VDeV9XXOogQXytsCrxzJaAacjHaz9psaNi21PWqGd4u5D2UduwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TwN/J8bp; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TwN/J8bp"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240423114249e4e30fcc33bbc9cf3a
        for <xenomai@lists.linux.dev>;
        Tue, 23 Apr 2024 13:42:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iYEwtDpnb6i0KH2Qawcr1Mh1Gquvf1nOTOS5ldwMxV4=;
 b=TwN/J8bpjC3EgBKUnYPWJyB9fcpjUxT7sWjS40+4zWtTshkKbQ9/1cNgJBSlWslAJrrn+r
 7oqfhA9twIdWtIQSc6eC8yIgjPEmrsK5UftUbcRtNJHt2Hrg9fk8UuwjG5337dCKRF0fjaVd
 Vgg3J4hB24SleytzViKRgVqc3VJ/0=;
Message-ID: <636c38d0658c7d1148e3b434351492a1375cfa6d.camel@siemens.com>
Subject: Re: [PATCH dovetail] x86: irq_pipeline: Add missing definition for
 !CONFIG_IRQ_PIPELINE
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: rpm@xenomai.org
Cc: roman.hodek@siemens.com, Fabian Scheler <Fabian.Scheler@siemens.com>, 
	xenomai@lists.linux.dev
Date: Tue, 23 Apr 2024 13:42:47 +0200
In-Reply-To: <20240423104111.32385-1-Fabian.Scheler@siemens.com>
References: <20240423104111.32385-1-Fabian.Scheler@siemens.com>
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

[To: Adding Philippe, the dovetail maintainer]

To Fabian, Roman:
Is that a drive-by fix or do you really have the IRQ pipelining
disabled. If disabled: We should discuss this internally!

To Philippe: Hope you can fetch the patch from the Xenomai list.
Thanks!

Best regards,
Florian

On Tue, 2024-04-23 at 12:41 +0200, Fabian Scheler wrote:
> Fixup b917e98008314b3c7596099f48ea98f541451083 introducing
> DEFINE_IDTENTRY_SYSVEC_PIPELINED_NORETURN only if CONFIG_IRQ_PIPELINE is
> defined.
>=20
> Reported-by: Roman Hodek <roman.hodek@siemens.com>
> Signed-off-by: Roman Hodek <roman.hodek@siemens.com>
> ---
>  arch/x86/include/asm/idtentry.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idten=
try.h
> index 9b936d3e76a2..307623b4e10e 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -230,6 +230,7 @@ __visible __noreturn void __##func(struct pt_regs *re=
gs)
> =20
>  #define DEFINE_IDTENTRY_IRQ_PIPELINED(func)			DEFINE_IDTENTRY_IRQ(func)
>  #define DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)		DEFINE_IDTENTRY_=
SYSVEC(func)
> +#define DEFINE_IDTENTRY_SYSVEC_PIPELINED_NORETURN(vector, func)	DEFINE_I=
DTENTRY_SYSVEC(func)
>  #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)	DEFINE_IDT=
ENTRY_SYSVEC_SIMPLE(func)
> =20
>  /**
> --=20
> 2.44.0

