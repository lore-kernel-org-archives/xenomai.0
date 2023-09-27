Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E353368
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 06:58:31 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2FAFC0004;
	Wed, 27 Sep 2023 06:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695797904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZtnOUiDXj3OrK08h0oEAUoa+vZEB8hZMVZYhQ4iuLI=;
	b=K8XGIgsB85wZaG2fdmFzuTRNexh+OCsD5IeiE0AmEXyyPT0+3GrvN8dlrJ1jdnUSfxLNBJ
	l9NVq6EQvOw+2sY6oj/65ZJREglQ+ptfbXt2up6CMKyepbmOBpEiY/OnFGiqibVG1lthSz
	ULKx7MSG1yfwinC5Gw/+eC/m0L6/rv6sUPP5+5p5hQ4h52NLN4b4/bsibhvB9dTdkm9Y2B
	aBlmo2vrKIqNZvML4eYR007SM512UW6dJwEXa/MGokF60g4oqK2x0g5Az9nXBPlicW8iwn
	uIM00cTC43beYVvaxw+oFYntkmGEbl1zku9TzbUtoWKY6JgOUFq9/iDLji5hjw==
References: <DB8PR10MB370698CF0BAFEAE2198D24A3F9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
 <87sf71nf1h.fsf@xenomai.org>
 <DB8PR10MB3706B544A1AD8812E2ACA78BF9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
 <87o7hpndh0.fsf@xenomai.org>
 <DB8PR10MB3706CC719B10DB6F15F7C64BF9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jesus Villena <j.villena@ecler.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [EVL] Problems writing to physical memory with mmap on oob context
Date: Wed, 27 Sep 2023 08:51:51 +0200
In-reply-to: <DB8PR10MB3706CC719B10DB6F15F7C64BF9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <87y1gsm7as.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jesus Villena <j.villena@ecler.com> writes:

> Yes, that's what I understood!
>
> Anyway, I have made some progress: if I write something to the shared area (which is less than 4KB) before going to oob context, it works as expected!
>
> So, it seems to do with a page_fault the first time a write is issued in the shared area. Sorry, but I don't understand properly all complexity about accessing Linux virtual and physical memory, security, and protection.
>

This memory range may have copy-on-write semantics, which would explain
the major fault when first touched for update. It would make sense to
pre-fault this area in order to break COW early for it.

-- 
Philippe.
