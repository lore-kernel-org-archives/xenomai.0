Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D2D23CF
	for <xenomai@lists.linux.dev>; Sun,  3 Jul 2022 14:09:39 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 300C7C68C6
	for <xenomai@lists.linux.dev>; Sun,  3 Jul 2022 14:05:29 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 1A14E60002;
	Sun,  3 Jul 2022 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1656857121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMvCaYiZZUlDG+dRL3pUDFZVWd8xBLgMJ9KDxIuOn9g=;
	b=Lw0w81ti966qgOVo7teSiy9AvHLC07G+5lAk+boLWcphXDlEYQ8sDF3TNG9+ed686qbnE2
	2SlFdgvqcEZeF+cBAoStNdtEJvYzVfVzzQNfj3VtKP48Bv3qi8GE7V1ALtE1l6fvQ3NzC0
	AgutGJvnjbGM3JZjbk9eJU7I98nApG0fSM+bzIs9PoDKHlPufTgQc3fHyESUmd05wJwAcK
	zLh2x6uSjgao+z7fME+tUPpu7DSJkCbhuwqq+R+BkqOCN2lFCIVUffL8cY586wXg8AfjZF
	JVQx5hM3wChYIcCSyX7UjFg0JA2VoGWUEZmxRRBRGa7zBtx2NGAuLEMXzcRyCg==
References: <88b02fec-830d-24aa-ae41-bab5031dafed@siemens.com>
 <2307b8d0-e901-2642-6d19-bf1dca91f015@siemens.com>
 <ff6f30d3-ae56-3d13-efb8-6d51ca231ca5@siemens.com>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: 5.15-dovetail or mainline regression?
Date: Sun, 03 Jul 2022 16:05:13 +0200
In-reply-to: <ff6f30d3-ae56-3d13-efb8-6d51ca231ca5@siemens.com>
Message-ID: <87wncuthpb.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 21.06.22 08:47, Jan Kiszka wrote:
>> On 21.06.22 08:10, Jan Kiszka wrote:
>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/452968 (qemu-arm64) 
>>>
>>> 2022-06-20T23:57:39 [    0.337643] printk: console [ttyAMA0] enabled
>>> 2022-06-20T23:57:39 [    0.349807] Unable to handle kernel paging request at virtual address ffff80003675c000
>>> ...
>>> 2022-06-20T23:57:39 [    0.359334] Call trace:
>>> 2022-06-20T23:57:39 [    0.359508]  locked_inode_to_wb_and_lock_list+0x60/0x180
>>> 2022-06-20T23:57:39 [    0.359577]  __mark_inode_dirty+0x2e0/0x430
>>> 2022-06-20T23:57:39 [    0.359603]  simple_setattr+0x50/0x80
>>> 2022-06-20T23:57:39 [    0.359617]  notify_change+0x37c/0x3f0
>>> 2022-06-20T23:57:39 [    0.359636]  handle_create+0x1b0/0x21c
>>> 2022-06-20T23:57:39 [    0.359669]  devtmpfsd+0x80/0xd0
>>> 2022-06-20T23:57:39 [    0.359688]  kthread+0x150/0x160
>>> 2022-06-20T23:57:39 [    0.359707]  ret_from_fork+0x10/0x20
>>> 2022-06-20T23:57:39 [    0.360029] Code: 11000421 b90012a1 d538d081 8b010000 (c85f7c03) 
>>> 2022-06-20T23:57:39 [    0.369411] ---[ end trace 91ca49b5035e8050 ]---
>>>
>>> Hitting retry now to see if it sticks. The real arm64 target was stuck 
>>> in u-boot (tftp), so I cannot tell yet if it is only a side-effect of 
>>> emulation.
>>>
>> 
>> The issue with QEMU sticks:
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/453115
>> 
>> But now CI is failing in the infrastructure, so I can't retest on hikey.
>> 
>
> Mainline stable regression of
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=bafbc134f5b0948aa1ca015a0dff70b02c0152b7
> (5.15.47), fixed by
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=ca67881dcef04c5b586a3b122307b183babd62dc
> (5.15.49).
>
> Philippe, could you refresh v5.15.y-dovetail-rebase to consume this and
> fix our CI again?
>

Should be ok by now.

-- 
Philippe.
