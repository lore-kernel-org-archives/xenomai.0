Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04385130AFF
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601084; cv=none; b=JgvIBnFD0HbPwF98iurGtWdat5BNLFSB9kgwcFXxGqOqHOflpRlrv+KHWh7tdO07vbaRkub/cejS8dUuRs/dlXAi3xiH2Hz+PyZX9/adhS+WWqT6L+TaoWRT8hKoqEGLIVti1Urj5+1Tjzr5wpeOZ56iWMYF0MxipXtbjlN+hiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601084; c=relaxed/simple;
	bh=yM4YDPwJr1pvosV4kxI4nHbNEvWq4J6GwJkAvjHH8KU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pN+xot2o6hwbWlB4EXvSUqsGJlU8tEio+A2aoql9vOK6SQXsh5VNZOE1H7tQ8JGUIvA88V4ELlQdOXfZ0LfdybAZSsVGrsUZDJvL2Lxq+Z4GaV+YzVWXz7p59IWX6JYNRPFn8FxpsX1r9gvU79qyRwEamfmGsZg9iJIceRlP8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea3e499b1so5966328e87.3
        for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 01:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720601081; x=1721205881;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yM4YDPwJr1pvosV4kxI4nHbNEvWq4J6GwJkAvjHH8KU=;
        b=e/59UCc4spPFcWSaRcZF/pLCFGoeypWUgnYmL+3S6BzkJrhSduW5MBW3s8kelBx7Sx
         h8ClxGqTlOy3QsrL3SttDWfrEcgYP0zEr6TmOeYGiI+QGyMsUrCpYLz7T4wh9bINEGDf
         6/AW/GaqcRSfWS35jWDUHHsI5n7TK0rrFFfLKhP004m9/NHa55Xeq4LCybjjQK75qYYc
         4FvUf9wT7AsbhUGhmE5osO2FvG1BHQsY0RUSBtAk3W+prwlE/XXTqZUe3ZD+lTYPxIcX
         AxjhcnXWWHuD0JVydo9CLYDKHy43IgVn67sWxRRhBqvqZAgJRFUVL/i/SLBDZzKOIeXt
         hSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC3LixNuE9SJ3MHsF2MbEFoHb305jZeljqA03vtLnK7rFnAWve2REbTbEFdZMtHvFV5jF69G1ogeHqWfwV8LlLP78skGNZ0A==
X-Gm-Message-State: AOJu0YzxWSmsH1dgZNJDc4aeLRquegtXpB669tMKn8b2bOjNSmf8xxM5
	C93Tp0zTVYZeZTcFm4B2O+dL8AFc0irYRgm0rczs+iP9HXoJv2rNoa6Awjy2
X-Google-Smtp-Source: AGHT+IGXnDhSkOiT176HyyDXz2cPn1Pfscz7vqW4b9X2WWbxwBrJRLwvn2vE/i0mzxfWfdw0JtzLPg==
X-Received: by 2002:ac2:5e85:0:b0:52e:9f7a:1512 with SMTP id 2adb3069b0e04-52eb99d5a15mr2666213e87.65.1720601080777;
        Wed, 10 Jul 2024 01:44:40 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7ed52sm4774884f8f.6.2024.07.10.01.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 01:44:40 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: Dovetail: Missing backport in Dovetail 6.1 and 6.6
In-Reply-To: <5c883622fa2ba963f05f652f07c27fed847aaefd.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 10 Jul 2024 09:40:32 +0200")
References: <5c883622fa2ba963f05f652f07c27fed847aaefd.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 10 Jul 2024 10:44:35 +0200
Message-ID: <874j8xy6to.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> I just saw that you updated the 6.1 rebase branches. Thanks for that!
>
> Seems I have a follow up:
> The 6.1-rebase and 6.6-rebase branches are missing a backport of=C2=A0
>
> commit e5ca068176e7 ("x86: dovetail: fix unbalanced inst markers (int80_e=
mulation)")=C2=A0
>
> See [1].
>
> I screwed that up in 6.6 with
>
> commit 2a2f595d9ed8 ("x86: dovetail: Fix compat syscall handling, account=
 for new IDT entry")
>
> See [2].

Picked and merged, thanks.

--=20
Philippe.
