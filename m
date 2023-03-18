Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60703224
	for <xenomai@lists.linux.dev>; Sat, 18 Mar 2023 17:46:33 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 4C710240006;
	Sat, 18 Mar 2023 17:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1679161585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+iRG86hFXHZ3W1SG329LWosHkFTaSOmBF//kT6jByo=;
	b=dlrsB3BCAgzCHOL2filVnJQIbR3KvuK9yCiomuC+E8uDWSVih4n2l30MMt4amyUcsLul5b
	3e6nulk4kxQmzRZzgkJD3gN5prPlwyIoMfrxb8F3dhEZAgUWEJ3cXKmbwb/5jIg5sbHooB
	etlA8FiaV9Pqo2kwLbhMaQWgqeOnjW34AqOPKf33BkPId05NSGqtJStT701zkMc7absin/
	V3swSazv9NhAQawQSUafVXsamqWj9HwMPgfRfxNxpHeEhx1VNIOR+H8d30eUOzXq+Q7Q6v
	5gmdFIkGhnoc7tpooQ/7Pt+PyemnLOpoDIAJocpGDKC+d8keRHxyGjBTlA4MTQ==
References: <20230317133249.38756e92@wsk>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [xenomai4] Sharing information regarding RPi4 demo
Date: Sat, 18 Mar 2023 18:45:26 +0100
In-reply-to: <20230317133249.38756e92@wsk>
Message-ID: <87edpm3qbz.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Lukasz Majewski <lukma@denx.de> writes:

> [[PGP Signed Part:Undecided]]
> Dear All,
>
> I would like to inform you about available Xenomai4 demo for Raspberry
> Pi4 (model B) board.
>
> All you need is to build the SD card and connect oscilloscope.
>
> Please follow guidelines in:
> https://source.denx.de/lukma/meta-xenomai-demo
>
> Full Yocto/OE setup is possible with single kas file:
> https://source.denx.de/lukma/kas/-/blob/master/rpi4-xenomai4-demo.yml
>
> I hope that somebody will find it useful :-)
>
>

Thanks Lukasz, nice and helpful work.

-- 
Philippe.
