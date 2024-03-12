Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1C1386CF
	for <xenomai@lists.linux.dev>; Tue, 12 Mar 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263812; cv=none; b=QDcmYmO7H2m5akVaeXu5gd4Fnl16JR2y22n2JJgTxEK8g5mnfcA+k4CBDw8yuJlgII9m3bkF+SYdtPOtSaXaLlCTeO0iyPGy5/dpDanyr1TB+M6D/R7pI8Ddsnaw3N2lUvHZloqLluC07Ddqdb9BmOIVHds6Y7Vg9i6Em4iKcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263812; c=relaxed/simple;
	bh=RECwpoagGz/sIX93aTjcMfx9QDrTUreD6zI0bURJO7s=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=NXngDlM1BCEMLA3GsngJNiR13jySIT4+v+IknCqy9BOHIlYFv7802xIG4a0jKDkLPYx1AHLBgkPvnj3CPhur2ZN5Qfeb+ZoH7YMbpe9KTEeSkm/A9R1qYfxvHk5F7l17EcRvICE/hT8io1hV8VkBPLDYIizob5VAc9NKbJVtpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513bf5a2555so1012506e87.1
        for <xenomai@lists.linux.dev>; Tue, 12 Mar 2024 10:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263808; x=1710868608;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rYWUNPKvWv/BS4dKhLtSCqwDZ/Hkusc+mtJQ/DsRQ4=;
        b=GpTB9vI86mZkYIXMFHBSULNQqywaEdYkQOsq+eokgTQBN49VWvI7rGETK3GnYUUHuN
         CXvM9/S8KXI6VFlQZRWUuT24FR/DZ4vUMelivBUJDCq0EgtWpu5ryEThJd8luoQL5gBJ
         GuHgHiw04C5OkrXK/vQXbigrm2C/B6w9e7rAO2UMPR2fZrS3InTSNpSFKlbtwziHrL1E
         gerGZpUwllPeB25jfdvKNvUu8ryd9Gyh12GsnxLU/KuCG26Nsx1uzKif26zh06YcigxH
         21OO5RSNxHNDQUKx85Az4ymZWwe/pBqeLenZ7Lw6c0o+hPOtW8zDXMHQ5dKSlV0CdGfA
         I9NA==
X-Gm-Message-State: AOJu0YxQJsQ/BN6v6hR99EmbkFS4QuA3pGWSlunHSxJZRVWdNG5yd8QO
	iygvjzWNZs+rSw8OEWW6AkBwssPB35zc/yuf4gasvfuRh0zXM9M7YwIuqA7Y+VQ=
X-Google-Smtp-Source: AGHT+IEzOYQt/T7suAgYhhJ32LTVHv3mu1C58eozWdQgGXZLtw+JH8WynU3phYOTWqJo33Chn95pjw==
X-Received: by 2002:ac2:4241:0:b0:513:b9ab:6e99 with SMTP id m1-20020ac24241000000b00513b9ab6e99mr1782548lfl.50.1710263807594;
        Tue, 12 Mar 2024 10:16:47 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b00413e6a1935dsm203916wmo.36.2024.03.12.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:16:47 -0700 (PDT)
References: <5dd4a9f05961fc61aec5f20bb645c50c8a1bf9ad.camel@siemens.com>
 <87r0goobeq.fsf@xenomai.org>
 <92265dca7efe0970f7dc37d8e9fd3d15a3367c34.camel@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.2
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: dovetail: Build warning about missing __noreturn annotation
Date: Tue, 12 Mar 2024 18:15:56 +0100
In-reply-to: <92265dca7efe0970f7dc37d8e9fd3d15a3367c34.camel@siemens.com>
Message-ID: <87y1an5q11.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2024-03-05 at 17:54 +0100, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > Hi Philippe,
>> > 
>> > any idea why I get the following build warning on recent dovetail
>> > branches? I haven't checked that yet, but I think all branches >= 6.0
>> > might be "affected".
>> > 
>> > The warning:
>> > 
>> > vmlinux.o: warning: objtool: arch_do_IRQ_pipelined+0x53f: __sysvec_reboot() is missing a __noreturn annotation
>> > 
>> > __sysvec_reboot calls stop_this_cpu() which is annotated with
>> > __noreturn. It's unclear to me why arch_do_IRQ_pipelined() is in the
>> > game here.
>> > 
>> 
>> Because the call to __sysvec_reboot() is expanded inline in
>> arch_do_IRQ_pipelined() via run_sysvec_on_irqstack_cond ->
>> call_on_irqstack_cond. This inner call is missing the annotation.
>> 
>> The following patch would do the trick, although in a fairly ugly way:
>
> No better idea here... As it is already part of all relevant 6.x
> branches no follow up necessary.
>
> Thanks Philippe for taking care!
>

Np. I don't think there is any better way, so let's go with this.

-- 
Philippe.
