Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131E2C15A5
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034811; cv=none; b=Hig6NkRWyKZrRMfbvwtxFQsHx1VlkHdByJm4xeSGIHbn5xpiJCfuo0o7LymElEbvoiJ0lf+8gBHcfBEGid0R1BUfeZ7EW5uGBq76Tz/YKYobSwqiSnOC9Rf1HfZg7g94aSdEFKtgQDKKt014AZvE2JOgiKYXko1eaAvskPoWkoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034811; c=relaxed/simple;
	bh=UR1bfjGrbZCRWfNWZYkpz9yS6qqUG67uD7vx+QR3L4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iU0R53eLe1ufCDQN92hM3XP/ZvP1QFaw58WDsIltYyxxkOYjahyNvyOv9gkRxoomVi5Fq1lQjtv4F+ZA3SieXbAGTbX6tBLiVFVSCFbspmoYnM3of4qlyVlNfPGFWl7Vmg3ByPVybbi956rp44STfoKjlgZJZSf30j3kanMS1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=fl+15pmS; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="fl+15pmS"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 7087D5834A9
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 05:29:25 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EAB83ECC0;
	Fri, 29 May 2026 05:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780032558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbSG/vUYpHyEmVocc+0n2WW/+Vse18ezP8T5kskx6no=;
	b=fl+15pmS6nK/2KrKY1aJzu5qedpp+MFAAO5Ncdwi6X86WamAmkpv2dA6OWoTxr/sJG28kr
	ze8KiE2hXGX0M3uzBupkAq7406O0fivno2ckGcbIRqidBOLJhsR4GNvRRDxb5ZMuaf3cue
	8cH76nbxTpTrZQbfN6haCRPn2Ds+/66vTK0XsLy0Cvc0UnWfilOU2eeJGUud2SL5RvaXQN
	2CHtKnobg85rAR/za8gRhhPQ34tUNPHTpPHbO1O6ZWMAhc+fldZd/LYEkixycOX7uP20PB
	56xEsZYJwVB+j2qduJYaDKIEZRT2rRrVAdtSohr8RiPpzWBkCVM80CpuNGTQgA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 0/1] tidbits: net-udp: solicit new client for server mode
In-Reply-To: <20260528194459.6117-1-hannes.diethelm@gmail.com> (Hannes
	Diethelm's message of "Thu, 28 May 2026 21:44:58 +0200")
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 29 May 2026 07:29:13 +0200
Message-ID: <87h5nqiy1i.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGIN+pthc7FRB7+dn1EzPH5cnDABZUQRHIMYIobki9BYx1fbh+YNBwwB39XRmAB6jIvD5D9wJ0Zlg4w48pKfmeAV+KdyIEHDNDw7oLVU7gyaKNaDzyJ0XH/ONZ4E8r3OO/qNcJGfUv6MDtxcwFm3i2rvYKa6IfVgXMAenMfQoDyY574v2ouOF+yydhWcIHzT3eC6uQGAF3xtrv4VNTCfb8UTK51iTbxL/Goi7ViMOGNk+kzFRpfsmDl8G42xw/asNj6pOkItKuCbjxn/uMPi5wvuPgSVSiDJYasfsedqb8y9ajx3GvNSYdKjc7eHM8VpQMPIFuLfJ3qjE9Bl+uk88axppUu0THwmOwDD6qABtcLw2AC9Ru6PvvLK9vwKwVf8rkxQzrvJDhC4rCfZ9Ugoj735wuisFhdm4wNMzRv0zKAWJ+WKouDqQvh6ejidGtqt4Vd41i/5Y4KVs/ajBxrFcPfdM2jg9KJAvTbEk8PQ9aLDowrDy5qEbX92mExwIdF4mfzydLT1vcuVTMOdtVsvfXHhqR9Z9KO0qluP+58I6Wytj/yS1pg0m84zQ3lP0xHpUvVRPSGh+n+cHeKfIXBJn9PSr0ou7duuwYztXmKjzf8NfDKZDO2G5G4S8MRLLbOgpi7Mnt0gsbzdgMwLLBaAXsq3kgC1wj6ABFNh1nXaWePqQ

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> As discussed in [PATCH] tidbits: net-udp: add server and client mode, 
> evl_net_solicit() is also needed for each client in server mode.
>
> I went for option 2, it is not to lazy and I did not find any way to
> ask evl if an ARP is already done.
>
> While testing, I also discovered that EINPROGRESS can appear after some
> time. I think this is due the kernel garbage-collects the ARP entry.

Correct, there is a timeout on ARP entries. You can make an entry
permanent and therefore not considered for garbage collection by passing
the EVL_NEIGH_PERMANENT flag to evl_net_solicit()

From the command line, the standard 'arp' command can be used to achieve
what you would do with evl_net_solicit() as well, since in-band updates
to the neighbour table are forwarded to evl.

-- 
Philippe.
