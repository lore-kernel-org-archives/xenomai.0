Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252A40870
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715948010; cv=none; b=B99ogQ+2mObrwVzOMdxtvUOrFjoyMr42Hy8sj2IrrU4w5RsFfoFOi/g3s6CuiKxXsPotfJqcqAFoTDjYKyCxDRsMM/62PWfjQF7c1fPABbE1An36OK1Vd6F9n7oRa9TzzofMT98NpinwNTkPQ/9CgcDhGBRWsZrBF72FHXm3300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715948010; c=relaxed/simple;
	bh=2nMeS7K6qkAvKFBj0bgXDG+O2mwmpgW4I/ufDQjM5Ao=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=IkYbyKYvypnKP3hqFGqD43HvDLfdEHxBIJUOAtXIDfmKhwAjsNBHV5Cl+gNhmceLe2d6XWDb1+heBXMbUVkRh/qtTCerRN7/SYzdUhrXgA8Z91i0KAZEvb1gxw4/YIE4Ea1cimjGM8xgcYnfzVpK00q/l7jcm8dD+CrA8DOFSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-420180b5898so370035e9.2
        for <xenomai@lists.linux.dev>; Fri, 17 May 2024 05:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715948007; x=1716552807;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkZ4SESpKj/ogWeodNcXN7MZMgKaQBEQWyywr+HC4XA=;
        b=RPmNuW6zkFXe+kTgK7T3eTd1SmTht8mEhlCx1LFe25SArUow8yQSQ9Ea8U7AOGHvyb
         0BXS9ppHTHa7HuWtHpDz3vv4z/jMtEte26Nu7ffEE+PlQ87Ar09LrWXXBp31/MVhUmK4
         yqo70t1qHWsZUZ/UukXUDT15qYagjoLVUiICjaCRWPFj9eGQMn497r+R9eTu1KZsjZNv
         V0qOWjtzA/VT+Jq0XjrQfPZGp7n76yPlpROixFHmzieJ+giZkMtx3V5hH8P6xI3AQ9pb
         CTa0oj6rueHAnGXr22p7uzSfQchyaLE6a8xV843MLw8dW0E7a3vbu3UzVw/81mRxWNPV
         CXBg==
X-Gm-Message-State: AOJu0YwNf7DXzpjr/JC2X90K40YnJAJ9aWH17W8LYn2trFq6cvQjIruW
	/BzkAzjDiPkoaRO/J+hFJ0Bq+KVlusu/oF0WukAb4fWsARbHfYvRLfMnGA==
X-Google-Smtp-Source: AGHT+IEFUpUPihr7Cj1J6FWF5taRAdaBQ8eoPVcrPontm19uaJp82ZbRRFjrGyBISRRF5Slc+CjoxQ==
X-Received: by 2002:a05:600c:3ca0:b0:418:2b26:47a3 with SMTP id 5b1f17b1804b1-41feac59eabmr148087385e9.32.1715948006937;
        Fri, 17 May 2024 05:13:26 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd491c712sm175684955e9.0.2024.05.17.05.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 05:13:26 -0700 (PDT)
References: <PH0PR11MB59492DDE7F2301CECFD2D8A9F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Date: Fri, 17 May 2024 14:12:48 +0200
In-reply-to: <PH0PR11MB59492DDE7F2301CECFD2D8A9F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
Message-ID: <877cfsskke.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hello Xenomai Team,
>
> I notice one warning message today in dmesg, when using 6.9-evl branch.
>
> Output(dmesg):
>
> [    9.807115] ------------[ cut here ]------------
> [    9.807119] WARNING: CPU: 1 PID: 1473 at kernel/irq/pipeline.c:303 inband_irq_enable+0x21/0x40

<snip>

Could you please try this?

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3d7be57150174..8f5a460d7fc00 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -259,7 +259,7 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
 
 	nr = syscall_32_enter(regs);
 
-	local_irq_enable();
+	local_irq_enable_full();
 	nr = syscall_enter_from_user_mode_work(regs, nr);
 
 	if (dovetailing()) {

-- 
Philippe.
