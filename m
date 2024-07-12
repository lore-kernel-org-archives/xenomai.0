Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9716FF45
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790136; cv=none; b=gnq0cl8I03qHh7h6YkKpAaFz6dglv14PeQqV6WIugulviFCNdpBcRQqG7jxWan4wo9Vox74VETsGiKiWZGfU09O2/mcLko2VBh5xZ+S33m297AGp9E5loftQSNU6vDhO3J3pUm2Zg99cMZdvCM2bthRCDh6H78LAW7QJWWe34Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790136; c=relaxed/simple;
	bh=QQauhDWHTzzxMlCTxlrOUP7i7hxOH3ggR20F9XhpemM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GNla1TOL8m4HBJrh1XGRMNeJn05BV9TegvpwjSzOCVO+5fculX/DHfbvuNZ7EI3ZHCDecFNAdVOlEulXqSu9JvmEYlnYAxECmwNuYoUnLnB/6cEGfQLdq5bA3dfujVlziKrcZ91Q4vktOhjNK+qJ/PvvUJBqJdb9IxE6Dc14v/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367a3d1a378so1669016f8f.1
        for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 06:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720790133; x=1721394933;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=odAsN/4Wpp4ITNDgb4qjPNGe8BhDSFzGsu9Peo0F9T0=;
        b=SHm+oQb6b+nG2ons7K667WOOmBhEDMM8k+WZkGqcgYx94B/8vrZWIfeCKUV4Bl+lDh
         kSbxn1Lf2HRHELbnmNFVjo46AmKKCPJdX5xqzDSsXc3ABdazMZgxqR2D6ATcDymx6JV2
         wqrVrfdOHZ0MB3iDrNQXcZBHrnSh45zxvX8Ehm6tDH8xg+ZTZuZ1Q7UnGn7RogEHxMVw
         EzyXPhekLpqlM/MyvNuQpcMhOOWETLETDKrY5Qph5JXTt4z51xR4igtOMFo6ucQnky7+
         7/+c87ceRxybUkD7qbb1gW7Roen5x6OfndO5oVXu/otiL9P5y+w/9WoaYPFkfoOwbOSX
         7OvA==
X-Forwarded-Encrypted: i=1; AJvYcCWzBxiJD0aMB8uQY+YpcK88obXWG4IR4SyAVg+JcoUKavdE7pm393lMwqjFcGL+GTR6iGh3ZSekU7qrSvEZr6caxQL9kK1Jeg==
X-Gm-Message-State: AOJu0YwyQCRZXpLfRW8dphbGw26lBhDgQAPQ2NVgx8i/tqSx3pnAOuoT
	CLa6YYk9jb/wZTotg9zFmMghvKSI7YfTIR01/G2/N+Q+Z5fJMOPJ
X-Google-Smtp-Source: AGHT+IG7TKXdijCMK0luA2BCrVq/Pk/u3Oq4DxwVBJBQwsigZ61kapuE3O60XnZFjEmEPmFaK7JIQA==
X-Received: by 2002:a5d:4747:0:b0:367:9b1e:7b3b with SMTP id ffacd0b85a97d-367ceadc72emr8679430f8f.59.1720790132850;
        Fri, 12 Jul 2024 06:15:32 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7dfccsm10251050f8f.19.2024.07.12.06.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:15:32 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Hongzhan Chen <hongzhan.chen@intel.com>,  xenomai@lists.linux.dev,  "J.
 Kiszka" <jan.kiszka@siemens.com>
Subject: Re: [PATCH 1/2] pinctrl: intel: irq_pipeline: enable pipelined
 interrupt control for pintctrl-intel
In-Reply-To: <CAFLxGvzJ2XbZ_9J6jtc5_Voz4zV73EUsujAdn+k_zTa3POL1Zg@mail.gmail.com>
	(Richard Weinberger's message of "Fri, 12 Jul 2024 12:25:07 +0200")
References: <20230904102533.22448-1-hongzhan.chen@intel.com>
	<CAFLxGvzJ2XbZ_9J6jtc5_Voz4zV73EUsujAdn+k_zTa3POL1Zg@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 12 Jul 2024 15:15:27 +0200
Message-ID: <874j8uoiog.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Richard Weinberger <richard.weinberger@gmail.com> writes:

> On Mon, Sep 4, 2023 at 12:53=E2=80=AFPM Hongzhan Chen <hongzhan.chen@inte=
l.com> wrote:
>>
>> This is required to run the locking code from the pipeline
>> entry context and the out-of-band stage.
>>
>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>>
>> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/int=
el/pinctrl-intel.c
>> index 2ef9e2d8fd9c..7797618a899b 100644
>> --- a/drivers/pinctrl/intel/pinctrl-intel.c
>> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
>> @@ -1322,7 +1322,8 @@ static int intel_gpio_probe(struct intel_pinctrl *=
pctrl, int irq)
>>         pctrl->irqchip.irq_unmask =3D intel_gpio_irq_unmask;
>>         pctrl->irqchip.irq_set_type =3D intel_gpio_irq_type;
>>         pctrl->irqchip.irq_set_wake =3D intel_gpio_irq_wake;
>> -       pctrl->irqchip.flags =3D IRQCHIP_MASK_ON_SUSPEND;
>> +       pctrl->irqchip.flags =3D IRQCHIP_MASK_ON_SUSPEND |
>> +                       IRQCHIP_PIPELINE_SAFE;
>>
>>         /*
>>          * On some platforms several GPIO controllers share the same int=
errupt
>> diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/int=
el/pinctrl-intel.h
>> index ad34b7a3f6ed..89ef4e37511f 100644
>> --- a/drivers/pinctrl/intel/pinctrl-intel.h
>> +++ b/drivers/pinctrl/intel/pinctrl-intel.h
>> @@ -228,7 +228,7 @@ struct intel_pinctrl_context {
>>   */
>>  struct intel_pinctrl {
>>         struct device *dev;
>> -       raw_spinlock_t lock;
>> +       hard_spinlock_t lock;
>>         struct pinctrl_desc pctldesc;
>>         struct pinctrl_dev *pctldev;
>>         struct gpio_chip chip;
>> --
>
> What is the status of these two patches?
> AFAIK, they never made it upstream.

These fell through the cracks in the -rebase branches, at least, likely
because the target kernel was unspecified. They look ok to me (baytail
may need actual testing, but looks good at first glance).

These patches do not apply to any of the current Dovetail stable
releases (v6.1, v6.6). It looks like those patches may apply cleanly to
to v5.10 and v5.15 though. IOW, a forward port is needed for v6.x and on.

--=20
Philippe.
