Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA422FF15B
	for <xenomai@lists.linux.dev>; Wed,  6 May 2026 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053264; cv=none; b=ZHZJDm9fASORhO6faGPErC3jse3w8+tdUIuBB3EcZyQY2n7OtKMLdYq5xQC5tIVla6TMQyaB03r5uSAGOL/OkwOSrfDc7pYgEH8PtMuubSv12SrQ3U/el+tA1A11JbzLTIsVgkDAlYeygcRQK37y19RJNd372ug5D7IoikCKiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053264; c=relaxed/simple;
	bh=m53RBzW9HKI4Ak55UrG2d7C3vGOJ/Kq5RPrbdfOGt6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nR7fTmz5KVDW68bNbY9QDOYw8mj+/ojkjMXOjIVBcZYLMzAfccQm8Q64pMloKaLH76YZ1v0t0pHEY8UMJGHx/L2oqOxhbAkfkQewFCh2LA4a2499N/1ZXyA6vVhriQH4vPIuHr0k1qZ5tvrMMLWv7SfFpI5exa7tpGNzRvZ0VSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=YBRmN/FO; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="YBRmN/FO"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 208E63EE88;
	Wed,  6 May 2026 07:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1778053259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CZFUz1bOGssynNSHPmtqafZIBbz0dNZgD5ATQpe+ClQ=;
	b=YBRmN/FOv9Bw1fa0tn3iP5cBh0V7CsjTEdtCoBIywZPEGWblJCNCbmslqrS4kdwL2aL8P/
	z3lNO7Uh+yMyW4NAKC+rXBTUMQwR/pSCtuiLmjRZFe8wHBe+I7kDHgJ+KKLdimBCdfWKBD
	Ikc8ZBX9T4AJYeRYDEGrKB+MCoYl2DP6RrXhxLp262F1HQ4Ji4xG9nMo40KuWn6X8s6t2y
	PsWq603mPA3GxSZFaRNO6IFJ7Iqxo4ZwTdn0cjpJDnwenbyCnJvoUHz5Ea1CzWNcPb8vGn
	SAe0b3DRVOiXPDkTZqf3WZlENPYgot0X0uriEn21SmlltRbyp3F5eC/YL4LdkA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jay Sridharan <jayasurya.sridharan@gmail.com>
Cc: Brandon Ho <brandonho667@gmail.com>,  brho@relativityspace.com,
  jsridharan@relativityspace.com,  xenomai@lists.linux.dev
Subject: Re: Minor page faults from memory compaction causing in-band
 transitions
In-Reply-To: <CAGNKwhBekLJqcrNi3u+ZMKrpqU-6X7_1DXJ7Grpz=R8FkYrjfg@mail.gmail.com>
	(Jay Sridharan's message of "Mon, 4 May 2026 10:52:04 -0700")
References: <CAGNKwhBekLJqcrNi3u+ZMKrpqU-6X7_1DXJ7Grpz=R8FkYrjfg@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 06 May 2026 09:40:52 +0200
Message-ID: <87ecjpj88r.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFIW2iXanMamrCLfjgR2uUTfE6Qq36cK5FkD/NZfcUmU80P8sFhAL5Wy6oJ7xMTIkxT1CzpXlp3y1JnGXKTck61lH0zEWp3VXl8Qepx02XpX9xLHwCdpiKlxCkt5qwEsn7f+mrZ2B6xsYJmhsxrbeDmqO7c+CSrkC1gqOFG9I2QJErwTDrIyD6GijQ2BdjH/jtr6ZJgGFkbN0xg/XjzWuLDE5pibbhhu4yLg5em6ZAOFeS6xs0LAk1x4LWxVXdWntbd1TnPIps2wFvyWXfLbuwwp4omnM10cqMVXhccizNwV4WJQ16GBguR3ddpukCKiIMcpGen2dnd95QjrNN+InwHec4m0mCkTB4S/uKUAhFHWgWBpo/CAoA43KrGPFirrFOZ03O6IVfob/JGz+6Xv5FzofG0NSZiCk5m3TT8Sd6s/lvGEg9EBrNcI7CjPTogmaVpxHQE75LQiLj5aw5FgeJ+uainiOs2cer3gt4uh+1AWJzLFPyJhZn+TccoiXPzgGSjTd8csWHQxhTsnfrYfy6Y0nhcPg2X7bHGcyaXe8DBO4lOgT00wwsn57ZQBhrz1IKIvxMVu7SMjtnc4G2sOQjkbgOinGjV24TCwGlm2Se9UXav2sobPAMRDc4CuA02gbenxIAEFJDOz8N9g26+gtez4yhIBS6vXSKzU47KjCKJ1w


Hi Jay,

Looks good to me, very useful for understanding some of the intricacies
of virtual memory management vs real-time workloads, and how to address
them. I would happily merge a commit with this information as-is.

[I noticed a couple of hiccups breaking the patch format likely due to
the MUA].

Jay Sridharan <jayasurya.sridharan@gmail.com> writes:

> Hi Phillipe,
>
> Let me know what you think of this patch for the docs:
>
> diff --git a/content/core/caveat.md b/content/core/caveat.md
> index b24e270..e11d605 100644
> --- a/content/core/caveat.md
> +++ b/content/core/caveat.md
> @@ -70,6 +70,68 @@ which depend on instrumenting the spinlock constructs (e.g.
>  `CONFIG_DEBUG_PREEMPT`), you may want to disable all the related kernel
>  options, starting with `CONFIG_SMP`.
>
> +### Memory compaction and page migration impact real-time behavior
> {#caveat-memory-compaction}

<line wrapped>

> +
> +- Launch EVL threads. At the end of initialization, but before
> calling mlockall..

<line wrapped>

-- 
Philippe.
