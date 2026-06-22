Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87B363082
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782112439; cv=none; b=ACKZ+kx8p6aU1xHgTm2N5ZHhT0AALi8RJnmMxibLIrXw3wViqt3Gw2iKAJpaJPesRm1V9epA9xQLGBJgVpEEeqVVvWj+k0qQ1jlJ3NJ+ZB3TS3Krom66AzuL/0fgfSgp85EzF6DQui4x8VxxseGNyk5E5SYbnO2BsEOh3f8YvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782112439; c=relaxed/simple;
	bh=xKOQOOays5Em87BPrl/pUFfJ4i6+XmXnuuvsG8me2bw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oAcT+TwuYDMlCNJRUbp8q2dqgI5iCUCSi87j6/uPOGp0k+aKEtRPbXjw4tprplzjBBAMZVr48CQVEF/Acdq3vAGSIuS1/kcs3agU7D4UmXroEzMPTq7pLCE2CnqXW3jHpX2VFsqg+OYSZSSWghmUrnqo9C8AJ6lWjFCbBp5h0g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=eLDWmCfa; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="eLDWmCfa"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B31A3F553;
	Mon, 22 Jun 2026 07:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1782112428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKOQOOays5Em87BPrl/pUFfJ4i6+XmXnuuvsG8me2bw=;
	b=eLDWmCfaTn6GHBVBRNkO5NGpFJm67T5cR/+YeQPyeVmODUX1jWqipwP7qPKPL/ioUGvR8T
	wtNRnEnZlzvYY5iAIWWZTtbJfNywI9jYgCQARKtsb4NtK2wJy48hpbKSDsh3ct5LkI9n/H
	TjBOlR+MNGlYlYeTSschyOPckmUmGnsAkGd8pT69iU3VdZf0OqmNCOcZCJ9jSNLtzEr8ir
	/ecQuqHoUYNHjoz92yVJKztFU4VqLWUBkTGnrQVLO53O0mb2S0Kl5l9Vr7zxEpPPdjqZ99
	p6IVCGIfNINK37f6Wb07iVtZ3UNVz4cF6GA5509iF6+MTXUFlPJMeVKLPnJKjg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>,  Quirin Gylstorff
 <quirin.gylstorff@siemens.com>
Subject: Re: Possible Xenomai 3 latency regression on arm64
In-Reply-To: <87cxxsfan7.fsf@xenomai.org> (Philippe Gerum's message of "Mon,
	15 Jun 2026 10:52:44 +0200")
References: <8ed28071-2341-4322-bedc-df1929e3a125@siemens.com>
	<87tsr4fe74.fsf@xenomai.org>
	<28f40baf-6a24-49f0-bf15-415e7ee6e34f@siemens.com>
	<87cxxsfan7.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 22 Jun 2026 09:13:43 +0200
Message-ID: <877bnrf3o8.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEdZyO7otkf3Q/ZgEXts2JWBTUXr9204Xm7C4mcR+G2TgQpO6DrkoF7GiJMKXFYSQ8oaY8Wwydz4FUOg+8r304UmdbU+sUsHjjhGMnwHJinFigZdXHEIT4EDU6PMsXI0RaKKfR/eflNyWokk4x/N/4YbbQPNA3gmdMIQAsbZDUO1QDHGsxt1tXZ0dVF4j8fHr47gExO8Qp6/HEbZVsfGh17I4ZbAqrMNWDXwqhwTQ6M/cx/pBwESrq9KEX+viaQ+8+Fn+/9IazUM3mDNeK9JyiaaSpZ/MmLhTlc2ziR13fosNe4W09WBJwtZLj84y4NrosDPW8laLfm3PFs97Y9VkfvMl/cLbxsWLj0OATsCqMcUsG3aGc8oMlU+9RN3dVDnF3iYoEOoEQBn8gcaCxtGuismJbdmxR1tFprmIY4wXiYxMo8so7hssxRWIK9MICw6LN5Lp+mGE17eusCdRiyCQHXlPJf9XvZLk/jPq89RIOfaGZykusFnpBwSic3JXuebSP2mnRfQ4x818t7yQ9WW0OR7olo3lnOKTGRld/q87m5ZpppmSqsjqVYGlQx4Ph8wP2nKWICDppoRibIk8YyjpOpMb+Y8iXm1gCb/tg1xaB7QDcxTTM5HwvjGZUaQaq5tqd+G/uHoZoBctxZeBXSFoDdYZTaapWaWeCF+RGnM9ApkQ
X-GND-State: clean
X-GND-Score: -100

Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> On 15.06.26 09:35, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>=20
>>>> Hi all,
>>>>
>>>> it seems we got some >10% worst-case latency increase over the last
>>>> month with Xenomai head and 6.12 - that is at least the setup we use in
>>>> our long-running weekly test.
>>>>
>>>> Tonight, the RPi4 test triggered by exceeding the configured limit of
>>>> 150 =C2=B5s [1]. About half a year ago, we were in 130 =C2=B5s range w=
ith it [2].
>>>> x86 and beaglebone are apparently not seeing this change.
>>>>
>>>=20
>>> My rpi4 fried. Is the issue visible with x4 as well?
>>>=20
>>
>> We do not have long-running latency tests for x4 yet, do we, Tobias?
>>
>
> Ok, I can try this on an odroid c4. Did anyone succeeded in booting a
> mainline kernel on pi5? Last time I checked, root-over-nfs was not
> possible yet.

A follow up on the latency issue. I did notice a regression in the
latency figures with v4 too, specifically on arm64. The issue was
introduced in v6.12.85-cip22-dovetail3-rebase, where vDSO support for
oob callers was unexpectedly disabled due to applying 682c4aa14fe6. That
change is correct starting from v6.18.y, but should not have been
applied to v6.12.y. The bug caused a ~12% increase in the worst-case
latency figures on odroid c4.

With that change reverted, I'm back to normal on c4 with
v6.12.90-cip24-dovetail2-rebase. A couple of additional fixes to the
generic lib/vdso support went in as well, but those have no effect on
latency.

All dovetail and v4/evl branches have been updated accordingly.

--=20
Philippe.
