Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FDE14F109
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779922; cv=none; b=ib3RNtcaMzLFq6xCdGeMaTcoS61DuD32RXpkQQkScObfmdt9/Bi77qHqaZs3LndReNsQ8k/Pfg+jzGrGnxJ3MaGjvm79mKUJMSBlXRqItHuxUoKxzX2MzCfDSAjewi21iWM51Y3VoaeFhWCEGhnd8Gh+jgFDTBn9G2TwlmJT4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779922; c=relaxed/simple;
	bh=/DAi2Hp2uHXvEUs47qrLZyzqXxMoxAt5zhV2CgeXx5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLOwNXxc4S+fw0Fysk+AeR8qH+GnSYlgQiuQ0Jxg7v2Vds8yc4JNVY+Vw0rX1HErk6YCtv4EYq0jNigvV3n5JpQttAEuC4zGEHvYcnuKW/6HFi9RnTGuO8Qd3wKYvu6W34LzlhY3/NWmtwXPxSYturAx6TVAwA0YHgsHL5WP330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VniPiD6C; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VniPiD6C"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9de13d6baso14149275ad.2
        for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 03:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720779920; x=1721384720; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQrsFieomrQ//h3AKoBYufNTOKm/Dq3tW6+MccemX8E=;
        b=VniPiD6CDP/urQZVVIVDH+7FfTeXnn696mvFkir0kieq009VvAFlgMt7fP23h5P4pl
         ZZpEXYvVDJzlYRVFMhLrGSBtCDX1uMJKd9ue+SFft5vzYNawSXroUMHj4eCZc4VEmCx/
         9VTic01/U3miLVSQXOi3OXVhakePDPFNsB8mf0RZi0o8jd6xhsqIryuCd1e8Fn245zT0
         dq5hyyAFGy30VdaGHRdmp5BQhEHdyG9ralxIOc6g9EbpIVHrbGclml94GNyLVkL4kUMu
         B0ilKJswzIn2n4tUP3IeiPM9Gc9RmDmI/CPVX2t4Fe71burxDNZ5j8hvy6YV4jZUc/O2
         fWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779920; x=1721384720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQrsFieomrQ//h3AKoBYufNTOKm/Dq3tW6+MccemX8E=;
        b=xULHkCw4ITp0Uhgl5fE8tXOmLu4FylcFjBgStNFoSnRZI6qvGwpupdUqffJQs/mV1V
         FKvG6y604UHpcdQnZGpqVR2YECH/BPKhWm4lpFn3CzVBwMSRS+A61V/9WhBEnBuGj0hJ
         eQIV7JpLzoXlZ71I+GtwZOn958lRx7umTnvf9LxJq6bVeTffeBa/WkL/Fu9ZvY3kKXnn
         gB8X7+cH5BZyzoqV2lZ1oaCxSs2vH37Jhb+yqgHPNnwEWd1G79recOJOEQ2zsfPT3T5x
         nkqPFPAwVKc/caD9/ctmUQ72cE1IvGiQq8+0uq2+gPNuVXMER32KjzDq+vhXOzfT59Fq
         SJUQ==
X-Gm-Message-State: AOJu0YwUh8/eX0/0LVeyBdrlN+VpfC8z23pASBriQc7qxzN5//rPfGqw
	43kWI3VpQoMqrwCCrl4ewI0G6HZW8PC7MaETaSu/ScDPhUw9IRBw2+k+X199n0ClamNCga7B++o
	+QR4Z7jw3z2OfWtv0xUdhemIvy+o=
X-Google-Smtp-Source: AGHT+IFK6UYOG9rIWlvJymKrq6v0fdZy1u3JT2Ob+ySJNu5mi5Q2FEMzitd/CCr7KswEk1l1Bg+S+fnJsDd32OFt2TE=
X-Received: by 2002:a17:902:dacb:b0:1fb:80b9:fb8d with SMTP id
 d9443c01a7336-1fbb6d66824mr92990185ad.56.1720779920476; Fri, 12 Jul 2024
 03:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230904102533.22448-1-hongzhan.chen@intel.com>
In-Reply-To: <20230904102533.22448-1-hongzhan.chen@intel.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 12 Jul 2024 12:25:07 +0200
Message-ID: <CAFLxGvzJ2XbZ_9J6jtc5_Voz4zV73EUsujAdn+k_zTa3POL1Zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: intel: irq_pipeline: enable pipelined
 interrupt control for pintctrl-intel
To: Hongzhan Chen <hongzhan.chen@intel.com>
Cc: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>, 
	"J. Kiszka" <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 4, 2023 at 12:53=E2=80=AFPM Hongzhan Chen <hongzhan.chen@intel.=
com> wrote:
>
> This is required to run the locking code from the pipeline
> entry context and the out-of-band stage.
>
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/inte=
l/pinctrl-intel.c
> index 2ef9e2d8fd9c..7797618a899b 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -1322,7 +1322,8 @@ static int intel_gpio_probe(struct intel_pinctrl *p=
ctrl, int irq)
>         pctrl->irqchip.irq_unmask =3D intel_gpio_irq_unmask;
>         pctrl->irqchip.irq_set_type =3D intel_gpio_irq_type;
>         pctrl->irqchip.irq_set_wake =3D intel_gpio_irq_wake;
> -       pctrl->irqchip.flags =3D IRQCHIP_MASK_ON_SUSPEND;
> +       pctrl->irqchip.flags =3D IRQCHIP_MASK_ON_SUSPEND |
> +                       IRQCHIP_PIPELINE_SAFE;
>
>         /*
>          * On some platforms several GPIO controllers share the same inte=
rrupt
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/inte=
l/pinctrl-intel.h
> index ad34b7a3f6ed..89ef4e37511f 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.h
> +++ b/drivers/pinctrl/intel/pinctrl-intel.h
> @@ -228,7 +228,7 @@ struct intel_pinctrl_context {
>   */
>  struct intel_pinctrl {
>         struct device *dev;
> -       raw_spinlock_t lock;
> +       hard_spinlock_t lock;
>         struct pinctrl_desc pctldesc;
>         struct pinctrl_dev *pctldev;
>         struct gpio_chip chip;
> --

What is the status of these two patches?
AFAIK, they never made it upstream.

--=20
Thanks,
//richard
