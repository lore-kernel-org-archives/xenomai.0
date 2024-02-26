Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5712C7E1
	for <xenomai@lists.linux.dev>; Mon, 26 Feb 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967513; cv=none; b=sHpyS6KOZh4US2AeCDB9w6Nf6CiyERIxfPMKkVn+aDRNbdkYfU90RFaLCorZKn/kzfGoYqwRgjGSf1c+CElzNm6LgLQ0BbrGQtaHrME7rdSx8yE4v4QODC3W0XddLVxZHV1ri4JOM4vp6HqXR8ehh7NtgBaR8COD6gH+rOwbaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967513; c=relaxed/simple;
	bh=jhtdf5pe9oCJXcRs4PHCQV8JyaKJmFTwGDyBzzx7BzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIid0yonzJCKouUhlZXGk0uoFLTR6e6KAXbcon0T2xNREqja3ZYgYwkRhS+weeJph7dRGFf2M3eL5ZnkckGVvVJaWiWLQ2F+AkaimAHwCPsZgH2IKNdSv0qD0z5pwnc1fBHndcyKuuYaX+z82MOqDnt2tpVZaWmlihzRUttQzo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaKbWbQ3; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaKbWbQ3"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a058b9bd2dso1525930eaf.2
        for <xenomai@lists.linux.dev>; Mon, 26 Feb 2024 09:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708967511; x=1709572311; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tT+PYlsWTfmhVf/rBIJGzhIBadJcwxEhBydGRr6Ses0=;
        b=DaKbWbQ3777JeTsQa2i6PgP/gsQ6xxAFYiPfbx1GiyYw3ECeXRO7PM7IMZ1bqmFe+S
         cB00WALDb8MRWUvKfZScrEkVbX17In5hasFq/NxPfGC8gsFHYB5d080UpHG/ObEiXE5s
         +CCBSkYpM/NrhCGuLqvRgW71VG7VE+MungEpvDtPDanDmiopctO2++k5QNgdsbcKdQHD
         ZsgvgjDanGgbRfx4Z4NUNlVeJBu/qbeFem8kCtwFX0Ytb312FoRapf0uXHu5n3Ghz2N9
         cN7z1Hoc/W6+SFPydIJX6SfJwnqRqkBTfpebfEhYJ5dhJFBMsxESRc77AE7LpAzCCa2H
         ZF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967511; x=1709572311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tT+PYlsWTfmhVf/rBIJGzhIBadJcwxEhBydGRr6Ses0=;
        b=PsmpyolwyJDgwx7i+4pB/Sa+YWp/ltnoZwjCyhPkrkjN+6LTYvdvXt7eG7NFmoWT34
         TM6GsuCMj2frAeI4UHl3rUkzl7SMQPJhw++MtrGqwtBONvR2VFdMW4W+k0h4oFqCFaFl
         nQgUNej+XplCBGF03cAi1zD9owL3OYUWA5IFLMTGd/M6CcQJbudvNOkgUQeZ1SNl4Leg
         P4P3M4IabpI4F2zeGp+y2z6JyhbE8SO8f7bReM0WhNSCvrvRQNNEhqhpq7737wRnaa7i
         6OmazT44zZOMAENVZ5lDgwcQUQt10JFrKyVhXCQu71IPlkHcuz1IE1Bkt7gU7+M4xTID
         c/ZQ==
X-Gm-Message-State: AOJu0Yyjpm+qm/VQb8qKCMg/ldHgbsrdyL2Y52EY1Rv8wk1d3m8OQJWI
	tm/BuY/rqIq+qf1axelLku7Qlwa4g+IUf2iwdnk68ioNc+ePoeYQAktdjZjAtaGef4Ca0YAk73/
	BRZQ+3Rujgs7/iL2hHdhlLT1Xgt8=
X-Google-Smtp-Source: AGHT+IE/02XNsktSa1/75ZAYbqE44BNViQhyFTnERmJ/tNXrdoc0NWgf+2bys9DTxVkb5lB0KnTcnil6LWmDMWRs21M=
X-Received: by 2002:a4a:dfdc:0:b0:5a0:a667:8690 with SMTP id
 p28-20020a4adfdc000000b005a0a6678690mr954599ood.6.1708967510882; Mon, 26 Feb
 2024 09:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240226-v6-7-dovetail-rebase-v1-0-2962213b5e9c@siemens.com> <20240226-v6-7-dovetail-rebase-v1-2-2962213b5e9c@siemens.com>
In-Reply-To: <20240226-v6-7-dovetail-rebase-v1-2-2962213b5e9c@siemens.com>
From: Philippe Gerum <philippe.gerum@gmail.com>
Date: Mon, 26 Feb 2024 18:11:39 +0100
Message-ID: <CACz9r+mGkGmDNQUeKOMcRx5geUKFfgUHhYj79E8Q6KOP=D7CTw@mail.gmail.com>
Subject: Re: [PATCH dovetail 6.7-6.1 2/2] dovetail: x86: Fix fetching of the
 first syscall argument from compat tasks
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"

> On x86 there is a small difference in the ABI (= register) where the
> first syscall argument is supplied between the x86_64 (native) and
> compat (i386) case.
>
> On x86_64 the DI register is being used, while i386 used the BX
> register.
>
> The same problem exists for further arguments - handled by
> syscall_get_arguments() - as well. syscall_get_arg0() is dovetail
> specific and is now in sync with syscall_get_arguments().
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---

 [snip]

>
>  {
> -       return regs->di;
> +#ifdef CONFIG_IA32_EMULATION
> +       if (task->thread_info.status & TS_COMPAT)
> +               return regs->bx;
> +       else
> +#endif
> +               return regs->di;
>  }
>

Ack. Let's write this without conditional block though, dropping the
useless else branch as well:

 if (IS_ENABLED(CONFIG_IA32_EMULATION) &&
       task->thread_info.status & TS_COMPAT)
           return regs->bx;

return regs->di;
