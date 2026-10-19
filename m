Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422102;
	b=aFzUAurkgIsw9hm6jQrAcPbf2xBLHueigHYceEqchYVfzrwabf54LC5hVjt7lxT59Ma3
	 3RX3/n0zxeWr3bwlPKlYL3toRFJGVltKqPUY6TQTdAAhwDkNyv7cbiYoeiIaJCMwU6aG6
	 YN0/eMZI5Ea4rjgXEIUqW/4JnNLqzPN+uzkIKkfjWAJOFSiaN/Nq27GjtTH4YQ1iZl+7z
	 f2mWIynKyK7uhCn/N1lRRsR5QqqbViY+1xkdjaS7kct3DS2eGZqXxITt3AY1RIB7M1Jyv
	 6oze5BYaa7lfFHv7sXgci8sNspC6gCCMhwixSkkH//Klsrc5fnLE1RRpVycwSpqTNYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422102;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl:X-GND-State:X-GND-Score:
	 X-GND-Cause;
	bh=9y91e3oHOAAeC6LBcWQmtFVa6alXJcUFL4ZazyIShKE=;
	b=wZzq9WuvtlO3gQrDy9R8prwhfh3nMdAuut8iXjCcIYIoZX4O6RhuIatpzQqczb6fqu/B
	 IyZAhIDnsudj+XNMSMuu49phejRgPcuR7fmt8D6KDIOvAyivhgXDmmG0uLCm/KTHK604K
	 hB0Ybm2/f8T82GhJmW2jRWeD5qiEy+42k5lB+cJXaEHmF7aS+QJhHEBp7OMIz/4tv2ain
	 EeN7Yh9Bo08tc8B9b5FlVMNL0U98UBM75eoKXaVcNXERWFIfDo2a4gN6t77VXV8FJzY4L
	 /bu7KBf2l9vHJCq1OpZpYKm/WEBsa3/9Q7jblJvYLFxK1nW6c9Ovf7wRZn9Tn+kAKRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=LMQkfsHQ;
	arc=none smtp.remote-ip=217.70.183.193
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696C607AF22
	for <xenomai@lists.linux.dev>; Mon, 19 Oct 2026 15:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C696C607AF22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=LMQkfsHQ
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01A4D3F086;
	Mon, 19 Oct 2026 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1792422093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9y91e3oHOAAeC6LBcWQmtFVa6alXJcUFL4ZazyIShKE=;
	b=LMQkfsHQ4UKdJkKHALpslX6pSNa5XFTz287SqukrxzzvTxzlHl5jouO1Lme2rRyoYuDUt0
	qQIR1B4xyGAMjSmMJ9QNyJAUq28f1/otJPGy/wVpcMYaVCXOapZMbTLKJT00XspPFBFENa
	yFmZ5vc4IOFV06gG4UKtXGjYFLoLYd55bvHc+C3uUfFkYf0bTwAFL1Tp4VsJfbIDe3Ny2/
	uJhiybSh+OU6D4YtW7xPIb1Rn3I7WjoTyXFkt2cdM+WV/Ar66i+iH7c/j+FYND4DngKyah
	fJ5YxupI3aiiL3/LlCdPFZYcdSXkj5TZhaDHoj8+BgROoko7ByhV9Y0VIOTEvA==
From: Philippe Gerum <rpm@xenomai.org>
To: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>,  Andrew MacPherson <andrew@elk.audio>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
In-Reply-To: <CAKndYJES9912iO1fih3Ps55aj5T+udqGSQ-yD4EJG+XMMsH7jw@mail.gmail.com>
	(Gerte Hoogewerf's message of "Mon, 19 Oct 2026 16:46:51 +0200")
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
	<87fqy3wg6m.fsf@xenomai.org>
	<CAKndYJES9912iO1fih3Ps55aj5T+udqGSQ-yD4EJG+XMMsH7jw@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 19 Oct 2026 17:01:31 +0200
Message-ID: <87ld7t3fas.fsf@xenomai.org>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTF1M8rKmQR5R0pPvsuYbhJ1pT2GO/6OaR6/mTOlypRkrWT5nAEeaj1/ptr7MsxvMEH1KvHwXeKU0Z/8hu5ovfsKUp1VYOVxajm3xzhGlzX7T+8jKnASYpB23hvKaewLa0NflfqKGw5glmOMHMh3BCtlfCGuQxOlYJcGPmd7AXaF42bWzwy52J8z/0ADILXfFty635ab2QsU/TKtuuEfjANxz+6CjfRlEhbK3v30vsJqndDd9IaYd+BIAxQxUx4vhzPvzMHO3Tyq1KGGg0bfwSrt6Af4j4iPSDtsGgqEVqBsrOt35+LXp8MMN3w+bjGE3pIhlqdWep3fZgY7gZkJDQMgI1yARfarhS51lbCWiJo36gti6/o7fK/dqNc+GXsnNmHKVvi02DQsTiQd1ArhqWWmOjOREO9rJY4+hv/4bexg79OkgVal1guBXDK3+cGBt8nAPwgcIe5V0iRP/URnaJ6jM/jBMvOsbwip31eL2qda5914pCcriHvF9Mik0nEcf4Ps2rODiYt+602QqW9w18EG0N+f14zeNRQJIBQR8ngX6xahc0v2LNoSewlk7KGK/4dR35rL1y2hlpS/yaRxTSM2YUAWFL59zNi0sIRzkr2BQFFWSikoPJKw1P1C3EZo+ZhFbufOUwFZf6ZisHTKK9Gqd0zHm7qVfV09R9Wu/MphwQ

Gerte Hoogewerf <ghoogewerf@lmi3d.com> writes:

> Hi,
>
> On Sun, Oct 18, 2026 at 10:45=E2=80=AFAM Philippe Gerum <rpm@xenomai.org>=
 wrote:
>> Series merged with backports to v6.12.y-cip, v6.18.y, thanks.
>
> I tested 6.18 (5dcafd54) on our end: ZynqMP and Zynq7k. Thanks for the
> backports.
>
> Cheers,

Ack. Thanks for the feedback.

--=20
Philippe.
