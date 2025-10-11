Received: from common.ash.relay.mailchannels.net (common.ash.relay.mailchannels.net [23.83.222.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F3217F56
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760212022; cv=pass; b=YohFR60bGnb6MTXWFqh4kpQk6176w6RTmCaELew/qrAm0swihR2FqdHOlxD/70x8EomeYICpSEeaY6WpGusrXcDFh6YluDyFnQ7c8XDqft1eYyyiTWd/Yr0ufVR2oPGivsbu4Vake4rAfCTT1diXuQen7IPvLkJOBFyGKeYOb3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760212022; c=relaxed/simple;
	bh=I1+MR6quoZfpWo4apR2ZuQiTZk2Jmbzc3rXtG5a3Aoc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RhRIIAff4geCLXVzBynkp8Lf0Ubjg0YqNUvJ3GUMTVPFnEaTl0ig1OWvref0e5+yIwcrCEaf3qVEfGKrmPaqZucAkeVzwjSxCaQjHdgftxEU2Dn6bL4nS2UmR6aWtLX6cBYXVUnW2dEQKgSf8bRX8LYepwCidPn+cvsyG8zjw4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=I/LqtnB6; arc=pass smtp.client-ip=23.83.222.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="I/LqtnB6"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C5C806A0A52;
	Sat, 11 Oct 2025 19:46:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a267.dreamhost.com (100-113-91-17.trex-nlb.outbound.svc.cluster.local [100.113.91.17])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9AE736A0506;
	Sat, 11 Oct 2025 19:46:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1760212018; a=rsa-sha256;
	cv=none;
	b=uDz6q89Ho8dm3xGU3rRqo9KUK5Wgac6irM7VI6tx17yRv/A8OlElQ94u+oYZ79WRqTuGA0
	KWaQFjNZhpnHE7GHWERR1FwCsS3AJYzTPUeaPwO03pQ/Zq8kS4JYrwgWb2a8Ep8xLs+DGg
	RN1aevNBXA34i+XDtkFB6Tno/jUVjyG2a7YdwX79cCHrRvHvMyO2lNfX3uA4PdofuQDSIN
	5Ht5aekXPmHJ6lCRPCpIkdG1T86WorXk33lZu+dHue+KP3XTJ8//DTPkFKEX3YW479yGeH
	V7TtWX+xexBqt2imQE+etyES7gAhcLQr6W4kudDaMvfOhKb3EIXbSM1NzZ5hqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1760212018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=I1+MR6quoZfpWo4apR2ZuQiTZk2Jmbzc3rXtG5a3Aoc=;
	b=Uninw6rLo1MmT40x9xa4wz7pwH+qDBVGcirO9rXNCwONmyeBC4meT7lhvL+JZRH/tKqDvC
	HN+g512OLHfpoBOgmz9lDdU+e8dp+bJAoW2o3yfncnad7VOW3tlfHSNwh/RuuUMMuJlUiM
	VCKCOScRwTwwZGOX5A2bKCYa0zkuxdPy+WV+fIMhslZJMUtBmS6tWSbevEgpD3zIzT+o3B
	S2CQuG8KBKwmGTHbGzgYhFpF3Zihz54K+d///HJM+LH5g337X9myRNMSt7TXiUCzTfzhKa
	CJh6rpSoD7Mm+ofURFDBXSluS6v34a370y1eSMzqT05jeKqNdRhPfOmdN9FYEA==
ARC-Authentication-Results: i=1;
	rspamd-777888ddf6-fmdsr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Invention: 7b9593c7705bb424_1760212018668_1826334219
X-MC-Loop-Signature: 1760212018668:2155752650
X-MC-Ingress-Time: 1760212018668
Received: from pdx1-sub0-mail-a267.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.91.17 (trex/7.1.3);
	Sat, 11 Oct 2025 19:46:58 +0000
Received: from giulios-MacBook-Pro.local (unknown [191.98.11.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a267.dreamhost.com (Postfix) with ESMTPSA id 4ckYz6076kzJX;
	Sat, 11 Oct 2025 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1760212018;
	bh=I1+MR6quoZfpWo4apR2ZuQiTZk2Jmbzc3rXtG5a3Aoc=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=I/LqtnB69BRAlcJu2YLYvDTgorNkKKjhLywohkCnb7vIyEDigZvHU895Wm7hiidyb
	 ygPL/wRYNK4snO+R02OGqolFNVeSNVRtao2Xdz7z/+0No/rh54S6aUFnDyI5dMcUQg
	 DNYdAn7vPcPc+sdenqB9vpyagZJ80m7xEVeVCkwL0zN+eiWP81++psGwc9ZLOZnuC0
	 6dT7zBKQJ6OIyIPTNUjv6Hi0WypvZ8kP1dlbqDIvWqdozikDObhale2s9VYybfkcb3
	 owO+hKbiUz8iWVSTR+Zvgxu00CyIcrTBSh9xueG7DZdy0kDplReF+nbAEi5BRWnnl9
	 5QX9UksNsvWCg==
Subject: Re: Unexpected switches to in-band
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
 <20251009151737.0d03b211@wsk> <20676160-4572-d92d-4b33-ff4255946345@bela.io>
 <87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
 <f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io> <874is5s6kw.fsf@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Message-ID: <be366ae4-b0c3-d6b5-25f2-813424f47c3c@bela.io>
Date: Sat, 11 Oct 2025 14:46:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <874is5s6kw.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Quick check: does "evl check" run without any output (as expected)?

Yes

Further update: tested v6.16-evl-rebase and it seems to have the same in-band switching issue. So far the only good one was v6.1.y-cip-evl-rebase.

> Meanwhile, I've been trying to reproduce on x86 and armv8 (odroid c4) using the posted recipe, no luck so far.

Thanks for giving it a try. Wanna have a look at/try my config? https://github.com/giuliomoro/linux/blob/v6.12.y-evl-rebase/.config
