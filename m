Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E31DFFC
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288624; cv=none; b=VNgM81BJ0QrVsw2WyyCPLcGk8KBJK6PbCBjthpD1z17ifYHyVoeet9/3DHWQsEJbCzPnjtHgd+QPUITS1rb/dS3QRch5EEFVBc5FV1gGCpLwF2KwyyUPyiB+z4RNWPOy7ay1d+TYSaJHFpABolCumv5Jn8MfWH6TgEIJLq1zrY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288624; c=relaxed/simple;
	bh=W30jvV/7or1ugX/mYhKJ/G1Uzj7sIjU4m3q8Y4XPJ9o=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=KvF3pwAU2g/9gw580yhaNyIGqUq92LYXC6MEi0kQ6K0xlcVIUAuMdzogwTIv5/UV5j3DWTau/CcXjJ28m29RXSNNAPzToPHoSjZZnCeOPa7blSOJyjFgxobjRw1lHQQhS0BOEHjvkbaMgXrTFH29juBl3noyq5/NHt9XfrQnIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f0f4746c2so858325f8f.3
        for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 07:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718288621; x=1718893421;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhc4aZmGiH2qnHYbFSvUnNuIwLHv6OHMC0Xh/ZzM9i0=;
        b=geNBKTmrIxVfXE/xhKxCv2/Jb0XVbmElHwRvpd5m8iVrSueFP6ZyKvf10lgTJcMgHb
         lqETPUnPM9R5fGfJuuehjzHKihEKS9gM0CSLG2Lc3pIuEkmUp/sDp37nXmmTmDpKgnBC
         oEMrKZS8+EObD4S/Mf8yyDUKRfC5DrwWUUIunKg1ePqvydrGJw4Vl3mSxFcyUTOxJNgw
         GQ03SFPNnGZvCquEQR7H2e7r5Bykw+wKcNE+5PRtQvlGRiHWMP+2Iz8sm0I0BaH2EoTa
         YdRjxc1bEkHXSA3jZGeGgARfWV2bfV0oCZzC0qMj8ZHmsFTAVuL4DOZKtQmejL3lX6NG
         XDIw==
X-Gm-Message-State: AOJu0YxObGBFBhAGWNVmTj/4jBVjQT2Rqhb6xNt8huWs2bOZZcapWUEl
	0mZqGFQr6PysP4HgF9bIUOFVwOO64749oRc88HFrVruY+YqsVy8t
X-Google-Smtp-Source: AGHT+IFF5vSq8d8uiClX9LB9+EUpdeNWJSFgxo4Ab9vF+GAuA83vnyWOQeLR205/rVUgPG/P4RipDQ==
X-Received: by 2002:a5d:540e:0:b0:34d:b549:9465 with SMTP id ffacd0b85a97d-35fe88cb0aamr3467380f8f.32.1718288621430;
        Thu, 13 Jun 2024 07:23:41 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104954sm1857879f8f.99.2024.06.13.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:23:41 -0700 (PDT)
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-2-tobias.schaffner@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Subject: Re: [libevl][PATCH 1/4] Copy dohell from Xenomai 3
Date: Thu, 13 Jun 2024 16:23:15 +0200
In-reply-to: <20240613134557.4013044-2-tobias.schaffner@siemens.com>
Message-ID: <87frtgrker.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Dohell is used as the default load generator in Xenomai 3. Add it to
> libevl to be able to stress the system while testing evl.
>

dohell is obsolete. Let's move to stress-ng or something alike for x4.

-- 
Philippe.
