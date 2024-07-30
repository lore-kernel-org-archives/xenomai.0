Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CFE86AEE
	for <xenomai@lists.linux.dev>; Tue, 30 Jul 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341453; cv=none; b=NPpw1KSrdvw4Kz3Jhz4VV3aKQKNh1qaznJod015PUCvJTKt76/ugcKaAYSUtLGBQsEqPd3c6m2pDCJleCq0t65GVUspuc5gctim8MO1az2GuUtxt2I73uiY/qyZ86goqYOsT5bPPSKbKZn/dPIMuJAI2qB+jHMhRDvk2f8C9wvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341453; c=relaxed/simple;
	bh=8zYP98QlfxyVIx/Sa/UiCcfYcs0e4Hh529379Vg5Dhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=utm4gzB0/fsRVaYwhpmjOKbRBOlxkNHtaW3xMdCgq5hMKHguwxirMr+eeYK6uKqwNAMqtt4Pyd7ztYJK3CsoyEIn3FeaqGZsJRe4qBRPrJJl51CbEAw57VhIAkdK/W6u9wPhQcw/wvYrh2z/PsnoulKrbAEEszcZMaHC1mfhtNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42809d6e719so26538755e9.3
        for <xenomai@lists.linux.dev>; Tue, 30 Jul 2024 05:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722341449; x=1722946249;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By2fCLvgCBK+62/VleyJc3ongzr2bWGLJqk2JGRVX4Y=;
        b=maefGYDBE7wcSacIWXDhy4VyCh2wHvo8RIC/U9ynZeLA2xz+J0trdJA8FZaamIdQpM
         ZuRD11ARnU6BQkWMRXipE8/ozoildmuL9RVY1tVRa3sKVCRoKovy2zfKITvRVnW4E4mO
         LBe9jpnXt9su/tqvOIgLUHNcG9eCvtgFtMlRTZAIefDXiWDECQ8rVAD5ECM8mxL0uCxb
         2DPOo3/8KwHIKLK3fdB2zOajg6nRRAVotBebDclKWZb9bDg8ZxDwp4wGbyAtiKpEZ8ed
         FgnhB7NSk5IBs7cO5YPSNoVTxVgHJ9ZTMLneC9YIvGdqc9tn+SXKXRPzNfKcGz+xe345
         e/9g==
X-Gm-Message-State: AOJu0YyfB6/xtNg5yVVF8qb9Idpxy7Quz9sOKzyuIESNG3AbqQbyvoaf
	rQm+Gb+Jvu1050LnoArfNXHq74nEVxHE99pLtRs25RMeSX6nz0CsteNIBQ==
X-Google-Smtp-Source: AGHT+IFQdmVGGz7o3eWzfbQ21hBupyTh44uFt9IkScklz6CpjTM1lg2RYy7CuxFSSEJ2mSwQl9ciiw==
X-Received: by 2002:adf:db47:0:b0:367:4dce:1ff5 with SMTP id ffacd0b85a97d-36b5d045942mr6604505f8f.32.1722341449079;
        Tue, 30 Jul 2024 05:10:49 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fd071sm14597174f8f.62.2024.07.30.05.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:10:48 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
In-Reply-To: <87ttg7qkx7.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	30 Jul 2024 11:38:28 +0200")
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87wmnmq8v9.fsf@xenomai.org>
	<PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87h6eprhbg.fsf@xenomai.org>
	<PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87cypdr5fm.fsf@xenomai.org>
	<PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	<871q3g3qva.fsf@xenomai.org>
	<PH0PR11MB5949E741DE6A97AF6E1A741DF4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87y15kff0y.fsf@xenomai.org>
	<PH0PR11MB5949AE14DD34B53E647A0896F4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87ttg7qkx7.fsf@xenomai.org>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 30 Jul 2024 14:10:47 +0200
Message-ID: <87le1jqdvc.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Philippe Gerum <rpm@xenomai.org> writes:

> "Nechita, Ionut" <ionut.nechita@intel.com> writes:
>
>> Hi Philippe,
>>
>> My .config kernel configuration:
>>
>
> Ok, this is reproducible locally now, thanks. Will fix.

Unfortunately, we have a conflict between some regular prctl(2) command
codes and the Dovetail oob syscall marker (PR_SET_VMA at least). The
proper fix is going to cause an ABI breakage when it comes to oob
syscall encoding when the prctl() (sys)call form is used to issue
requests to the real-time core.

-- 
Philippe.
