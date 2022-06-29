Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E703237
	for <xenomai@lists.linux.dev>; Wed, 29 Jun 2022 15:16:07 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 8429A24000E
	for <xenomai@lists.linux.dev>; Wed, 29 Jun 2022 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1656515760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=zVriy7RUTCA2cPGtWistg3Q7IMuqODVaDwT+VmaNjfo=;
	b=JWrEXAjKNKWdw9OxxsP/Bg4ld3OSzo/D6NDnOXKUpWI8SiwAj9aYXe9Xcu7Kk5YPpFI528
	dD6aRECZyS1oPD5Jamz2JPeStwsIWxsnDvsUwc6WP5za5zUfPd7jXb4OTkppkZlmvSrPBy
	qvubHk4/006JdWPMT2XuzZnZvGmVnpYb/GRchGEo5Q4MeE1SWqvo9GD+zvxMNGPRBO9ohw
	JXvKUMssZSQ6WXvVjOTssJzAbA9oc8SxmUXUTV25DXmbiwDfxhBzrX+DOhThJOgLbCL7Dq
	T7/RmpiE27j5AitlmNUcKAMK/3a/hMRjv27/caDHtKiqEsFvtNavauu1JqsEvQ==
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Subject: Mailing list archive rehosting
Date: Wed, 29 Jun 2022 17:08:28 +0200
Message-ID: <87ilojv6ts.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


We have completed the migration of the Xenomai mailing list service to
kernel.org.

The list archive is now available from [1] (full contents since
2002). The former archive service at [2] will be shut down shortly.

Thanks,

[1] https://lore.kernel.org/xenomai/
[2] https://xenomai.org/pipermail/xenomai/

-- 
Philippe.
