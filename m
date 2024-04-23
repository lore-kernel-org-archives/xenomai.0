Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01613699A
	for <xenomai@lists.linux.dev>; Tue, 23 Apr 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877169; cv=none; b=s3HKQwQcvfcuu6/arFxpUlwUEquhK5vl7R0uiWfqTFC/5qfUtaftVJ/nFEFCXABGhZIBZoJO4TYms2sWWUjl/a//dh3uBeMBzFj/kyJxRVA8h/5C6h7wTRyd0kEvxESvaVNn/YoifxS7xx7w4F6xTg9eDqOhNbkuIcNl5dAGNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877169; c=relaxed/simple;
	bh=0C2UOPm5y1WsfyxFH081qJZP5+NmLCMO/2/fUvw8Sks=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=LlHwS9f7Ul6Ywdbe+qRJbmJQFGhUP5/ge2anFmRxKfu8v1+027SFxXNwjvT/roaTA5yp3BtIk14RRKQs72vuGJ5xmZEb2q0+65e5907Pn8MNdeliK2dGwJS28/+dKi9D8JF+RH2Y5OKz6oXpMikMYZnwEynzOYEpjdtQ8vnSaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343d1003106so4726095f8f.1
        for <xenomai@lists.linux.dev>; Tue, 23 Apr 2024 05:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877165; x=1714481965;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dW8IXvd6O2Fve+V51DPs4d+BUPTRRhrfCU1ZfAhIR8=;
        b=g5FBkX16QYmyZvnzFfcsp8BTI2lFs1Vz17MXOUDxYdLkbP/AhIsJ3M9ICn9T3OkbH1
         KIMI7Wx/YPLFB4Q1EBB3mUVDycSe7uDKak94OhODDMIjNnMLuQgGfvrzorKHwusxGUzB
         m61aSGYVidSd3VzVXSX0Gcwg2SgYg0o5vmnHJK9gwMrfM30KgIrjcPZGbirsrv2KJ9kn
         F0XW1B5EeKbsSycvnmLUcfV1G3JHZMI+v5hMOH/9l1kakTzkaG00jY5M+wKZdMGxLV4t
         z+0OJHfKiGuKzH/TDSzwCc6MOtEi5DbzHK0r9ihstD26tKS8obIibNrAwe0iKYGj+7bg
         cylg==
X-Forwarded-Encrypted: i=1; AJvYcCXXMC0aK6GSc1fsNpoED8M0ikAjmbKY82lHlG7zB+ypVKOBYj2JJw5boZgldw9f6Trw6+PCyKT7X3xeMyHccX+OdK32nEkmOQ==
X-Gm-Message-State: AOJu0YwS4i2kxps30+RTJ2BW35eBWbG4aeEMKtcn8SWc4xgmhLod30ZI
	JRFYo829mpkp2I/o4HeGQAxqsF3gtKFjSHclMOYphX3iIqkt46kj5/UQWmTK
X-Google-Smtp-Source: AGHT+IH4yBEpf3uL1YWl/GJjeDbsg3NXv7Qr0vloVPtUCpjEqzPW7XGUx8u+Y9MZw8wVUyYzir0Q6A==
X-Received: by 2002:a5d:430f:0:b0:346:59e9:65b6 with SMTP id h15-20020a5d430f000000b0034659e965b6mr10497283wrq.6.1713877165116;
        Tue, 23 Apr 2024 05:59:25 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm14475033wrs.53.2024.04.23.05.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:59:24 -0700 (PDT)
References: <20240423104111.32385-1-Fabian.Scheler@siemens.com>
 <636c38d0658c7d1148e3b434351492a1375cfa6d.camel@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: roman.hodek@siemens.com, Fabian Scheler <Fabian.Scheler@siemens.com>,
 xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail] x86: irq_pipeline: Add missing definition for
 !CONFIG_IRQ_PIPELINE
Date: Tue, 23 Apr 2024 14:59:18 +0200
In-reply-to: <636c38d0658c7d1148e3b434351492a1375cfa6d.camel@siemens.com>
Message-ID: <87sezcz13o.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> [To: Adding Philippe, the dovetail maintainer]
>
> To Fabian, Roman:
> Is that a drive-by fix or do you really have the IRQ pipelining
> disabled. If disabled: We should discuss this internally!
>
> To Philippe: Hope you can fetch the patch from the Xenomai list.
> Thanks!
>
> Best regards,
> Florian
>
> On Tue, 2024-04-23 at 12:41 +0200, Fabian Scheler wrote:
>> Fixup b917e98008314b3c7596099f48ea98f541451083 introducing
>> DEFINE_IDTENTRY_SYSVEC_PIPELINED_NORETURN only if CONFIG_IRQ_PIPELINE is
>> defined.
>> 
>> Reported-by: Roman Hodek <roman.hodek@siemens.com>
>> Signed-off-by: Roman Hodek <roman.hodek@siemens.com>
>> ---
>>  arch/x86/include/asm/idtentry.h | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
>> index 9b936d3e76a2..307623b4e10e 100644
>> --- a/arch/x86/include/asm/idtentry.h
>> +++ b/arch/x86/include/asm/idtentry.h
>> @@ -230,6 +230,7 @@ __visible __noreturn void __##func(struct pt_regs *regs)
>>  
>>  #define DEFINE_IDTENTRY_IRQ_PIPELINED(func)			DEFINE_IDTENTRY_IRQ(func)
>>  #define DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)		DEFINE_IDTENTRY_SYSVEC(func)
>> +#define DEFINE_IDTENTRY_SYSVEC_PIPELINED_NORETURN(vector, func)	DEFINE_IDTENTRY_SYSVEC(func)
>>  #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)	DEFINE_IDTENTRY_SYSVEC_SIMPLE(func)
>>  
>>  /**
>> -- 
>> 2.44.0

Merged, thanks.

-- 
Philippe.
