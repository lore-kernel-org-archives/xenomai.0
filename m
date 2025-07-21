Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C641DFDE
	for <xenomai@lists.linux.dev>; Mon, 21 Jul 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115604; cv=none; b=hMfFaYVrbTvpoKm1dIpnYdmILFRF8aVkMcmCTcJ1cu4XE7ZDer0OT2aaQBNqSoqX3zS/wk/Gm20R9+X2X271GDypeLo7rD7h35xU68iK4EUQjehRjhFeIvD9PE1nCQ+X/C/PiSwehBWiHluRORMwocUh1/jXQHzxBMkrshlquK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115604; c=relaxed/simple;
	bh=RAZ+fowwW2XZJ1srBZEw2vQX/PzShTOmN+7QeftMBfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AixaKpgC1VyySPu4QEM5Ukh8l/7NqJ3BQK9M/NLiZ1uxrEc9yITMGhynecHU/vV2tdHQvDK41nACvnWggiTNEfCWUKrvE1xdVc/P049OwFt0wRMrVtiL9ms2S/Y6kGhTOorCh+TkOrruaaMIxlHDpcTuOSIg6KF0f08AO1dLaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=jBwUj3GM; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="jBwUj3GM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753115589; x=1753720389; i=jan.kiszka@web.de;
	bh=RAZ+fowwW2XZJ1srBZEw2vQX/PzShTOmN+7QeftMBfk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jBwUj3GMSaDHWxsx4aT7fF4Vbo9VJCQkOgv89shSiR6vXoScSNO3mLBB93jUX4py
	 Ajq7yscAuTYh069oV8be+3X6J+oj4SH2DmJlIO7O+bADGtBRgylJELoj5Fqi2FjMp
	 ZylCFWike0ij3bPcMNlFnNQz4a1bwLNyKIyRDm3Fl4dZN+NdKs5QYUqRe2oFiHmCH
	 xGqIaVvkRsVg7WlRFM+Zp0sjv+UT2EzvrG4MVOw0lg2p1VzuUfL+nvm/SS0d8BSBQ
	 NvXy6Y//ZfKC20XF/f9AD+t/GwkRCkKa0anKuqI7Mnfm91r2n0oIdWGHWQdTcv7YL
	 kNeE65hE/HBGMsTNOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.10.204] ([185.8.243.41]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuF8z-1usWvA2X9h-0183H6; Mon, 21
 Jul 2025 18:33:09 +0200
Message-ID: <f616e74e-2df6-494f-9017-201e5825ab4d@web.de>
Date: Mon, 21 Jul 2025 18:33:07 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xenomai.org down?
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, Luis <luis@apue.org>
Cc: xenomai <xenomai@lists.linux.dev>
References: <7ec1afca-5d28-4763-a091-886e1c31412f.luis@apue.org>
 <CAFc1U0v7ENaCASVAje4CdEoJ7xP1GmM13StK4rVCt9T88mBGSg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <CAFc1U0v7ENaCASVAje4CdEoJ7xP1GmM13StK4rVCt9T88mBGSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gtGllSQNInaexRwjGgsmxU5D0Ap2aXZ2l+oOZAT5PFIc6kha8L+
 /oRv0pVoJ1YonQGW6QHBvXW+HVWw16ZOStYEOkId8eiOTDYE/2gqVMuyMCJV5nJSS1ILvXB
 QS5m12ijW86Z5EGFw2l51p3AIo7UfVQFHmBeAbXvsQWWajEneMThggr2NUYtA2EqRZw1MTp
 16W9BZoK/hf97C8CGWmYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kDeT0xl+tGw=;6eFaMm4IHouDPA5s8b6TeyVwUD5
 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

On 21.07.25 17:34, Pierre FICHEUX wrote:
> Same for me.
>=20
>=20
> Le lun. 21 juil. 2025 =C3=A0 04:45, Luis <luis@apue.org> a =C3=A9crit :
>>
>> https://xenomai.org
>>
>> GitLab Logo
>> 502
>> Whoops, something went wrong on our end.
>> Try refreshing the page, or going back and attempting the action again.
>>
>> Please contact your GitLab administrator if this problem persists.
>>
>> Go back
>=20
>=20
>=20

Thanks all for the heads-up, I've informed the admin of source.denx.de,
our host.

Jan
