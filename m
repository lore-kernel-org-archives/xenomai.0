Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A27D5FB
	for <xenomai@lists.linux.dev>; Mon, 18 Dec 2023 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ53+trV"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3ac28ae81so10140265ad.0
        for <xenomai@lists.linux.dev>; Mon, 18 Dec 2023 04:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702902787; x=1703507587; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wuiv9sCFWQ5zcEflTCsLdm/Lwpp+MtGkkNzRT1zROPA=;
        b=HQ53+trVjW+qdL6p8b2niyLSt27tnoHQghVpa7HlcZL7kqYb2g5sA4EexhOaDtBcM/
         DkNXx9P55nR/oqmIWBUrykm1SRGyQm6Af2mcTQDsyB66mMeNDklWRtieDZrfVKWuTluj
         2Qqi88jBgs73yveK/mJyA+Kzk10PIGMqmSaGKNqDg1Qq49ZdyC7ZPh7Z07/o/rWaVBSG
         E0dsKyzNhFwsm0vmpfR7RMk8Mw1QHGfUHPdE1ijWMKmsByLmNAaqYpTAdqN8CdvdPLBk
         ZwXQzP+g05Uw3ECXAUfu3FVdaFUf73Pq+COtB3dK3dQt1oJEjXetUiM+lFDuMgvn8hlS
         SaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702902787; x=1703507587;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wuiv9sCFWQ5zcEflTCsLdm/Lwpp+MtGkkNzRT1zROPA=;
        b=vtf4EWUwae/ZLnmTpoQH8P/ny79zfDC8YGrGZ7frAKZ/YEWs1wEg6qGNf3u27POQED
         cp86MwDSflLBpvykbnrlN3Avqt9Vw+5u0oLvGPUby3/WNgliDmCpTK3REep5+z+6FM1q
         04GcZHCB9GI9TiksSIwtsKNbgBhtn+hQzIMi/X7zE31nCkoiYJJDOOOuLB84uOMDbpJt
         Dt8MhBnzmIDK0L7uIuF29zlVKBZzlqz6Hglhsd2fzsTy7tOEt6VXKHL6G3EI0kjzR79t
         uroilLLRUINV3la4IcBfJZYYSMbbJMJEZ9xGaTBTNyqs2izSxOOyOleBeTb6DbxCIo4l
         O6jA==
X-Gm-Message-State: AOJu0Yxo6OR3MgW+m0nEUKhnUuKRlG7dNiPnXZArIcFt3c8xLJRzAHUu
	8qM1IdhOeRiftxB82fMbGJKHQ3bUMGvLvYPyD/6foNNyfGo=
X-Google-Smtp-Source: AGHT+IHgJkSVf9S/8lnhhBCoApc23+FFNs/C0Zem+Co0M2J9FY6I8QwQBZm80PDHEEA+ZQPTwmNz51cB7vtoAZpgls0=
X-Received: by 2002:a17:90a:c20b:b0:28b:9662:e849 with SMTP id
 e11-20020a17090ac20b00b0028b9662e849mr531401pjt.86.1702902787155; Mon, 18 Dec
 2023 04:33:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Mon, 18 Dec 2023 13:33:24 +0100
Message-ID: <CAH0t8y2Y6OP0g1c6duLKK6GnEjd2AYtsBfGJp_GKUprz+-kz7Q@mail.gmail.com>
Subject: rt_e1000e and Intel i219
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear All,

The current version of the rt_e1000e driver does not support any Intel
i219 network device. I found a mailing about this from 2019. This one:

https://www.mail-archive.com/xenomai@xenomai.org/msg16000.html

The "unofficial" patches (created by Gino Strobbe), that upgrades the
rt_e1000e driver should be there as attachement, but I could not
download it. Probably when the mailing list had been moved to the
archive server, something happened with those attachements.

Does anybody has those patches? If yes, could you please them send me.

Thank you very much,
Tamas
