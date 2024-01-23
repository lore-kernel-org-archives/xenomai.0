Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9275F863
	for <xenomai@lists.linux.dev>; Tue, 23 Jan 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019616; cv=none; b=ETjtPjbrHvhqqoJX1CN5XJihBGQ1eeY9SEK7c44IqGrJPMEADIc5POMKsuv/Z7Pvb5kkWttWzqN9fAV5sFBjTtVYlHT6effoW8gusQXITk18FPmNZ6gcQS6jze1Ehg76MviHOqDvmv7txsN5JMxCzF2IU9zg2OVcnob0I6eUjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019616; c=relaxed/simple;
	bh=HREHuyQVJYtOem3lVVtL4d+VnySUqOph0UCppnYMswk=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0+8KTY9onvi+PYnFKYCid33U8jG683GzfRQGHCo2ygeTRz2dgJfac7J/mzAoj/WP73ax+RePn44aIqGXf48BYqbjUI7Np49ADCCVKmi7ynHO2V9seenuIcfztCEVav709xucDom53umhCccqx9CLEucbRhibBzWGZkH0c2M4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=drotek.com; spf=pass smtp.mailfrom=drotek.com; dkim=pass (2048-bit key) header.d=drotek-com.20230601.gappssmtp.com header.i=@drotek-com.20230601.gappssmtp.com header.b=BOfjJecP; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=drotek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drotek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=drotek-com.20230601.gappssmtp.com header.i=@drotek-com.20230601.gappssmtp.com header.b="BOfjJecP"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso5830213a12.3
        for <xenomai@lists.linux.dev>; Tue, 23 Jan 2024 06:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drotek-com.20230601.gappssmtp.com; s=20230601; t=1706019612; x=1706624412; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:to:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJADpHvT6sjGl7GTva7qdl6E0NzKeb8ZT7Kciof5eDU=;
        b=BOfjJecPIfGtbga9dWGzJYWZ7aOVG4JenjMDwVwky9yKpKQHaB1rK47jgCGZpTtwOd
         xXe/NV21mCmuZbbg4WTjTOcaPLpJepcdQjaL0mxvsKKfyj0PXCx86PAknDKQdZjtrC9a
         MHdTLNicLjR8B5Mcc9DGtDTQ0IxbeKLUebO2/1PZLGrYAyeH0Bj/v7NWkatossMMVMJ+
         bFjyZq7th3O+jpCCiCuka1CQb1bpTYbjHYquq85rHkL/0BtkC0QdIGCEzmyhZ5mhgbCq
         gslQxbTmdyy4JyO4X9e0BqOrmxuagTpaNSaYL6ApujiieaZiuYfYlom3EcmLBGkNnHlK
         nYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706019612; x=1706624412;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:to:from:date:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJADpHvT6sjGl7GTva7qdl6E0NzKeb8ZT7Kciof5eDU=;
        b=KrvGUfREZFNJKCXnmQ3zDlApyXPWcu51txutc/Z345kc32lLmoBzdNKfRaO+rgUowG
         jb1Bl5Wr5u9QIPJpoEDlVgUlDo3kZqczEjjQQkAEUM1bFtfHWyfAEKIsBqCqdAEduHLF
         HFsEk3GZijtO27OQ+6v704F+KtBFtTlandSP1uTvsQZ1WpuDtFNHy/GfOZoWD8tZusIM
         QLQBmqNxTPDtg+urCMP+UMDrFjSkQKGpBu3EnW+mucF/8dMy7LgDcvpt82rhruqAiwAH
         9HmRtr50yTgxdnoXHE03D8+hj/7CLwZzZomxCMV23y4z9bii06iZRGpCk7jI1EPJWZW7
         JxFg==
X-Gm-Message-State: AOJu0YwvwN4CNB5rfwifViCsGxW3S1Zanf9EvoQq3mBH/FDfxyVH6QUx
	yZgib5tq45CyxyCgkwY71xkXFBhI/vRac7ck4Wb+axF/mTW77edRbumz+rdZ2aoplo7OKfCj2oK
	w
X-Google-Smtp-Source: AGHT+IHiajD/4naH8ySQtheCtFnYh2h5S8N/USHiwN0x+0lawOd7c2SG98+gk2T49koe7P2NH5hECA==
X-Received: by 2002:a17:907:94c5:b0:a30:70eb:b331 with SMTP id dn5-20020a17090794c500b00a3070ebb331mr924563ejc.44.1706019612426;
        Tue, 23 Jan 2024 06:20:12 -0800 (PST)
Received: from Edoras.gmail.com (apoitiers-259-1-37-199.w90-55.abo.wanadoo.fr. [90.55.220.199])
        by smtp.gmail.com with ESMTPSA id va11-20020a17090711cb00b00a30e1f233b4sm265191ejb.128.2024.01.23.06.20.11
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:20:12 -0800 (PST)
Message-ID: <65afcb1c.170a0220.d7f9.11b2@mx.google.com>
Date: Tue, 23 Jan 2024 15:20:17 +0100
From: =?ISO-8859-1?Q?C=E9dric_Ch=E9pied?= <cedric.chepied@drotek.com>
To: xenomai@lists.linux.dev
Subject: Re: imx6 flexcan
In-Reply-To: <87h6j5h4t7.fsf@xenomai.org>
References: <65aab24f.050a0220.e75a1.ee69@mx.google.com>
	<87h6j5h4t7.fsf@xenomai.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/30.0.50 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Philippe Gerum wrote:
> Real-time driver support with EVL is documented here:
> https://evlproject.org/core/oob-drivers/

Socket Interface is under construction.

> There is more than just enabling an oob path for the flexcan driver,
> such path should be enabled in the generic CAN stack as well for this to
> work, as this was done for the generic DMA engine, the generic SPI core,
> and the generic GPIO layer.

Sounds like a lot of work. Perhaps I should consider switching to Xenomai 3.

-- 
Cédric Chépied
<cedric.chepied@drotek.com>

<http://events.drotek.com/>
