Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8487F525B
	for <xenomai@lists.linux.dev>; Thu, 15 Jun 2023 09:28:50 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 68497100005
	for <xenomai@lists.linux.dev>; Thu, 15 Jun 2023 09:28:42 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4CA1E9416B7
	for <xenomai@xenomai.org>; Thu, 15 Jun 2023 09:28:42 +0000 (UTC)
X-GND-Sasl: rpm@xenomai.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1686821322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+1hjxJnK0azU3WzEcQh43IwymFFiLTU0OkDE97pAMo=;
	b=dE6lNlWZ424e9AnUYIm0o4u+KoRjuzq7i/MgkWHGCVUc+s+J1jvdMCa3ikpC/DGlevJ2cd
	EFVeXg2Qpyg0WRa3oF3KeqY9bljHNmlzL8B4QKlMyILMPgUBRp/IrbD/sY3nMP3eFyQYIw
	ZpoqGlHBsZ3WzQyW/xNrEIaLlF6GZv7maMR6VtI6MEFzxmqsEFntFSz62vrNnA0Yfvjsqm
	ppGCVGV6oHskpwm7HI70LLK/V8I3LomgnBhE6WvWC2a6iYNRGlrNod2J9/Hw0IMt06vefv
	iDEXngKR/IbNH57yS4w5ToCWzsd8fZsbVYzF087R1CsWfY4Npo2Bip6R1scglQ==
X-GND-Sasl: rpm@xenomai.org
X-GND-Sasl: rpm@xenomai.org
X-GND-Sasl: rpm@xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C990E000E;
	Thu, 15 Jun 2023 09:28:41 +0000 (UTC)
References: <321584983.3714817.1686565517697.JavaMail.zimbra@nod.at>
 <dd6b33a8-f53c-8c51-a30d-2688ddac1709@siemens.com>
 <1832934245.3714909.1686568547516.JavaMail.zimbra@nod.at>
 <14248715.5206787.1686676799496.JavaMail.zimbra@nod.at>
 <MN2PR11MB42852073A335361100FF8948F25AA@MN2PR11MB4285.namprd11.prod.outlook.com>
 <116129980.5299274.1686733935108.JavaMail.zimbra@nod.at>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Richard Weinberger <richard@nod.at>
Cc: Hongzhan Chen <hongzhan.chen@intel.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>
Subject: Re: Massive variations of execution time on x86
Date: Thu, 15 Jun 2023 11:22:49 +0200
In-reply-to: <116129980.5299274.1686733935108.JavaMail.zimbra@nod.at>
Message-ID: <87r0qdcbwc.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=dE6lNlWZ;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.196 as permitted sender) smtp.mailfrom=rpm@xenomai.org


Richard Weinberger <richard@nod.at> writes:

> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Hongzhan Chen" <hongzhan.chen@intel.com>
>> SMI processing can last for hundreds of microseconds depending on system.
>> I know that it  are all disabled according to your hardware vendor. I do=
 not
>> know if it is worth
>> double confirming the value through rdmsr 0x34 really does not increase =
when
>> issue happen
>> but we have no idea about the root cause.
>
> Our test case monitors the SMI counter via /dev/cpu/X/msr and observes
> no change in the counters while the test runs.
> So I'd rule out SMI.
>
> Thanks,
> //richard

Any chance an NMI-based Perf event handler might be causing this?
(nmi_watchdog=3D0)

--=20
Philippe.
