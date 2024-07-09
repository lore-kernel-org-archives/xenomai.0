Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777B19DF9D
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541531; cv=none; b=HeyJeInfDtL40rDvZGSq1njrz4UgHjQFdEVFaSkKn4e1g2Qws6FM+3K2gGN3+Ohm4EExakRfmQ9/UJDWyLFDk9eb+4K3Jm9JAnG6KUCya1AGrV0RuAHEOndzsA5Eez8SFuX7ZTPQggzm46jk3oEVWNelI+/dEr5EErLg2soGz3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541531; c=relaxed/simple;
	bh=bdr2qT8dXIMQzW8UpQDt+xj0CE8RfpiCusyBr+ezauc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QptZV1X0TrKCTerQkXprHm7gzkcdsULy5NYZDVTO0vFw5htUSnWEmIJh5t7OXv+MZ4i2bzj7YZ90v6KghbOVEt0UWtl9uKQpmb899+OGnRmtviZ6VVO3d94TavbVcXut538l9BR7wzmmzkdinEeEthBnx8Y7cD5NcOJ7Cg+HQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 8FF3F100002
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 16:12:06 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by spool.mail.gandi.net (Postfix) with ESMTPS id A6F97D8118F
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 16:12:05 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so69108891fa.3
        for <xenomai@xenomai.org>; Tue, 09 Jul 2024 09:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720541525; x=1721146325;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsIWQYEKaolfFFMWw/ERmv2bGC6pMaZYQtTE2piYdLc=;
        b=vPOYMPX3mNETqgzz/3jwU3kQh18BjibRwH8KrQ5uqLHlADamSVqHwBZX17HyG3kTi5
         RfXAYELia0hEXnQ/imY1GUDj4tPQ2sLQZ+cjyxy6mH6/Ri5A/oi+swfb/p0IqIrBWtj9
         n+r0dLHQ8wd+u6/n6/kVopXABR+foK6K9vqf+AztXE7GjR5qMJ7G80EAoMe75oleZ3RS
         iALf343Kxozlr4tqGMBrDS46rCHW7O4Ed2G9g39rV3SNENqx+J3oxrtrSoLKKHgk8zlp
         YCdIU2IcZhPyTM7iQ4fW7OivQRyQxBmZTcQwv0J+fsp5bVj4AuUNeXB8R6Z8bYCzMkqk
         iC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVh9Su5NFyDFyVB0Uc+UYpyEn6uy8pZDPiR+EzmHQCM/qFVPgivAauOozdv6X9Zh7losC4NmKhFG0anEkoIgbbwnPHq
X-Gm-Message-State: AOJu0YyHQfPoexgyrxxI6Vst8ZwEeQEwIS0U9tl/VGPxl3flvZs/2G60
	TMgV6OFFSTJppSz0vwz+xmgb1gwELjix7tHEdwQcvof7r3QBowz35pTzBw==
X-Google-Smtp-Source: AGHT+IHPX9X36QGSfxYcTjTYMkNkfx2AqLh7OdKjCpmDczSsdRU4PiwyIDLYf0cLXc9jBUmk4Zy8jQ==
X-Received: by 2002:a2e:880a:0:b0:2ee:7b7c:7f6e with SMTP id 38308e7fff4ca-2eeb31827camr20084721fa.39.1720541524463;
        Tue, 09 Jul 2024 09:12:04 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f74410esm46985865e9.47.2024.07.09.09.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 09:12:03 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>, xenomai@xenomai.org
Subject: Re: EVL documentations issues
In-Reply-To: <15bb47c2-cc47-f576-5d5e-652c43b9d2da@bela.io> (Giulio Moro's
	message of "Tue, 9 Jul 2024 10:51:18 -0500")
References: <7e4de8bf-c42c-7592-ee44-022d0e75fb68@bela.io>
	<15bb47c2-cc47-f576-5d5e-652c43b9d2da@bela.io>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 09 Jul 2024 18:11:54 +0200
Message-ID: <87v81eh7ed.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.208.172 as permitted sender) smtp.mailfrom=philippegerum@gmail.com;
	dmarc=none

Giulio Moro <giulio@bela.io> writes:

> Giulio Moro wrote on 09/07/2024 10:45:>
>> - there are several broken links. I found these with https://www.deadlinkchecker.com/ entering evlproject.org  as the starting page. I report the result  below for convenience, but the kast column "Source link text" is much more usable when viewed on the site as it is a clickable link to the page containing the broken link
>
> Here's a better plain-text version of the broken link report from the same source.  Last column "Linked From"  is the page that contains the broken link
>
> Error          	URL                                              	         Anchor Text	Linked From
> 404 Not Found	https://xenomai.org/documentation/xenomai-3/html/man1/latency/	Xenomai 3	https://evlproject.org/core/benchmarks/
> 404 Not Found	https://evlproject.org/core/benchmarks/(/core/runtime-settings/)	calibration settings	https://evlproject.org/core/benchmarks/
> 404 Not Found	https://docs.zephyrproject.org/latest/getting_started/installation_linux.html	Zephyr SDK	https://evlproject.org/core/benchmarks/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/revl/-/tags/0.4.0	0.4.0 [302 from https://git.xenomai.org/xenomai4/revl/-/tags/0.4.0]	https://evlproject.org/
> 404 Not Found	https://xenomai.org/documentation/xenomai-3/html/man1/latency/index.html	latency	https://evlproject.org/core/testing/
> 404 Not Found	https://xenomai.org/documentation/xenomai-3/html/man1/autotune/index.html	autotune	https://evlproject.org/core/testing/
> 404 Not Found	https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__core.html	Cobalt core	https://evlproject.org/overview/
> 404 Not Found	https://evlproject.org/core/user-api/io/_index.html	oob_read()	https://evlproject.org/core/user-api/function_index/
> 404 Not Found	https://evlproject.org/core/user-api/flags/(/core/abi-revs/)	ABI 33	https://evlproject.org/core/user-api/flags/
> 404 Not Found	https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm.html	RTDM	https://evlproject.org/core/oob-drivers/
> -1 Not found: The host name in the certificate is invalid or does not match	https://rtai.org/	RTAI [302 from http://rtai.org/]	https://evlproject.org/core/
> 404 Not Found	https://man7.org/linux/man-pages/man3/clock_nanosleep.3.html	clock_nanosleep(3) [301 from http://man7.org/linux/man-pages/man3/clock_nanosleep.3.html]	https://evlproject.org/core/user-api/clock/
> 404 Not Found	https://man7.org/linux/man-pages/man2/fcntl.2.html)	http://man7.org/linux/man-pages/man2/fcntl.2.html) [301 from http://man7.org/linux/man-pages/man2/fcntl.2.html)]	https://evlproject.org/core/user-api/poll/
> 404 Not Found	https://www.kernel.org/doc/html/latest/core-api/genericirq.html)	https://www.kernel.org/doc/html/latest/core-api/genericirq.html)	https://evlproject.org/core/kernel-api/interrupts/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/libevl/-/tags/r41	libevl r41 [302 from https://git.xenomai.org/xenomai4/libevl/-/tags/r41]	https://evlproject.org/core/user-api/api-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/7af18f8a38ad68f581cf770819ccb98c29f41586	20 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/7af18f8a38ad68f581cf770819ccb98c29f41586]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/41dc88ab524cd32878646d98b57d390e2bcc1198	26 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/41dc88ab524cd32878646d98b57d390e2bcc1198]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/libevl/-/tags/r40	r40 [302 from https://git.xenomai.org/xenomai4/libevl/-/tags/r40]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/87ee9586fa60	17 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/87ee9586fa60]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/231089ed6028	16 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/231089ed6028]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/6b8a2319c02d	15 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/6b8a2319c02d]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/3d4ff940c1d3	14 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/3d4ff940c1d3]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/a142e2e027dc	19 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/a142e2e027dc]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/b8351b703ffb	18 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/b8351b703ffb]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/b81555f4f48b	1 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/b81555f4f48b]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/cfab80b242c4	0 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/cfab80b242c4]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/f6f6e58cbaff	9 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/f6f6e58cbaff]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/9397204d7484	8 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/9397204d7484]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/c1a5ca6a70e7	7 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/c1a5ca6a70e7]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/bc92ac9d3b90	6 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/bc92ac9d3b90]	https://evlproject.org/core/abi-revs/
> 404 Not Found	http://nanopi.io/nanopi-neo.html/	AllWinner H3 (NanoPI NEO)	https://evlproject.org/ports/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/d9b664b5ecdb	5 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/d9b664b5ecdb]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/57ce409e23e6	4 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/57ce409e23e6]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/c1417f3dbe4f	3 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/c1417f3dbe4f]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/3af3b43bdf20	2 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/3af3b43bdf20]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/a2ba90db409a	13 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/a2ba90db409a]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/0b5a64ead6f6	12 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/0b5a64ead6f6]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/b7c6e2276983	11 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/b7c6e2276983]	https://evlproject.org/core/abi-revs/
> 404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/8245a892b9ec	10 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/8245a892b9ec]	https://evlproject.org/core/abi-revs/

Thanks for the heads up. Fixing in progress.

-- 
Philippe.
