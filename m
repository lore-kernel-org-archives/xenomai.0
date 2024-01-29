Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C6D54BCC
	for <xenomai@lists.linux.dev>; Mon, 29 Jan 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518003; cv=none; b=SSHrPynCNunjVFoLoXJISnI6ys8akL0bZCnFZzq1Qou+KtcV4xeGL9BdigJqqRwVFQJi1/3HoghQJB1Lxk1sy+oTRT7hx/wRMd9sqO3c5VoyLuIMeROFVhrEqtPoROiuXB1drh6FOEJqiP5GqBELUOKGxzSv75+Bbxb0MkFNBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518003; c=relaxed/simple;
	bh=FFac8jsbgTIb1DFORXNuIA7n8HkS+p7CPCuGsMwK4c4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=trUyUR8W3AjsGXHb0SYp5Ky9IocKMWzrRglBH49E5Tf7xSyNEJXk4pntu2MXFOP4+k3NN4A92l2+03KymYMJRN5dqHI8qrHa0dIFarwVExSjEGE5Q0VirNDe0nIs2/svTdM+jZIKpTVYUaRcEG+/ujsqMBaIsY0/Qqm0LT2sBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id CCA9780005
	for <xenomai@lists.linux.dev>; Mon, 29 Jan 2024 08:46:37 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	by spool.mail.gandi.net (Postfix) with ESMTPS id E6E64941598
	for <xenomai@xenomai.org>; Mon, 29 Jan 2024 08:46:36 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso35806335e9.0
        for <xenomai@xenomai.org>; Mon, 29 Jan 2024 00:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706517996; x=1707122796;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JS3qyDOitexRhq1w8WiMaOCsW3TJu1lFbMu2zhWDuJA=;
        b=sYfetlB9lkNP+U88JC/GbwmaOvp8rybNQXKd+bWEzdUyLOiLAqOTPeJIVnkX0bzY8o
         iFCEi/rnSlMjHeYcVQ/2TQScygTMX+F9v4YZOX4HkAf+WY9PPGsgHE6+OHzN+5IcYh+d
         HE9NgCCOl7e2UOkl/LzrQSXjuUdCUznIeQeHWa3JDzUff1Xk/zvH8bj09/nIsNFge5Th
         1YlhWlJKT5rDIUVd7NKWihIwJZuY8dDaxiNfk3B6O7Qgr5dZ7jkpbLrDrhv4diV2r6iV
         7WD3uwzgEkzdOmmIzrcx0fIVVcvvwAcIARquKPueqDG2O4AfypoaOS72IauLPxLWeO1e
         jccw==
X-Gm-Message-State: AOJu0YxyaJrW4ian4DLuXmAg2wUkcRw7TF6wssLDhsw4igTnvDgmWTmw
	EaFhpCU10B1Kz4kgzNVAEXnlxU8cxEpWLBFY6kOCa7warzq3wdMymbkTAOlG7qM=
X-Google-Smtp-Source: AGHT+IFuEVPoCfi1mhrUGTXiz9vmpgTdgKJ/zl/tg7ufVx9G0+wnJkrxuyBflwAzXjr3FUUjeaUcJw==
X-Received: by 2002:a05:600c:5123:b0:40d:484e:935 with SMTP id o35-20020a05600c512300b0040d484e0935mr4446323wms.12.1706517996271;
        Mon, 29 Jan 2024 00:46:36 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b0040ecea3c4dbsm13163647wms.46.2024.01.29.00.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 00:46:35 -0800 (PST)
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
 <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
 <79e83ee2-7406-43c1-9a71-e79cb2cbd127@163.com>
 <d799980b-fbfc-467b-87b7-5a4fbc6ddf50@web.de>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: linz <powertree@163.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
Date: Mon, 29 Jan 2024 09:42:38 +0100
In-reply-to: <d799980b-fbfc-467b-87b7-5a4fbc6ddf50@web.de>
Message-ID: <87ttmwo7by.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.128.44 as permitted sender) smtp.mailfrom=philippegerum@gmail.com


Jan Kiszka <jan.kiszka@web.de> writes:

> On 25.01.24 04:18, linz wrote:
>> I think my patch is not suitable after listening to your suggestions.
>> And I don't have any other good solutions.
>>
>> I think x86 is ok because there is no operation of writing global
>> variables in the critical zone.
>>
>> kernel_fpu_begin
>> =C2=A0=C2=A0=C2=A0 =3D>kernel_fpu_begin_mask
>> =3D>preempt_disable // enter the critical zone
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>WARN_ON_FPU(!irq_fpu_usab=
le());
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>WARN_ON_FPU(this_cpu_read=
(in_kernel_fpu));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>flags =3D hard_cond_local=
_irq_save(); // leave the critcal zone
>>
>>
>> But in arm64, there is operation of writing global variables in the
>> critical zone, unfortunernaly.
>> efi_call_rts
>> =C2=A0 =3D>__efi_fpsimd_begin
>> =C2=A0=C2=A0=C2=A0 =3D>kernel_neon_begin
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>get_cpu_fpsimd_context
>> =3D>hard_preempt_disable // disable interrupt, enter the critical zone
>> =3D>__get_cpu_fpsimd_context //=C2=A0 first call, modify global variable
>> fpsimd_context_busy
>> =3D>hard_cond_local_irq_restore // enable interrupt, leave the critcal z=
one
>>
>> handle_arch_irq_pipelined // Latency timer interrupt triggered
>> =3D>handle_irq_pipelined_finish
>> =C2=A0 =3D>irq_exit_pipeline
>> =C2=A0=C2=A0=C2=A0 =3D>xnsched_run
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__xnsched_run
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>pipeline_schedule
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>run_oob_call
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>_=
__xnsched_run
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D>pipeline_switch_to
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D>dovetail_context_switch
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__switch_to
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>fpsimd_thread_switch
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__get_cpu_fpsimd=
_context // second call
>>
>> So, I think there are more todos on arm64. Do you have any other good
>> suggestions?
>>
>
> Philippe, some input on this issue would be helpful to know what the
> next step needs to be. It's still unclear to me how fundemental this
> issue is (false positive warning or real state corruption?).
>

This is a current limitation on arm64 which amounts to a bug
actually. x86 has the proper implementation, which allows oob threads to
safely preempt kernel_fpu_begin() / kernel_fpu_end sections.  Since
kernel_neon_begin() re-enables hard irqs before leaving, it is creating
the opportunity for a mess.

The way to fix this is to implement the x86 logic to arm64 when it comes
to in-kernel fpu usage.

--=20
Philippe.
