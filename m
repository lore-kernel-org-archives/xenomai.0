Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479497;
	b=14mxpNzUx4OoXE15GPaH6Y6SCsrOKCaQAtbKNIdx0dz2mCgcF/txVfOJ68Y2GP6b7Ntr
	 iNk5ocw5DiEm7GLyOdCYCkCstOXuRRQTKpfN9O1ytFlQRPfwdNvwXPWDTnxABVASrQD4P
	 A9n2hSHK2gKNDlLzcDoNzfW4SNY85I8io63UdXG76FtD6ZSeY2kMKHFZ2M4njgYt4SJp6
	 2UsE+2Bohd90GXr6MiHSzGJ9xp7F9GXG2PNOx7gGkTTAMCOqrMxOlLVVGoUrhD16ik4UF
	 uza/+TtcUm+P1v5YNpBmUgbvoYiJ7SRBDZ1qQNeeo9z8MNkw//jXp1L1N5ygWx1igTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479497;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=KiK+BFi8FKL/5cZBWDLYefHOOLen9UMztcr8kikiu8M=;
	b=iVXM2PcT4T+slpsgD6xjkf4jJIAE3cO8lhyzvU6CGIam98XFU33pGpbb8uIiZseJkpL5
	 ve0JWBcA2amdlMIfXO0GK2dOSA/E/PUhvPOX10pORAwN7+SD00PAe06KA5PlZQaqRqC/1
	 XrcAsrTu6S8gU5UGSz7Kg05Acj11YkBpFj9FCpzwTPrQrLbTS6gu84+kSPFl2U4XVT5M4
	 5irLa1x3Mv/ss/TftvxWeAADuYjKcTlXLV5PPjENZ+AXy92vZwLt6i/UR3LtwDio2aqE+
	 hvIRHhKShT4VKvpsMZMw55z6Zl3okC66u5dN5rW2/zSq9N7G3NmaUCVHedewOap5Ibg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=TJq3qRq1;
	arc=none smtp.remote-ip=217.70.178.232
Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B3606A331
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 10:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 601B3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=TJq3qRq1
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 3921D3E9E3
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 10:31:34 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 96734268011E
	for <xenomai@xenomai.org>; Thu, 12 Nov 2026 10:31:33 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=TJq3qRq1;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 2001:4b98:dc4:8::228 as permitted sender) smtp.mailfrom=rpm@xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A07A3E985;
	Thu, 12 Nov 2026 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794479493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiK+BFi8FKL/5cZBWDLYefHOOLen9UMztcr8kikiu8M=;
	b=TJq3qRq1wvKlD0sScClqNhhqLACjB8/Jt4I+g0FNst81tajWg/buMR1NQu85bF9O5GxEuR
	HRQjVPqdf+K22Dl0bKvHpvhZU17modQgp1L4lN23Wf7WCK+YI0iuuobz4XI/1Fm33NjBcb
	HOH8OCb8ULBV1+dyXJ72ewDovW+gFYsVhwxcsYeRfvdQTls4YOBArliljAaU3/Wcw6CRZ5
	Ngo+zout39iQLlkL3FO+OTMEaTyyuPq0T6fNJzJogjUuVTxcTDTAW9ca04v3XQHfII5/6p
	OaP5nAkd3bj3FAQpOjJDDvCjVScC5RKWHoYajiZrDmFLKvYI6YrdFBJS/V4U/A==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  xenomai@xenomai.org
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
In-Reply-To: <cover.1794399047.git.jan.kiszka@siemens.com> (Jan Kiszka's
	message of "Wed, 11 Nov 2026 13:10:43 +0100")
References: <cover.1794399047.git.jan.kiszka@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 12 Nov 2026 11:31:32 +0100
Message-ID: <87cxsa2vej.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGrsyZpw/HGjsDtW3mazAvwO3EX8LR/UxB3cpT2UjQqOV+jgg/YJImIiwuvTTcixq97r/qbm51d5ERJxOWY/vpXZK9wixuTblBgoIcb8FiF+bf/w2wK9DKdLf1LCX3BjbIsE8zLiPgAEVFAKzncQBgQ5z6J3BOeJagBhh3ArnQnkqMVtQIXbT4G4pERORv5Yi5PZPdY9XN6D+gJmjH/VspCrTqC/pUneF/yppMeEfwiIfsEfjwxtizC1A01e/cjc3O5C/AJZiAe/XTtf9F/FT+gYRoBDQtJdVKiDSmpMnTfUMMk133uTyiqKKTxgjj3oxlbbgVLwn+yS+3IG4Q0tTezcBepzEcwgY5BAvUrzxw1RGIopGoaii9KSe6O1aGDXZAR1LUoLKoRNaye8atXeBpmobFVmPyNNEBnJOUswCnIrwBrtLq9iYid/mTH0/R7SoZGSdrCwwBmA3SdApmOmj+d7xE6S9mVc/gJyyHBRFX86JKYawwiFqm4v3fCK5ZVBraKoxu0Be7vjOH9DpIIbJJB7fhPx8hYTbzYTEjsXL7bSmJvQKP34RiHooIi2DY9QwX6ri9T59/nBUCfy61aD4boOfZaUn5MEfnjgDesaa6EaX2ZQLSNUFte9y9v1DiyrhJGXeExSFGxQRy2Bc+1WgUfe7lkj6DRZpLe+JjC9ck9oQ

Jan Kiszka <jan.kiszka@siemens.com> writes:

>
> I will share the lengthy test case as well once I'm done with stripping
> it down further (if possible). What the tests already demonstrated is
> that unpatched kernels crash.
>
> These patches here are almost completely generated. One of my few
> contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
> of having oob_trap_regs as a nesting detector came from the AI, though.
>
> As usual, AI is still rather verbose in descriptions and comments. Some
> of them I already shortened, but most is still left. We can cut down
> further, but I would first of all like to have another review round.
>
> While doing that, keep in mind that AI tends to ignore issues left and
> right when being told to do a specific task. It may have simply missed
> further preexisting issues or even created new ones now. Watch out!
>

It looks like patches 1-3 have landed into v6.18.Y already, which means
that you are confident with those changes eventually.

-- 
Philippe.
