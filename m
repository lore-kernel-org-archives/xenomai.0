Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D537B
	for <xenomai@lists.linux.dev>; Sat, 18 Jun 2022 16:44:23 +0000 (UTC)
Received: from relay10.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::230])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C8449C525F
	for <xenomai@lists.linux.dev>; Sat, 18 Jun 2022 16:34:06 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id D4DDE240008
	for <xenomai@lists.linux.dev>; Sat, 18 Jun 2022 16:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1655570038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=oKfhqAPhVGgTBeEP3E5h6uAawB2x8uwnZij5efKMXPo=;
	b=P2TcTPEXbtvberYV2yd2oR1I9MqWjfr6Oc76qK/sNqvq24HnTCXwmK2OPVbxUfvAUHT9p7
	Z0nDXnRUqEVALXx2KRwG4SXoxhBr/BWAAZIMrOHevr5qjkiGxRz0VGQiJksj+JHboomTER
	fdWNazdOY/wyPyNfwFsTyIsUp/Dg9Y4pxWqOdSrdJuuxbmDTTCnUsRI6qA7nTEVOAwrYbL
	JWL0KTkmiSflhUYO4/QDedGammzyKrsEFaYG7iO34W5FgFx5woh0KxbgQl6vH9GxPcmAnu
	B+YT8apUIXO67fcdvXhYofu2bZcodLgYRsNp0VWQ7JYshjYCKV1OWsFcyp7nDA==
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Subject: Mailing list enabled
Date: Sat, 18 Jun 2022 18:11:31 +0200
Message-ID: <875yky6idl.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


The mailing list rehosting process is complete, welcome back.

Unlike I previously announced, it looks like keeping xenomai@xenomai.org
available for posting to this list via mail forwarding is not going to
be possible. So please switch to xenomai@lists.linux.dev for this
purpose, the information on the website has been updated accordingly.

Thanks,

-- 
Philippe.
