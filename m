Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB513B5A0
	for <xenomai@lists.linux.dev>; Fri, 26 Jul 2024 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021438; cv=none; b=lEk1Z3pFw2rsZ7Bd5uoWngwYcQKq2vOxDhw7Nf+3Uy9sSCNOosSSxLcuHrVB2pldiCtB+rGu1Auo2WTrg+8GQATE3WfMpkI+Kba6BqGR+RR9k1XQsVhVZgD4/Um2M1StxqIhrLk16rhNU5X5dnkupRqgi375VohL07TrFqv2Nbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021438; c=relaxed/simple;
	bh=uYsYRZh4aa9TLv2NwTd+Txeo7FZ8CD8oE4dUpiWxSqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IN51pPcss3e1DL32rmjYGl3zvlnAuYghSplJVkHHA3nNVEdzJ2ieJ4J1YfDe12EGr2q0XFAIAOTb5A1TUmY8YRn8TPcfPI0GAMW2fQx/jp6EtLJikxJMKob73SYoRdkruUt4UlyKCFvG8KUuH99mt3hgD7pGaneQ10nJ6GH/8F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a8caef11fso222059066b.0
        for <xenomai@lists.linux.dev>; Fri, 26 Jul 2024 12:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722021435; x=1722626235;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/34YOBivKbp1nTkSTO5B/ZBW1a3Anz71aSDqlvZuLE=;
        b=DIP4OX6yhSgI0E8oHhtex7GrP0EfgKkVuPfjWQbPn4fHjH2eLYMWkm1l3KXPblu8hn
         REMXhYBFsMrMFWE6OVVTkv9jdIIIF89iS3kbXY5oHY2dl2MTKggNo3g/uTuQP4pxEDmA
         ZiSt6EN/DQOC+iQMwK+2w5LEycz943bI6sAmlpUaaKcKkLO2DtwloF9fwHU/6rO11Uv5
         4PNPc5I+avbURDZVJ+TM2lQTRsVq3jSOdNV5jTHFaNRsHur1d69S3u0EiVQf0FogCVjR
         GUTz0Wsz4iZasGY34h3GALthjdozXrXzhJPxd7um/uVFiP4it1CiibkDhYnKxP1jOYlA
         tlHQ==
X-Gm-Message-State: AOJu0YziGFJflZx6h9azU3V2vCSDBHUoCjqt3/FwqbdtQLULG9sKQYs8
	CyHXG1EuDFjqmrR28MpuQWZ0dvQgTZXB8WEyaM2XqGaM01rNFVDJThaLUg==
X-Google-Smtp-Source: AGHT+IG2WslLgh9EJPHavADlcSJvn9aS0tQknpbNDayrRmaq/O/wzK9hhTpa9q0CSl6jf0qsH+ZSkg==
X-Received: by 2002:a17:907:7e9f:b0:a77:c043:5b5a with SMTP id a640c23a62f3a-a7d400ad8fcmr34716266b.39.1722021435230;
        Fri, 26 Jul 2024 12:17:15 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de90sm206949366b.62.2024.07.26.12.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:17:14 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
In-Reply-To: <PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	(Ionut Nechita's message of "Fri, 26 Jul 2024 09:54:27 +0000")
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87wmnmq8v9.fsf@xenomai.org>
	<PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87h6eprhbg.fsf@xenomai.org>
	<PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87cypdr5fm.fsf@xenomai.org>
	<PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 26 Jul 2024 21:17:13 +0200
Message-ID: <871q3g3qva.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hello,
>
> Any updates regarding this?
>
>


Stalled for now. Could not reproduce this issue yet.


-- 
Philippe.
