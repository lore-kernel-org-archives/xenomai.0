Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421073;
	b=pEnT+j7P6gVBtt9LdFqaeftGFyFJ6dHVO9Md3zRHR6xe6y55OGrZUszbaKvLfdTpEc+h
	 RKx40r/F/eeKnbTs7dAJdbuRBKJEn7WIDX/AoEoTKUxqzf2SPEKmkCAnCmDE1ALu1XawV
	 5HGVg/OpuDN9w7u2R0FvXU0cMR0+NNv7ljQFIePSpeWbGz+dfsaujNPo0U6oZO4/92e9D
	 ie+slBOeItAl+1rYZ8O3xGz1g5SqqjMjD2iDhCR2zYfKk1xJDwy2RyQbArAYUy2NHcbSb
	 LOuPuec4Qi1lO8Rf0VRvFcs423Iz2TY+q8h2X4IuquV2OTMBUW2MRTX0AmQKUQzEw9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421073;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl:X-GND-Score:X-GND-Cause:
	 X-GND-State;
	bh=lHErYtQGTgdVR5dimZCfOnUkDW84zRoTlGp2PVMM7A4=;
	b=vj4migUmW1IxAGIipTCibPGjaoxXr/rcsdeghgOOQO+gW5qLmFugBHzTsQQ+nkBEVV24
	 m50+yaVpcs48AWYATIk+cvSUdSDLV0Kw3GDA1wNflgc6C2MhQRq/+M+OOcBD+/XBH+4mA
	 vtPW54/m+NukFs6fN4SCfx82i5ZU3tWpIzs1ocOz8BSgdTxbwtvqYa6HuHzQHSUebIyNV
	 YQmf9fqbm6rfydy3A38MaXBJq1B/cRmXrzYsNCFpj6z6/fKYAYdUMT5We/MEUg3ZgTiWB
	 3CdqCVMm0SrYSULwRWMSn8mKQ/usiLZ0RmzZVxaNAJbVOigA2YxFs6M0Jqadl4lrmkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=RpPxhRop;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6544B606A89A
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 18:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6544B606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=RpPxhRop
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25ADD3F5C3;
	Wed, 11 Nov 2026 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794421070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHErYtQGTgdVR5dimZCfOnUkDW84zRoTlGp2PVMM7A4=;
	b=RpPxhRopKiBySinZNrP4aQLB2OaNZhXPzRhv/HGxdLIFNXlCly0jSG7hAztlORtSgg1tcm
	iAEyTVo1q+KzawSQpXjLKyzX1wwXPi8PVs2HAMdqfYKcgc5wSiI4jXyGXsBV5JZYDaOhXC
	VL9S/kui+3yg1vWpUjFu5zzY5W+4Gz5zFOn0C6PQwVQ0LtYNvAJpAd8CSeOlMDcLscenh+
	yop0eHJxfBsC4GPMpeZgm8+b7lmvIEvkV1VX0JQn041y8pHrV4kb91zZLn2Q5juE3f8o5z
	A/i+/rNwMSlMAbAB1z7khx5j2mY+BJUHP73h83foypqehASAoDA1OcKkc1GbpA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: O_OOB ABI
In-Reply-To: <10791d06-65b9-48b3-800d-383e8f50c99d@siemens.com> (Jan Kiszka's
	message of "Wed, 11 Nov 2026 18:55:31 +0100")
References: <18f772e8-118f-46f6-963a-58db46724e24@siemens.com>
	<87v76346l0.fsf@xenomai.org>
	<dda83d6a-554f-48bf-8f00-5d1a1deaa82d@siemens.com>
	<875wy345kz.fsf@xenomai.org>
	<10791d06-65b9-48b3-800d-383e8f50c99d@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 11 Nov 2026 19:17:49 +0100
Message-ID: <87zevf2pwy.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGcYqiD9402hUGyvUhvFTMrEucS5gCFQ/xwaXUZvDk7/5oDUKQXoQWlMD7QcNshNjx7MPkB/yNZDG6D/Zj/7QBUB6e/BoERICenWHLklyVOwNUNtorFihSnv2CbBVD58VMWnEPlH+ofGQVSoh7GhIaakRAlHsEijRIsoDeqSQKYF8xn+neE0Opj10PdILmX0AB+yu2S08McOJPWqMxf+vl4ac95GBVZoyqh4cjYV0YAiWoC4VeowpXfr3R/Gi+CJVbrTrcjly7B25NYaODibWFlLt6Xhrxz6RlqKSzwENNO9MRcT4Bqmv+URX+G4YO14yOg7x4lBMDb7H5qJf34XC8ZVSMbprplM2GuY4aBxAdubNwjC9nj63QgvF5Q23cRi3R2p02DgZ1EbQaK1hMFP4uJDEDa4kQQH/tcrV/e1ohWyDgTVBgEdDFR6mOPCEf1hxEFdonkqCeJYcQnbWKlmPRkIUqrREW38BoYnsIk44ViQwmNOdCMPbBZP131EFr6IxmDX2AW1ooSbymNaEd+j72eKWapALBD87oawb6P5iTCfeRJ+sKyobzkh3ObtWGhns0jRMIFFTK6/EsUD03LVc3g97znwmMwRD1efM4t9EFfUnjju6wP71fSkFw9NA7aji4vGo5dJhMMFgxWReUWiPyV+38aqGatZ1sw0zM20nT7Vw
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 11.11.26 18:54, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>=20
>>> On 11.11.26 18:32, Philippe Gerum wrote:
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> Hi Philippe,
>>>>>
>>>>> FYI. I assume this is an evl-only topic - if at all:
>>>>>
>>>>> "O_OOB changed from 010000000000 (1<<30) to (1 << 29) starting with t=
he
>>>>> v7.2 port. That changes the userspace ABI compared with 6.18 and =E2=
=89=A47.1."
>>>>> (opus-5.5, while reviewing my 6.18 rebase)
>>>>>
>>>>
>>>> Correct. Only the evl core enables the oob capability for regular
>>>> drivers, which userland may request by setting O_OOB in the open
>>>> flags. This is out of scope for cobalt.
>>>>
>>>
>>> OK, but shifting the bit was no problem for existing evl applications?
>>=20
>> It was 'only' an issue for applications built against ABI <=3D 46 which
>> could not run on a 7.2+ kernel as a consequence of this upstream change.
>>=20
>>> Handled by the ABI matching between kernel and library?
>>>
>>=20
>> Yes, this has triggered ABI 47.
>>=20
>
> Thanks for clarifying - maybe the AI will find this thread and avoid to
> flag this again. ;)
>

Maybe an AI will end up writing the whole thing and start complaining
about its own mistakes before fixing them, blaming the insufficient
effort level of "the other guy". Like humans usually do.

--=20
Philippe.
