Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824CA82480
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384159; cv=none; b=mXbregXviLIXBIWe6YSbV7FH+CAHC5HQ9la/b2qvSVEhG73i8l4Zn71xrMl4m+6M5DscdnPxKVAL0ZMtbosQzswKtg3iQRyzAhi1+E+htuYJDqwypyI8dns5nDE2aGHB0RnZBC1im1uSdfZwcD20QjJIm2gYTaOeFiNjAm2AgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384159; c=relaxed/simple;
	bh=4AvN38IlbGk5TkZZJIlhrb0U+60GqRYamyQpP60SEoM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=iaS1UP0y+NHalIIma4oMsS9HdSHzPIRQN+BCipG5SSwz5MZcRVUl+pz18o5K48BPzfXfLJnNq+XwwxMPVLZnAwaDah32+0Ih7dpqcBoopesoiyx9kpg3440t4vzscn3vYwDcp49DDhIV5ThdKx2CRYKAPvhZj5x4pTprNfGZXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354f3f6c3b1so86277f8f.2
        for <xenomai@lists.linux.dev>; Wed, 22 May 2024 06:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716384156; x=1716988956;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwSLmA5gkIgMwGDIAfvqvbUxOeQ50oFWa2AA2jrk/dk=;
        b=bUiRMhmlSmXzJwXd1+tos8Cqpunva5+VjxGt2XF1oMOC9zq6PjUo46kay37tksupj2
         Bl2CLuj1fjjc5tYWcNjIrXCFM1zstGFEPolNyxm8aBjr+4jtDaIVnzdmvHckL9DT0deL
         nylwo/aQJR7ru9nWSiYnnsJVreQWV4g2x2kUwxMRald10MwJrk0Ze51fiQ+BLgriKNZA
         rclDeuYRCpbxPsXkVLK7hdwAxaW9O+S8j/W/2sd7W8RF3RAAs6MS2xvpDmBOXXtRgl5D
         87Kwfz9TY034g/G7WhWdUxZigJR/a+iY9fVhdEIwmaLdmi9WzjXKyW0R9AJXRCvKpt/s
         aEOA==
X-Gm-Message-State: AOJu0Yz4CUXcdN41qQAwE2pwHEgY1vu9OjHPNLdxmY3vdkW7XfwzgeKj
	l1c/tyfKsqWs9OhlUle/M6UQ1p8kg0qOy/9ifS2s7wfbRzV1xhhU7IocrXFa
X-Google-Smtp-Source: AGHT+IEJsnCinszeVvYx+UzVsgol0OURPac2HZhHvEKNq0ELjKK1cFdjCXs14ZbhWvtI1I/j781zmQ==
X-Received: by 2002:a5d:5612:0:b0:354:eb32:6d1a with SMTP id ffacd0b85a97d-354eb326e3amr966760f8f.59.1716384155536;
        Wed, 22 May 2024 06:22:35 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354ca01df75sm6882753f8f.84.2024.05.22.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 06:22:34 -0700 (PDT)
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Date: Wed, 22 May 2024 15:20:21 +0200
In-reply-to: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
Message-ID: <87wmnmq8v9.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hi Xenomai Team,
>
> I installed today v6.9-evl with all patches suggested by Philippe to resolve RIP warnings in dmesg.
> But I notice other one behaviour regarding EVL core.
> My system have desktop environment - Ubuntu 22.04 LTS(Gnome Default Desktop).
> I started Firefox Browser to search some things, but i notice more warnings in dmesg when Firefox is started.
>
> Is normal to have more warning in dmesg for Firefox browser?
> Is only happened when have Firefox browser is opened.
> When Firefox is close at process, messages in dmesg not appear any more.
>
> Output(dmesg):
>
> ...
> [ 4767.957239] EVL: invalid out-of-band syscall <0x43564d41>
> [ 4767.957260] EVL: invalid out-of-band syscall <0x43564d41>

I may need a bit more help for this one. Can you patch in this snippet,
then post the output it produces in the kernel log? TIA,

diff --git a/kernel/evl/syscall.c b/kernel/evl/syscall.c
index c2a3f13ebe372..1d02b9d6dd38d 100644
--- a/kernel/evl/syscall.c
+++ b/kernel/evl/syscall.c
@@ -269,6 +269,7 @@ static int do_oob_syscall(struct irq_stage *stage, struct pt_regs *regs,
 
 	nr &= ~__OOB_SYSCALL_BIT;
 	if (nr >= NR_EVL_SYSCALLS) {
+		WARN_ON_ONCE(1);
 		printk(EVL_WARNING "invalid out-of-band syscall <%#x>\n", nr);
 		goto bad_syscall;
 	}

-- 
Philippe.
