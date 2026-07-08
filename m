Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2F3F0756
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500943; cv=none; b=sqYj3nSCN62fOmNg3VF0O2uHX21cyjCOuhNJhHwcJb3c06qgtcYkwq/2VJQy/FQ+4nQ+qMDEkduiMqIpT/PNpBgi0mCwq+MNFwusXmGbQoDeleqHTDZK24pxMQ2x8CcePfSUsVjAgAubQHZPfTs/KQu9nwf3t+vY8visr2nGbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500943; c=relaxed/simple;
	bh=Iu28TtLtxMKDo85eK7XF82DcgpRp55uPw/ZPS31yqOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZJdW328U/OhSQvRhQDDDOAUZ3Bf87ea3MqP9e/VuHR5Eqk15UJlt9ZEkz7hV4pczqgRqh1raNEdp0Qo77+01v7k5JCDTErJw+mBLIQ+xiDm7N3XgnxcDzuKXZ11v3hXn9mb3dEsa+5hQMUnklEOZ1Bq3LW8SzCMM/xrIv84KVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=aqdY6mLK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="aqdY6mLK"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D1953E9C7;
	Wed,  8 Jul 2026 08:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783500937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00ls+5kkr0cFUD3gRGVBm9++9F1gmVbl77VeSRQGkmE=;
	b=aqdY6mLKPX/AttcvPZjwZXkSyH9a8T17LAH6skb57zDf9gbswhODVo0NAZtrdz8ZEQDOg+
	bQOq9mmLUYdTHEQH1G5SO7iTSZJPiHx6zUVR6s7ptRnpbMR0rNzKcrsrIkIOpwYQdMkkxL
	qr+CIb4uEEy3oMYm17M9zJu1Ih8PM5IKEEqY2lBGYhkjof/+OyaFxGliqM+77s9ZpZx+Tg
	Fn7wEgaDzrxvFgXjB6FkVuXoiZqp8YgrfRPA2aJYKGCoBfDt++GDHZaH78dsT7clnzZPPO
	za1F3KEoknusBa1TvnLEoOoOFwLFiJ9pF9ZGXIGI3kXLyWRgnu8xf6FQYwj5vA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: [PATCH linux-evl 0/2] Add RISC-V support to EVL
In-Reply-To: <bd2c18af-c93e-43fb-81ef-14cdd31a8bba@siemens.com> (Jan Kiszka's
	message of "Wed, 8 Jul 2026 09:23:45 +0200")
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
	<837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
	<40c1b8c7-ffb9-4f13-801f-cdcaeeda5ce2@siemens.com>
	<e27b6011-a7f8-4be2-995c-2515f74e87b9@siemens.com>
	<4906b6de-86bf-4c44-8f7a-4486aebf3c58@siemens.com>
	<bd2c18af-c93e-43fb-81ef-14cdd31a8bba@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 08 Jul 2026 10:55:36 +0200
Message-ID: <87zf01lv1z.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTG3FP7BAZ6LmHlh5TSQsA4b3nGzaannuRJTXbXXnoRDS74rBZMnGU5dINGk4yGRlH1ERkzPjTxXLpPqh10+ep0zSIdkyMbfsOjeyeZ/8EBR4Ko3SRJT+elHqQ9d0m/tRSvFaus1h5s0+mpV2PG9BgacIOF0l+pjhHvvryNdK5c/k4qn/03+ESaijN0uED0wvblHizf75DqnblRPOXTZEjfYpD9t5dM/6BV0GmVfnmbjhCu+kYsdbCKPVT4T0lkEabPaXNbQXZb+brsvUNYlP20aOIEwy/kqGbv283ipCnHjL4/KSgH9BVZcHZ6qEr8ic6tP3MQlr5cCyv622r1F6oJdPUSqqvG+BX08IxNfdt8W3gbaOr8eqK4BMxgpwL7p8+7ZzpELB4abZSkuj2RnnqgPJVfWTZvT24YRoxaI84F3CFi5UT3DePYb/aKuZg+eFtENhYaQupAxNqXVy03NVHejpDifQACHRGcOiQzD2elcRLWiZ6HWGiGd+pZ6vsXykw1LGNUlikdz58GzEPfwOm8mqHTJn5BP+xwnaRzGVXryqTPLACIxst7LCXlVzUf5IomQYRtfFphlELxcExrNAetPx5Mpe9ALmB9b3A0C6XgvUyTBrJEj3Py2F7OUKvbKadmvuEYFkXxvrA152tum5Rz1/JFYG8jsdyLrXUWPexFsOg

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 08.07.26 08:26, Tobias Schaffner wrote:
>>=20
>>=20
>> On 7/8/26 08:07, Jan Kiszka wrote:
>>> On 08.07.26 07:17, Tobias Schaffner wrote:
>>>> On 7/8/26 00:30, Florian Bezdeka wrote:
>>>>> On Fri, 2025-10-10 at 12:10 +0200, Tobias Schaffner wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> this series introduces an initial EVL port for RISC-V.
>>>>>>
>>>>>> While some tests are still failing, I=E2=80=99d like to share this e=
arly
>>>>>> version with the community to gather feedback, reviews, and hopefully
>>>>>> some assistance in refining the port.
>>>>>>
>>>>>> The patches have been tested in combination with the Dovetail RISC-V
>>>>>> port on top of v6.12-evl1-rebase.
>>>>>>
>>>>>> Looking forward to your feedback and suggestions.
>>>>>>
>>>>>
>>>>> I tried to apply this series today, and run into the following issues
>>>>> reported by my tooling.
>>>>>
>>>>> Patch 1 is fine, patch 2 has some checkpatch findings.
>>>>>
>>>>> A couple of debatable warnings like:
>>>>>
>>>>> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>>>>> #58: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:2:
>>>>> + * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>>>>>
>>>>> WARNING: unnecessary whitespace before a quoted newline
>>>>> #95: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:34:
>>>>> +
>>>>>
>>>>> In addition to a serious one:
>>>>>
>>>>> ERROR: Missing Signed-off-by: line by nominal patch author 'shannmu
>>>>> <shanmu1901@gmail.com>'
>>>>
>>>> I did not get any responses from this email anymore. I can try to reach
>>>> out to him one last time, but what do we do about it if he will not
>>>> reply?
>>>>
>>>
>>> If I read that patch correctly, it's majority is taken from the
>>> corresponding Xenomai 3 logic. How much is unique contribution, how much
>>> was your work, Tobias?
>>=20
>> I added the evl_set_fpregs/evl_check_fpregs content which is a
>> translation from what Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> did for the x86 and arm architectures
>> with some isa enablement bits added.
>>=20
>> This should be the initial version by shanmu where I added this on top:
>> https://github.com/shannmu/linux/blob/xenomai4/wip/dovetail-riscv/
>> evl_port/arch/riscv/include/asm/evl/fptest.h
>>=20
>
> At least for this patch, I think it would be fair to claim authorship
> for the final one and only refer to shanmu as provider of a baseline.
>

Agreed.  This is a trivial adaptation of the pre-existing
arch/arm*/include/asm/evl/fptest.h, which is in and of itself
boilerplate code.

--=20
Philippe.
