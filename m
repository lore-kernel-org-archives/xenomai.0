Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17407237707
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612233; cv=pass; b=Onb9czdQhf33NV7I6xRE4+Gc8Qu9+OoegT7Dd3zYjP0+GDdwuXDE08LrDUy4gQT/YEVJrPGvhf66DPSICYCpHT+HsjQc1TvMQpKppsV6DmdtLL50kPjc1NjszwLWKHe2mnyvfvAqTKNIBA/Mp74DuNCOo2Ht5rr0gdZ9XA4ltN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612233; c=relaxed/simple;
	bh=rs+rK54bnvlYWPw+tZ8O8XlQ9SxCmPJ95KBvgW1J8Io=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=T1fCYl1yj+n4tQYbUoHOE8tlJoRlIGXfhnu0pIDPiyaeBnnePjtmbwMApP9JKva7/p8ApoN6hyQm0FpHwVGm0gOJbuyORrqe0qI9V+PAN7ijtc6eFxaTgCZQXdRTj3cFpBg0NOTWc6L5eYKaPNnWpQ79mGIk0DgE6KtnBvssBaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=uHvcyogy; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="uHvcyogy"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8986E5630AE
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 18:14:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.101.114.146])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E2927561D99
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 18:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771611252;
	b=pZdMOtHwqQTaX9pKTjHCz+v7NlfZRJA4wh1Jp0yoeMQDkuCWsoDBwdQB6IQGt/rxG8eiFO
	QTFrLPyfUvjNhtTWqnZwHvj2Ju80QjFUnOI4QnJpZCZhDuDZwPI/EQ9M3Umu1jvnPMwn9E
	rva9rwnCyMEKJWxReIxkODMgO0jvy/bCXarDRnXt2OJVf2I3q11VU+P3GTtojw6qk4zxtw
	YSg/cYTHlb10Fdg4CHoh+uDoa5Gq4H7FY1VeT4/M/S0YLxiD/AK/wRTYk+5H7cAazB3l8u
	vfdusljQQ/RZEJzf4qz6BohyuJ45ugqMUzEk4lK4JeAetuNqQ+KvN+YeIa2iNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771611252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=rs+rK54bnvlYWPw+tZ8O8XlQ9SxCmPJ95KBvgW1J8Io=;
	b=MOg7gKZ10SKmf0XW7d1TGqHrRzrzE0B3Yi9pUjy+WlaVp+kxwyXqL0LCz+TldyKzwvqcNi
	2Hsetfw2+sOkPrkQUlMYaYhVKM88eru1gUf3f3eamE4dQ49VXP+q1O6rcRfGDZC/9o08/F
	hAaBrmkdAstlxmp7KHRz92mzQsmPhRT56aDivb2o8WVcW8LXK1MJFoNqpHviIdNPZdOQT5
	OTBa7+Bbh+q9t3LZHJUGAb5IYuNp2TKTgTGGPFetKEE9za/QcC3ghryI/aLnv49jgJxJxl
	NPsHgA04g4bxt1kcZTDEMpjWhpEXeZnD9MWz/+I9PjRj0tIjcX5VFSD8aOOGuQ==
ARC-Authentication-Results: i=1;
	rspamd-84c84ff4fc-rl9rh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Chief: 05aa33ca3a721234_1771611253214_721725233
X-MC-Loop-Signature: 1771611253214:3237343809
X-MC-Ingress-Time: 1771611253213
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.114.146 (trex/7.1.3);
	Fri, 20 Feb 2026 18:14:13 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.170.59.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4fHdg83Mpbz107J
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 10:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1771611252;
	bh=rs+rK54bnvlYWPw+tZ8O8XlQ9SxCmPJ95KBvgW1J8Io=;
	h=To:From:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=uHvcyogyEDT4BguIb4pAlZxAM62bCY61dX2sMcmF2oQSuDWdBxmRNk0/nKKptzrtI
	 4t4tXaB6n/oyxRkM1tuKo4/lTkr3skYz4lwQPqS8KE8AAyIVCqopwTWZz0W8v5gmEE
	 ArEk3UMuZqd3LnH38OMpJcmzZcWT6Zw4WmRCop6dZZy9Wwi7K/BAh7Ilma9qHUTbdR
	 +7WLTUf+SmteHQuPjoBWIAhQj5xm+8m4hOSoiXvVAqaBPCBupJQjWVcpTRKYvxpVVh
	 gi3iOQflgyDNuiPJIuDJkN3M60zJQi1HGWUkM4dSJ9G6wLOhugKEyTR3bVfZ/4I+yp
	 YAiEKehXuQIpw==
To: Xenomai <xenomai@lists.linux.dev>
From: Giulio Moro <giulio@bela.io>
Subject: evl ps format output issues
Message-ID: <819e7e8f-59b8-621e-6e68-6bff28cbcd18@bela.io>
Date: Fri, 20 Feb 2026 13:14:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.8; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,
when running evl ps -st there are some formatting issues that affect its machine-parseability:

- the STAT column often is empty (I know this could be obviated by using `-n`)
- if PID has 6 digits, then it will touch the ISW column and other columns also seem at risk of overflowing (very much a possibility for CTXSW, SYS and long running programs).

The above issues make it hard to use `/ +/` without manually fixing things up to split evl ps's output.

I suggest the following:
- reduce the width of all fields (not already starting with whitespace) by 1, prepending each with a space. This ensures that / +/ splitting works.
- change format_state() so that it always returns a non-empty string

If these changes seem reasonable, I'd be happy to provide a patch.

Best,
Giulio

