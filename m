Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42BF1AE0AC
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542074; cv=pass; b=LkrBKZRLxHFfcc/RD5OU6SYT8lCwWs3MTLmKV/cYzvW5Eyn2fNrS9a6pNVCiCO3kegDlXeIRkDxfHvY/917sVTBknWjznZqMxvntH+BercDlKqBZyE4wPg5Gi2YhlyzrTxsCmcKQhQabS8CZgpeFKFdoFEyQBQ5cfL0kRNNkHn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542074; c=relaxed/simple;
	bh=hVO50rBE2gVAV93anPuI/Q1E8wqPJYFmN1ZWjDY82oo=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=q/tDL2AY+atkpGvV+JaiUidR+NAnJO8CEGEmwxoA4jHEiNGJJ8LddyUuD+/XTnUZ6Yz0RTPpmUUQdyJFPNs9zFZhwPI7uctP0d8qn7/dq/cvtqu6eZKa00jfr64Sh1pxq+jrGn6GtMtOJII4svDQrsaYJqUukuPvhU0Q/WvClqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=pesPTWRd; arc=pass smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="pesPTWRd"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id E990E240002
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 16:21:09 +0000 (UTC)
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by spool.mail.gandi.net (Postfix) with ESMTPS id E04637803CE
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 16:21:05 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0699E2C25DB
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 16:21:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a308.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 78C7B2C2A07
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 16:21:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1720542063; a=rsa-sha256;
	cv=none;
	b=1qkgrr9qIcoRKopuZY36+uzCSzpootTKJ2dUG9fgh2vEdwZoDvKBn0XXX3FlRr17cXqZBW
	YIFDx1jybG48B9PzXDyqJiGFieRvnw3uOrWwiYwB8Ac1FleAlRYM8m5ltUdjvhx7mCaJv5
	qXR5VayQ1nQuI18ujYEJIaOwEWUHere432Db+uJdJI8oH9MdLh6aOYNNf1siH1PtzQiiWG
	K8jmnziZlhl005ScapzOtRq/H2HqmNqjPCsCtDGQbSPorO7AWX/BoxnQohaob9enVzCde2
	4/0jkMG7rsMb0sP/GlicekrCO7dsjrNkJ65vvT3Olf/W5qUPruEmt/CaTQG0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1720542063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=MZ6zmfpCl0oOeXjBn0/AyfL61B9o6LZLpIlZBOQbD2w=;
	b=Q6VOFJukbdkCWDYXinoLRv1ARmlD4O+d3z5aDGUE+LySp3zgKzSn/7/hslz9DLoxv57nOC
	VZWaBr6qSLEnWSlkW2lThKJhHPSalrESAhfKSs6I+VPYK29nKSLWynAOvq3eVC8UiRgs46
	Q+a955hch2Iq8DKhwdbnGdXbU5Ph9g488hRsRnL9z++lM8Jw/qEu3vwGn8r74zVgZi2ZDJ
	zs0K1qicHayJPoCSAYl00vbOKd8rLAGQqIPfwPpu0lrYXSeZeFeNLIOTk+wJRYuEauH416
	BKn+KagIXRJlaCtkxW0h5XGU1lW/wZC4FJbzNgJOs+izwlDzGBaIs6dZ2RwQdg==
ARC-Authentication-Results: i=1;
	rspamd-6db77b4858-s2xjv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Troubled-Thoughtful: 5183597e6458ed35_1720542063864_2025427576
X-MC-Loop-Signature: 1720542063864:2312368879
X-MC-Ingress-Time: 1720542063864
Received: from pdx1-sub0-mail-a308.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.138.214 (trex/6.9.2);
	Tue, 09 Jul 2024 16:21:03 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.99.138.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a308.dreamhost.com (Postfix) with ESMTPSA id 4WJR7M0RnHz9f
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1720542063;
	bh=MZ6zmfpCl0oOeXjBn0/AyfL61B9o6LZLpIlZBOQbD2w=;
	h=To:From:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=pesPTWRdKfbURLNF6NPd2NsaTxZ3XH4htTVWdx4aOixscPsze04W94eBWQjixaT5n
	 ezCw//4uvON0SgNLje+HUCVidGkRSRY2zd52mQN3l7t4yk0LpYI+Msk+h7CPrDJhfs
	 EWNlMgejJEiO92kDs7CH9Xe18FpX9DsX65Sshxlz2l27zEQZKXo5o7S2OPK6JwqYm2
	 uRQovuPGw12NjzsD0CncLa75Z0x0yAHOAkjhz0knrj9qKImlrOPyJkQgFqevglFVXw
	 /wCRoLkNFGPYuDDg9tNeebZNvqJEeQaBTJ0iTk0hrsNl9bib8JvCD0t4+bWGSBajph
	 s9WMQsju2LC+w==
To: Xenomai <xenomai@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Subject: [EVL] xbuf preserving message boundaries
Message-ID: <63f65db0-f9e9-c720-940a-dd6276f93076@bela.io>
Date: Tue, 9 Jul 2024 11:21:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:91.0)
 Gecko/20100101 Firefox/91.0 SeaMonkey/2.53.18
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=bela.io header.s=dreamhost header.b=pesPTWRd;
	arc=pass ("mailchannels.net:s=arc-2022:i=1");
	dmarc=pass (policy=quarantine) header.from=bela.io;
	spf=pass (spool.mail.gandi.net: domain of giulio@bela.io designates 23.83.212.17 as permitted sender) smtp.mailfrom=giulio@bela.io

(is this the right list? or should xenomai@lists.linux.dev be used instead?)

This page https://evlproject.org/core/user-api/xbuf/index.html states
> A cross-buffer can be used for transferring fixed-size or variable-size data, supports message-based and byte-oriented streams.

However further down it says:
> If you plan to send fixed-size messages through a cross-buffer and keeping the message boundaries intact matters, you should pick a buffer size which is a multiple of the basic message size, reading and writing complete messages at each transfer.

Is keeping message boundaries possible only with messages of a known size (i.e.: it is not actually implemented and it's down to the user to do that)? Or is it possible to preserve message boundaries for arbitrary sizes? I am interested in achieving a behaviour similar to what was available on Xenomai3 via the  socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP) call.

Thanks,
Giulio

