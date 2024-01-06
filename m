Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E57101C8
	for <xenomai@lists.linux.dev>; Sat,  6 Jan 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mytra.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mytra.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mytra.ai header.i=@mytra.ai header.b="WXaT5wlx"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28ca8a37adeso642193a91.3
        for <xenomai@lists.linux.dev>; Sat, 06 Jan 2024 14:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mytra.ai; s=google; t=1704581427; x=1705186227; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oX90y7Zj6Uzy9JjCRoN5vCfNKbbqM9KU3rizBVWNn9g=;
        b=WXaT5wlxG7jYnqyN59cAFcG8lV+sqDN+QXGXd/EdNkYPexYolm+DNQmSKmFwqWd9Co
         1NOmeHVH9+9NzpNtpFXUpkUcWq5iSVML1eMuHhljRloQENaHf9YIVSlbV3zSD5/begwG
         FS2FT937YpaYECa041q6eMcwB5bIPBitif3qJdpHUhLqPND0bCp+shf7rEDBS4KrLv9q
         6/PTI68jdO3SI5h0zaUEQdd/XEWBC+qmvg4HnfeVRR308od61cRUwpdkaKSo5pVK1Z/V
         2obfnKUsChZ8J/K6ZNQ/1HLFW34YujbyQ8iYeYdeEduvdLBAC7EvxYbJYZGNr3fmrAfP
         3J4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704581427; x=1705186227;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oX90y7Zj6Uzy9JjCRoN5vCfNKbbqM9KU3rizBVWNn9g=;
        b=BKo8qn8SW6c7V2CpU4FdycfFuHTJzdDgu7JYHKFotvSKyFeLnh0LeagO8MhxnVcITl
         eLMM1e8QD3eLAVbyse/7ZddN4Qq9Z3UqqcJ1Z0tD6YNaqE9tAmfsPjjA5Kn1vTJOg18+
         XHn41u/xHo5P+59x83SHE2O0rXE42m56ocZUK8MVzGSeSBh9EmsaosUrkFdEk8DnUrTn
         2JAw1Z/APTx+aJ+FqaXx5ENEPIbLYElh6v06ojTD+KQbMd2fokrdUD/Q0go4THz3znJR
         H1EJefpm9/lmrRmi7Kx+S8yl85gdQVZI0F3ptxTTFgpaGGVg95gozvVEbezhq83FQnvl
         bXMw==
X-Gm-Message-State: AOJu0YzUziQGIzQ0Je0QDBpSGVYkg+2+UPyOUrT98yzJ28oxZ/+wIrh3
	RKJJpRY9gr0G8WpaR8ZzW4CjnOWDz/iEZAlNBDS3CyiEUT5d7wFLyi3Ljw3fZZsw70lS
X-Google-Smtp-Source: AGHT+IEclYQ+UudCn2wwTGNA3g83Svk8DQ5iXzy9bYPueetI2jnbDBj/LhTHcTy5DzrU9c1zA/s6CtDEkvi4IucYet8=
X-Received: by 2002:a17:903:192:b0:1d4:91ac:ce9a with SMTP id
 z18-20020a170903019200b001d491acce9amr1913512plg.135.1704581427128; Sat, 06
 Jan 2024 14:50:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Mit Jothiravi <mit@mytra.ai>
Date: Sat, 6 Jan 2024 14:50:16 -0800
Message-ID: <CALB5FwhdXM=a6H-Rz63Ww4yE7hz1gTfi4MHdpAdKq_f9Ba-RDg@mail.gmail.com>
Subject: Inquiry: Xenomai 3 Compatibility with AI64 BeagleBone & TDA4VM SOC
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear Xenomai Mailing List,

I hope this message finds you well. I am currently considering
implementing Xenomai 3 for a project and would appreciate your
guidance regarding its compatibility.

Hardware Specifications:
- Board Type: AI64 BeagleBone
- SoC: Texas Instruments TDA4VM
Operating System Specifications:
- OS: Debian Bullseye
- Linux Kernel: 5.10.168-ti-arm64-r107

I have reviewed the supported hardware list and did not find specific
mention of the Texas Instruments TDA4VM SoC. Could you please provide
any available information or guidance on the feasibility of setting up
Xenomai 3 with the aforementioned specifications? Any insights or
additional resources you could provide would be greatly appreciated.

Thank you for your time and assistance. I look forward to your response.

Best regards,
Mithun Jothiravi
