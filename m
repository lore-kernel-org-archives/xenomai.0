Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DDA3B14B8
	for <xenomai@lists.linux.dev>; Thu, 16 Jul 2026 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186861; cv=none; b=Xs7rj2AGdyDRqTqTR+MPfR3XTc2W31ZCMNwII0kBENioro/B9xfc5GEAFcYOAkTNbw0yqOAsT5r+xkCGKsCZBfLsFP6h9HU2Kr2VJYrQLil0fGow4EU/Veexg6cf1iJWlze3Q2168qNipFss0I+cD8ZdEcGs9uyljcDH0BPoCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186861; c=relaxed/simple;
	bh=pXdgW78bmqZKUbGC4PNyEfAf5MxRb1e43hmBd9qPbEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=riyoFkfs2k/DxM3DAvpB/yp8jEt7aMzBbrohPycSv+FEoLA8fJj/CPb7Pnasm+/20S/OKxSlvs4zVaffxWDjnMaY6cYalp7kzePFK9WA4varAx3V4PMb8iu/trwQTcpr5OCWnut99DXDtoJqfIOoWQ8t9rneSfx2gXRa80UmfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LE/jN49x; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LE/jN49x"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260716072722d655d1fa8b0002078e
        for <xenomai@lists.linux.dev>;
        Thu, 16 Jul 2026 09:27:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=K5gZBzShAxAgsLnzh1A+ZWRzp1YvW5z+XKIZizJZuBE=;
 b=LE/jN49xzkNZ9JdrKFbjcKgc6Iy6Bdm/hJEq66bDNtO93xZxLljVilc4U0mK0dB72hD74E
 5a6UvTg011BoghT3Y8Dfs33p0iGRFMfGZMkZea+0TfTswBhTMC619D4W8TShPik9uPebWNBC
 Mi4sDNpVkmGBAfbt2I2H+TYzVu0kNWxXPjZ1UUxGh+fIp7uPR/chNYSv5bI50QnQUfuDEvXT
 TTOC+BO52B/9taNohGt2F7JFmlQIGKehE/LimAEAfZkVXhGgsn3NUN/jcA0cP/IowMd+M5V7
 tYupH1kFpgZix3sec6Fy2ZmlDcx2DrOz3elHKyrGnC6/kwlF6iEbsasw==;
Message-ID: <feebd79f4099b3e917b0e094a1342444fe0093f1.camel@siemens.com>
Subject: Re: [PATCH v2] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: linz <powertree@163.com>
Cc: Philippe Gerum <rpm@xenomai.org>, "jan.kiszka@siemens.com"
	 <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Thu, 16 Jul 2026 09:27:22 +0200
In-Reply-To: <55bf6b7f.363a.19f5eb8aece.Coremail.powertree@163.com>
References: <517534d7.8863.19efe1f45f1.Coremail.powertree@163.com>
	 <ad8e6855-2d67-49a4-9a52-9819b93b1802@siemens.com>
	 <023fa6882b563713cbcc06bd954c8e9db4200d73.camel@siemens.com>
	 <c017bc0.9041.19f5afdb56f.Coremail.powertree@163.com>
	 <6ca12451-a015-4b54-9e22-0256e97d834e@siemens.com>
	 <55bf6b7f.363a.19f5eb8aece.Coremail.powertree@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2026-07-14 at 11:43 +0800, linz wrote:
> Thank you for your feedback

Welcome, but that shoudn't be part of the patch description.

>=20
> Under 6.6.63-dovetail2 environment, raw_spinlock_t for the ITS node lock =
triggers out=E2=80=91of=E2=80=91band context warning in irq=E2=80=91pipelin=
e code.
> As suggested by Florian, hybrid_spinlock_t should be limited to struct ir=
q_desc and irqchip internals. ITS node lock is more suitable to use hard_sp=
inlock_t.
>=20
> After replacing raw_spinlock_t with hard_spinlock_t, the call=E2=80=91tra=
ce warning disappears and system runs stably.

Which warning? That should be part of the problem description here.
(I know that it was part of some previous report/patch)

>=20
> In addition, the gic=E2=80=91v3 irqchip already has IRQCHIP_PIPELINE_SAFE=
 flag, while its_irq_chip lacks this flag.
> Enabling IRQCHIP_PIPELINE_SAFE for its_irq_chip has no effect to resolve =
the warning.

To my understanding gic-v3-its is kind of an extension to the gic-v3, so
that gic-v3-its doesn't need to be flagged with IRQCHIP_PIPELINE_SAFE on
its own. That part should be fine.

The main question for me: Is it an invalid code path that we take or is
the oob stage not properly synchronized with the inband code? I will try
to find some time to look at this again. Meanwhile:

Philippe, any comment on that?

>=20
> Signed-off-by: zhanglin <powertree@163.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v=
3-its.c
> index 0e57735eac..3f2b02b8f4 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -94,7 +94,7 @@ struct its_device;
>   * list.
>   */
>  struct its_node {
> -	raw_spinlock_t		lock;
> +	hard_spinlock_t		lock;
>  	struct mutex		dev_alloc_lock;
>  	struct list_head	entry;
>  	void __iomem		*base;
> --=20
> 2.34.1
