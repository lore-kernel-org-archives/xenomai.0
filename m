Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59016263F34
	for <xenomai@lists.linux.dev>; Sat, 25 Apr 2026 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777143055; cv=none; b=arG+xVUE1nI9sXGGNCDTE9W1/j9lgY7x3L0mOjB5X+33iQ2gdAWN1tiUMyHM4dikMTzsDliQRaV4fSbbWy3hPZREYNaF+k2qt/RoaBZ0u6aNQ+ryYI85h5JQrFQtdJkRYCAxatT0nwi5bGGsnrGaWlUzHOj9KOAUPjOhagFTLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777143055; c=relaxed/simple;
	bh=pRci5jmRWpusb+p+d+kgLsjl2B2c08PQh7nHfwDQ7oU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gWd1mm/RYKNTbshQrY9yvutKxzZiq4TbPhFkcU3f4rfm82GuqUMxpzlrcUIgCsZm/VhiWV6XrwYRT8f2AuXKx6zZSKX1F8S6svhU9m6GAPqeuxWj0YlD/dKSFtl/mwVdjj0yUQPpjC7On+YRqIce0tUoj7RhDBaSvJ/KfU/0eCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=kTbCupue; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="kTbCupue"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D961D3ED66;
	Sat, 25 Apr 2026 18:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1777143051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2e3p+QUmYolt2o9+JmQVds4PTbbvFGtTJQJMoz5d90E=;
	b=kTbCupueJywocbPM+n3MQpSHsS6+wTAQ8UMBxXm5aHOLn4cZqxts+uyfr/bY/TT/fgD6Zq
	qaZkKNOxfZALtYjPmqm5auHXH/gBdhwSoIze2X9MtKCzYi6uQFQZsC+t+gsubVtyLwoibp
	+geOlEA4a0nPH28sM1y4oV/yFW0JyFcMiZwjLvbtRdtG+Muiv3+qNwNekwmSwlpqXRJ9o+
	NtPmnG4HeSCoxuQAMlEBfDRj/W0jjQDcFVtJU3QWge07tJztJiHd+pB/CA/KyvQB5VGEmv
	ON/XUsx2/A6oF/LardnANzIowaQejs8fDoiAdkMX9RfY6ZXTwXI4+cGBy83CRA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [EVL] Kernel WARNING: notifier callback netevent_handler
 already registered
In-Reply-To: <8e08bda6-1fed-4a5a-9bb3-74f019b05855@gmail.com> (Hannes
	Diethelm's message of "Sat, 25 Apr 2026 18:24:14 +0200")
References: <8e08bda6-1fed-4a5a-9bb3-74f019b05855@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 25 Apr 2026 20:50:50 +0200
Message-ID: <87340ij2lx.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGLv7UtltuUWFko0L1lBjhMcv0rwSdVZxYpqIMz1GBCPUgeNHjCJNkqTa0Nddg2pgjo/DRds3zRpJ7fMKwk7sohfME7UjPAdwPTkqOR9Cx4mA9HcYqi011LhB0jxAfXa+npdAo4jacBefG7gM6RX9PufTsi2I8e71xrb5WbQmq84abQjyHTN5RX7Bgtn0v+h5yp4igbWp9ifIMe4CFaDMSB0NaXBM8H5kF0CnbvHEwqN8yrOSnT6Yb9S2iGdnB8S/9776P6p8a9LIBVCq4W4e/ARRm42Q3DxQkmSFRQYdGVVxFM8gvvYt1vNajnwOw9buRXfPTnDa1a5/8wZIll4AtKGVSWnXpIpED0pmS/Mu7Sr0DP2ZxI4bjK7CCEDYqMjfhKSoNcwAP5Khq4LraNGR8PeV+fvwyq4OkL7uDsu/lB6qWOwLGyK5Slhrd2PiNH2rrgunmYqMXdmKAuW+9zmxQQQw9C/OsFJvA1S8ZMJGt53YNwfFP/mn23q42PJ3J00pLaTK/gnNErQ8pErPpEzsOCxGvJHF92HtNi8+OiO7FbG76J9hOIK9gABKfRFzpxHnPSXI3u00yfGgeQgVWdxqjEvsc9dMe2c/f4To/8xuapTy7revx2YqLM2byoOjvKDG0BdX2LShmKT8sMcnxZ2kea9JDPgHBIW+o6pZTcjE/ZVg

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Hello
>
> There is a Kernel WARNING: "notifier callback netevent_handler already registered right after boot". It is repeated 5 times.
>
> Config:
> Debian Trixie with xfce4 Desktop
> libevl: r56
> linux-evl: v6.12.67-evl2-rebase
>
> I traced the issue already trough the following code:
> net/core/net_namespace.c:355
> kernel/evl/net/net.c:35
> kernel/evl/net/ipv4/ipv4.c:41
> kernel/evl/net/ipv4/arp.c:323
>
> However, I lack the knowledge to do a proper fix. One way would be to just check in evl_net_init_arp() if it is already
> registered and don't do it more than once but that doesn't feel right.

It looks like the system is instantiating multiple network namespaces,
for each of which we set up an ARP front cache by calling
evl_net_init_arp(). Bad idea to hook a system-wide handler there as
well. Could you confirm this fix [1] works for you?

Thanks for reporting this.

[1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/569beef061321c2c00d775b13ad0aec1a1d2a416

-- 
Philippe.
