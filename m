Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D646A3
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:40:56 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id D96AFE0007
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:40:47 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by spool.mail.gandi.net (Postfix) with ESMTPS id D29B6D80061
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:40:46 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 455C9FF809;
	Mon,  4 Jul 2022 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1656942046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wx5K2nbfOPLiG7iQFuT9x6Dd1ePU0nEQ2v1jLmFcd50=;
	b=h8wGHo+NPFd47M5jet89tAKO3v0CJPNj3/s4b8L7GeFXHx8YW2D3kIEKxeDY8kcQIQNu1p
	+8obwZCvOniiyeF2/tjSUhGnIcf9c8/W4zPNeEEb4ZdmKWchGKCO8J+CeCm7iCf7RO4buT
	7qXKOWDUFOl4NmHMZdoNPieey06QyzJBUiMB88GwYdo3pJko1Y7ZdomUJvtxR+srAknbLD
	856MpLIoaZZXRi9AkYEiSjmsbZIStWnYTN2t5aOuIbXy85yZfVTYDPCU0nm76GRPEwIsUM
	c0xBB/pHtEXpKXxa5UHRnInKj6fWkL2NEdj92l9G+OO4YDPy3hwEZmP6QZVmPw==
References: <cover.1656940114.git.jan.kiszka@siemens.com>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Gunter Grau <gunter.grau@philips.com>
Subject: Re: [PATCH 00/15] Kernel 5.19 adjustments
Date: Mon, 04 Jul 2022 15:35:34 +0200
In-reply-to: <cover.1656940114.git.jan.kiszka@siemens.com>
Message-ID: <87ilodt2qq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass (spool5: domain of xenomai.org designates 217.70.183.199 as permitted sender) client-ip=217.70.183.199; envelope-from=rpm@xenomai.org; helo=relay9-d.mail.gandi.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=h8wGHo+N;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.199 as permitted sender) smtp.mailfrom=rpm@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> This allows to compile and run Xenomai against latest 5.19-dovetail. The
> kernel deprecated a number of APIs that forces us to move on. Luckily,
> we can do that unconditionally in many cases as our lower limit is now
> 5.10.
>
> Philippe, could you have a look at the SPI changes, specifically at
> "drivers/spi: Convert to GPIO descriptor API"? I'm unable to test and
> unsure if the conversion of find_cs_gpio is correct.
>

I'll review those changes asap, but I don't have enough bandwidth for
actually testing this code ATM. If anyone who currently depends on this
driver and/or is willing to test it, please do not hesitate to chime in.

-- 
Philippe.
