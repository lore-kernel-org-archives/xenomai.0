Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0A842DA28
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558346; cv=none; b=rlhfZhzguU9KsLaWFC0mBUtfg3wp3wwIGufyCnipxfO5sdg+zbq7nUHcJ8U2j0G/I30x29nQn1E+NqY2inWBDbIsf06+kmnKtJVsa71IpSUQdq1eaL76Ljh/tZzW4fCH2P9pRDtNag+wJaeKCZJ63qEVJMj2Bh6LFu3K6jHcOBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558346; c=relaxed/simple;
	bh=GeYJfxCc6wh9bviw9Jtj8NLm8oqMkjpJHFmip8xvtsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m9nPap0rxf3HQF7leO8hkucMaKL67bvbM6IW3ZL3H16fzAdavSV7D4HNDA03oh+cYqCrwoO1bcCURdn9cOW4pvJ4E4Vo5kx0ZBp5iXXxjjlWyoh8bU7eBZv3DUIt0umhCWE6mleyn74hmemi9tg4eIUJr1H/1KspU45bz9ipHEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=NYnD/DbW; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="NYnD/DbW"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08B7C3EDD1;
	Mon, 20 Jul 2026 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784558336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojJUQm24DzAesdaFpYDxnwUKx7Ie50GCy4mnMGyjSMs=;
	b=NYnD/DbWMs0zsOyaFDwxQnnT8pMRaZM1L2gi00NWnlmNVUVPDT1iuaoYqOHWm6aSWH9kEA
	jXTYP3DSyhgnA5g2QTiLrgU26rJOUfI69Z0e+nyJfTgBo4fu0UVfrJu0/Bhdo4e2nteYC2
	rdmuqlKgBs/rmKg3AVLFymOP8Xn6Oak0ZZ7K7VBDIe3ktnQS41Kg7YjVXekzvLIcnygKkh
	e/buuzq+oEpplsvYTfWUN2eNU9VXtObWn/Cx6mxKZuykCcF+IerKezBJzhF/R1aQzmEwTO
	vmelXr7NgEhDihzRUiZCUbda4oE/5V2xk2YNTvVe7XRzuNFsNHg31cm+3dtIjw==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 0/1] libevl: Add debian package config
In-Reply-To: <20260717205820.8359-1-hannes.diethelm@gmail.com> (Hannes
	Diethelm's message of "Fri, 17 Jul 2026 22:58:19 +0200")
References: <20260717205820.8359-1-hannes.diethelm@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 20 Jul 2026 16:38:55 +0200
Message-ID: <87wlupzpxc.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGDdCGa4qGJFE48LYpFOxdBXQJfK2HrcKSu4GBBeSLy7kLnhSPln2hV6yW6Vr8n11urKIenonqkIsGIOX2SHZNj0scES5mokr6kr91l4LaK8fLI2VXeXmb7CNw+eSPsSwJ/6kvpiWAztbRis2VIPiW9WmAC46ZjQUUnNlrLTl/hz/FD1jdSzWHmh9bUTY6exXi/4yatiiM2IYMDK05xkK6zSb3Sqm/k5fy77jKhkiC0XGji/SBtzZ9z2Wo5BLY0GjDf41oaqhv5Os87UZ+iKHsSFNrTDrE2ZG1KSHQjwtIrt6hu4WpNnbgytETf/tleZxrpm0dR+7hSJH1oJvl09ATBbGmYFP0/vHhBVqkuP7FZ2715Uahgw0WVkYHIqvKSU8LS0xVlOLpr0JxoJ7RPVTdY1/3Umkr5W1y4PhQ+1PPqJZV7GX5KxacD1t6yrCI77VuxtChmTVJXar3+ycQdmBDYorpDVkZOc5Ty8lDONHwWz4KKtbeNyORuMdKJpylXMIgH8MmLcFfhspwxYoB1hyFhJcV5Ccn4AddWgStHWWlNYIncw/TQIC4PeAoWZ1KjmelOUU5WlULeqXoircjZFMCBK6pDvZEg8ccZULZm7MmK4wEfSTKQu5fZL68qb2uHFXsxP3Z2RBlzGaHs0UP3F5SWGzUCSQsIGNaQd6eGNIggiA

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

>
> If linux-evl is also built and installed as a debian package, linux-libc-dev can not be
> installed due to /usr/include/evl/*-abi.h are both installed by libevl and linux-libc-dev
> from the kernel build. However, installing linux-libc-dev from debian trixie works fine.
>

If this helps, we can tell libevl not to install the uapi by passing the
-Dinstall-uapi=false switch to meson [setup].

-- 
Philippe.
