Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C116995B
	for <xenomai@lists.linux.dev>; Tue, 12 Mar 2024 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229697; cv=none; b=bIBhZ2TvK9xGjXlpZqwzHZrOMaOFh+PLP5igT+e8YGfqtGTgJjrhUepytMOeED5Esnrm8v1ERrLyvRn2pO6Smc6PImv+bku+7ihR6Y5BJJ0t9rVFJZMiTpYRNoVsBfogLKo910N6Po65ovQvxALDEhp8wNnc1dsq2csFc5TlhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229697; c=relaxed/simple;
	bh=79BI+6zSy71rpl2eLGrbdy6eMABweVRyslMSXIKiz+A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dj7ydhjHnh0676VbMRvrf5Tmy6oCjvmAaZxh37d4wr6Gx+vYYKK6+OajoD7ANY/h/gL+p57yrXBYJ5cGY6SEnBWGPm1OtA+ed9kTMUUgF7zgdZbdL4x86tTL8OI0DcC8aBSPfeQEFp7qGGG3f4i7WLcGIL1PhnSMroSbdMYHah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZLTLuRXo; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZLTLuRXo"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2024031207480225433314a43cb677bf
        for <xenomai@lists.linux.dev>;
        Tue, 12 Mar 2024 08:48:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yImVoHwauUDO+GtSyZJodVnllijQGCg6zFuICFC1FEs=;
 b=ZLTLuRXoAsIIMbhOffR9GgFROAoFAo9LWPWoA2ZIl4A1thL4mUnwNalN/kH/aAYPs4XC9O
 VKdX5G+VxEwN7Fxc6z7ZZ3IwGPS+yBZ+dLXjahp+2ftJGPqz2mmh/ao86Uxjq/p4pDmcBiFC
 sprnvVv8sTFq4LO6dWrw4Mg7HieWk=;
Message-ID: <2cf397da0544e3be7ffd6abd8166e998804c9fa3.camel@siemens.com>
Subject: Re: [PATCH] testsuite/smokey/gdb: Fix race-condition
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Fabian Scheler <Fabian.Scheler@siemens.com>, xenomai@lists.linux.dev
Date: Tue, 12 Mar 2024 08:48:01 +0100
In-Reply-To: <20240312063813.27021-1-Fabian.Scheler@siemens.com>
References: <20240312063813.27021-1-Fabian.Scheler@siemens.com>
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

Hi Fabian,


On Tue, 2024-03-12 at 07:38 +0100, Fabian Scheler wrote:
> @@ -283,8 +285,14 @@ static int run_gdb(struct smokey_test *t, int argc, =
char *const argv[])
> =20
>  		default:
>  			wait_for_pattern("(gdb) ");
> +
> +			/* the signal handler only is used to skip the test if
> +			   gdb is missing */
>  			if (child_terminated)
>  				break;
> +                        else

Formatting: ^^^^^^^ Spaces vs tabs.

> +				signal(SIGCHLD, SIG_DFL);
> +
>  			send_command("b breakpoint_target\n", 1);
>  			send_command("r\n", 1);

Best regards,
Florian
