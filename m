Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3667F
	for <xenomai@lists.linux.dev>; Sat, 24 Sep 2022 08:26:47 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id BCAC1200009;
	Sat, 24 Sep 2022 08:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1664007999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3wveTfvzidwP+Vk6p9uqOHABY51pZuVmbq6/50zAqCY=;
	b=g/pA8LJ24l6u+8NMsXgGc+dINz+D/iWOTHQalkR94HjGHa6GrnnvB4bGds1t+rjXEp+a97
	HTuuMf3dYFDbB7DjLLgitxV/9CfF/8weWcgs0aZwY6XNn1r18k/Uq9rm11hwvQT6/HPVvs
	3PJurbFkpI3xRYzYoMwm1FJAt7WwRUlhpBiXtJc5PVBPxf1DSOhIUSEpMnp559YFZsh1W6
	d/YiGi5pwFViWlf8IBSkAxplb0K/QiUBGmWW9Kg3eTMFyF70KLSWev5y+pYfytGmoBS6LO
	+f2psRo7iz/z2NuczghWzPo6QYZcg1ic+0cRjq28Yr9tsO/wsgWboCie3vgW6w==
References: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Bryan Butler <Bryan.Butler@kratosdefense.com>
Cc: Russell Johnson <russell.johnson@kratosdefense.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [External] - Re: System hanging when using condition variables
Date: Sat, 24 Sep 2022 10:21:32 +0200
In-reply-to: <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87o7v59o02.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Bryan Butler <Bryan.Butler@kratosdefense.com> writes:

> I have another system that behaves slightly differently. When it hits the watchdog, here's what I get:
>

I have been able to reproduce a bug on an armv7 SoC with the test case
you provided. Sometimes the RCU stall detector triggers, sometimes it's
a plain hard lockup. I believe these are symptoms of the same bug, which
_seems_ to hide in the PI chain management. I'm on it.

-- 
Philippe.
