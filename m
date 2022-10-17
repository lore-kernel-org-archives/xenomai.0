Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C601510EA
	for <xenomai@lists.linux.dev>; Mon, 17 Oct 2022 07:11:49 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 9A600C9EE8
	for <xenomai@lists.linux.dev>; Mon, 17 Oct 2022 07:05:57 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 6F8601C0009;
	Mon, 17 Oct 2022 07:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1665990349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=st3oDPVgjo01JPxyo+L6PUgYQWa9Aq9Om7jZjXqsDEE=;
	b=KdEWxcOoo9L5wadC7lTPi6LJ0UUE0qd76Di6vTqIasjkg/+GnarphebbK1QCQKpogDD6ls
	9zPSNLPp6fvTDO0ryoQXn7UcdvHjuJmq2pyhUOKp2sLzUZvmGA9/2mS3tdd+MqLpXnbNCN
	17LLVQd0XEx5SbCcmy7T2vjkhn9Kk3toQdRucGok/RYBKff8eN+Kit0glVX+EBYowNI6JE
	JoT3g/6hs4joXOReP7WlwDXC+PEqJCviXBEzflS6Axy4scTXge7hMyHMaw9s5GCfn1xUcT
	aK13gWAGqVWWwC4lYSsK2JxY0nfU974dw+i45drPOmQnK57sRP77eDzOiNcxSg==
References: <20221017062827.2589013-1-johannes.kirchmair@sigmatek.at>
 <VE1PR08MB4909F06FC4CA8F02081EF97E92299@VE1PR08MB4909.eurprd08.prod.outlook.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH] fix oob_trap_unwind call in SME handler
Date: Mon, 17 Oct 2022 08:56:21 +0200
In-reply-to: <VE1PR08MB4909F06FC4CA8F02081EF97E92299@VE1PR08MB4909.eurprd08.prod.outlook.com>
Message-ID: <87sfjnaq0k.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Johannes Kirchmair <johannes.kirchmair@sigmatek.at> writes:

> Hello,
>
> I stumbled upon the fact that in the SME handler the calls for oob_trap_notify and oob_trap_unwind do not match.
> The fist has ARM64_TRAP_SME, the second ARM64_TRAP_SVE as an argument.
>
> I am not 100% sure if this is a problem. But I think it should be fixed.
>

Agreed, this is clearly unbalanced.

> This patch is for https://source.denx.de/Xenomai/linux-dovetail v5.19-dovetail-rebase
>

Merged to v6.0-{dovetail, evl}-rebase.

PS: I'm maintaining v5.10-{dovetail, evl}-rebase, v5.15-* and the
current kernel release, i.e. the latest SLTS, LTS and tip releases. If
anyone is interested in maintaining other version(s), please touch base
with me.

Thanks,

-- 
Philippe.
