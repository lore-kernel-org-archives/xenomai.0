Received: from dragonfly.birch.relay.mailchannels.net (dragonfly.birch.relay.mailchannels.net [23.83.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231641B808
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760156720; cv=pass; b=grxvQ+FAIa1s9OjX0LtsO4T/F9KlaH2DCKT4A/qS8iUxfMOvmEyEneYkupvlEP+hnyhoeSqydpGoZuiDZc63xNolaJ492NIxRSl/30/Q5DdXtU57tjzSOTq4DMOA2UerC3At7w7mAc6V4ISx+LPc2YnkgXpCj9atdKU+0T3lxiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760156720; c=relaxed/simple;
	bh=MEsGHxCmHaaKwklMTGOIOvoJ8LudD16x53NjhSeOVkc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NFMqLcJy97KBXxwpevyu/g7CFYQugcMeHNicXee7+/pmIqAI6Hjivmf4xydy46Jd5nLDENS5dwMgi0ZW7tqeHLLoOV159I1SES6J1lsDZlmytJicXIBONGZTdTM6/Btx1lHb/d6Il2BKVuVL6p1+ORj+2CGWZ8oVjnvhaugSDPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=yICHEpIW; arc=pass smtp.client-ip=23.83.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="yICHEpIW"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A632A861CD2;
	Sat, 11 Oct 2025 04:25:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a401.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.113.157.12])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B8CF7861DAD;
	Sat, 11 Oct 2025 04:25:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1760156711; a=rsa-sha256;
	cv=none;
	b=SCS9yZwBog2QOnY2TUzLmuHcGJ1RejUBNjm8XoKpLjDEUCBbcqVGC5Ndh7K9hhlfxJ2l7+
	T1sP4p7mwVIHHwTADRMXz2aVMTqDw14IbKY++8vHnmcY8tvzdjddwVW9N5xk+ojjgEZSwZ
	ndNs4iIN07XEN2mkmczB5Qv/oPUokroDbKS/mgZ606T9QqfEQQRG5fNdiDmFRShZY8rog+
	D3+gnKiBQ9Yz9mlCaubuefVi7zDIiM/VhjxbVe7y8GDktyC9bcK+jdtibum/+WSMnrtBPw
	PqxoRciGMIOYN+hDxs3pG2oadk1XorsqUt5oQlGoP8TZN7kiYFL6XlK3NYchQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1760156711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MEsGHxCmHaaKwklMTGOIOvoJ8LudD16x53NjhSeOVkc=;
	b=s+wCOw7N6RoYnjZhUUT588g3y8huLdickEVIM8klKWF27OA3I1CcrvTsQ21ImKKglin93e
	MYJmHV2ZlG0BWqnVL8FmCBOq/qrZuChv+3avw6YyaJ8EvoWwYzetSpJr1LJhnISrOsAOUq
	MveXvB4pfFGWH6fYRRU0L+gvY3bUjKpwOkH6T5QZHfCDKkLYcAQB/DPCjwWAfBn5HPZaQh
	wDEY+XCDU582C7fECwPOGyNKrjDU3CrW1reCiKc1iOyyWrDsUfQJx4JS3FPM20J6QtSN1N
	lAzArqpc2adX5LOoJFWU28t400t6VtoS+UMaaHX5oMGdiuxFldc710yIfxzkUw==
ARC-Authentication-Results: i=1;
	rspamd-668c7f7ff9-hxbx6;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Arithmetic: 56c3dacc723c32dc_1760156711521_2495311495
X-MC-Loop-Signature: 1760156711521:2705334716
X-MC-Ingress-Time: 1760156711521
Received: from pdx1-sub0-mail-a401.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.157.12 (trex/7.1.3);
	Sat, 11 Oct 2025 04:25:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1760156710;
	bh=MEsGHxCmHaaKwklMTGOIOvoJ8LudD16x53NjhSeOVkc=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=yICHEpIWw9XqAf6Qy9IHf8rXfxqokt9860tGbB9ga0Mm/Vs5RRXtHV8hJU/dRbutA
	 rgSCx9WP+KAAsKZFKh+UE6UWJolpxxnf3It73pe/B/D3rt+I8V3OP4Nmkcz6hl1cJ6
	 d1BCb3x3odsJJ+xZCo4N948yj2DG3ir2wU0EoBhp+6EMFU1bUkoMRiMOctTZjad3mt
	 yY8mL9uKPwzaHVEUxxgFHI+F0I+zMX9LKe1pmilR/j+fJom20EUeui9TfhD6VrI4QZ
	 2WFep0qjIYT/B7tfc9cjwutgmnXT0xk3Oo0i5edRGiUZm34rK5G8l9CK2KDS16IJKg
	 rttNZyZEUqguQ==
Received: from giulios-MacBook-Pro.local (unknown [191.98.11.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a401.dreamhost.com (Postfix) with ESMTPSA id 4ck9WT6yNdz2wMq;
	Fri, 10 Oct 2025 21:25:09 -0700 (PDT)
Subject: Re: Unexpected switches to in-band
To: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@nabladev.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
 <20251009151737.0d03b211@wsk> <20676160-4572-d92d-4b33-ff4255946345@bela.io>
 <20251010122427.54ebb9ac@wsk> <a3af644a-f056-2b99-7671-461681962a0e@bela.io>
 <20251010150805.36a2b683@wsk>
From: Giulio Moro <giulio@bela.io>
Message-ID: <978c36d8-1ea6-748b-05c6-81bbfef4b7db@bela.io>
Date: Fri, 10 Oct 2025 23:25:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251010150805.36a2b683@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've tried the same base kernel using cobalt v3.3.1 + dovetail instead of evl+dovetail and the issues are pretty similar, both when using `latency` and our application. Is there a modern-ish ipipe patch anywhere? I do not see it in the current documentation ...
Best,
Giulio
