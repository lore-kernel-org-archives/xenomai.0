Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD113D61E
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384013; cv=none; b=NjliUKP/gWA1B1hs4vcu/KeP3kcFMFgW9ICJo8V1JW5nNoGnPKUPuB188zWLOtTkpYE/UNJwZ740Af2j0H87VL54j3YFDyyAQF7+DITCRJMdxbMESbBRici2pfx6J6pqgMshOrDNmMQPPLmaV8q96JiDHcShe2RtdaJfenQTd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384013; c=relaxed/simple;
	bh=TS+jb0rbOFo0qBGB5ABKZ2wpyewWyAJOzflqZUzNOP4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=K5INHHs2xKeR+204X5E19t2i0DwNlnoOiXLBWNoUneepw5t9ekGXU2G2w/jmErusAW6ab4NHSlkE06z5RckCFYOujAHmkte38oaEZ24zl9HSCXW8yMN2F4l4Ld/6ugfMIf5gbbv+koAOEnTmczM1S8NlDk5MrjyyIXuwkjidYpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-354de97586cso663269f8f.0
        for <xenomai@lists.linux.dev>; Wed, 22 May 2024 06:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716384009; x=1716988809;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA+K59vKmsdjhrODPDUq+HX4QfLUXsL/usUV3J9+dkw=;
        b=tHRri8ZbGFBws94Pd1vmDQblNiOQqwpyhTqy+ttDP0KT8IHcqFb7YJkD8O98IMN9Kz
         evYQ5B1jPEsZzjMa1jPvLCb6elDCgqmSTOU1SRxPeRqQNIDsHyMOOmaxXkenI87D+AVm
         KzrUBTrExhbOAJ9X8PZT0l6Gd/gkpgA3Qc0eYT2/T/JJd7JtKDhbVCo5u7PQI8PMXnFO
         Y7Xsfbl7ra1epOfK4JDv9tGikIntsX1bmhNUB/TxjVinnJV55K82hpLqoMvsdj/vVllN
         yy+E73WxNUQNzVevvSI/p/6kyVOawQzqk+pqg1bGYGLxUZaZ+ctgB711Wyw9lUOLX0a3
         jymQ==
X-Gm-Message-State: AOJu0Yw/L2shV1deglZLSIlLs8gXIC2ngHKnEt1KgE6/Z6Y9fAroF47L
	NqahRja/bAYFERP45fMcT9afaJ8IfIn4QgdclZO5AZBtkU8ZnsYP2WKkS4yj
X-Google-Smtp-Source: AGHT+IHek9ytE4TxFcAfLzBTd0++bNTpO9KPUAtWDSSdTulC6vY6rPAMFdUGiOXUaFyv5zrWy16x/w==
X-Received: by 2002:adf:ec47:0:b0:33e:cf4d:c581 with SMTP id ffacd0b85a97d-354d8ce172fmr1360597f8f.41.1716384009408;
        Wed, 22 May 2024 06:20:09 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79be12sm34445794f8f.20.2024.05.22.06.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 06:20:08 -0700 (PDT)
References: <PH0PR11MB59492DDE7F2301CECFD2D8A9F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <877cfsskke.fsf@xenomai.org>
 <PH0PR11MB5949EC28B447C7534BF8292DF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87y188r32a.fsf@xenomai.org>
 <PH0PR11MB5949CA43AC47E322BE97B5AAF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB5949D3CFA8AD77346C36097FF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB59496A3A9FFCB39B7715813AF4E92@PH0PR11MB5949.namprd11.prod.outlook.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Date: Wed, 22 May 2024 15:18:51 +0200
In-reply-to: <PH0PR11MB59496A3A9FFCB39B7715813AF4E92@PH0PR11MB5949.namprd11.prod.outlook.com>
Message-ID: <87a5kirnjs.fsf@xenomai.org>
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
> You are reproduce this issue without CONFIG_EVL and CONFIG_DOVETAIL enabled in config kernel?
>
> CONFIG_EVL=n
> CONFIG_DOVETAIL=n

Yep, this should fix the issue. This bug might have been there since the
introduction of scoped guards for hard spinlocks. Checking and
backporting fixes if so.

commit b51c3afd66c8763bed7a4b8258cc5cf5c8ebd719 (HEAD -> rebase/v6.9-evl)
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Wed May 22 15:16:52 2024 +0200

    irq_pipeline: provide placeholder for scoped guard w/o IRQ_PIPELINE
    
    Signed-off-by: Philippe Gerum <rpm@xenomai.org>

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index eb8b4d386e942..545368b045e52 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -612,7 +612,24 @@ DEFINE_LOCK_GUARD_1(hard_spinlock_irqsave, hard_spinlock_t,
 		    hard_spin_unlock_irqrestore((raw_spinlock_t *)_T->lock,
 						_T->flags),
 		    unsigned long flags)
-#endif
+#else  /* !CONFIG_IRQ_PIPELINE */
+DEFINE_LOCK_GUARD_1(hard_spinlock, raw_spinlock_t,
+		    raw_spin_lock(_T->lock),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_nested, raw_spinlock_t,
+		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_irq, raw_spinlock_t,
+		    raw_spin_lock_irq(_T->lock),
+		    raw_spin_unlock_irq(_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_irqsave, raw_spinlock_t,
+		    raw_spin_lock_irqsave(_T->lock, _T->flags),
+		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+#endif  /* !CONFIG_IRQ_PIPELINE */
 
 DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),

-- 
Philippe.
