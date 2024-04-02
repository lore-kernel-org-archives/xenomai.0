Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED48662E
	for <xenomai@lists.linux.dev>; Tue,  2 Apr 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065324; cv=none; b=U4d7P/dt28c0RmQ0Pt+syI9SO9aRc7AG7BubGP00RKb06IVq63XzSgxNbmm38dmePnVy0lGRBH4Hcvg65rs6nF5nYUR42kOEOc1DtMOYJ1psVm8/6IgYjKeJnXw0dS2Il1lwRb6lJRJfcuwhRV8YXvLltz4QD+tUh8Eu512YIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065324; c=relaxed/simple;
	bh=EvpmK2sZDYe6ZbAzJOxi8XQY6wCPm5cJIKC8jdCDdcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxjTJrJ4koVSzH6nulU7kk+jtg891iT8tGdWhHUTksGPEPxJOKQk11NCHYP7nURoFL1YUgFFMlH0CeXvp85u6UqtNH7bPJhxS8FTxwe9y4GsHY06feHwhL0F/9FQie5wjndbKn+WxIjid5WXuIhlQ7DIx5/nIwwz5fgH2oO0I3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=j80+EvXz; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="j80+EvXz"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202404021341507a4e6d54e51befbc53
        for <xenomai@lists.linux.dev>;
        Tue, 02 Apr 2024 15:41:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EvpmK2sZDYe6ZbAzJOxi8XQY6wCPm5cJIKC8jdCDdcw=;
 b=j80+EvXzDfjuGkJxhN54K5qR7aXG3j3CA+gS6JEhTSmHl53co1A7Ef33LRUAcLUJxDVs9b
 cipRUUYqOaNwx1vLWoSPjn9xWk4nuMxGlLAbQfbVEVhnODyqgtsX5jOVMbcwdLH9Spk8DxzZ
 Nzhb04OFx63TyOahsO3cx0ktY5Jnc=;
Message-ID: <3d312b9673593f87ca2cfe6d86d3c9a1a791ab8d.camel@siemens.com>
Subject: Re: Process stuck in cobalt_monitor_enter
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Mauro S." <mau.salvi@yahoo.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Date: Tue, 02 Apr 2024 15:41:48 +0200
In-Reply-To: <89ad3b15-7fe7-44b2-8719-02dc8425ecfe@yahoo.com>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
	 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
	 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
	 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
	 <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
	 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
	 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
	 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
	 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
	 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
	 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
	 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
	 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
	 <89ad3b15-7fe7-44b2-8719-02dc8425ecfe@yahoo.com>
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

On Fri, 2024-03-29 at 17:06 +0100, Mauro S. wrote:
> Hi,
>=20
> kind ping about that.
>=20
> Not to put0 pressure on, just to know if the problem is worth=20
> considering and will be examined or if I have to make my workarounds=20
> definitive.
>=20
> Thanks in advance, regards
> --
> Mauro S.

Hi,

we had a short discussion about that issue in the last Xenomai
community call and agreed that we have to dig deeper. If you got more
information in the meantime, please let us know.

How does your workaround currently look like?

I think Jan will answer once he's back at work.

Best regards,
Florian
