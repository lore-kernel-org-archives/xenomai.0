Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2607D2F32
	for <xenomai@lists.linux.dev>; Sun,  1 Oct 2023 09:38:33 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id EA2BBCA102
	for <xenomai@lists.linux.dev>; Sun,  1 Oct 2023 09:28:51 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD79720002;
	Sun,  1 Oct 2023 09:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1696152524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u1EW+xuS6zA89IDb8t7PjkmfHlPyJrTv66FXSv+TILM=;
	b=HBVw5incBJ5w9XOeULv9+GQMqqNtJJmwL3QDPut5gt0lx2Qge1wj29g2/4S3z/09TEIJDd
	VRqc59u/u0ppydv8fdlckGMzNCp78g/Nj8+nRA9sk3W6wtCF89C1l4EfFw/xv8PbwTCIyY
	2u/ksBa61WNyf1Tx3FPZ/fP0aufRVlpoDz6GKOpBSA/biEzVrXYbM7ce09UtqVBCxnTAI+
	XSv6oKMLApLG0vUW0YR/uAb/HMA8MIsa1moeB5PycbPF15fNimLHAF2TbFF/SnfaEib5uK
	1Tp6X0x5pP4Eb5RXVvqxfvAtH+3D7GHq2XmegttNuGyHAQjBK1VdbpB3lhf/kQ==
References: <A25826ED-41FD-4738-9D5A-C379F4E00EED@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: YinJie LI <liyinjie0418@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] core/user-api: correct the api name
Date: Sun, 01 Oct 2023 11:27:55 +0200
In-reply-to: <A25826ED-41FD-4738-9D5A-C379F4E00EED@gmail.com>
Message-ID: <87cyxypu7t.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


YinJie LI <liyinjie0418@gmail.com> writes:

> Dear maintainers:
>
>
> An API name correct was found in the online documentation.
> Please help confirm.
>
>
> Signed-off-by: Yinjie Lee <liyinjie@sinsegye.com.cn>
> ---
> content/core/user-api/scheduling/_index.md | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/content/core/user-api/scheduling/_index.md b/content/core/user-api/scheduling/_index.md
> index 00a2b62..263f3c8 100644
> --- a/content/core/user-api/scheduling/_index.md
> +++ b/content/core/user-api/scheduling/_index.md
> @@ -13,7 +13,7 @@ module for a runnable thread in the following order:
> 1. [SCHED_FIFO]({{< relref "#SCHED_FIFO" >}}), which is the common
>     first-in, first-out real-time policy.
>
> -2. 
> +2.
>     [SCHED_RR]({{< relref "#SCHED_RR" >}}) round-robin policy
>     internally.
>
> @@ -404,7 +404,7 @@ A thread group is represented by a unique integer returned by the core
> upon creation, aka the _group identifier_.
>
> Creating a new thread group is achieved by calling
> -[evl_sched_contol()]({{% relref "#evl_control_sched" %}}). Some
> +[evl_control_sched()]({{% relref "#evl_control_sched" %}}). Some
> information including the new group identifier is returned in the
> ancillary `evl_sched_ctlinfo` structure passed to the request. The
> `evl_sched_ctlparams` control structure should be filled in as

Confirmed and merged, thanks.

-- 
Philippe.
