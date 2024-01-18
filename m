Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE024A06
	for <xenomai@lists.linux.dev>; Thu, 18 Jan 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579100; cv=none; b=h/nH0A19+Iqh9BstN3Syto/mXHfD3gRq2yyG0+hA72keeviu6BLXvfok4KcMZSdvr0T+91hTx6RrseCaHQG0FdlV2NHyTC1d0tjTCd1LBmTJZ8AhYI9nPY+QKuLqZtakPZW2XFJwQLFmT7/pQzTyr2dgLFT4vD6l+wSoaIcoNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579100; c=relaxed/simple;
	bh=vDtzlovCzOw/3+Kq9D1mupSM19pDE5NUMbyKLQvHFNk=;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Flowmailer-Platform:
	 Feedback-ID; b=CoD7np8qNg2qdryVkzUTOKNdtvoLDjZ9wA8pYfrTaqWMIExeQfcwYXEXhLzrRLSirlZ94dBsqDVj0SSA04PVgr/eG3XnUN9C4l9TUebMhd9X+qJGmzCMm/75a+qCcj9MjiNt6Vu+NsPktkdGNMz7b3TzQ5HSzIpjj6kBcHHN4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=CBqQHjKq; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="CBqQHjKq"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024011811581053fb6ca75a0399d151
        for <xenomai@lists.linux.dev>;
        Thu, 18 Jan 2024 12:58:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=vDtzlovCzOw/3+Kq9D1mupSM19pDE5NUMbyKLQvHFNk=;
 b=CBqQHjKq319ebhLc5OTa2sHrWyvhMbWXsynkL+HF7WjMMBo5IJI7zyCHYdV9nNZ1DAWUYs
 0/Em8KAGFtHPBlgyRTHm3hfWNo5eTCQLWIk2hV2ItCPUTNvFrV50GiGGvTefvd1FpHGrgBPV
 aX2QH+veKaUUEn1BUDSA9A1DvhHzU=;
Message-ID: <12402f4121aca76943a0dfadd02149f074aab801.camel@siemens.com>
Subject: Re: latency: pthread_create(latency): Operation not permitted
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "mars_liu2023@163.com" <mars_liu2023@163.com>, xenomai
	 <xenomai@lists.linux.dev>
Date: Thu, 18 Jan 2024 12:58:10 +0100
In-Reply-To: <789c8c7f.87f2.18d1bd6752c.Coremail.mars_liu2023@163.com>
References: <789c8c7f.87f2.18d1bd6752c.Coremail.mars_liu2023@163.com>
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

On Thu, 2024-01-18 at 17:10 +0800, mars_liu2023@163.com wrote:
> hi xenomai,
>=20
> I had a problem when running /usr/lib/xenomai/testsuite/latency:=C2=A0 =
=3D=3D Sampling period: 100 us
> =C2=A0 =3D=3D Test mode: periodic user-mode task
> =C2=A0 =3D=3D All results in microseconds
> =C2=A0 /usr/lib/xenomai/testsuite/latency: pthread_create(latency): Opera=
tion not permitted
>=20
>=20
>=20
> xenomai version:v3.2.4; kernel version: 5.10.199-xenomai.3.2.4
>=20
>=20
> I happened to find this problem is related to install containerd.io_1.6.2=
4-1_amd64.deb.
> if=C2=A0 dpkg -r containerd.io_xx.deb then the latency test is ok .
> how can i make latency work with containerd.io.
> does containerd.io effect the env of xenomai appliction?

Are you trying to run the latency utility from inside or outside the
container?

In case you're trying to run it inside a container: We might have a
namespacing issue here. I can remember that we had fixed some of them,
but maybe there is more.

Florian

>=20
>=20
> thanks=C2=A0and regards

