Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835513A3F2
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392088; cv=none; b=hifUSTJn8rviGLOs7F2Z3YvqcgYev8A1STsXoVBkeylR/JSckufw1ZCi0fVsEetH4frsqS6qlq4wRhJAZ6Lh+DLpBhz7AcuFqTnJZpjDYoRihOa9NFSRPsENjGqt+9mHXfijKYm4lidkOFDfTPWtbfP3dJgt220C79QEBSbpM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392088; c=relaxed/simple;
	bh=l2Slf3NIm5mnAaYLscPjlxE6UTdroQxRj+dQnYfGwVI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=kJiZ6lto9Ogplsq21fKinZRIb9ZOP6rbEXNoU/UkYS0vJumnj4yZkfJ11ViyIXcIFo+DCAuX1winhstiuLbUS9fFC1byRbNC7k5Jc2pcwY7TTJcRSS9tloyIToCzFPyrLDaWNQGBO7m1m3/2kC6ncV4ar2iw9ueMbeGDVwMzt5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-354e0cc9c5cso618989f8f.0
        for <xenomai@lists.linux.dev>; Wed, 22 May 2024 08:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716392084; x=1716996884;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YGrLY2QNzN47bLYWrwfIVc/7+YIq/imXxAnaVXrVXU=;
        b=mUW7XAT1b4EtbTi5H969oG2N+TadgYbxoge8QBD02N3SPS1iVqsm5int5t1E9HzqF2
         crNqZtBt5IAaivrdimMytAXKtKq6PjLPh67rZapghvJ2+gJqdfJQHnDXkqpZU9EK8u9g
         ADmJYXc9xHLLf9SpHav5FIUzTUOZKuHOQApZ7vwtt7geAwODJiWacneIWUUhVNxKN+6l
         4gOGdRSjjNIYxSCjqo0GzVoch7qtBu3S+3ncMk19tSK10rhZ782h4b716m9oBabVqbOV
         NaMjwtQmUTYuB2q0BrI/gSixojSn0FtrjQMiyHWceTsLQ6gA3yqF6UZ/7IiCB4LAEXkT
         uT9A==
X-Gm-Message-State: AOJu0Yy7554cLcRpTXcl/jytVFN2/WXQhViFnlXSoi8ALUQM9QjX2Hij
	Wgm0UzlWbNdlIlecXWEpAN3ioAPzudHvA70GjOagaWTUnpP21YotxP67bQ==
X-Google-Smtp-Source: AGHT+IFx+dXVEOttI0MpSBkKERINKyawacXajDM0ZbDIjbywevWwF7WIle6laEBvCkOWE2yJrffX6Q==
X-Received: by 2002:adf:f4cd:0:b0:345:bcd4:bc99 with SMTP id ffacd0b85a97d-354d8cc8f64mr1906922f8f.11.1716392084170;
        Wed, 22 May 2024 08:34:44 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351b79e8e6bsm26912144f8f.65.2024.05.22.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:34:43 -0700 (PDT)
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87wmnmq8v9.fsf@xenomai.org>
 <PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Date: Wed, 22 May 2024 17:30:52 +0200
In-reply-to: <PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
Message-ID: <87h6eprhbg.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hi Philippe,
>
> I tested today with your change:
>
> git diff
> diff --git a/kernel/evl/syscall.c b/kernel/evl/syscall.c
> index c2a3f13ebe37..1d02b9d6dd38 100644
> --- a/kernel/evl/syscall.c
> +++ b/kernel/evl/syscall.c
> @@ -269,6 +269,7 @@ static int do_oob_syscall(struct irq_stage *stage, struct pt_regs *regs,
>
>         nr &= ~__OOB_SYSCALL_BIT;
>         if (nr >= NR_EVL_SYSCALLS) {
> +               WARN_ON_ONCE(1);
>                 printk(EVL_WARNING "invalid out-of-band syscall <%#x>\n", nr);
>                 goto bad_syscall;
>         }
>
> But this is not working properly.
>

Please, double-check that you are actually testing the right kernel.

-- 
Philippe.
