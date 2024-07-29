Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0315572A
	for <xenomai@lists.linux.dev>; Mon, 29 Jul 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263350; cv=none; b=h7Bg0mYbVcCLNXOypQmaERDdhLxPpCTXu1yKur2KfBgoyWi+m9ggHiFSdlKZGq70xKitsdUwI0PLxZ9IpMEiloO14JWnm3l26CRb7PIQG5kAIF9EMxLkqo+wi6EHQUlQ6XK7im1/PgPHMh2WoccZ1ZsjxycDx91m1rzCop0mdoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263350; c=relaxed/simple;
	bh=AezKp00vMoABp4vOGvV3ZWi2IY8LNRZdj1EmMHUvdYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GW9ppjj2G78OIccuC8xqgWnBeB2qR8F/zUkMx23tYQRr2COXEhgJB0Vbo4EwfKQQQht31Rd8nGuBymUSxhO8JM3cTqU7SVHy9Q2EDSeZdDOqLQMn1/nYeSnp3wDLhvJRElOtaADeRhQtS34Mj0uUHEwOkxlETqUA7K5P1Hm9pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-426526d30aaso17895155e9.0
        for <xenomai@lists.linux.dev>; Mon, 29 Jul 2024 07:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263347; x=1722868147;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSTYb0aIL3GmRlNrYJtj325KUIecij2M9wfKPYdLvjM=;
        b=niqNYIe71ThsZTt4WMNO+zd59uipDIbo3yiSNxminse6AhiUfpFU5cqAtrnY8hoHjE
         9aay4up2VOW6rv8IcejgopfvYaiMq4zhBNEIzWX2/Gy5KbmSVFpGV3R9JFTiXnVJqZDr
         7mXKjREsLiVdXeh8p+f7g+kW/0/taMwVDS0JKAdSpBO60fz+vxAjB1yY+ZsoYSqr+l/5
         ujOHx541T644QEx6MRxsI4ppUDUmGr+fHhwNXiXeNi8kM1aMf3CjNlL4eHAasNU/XeJw
         /jiOqNLiQqmzJ5VmgbOEi+5jVnoEdE6XHNozFE8Jp3QDiK/7DIHX/fode3Dsy4HfjWpz
         mnYw==
X-Gm-Message-State: AOJu0YzpOKClahoI9kPthy15BBG3Ppmdw21JBXgtzyNrmCef1pLdZnm4
	jVNvUivnaqdBSwQqf9d08A7MEdh6VYJRKetuekFc1EnoYGwcFwNbsYhG7g==
X-Google-Smtp-Source: AGHT+IG4PBwb6umHRhihEajPakMwCvah0s9DMIZ+zE/+peKmjMumMYoQlM3h5p9DOzALfTaSZGH9mQ==
X-Received: by 2002:a05:600c:4f8e:b0:426:5dd0:a1ea with SMTP id 5b1f17b1804b1-42811dd1906mr46882135e9.28.1722263346822;
        Mon, 29 Jul 2024 07:29:06 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730d5bsm185280585e9.8.2024.07.29.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:29:06 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
In-Reply-To: <PH0PR11MB5949E741DE6A97AF6E1A741DF4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
	(Ionut Nechita's message of "Mon, 29 Jul 2024 14:09:20 +0000")
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
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 29 Jul 2024 16:29:01 +0200
Message-ID: <87y15kff0y.fsf@xenomai.org>
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
> How is possible to help to reproduce this(EVL: invalid out-of-band syscall <0x43564d41>)?
>
> You need my .config file kernel configuration?
>

Yes please. Meanwhile, I'll be setting up 22.04 on a vm for debugging this.

-- 
Philippe.
