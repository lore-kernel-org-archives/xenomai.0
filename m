Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98E3A4F5A
	for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109543; cv=pass; b=XcwPRzBgr9qaCEQs5rFikX81rJ16YLOqY443mQ2ie2rKt2aFZOKC81O7RR+TZfXD5xkrtgXgPnd3Pgi2jIZ0X6zUAz0eV+/R04VZu6twOUl9BIaRUI7sfL/MhMWtn5mYd6HvBcfOLMTA/0sbcocCwMSRsIwMelpI1h3oTPwC4vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109543; c=relaxed/simple;
	bh=e54ZSInu+cMAZ+p0YTYfmTmTkyYNkCHGNrDCsCsvKy0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NLkuD9lVmp4Y7m9IInt0pL1GfGd/k0xAB1+Uque3lABm6sFTMKDhDUS418vDHmY8KSTIC/kWArE04eRax2FWC5hydvMJfP0Li/9r6Yi5MdbcFQF1AFBXAB1jN4U2776pNDhhddNNR2+PACcUjNBHHIjTpdHhVA6tF2tigliGsYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmyeBh7Z; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmyeBh7Z"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a1307438ddso4680383e87.1
        for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 12:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776109540; cv=none;
        d=google.com; s=arc-20240605;
        b=PK4lhem38uHfZhsmGjJ4cvmkkKjLgZ37Ssffu+sJknj6j7QTZua826I0KB9gtmLYGa
         86/ulsqNVZTsacSMPFWcwp7NrRBwPFZkdTcLSFXmrKHoBJZO1bToVwPCHRoojDE09zWQ
         Onyu8NprTzzeo/hgmhq18Sc79mJ/4B0fquO34kkDg+26Ipd8MguxMz6/wayL2uu7yymI
         sCMNNMqg0UySpu1lVV5IYoMlZxNJ4npxXGEa8OP5TLwb5125nlCitoGr7trHtVsHofHL
         lSOGsI5QDLOUBjjPW9hEQRlj+0yy+sUyS7CMKpr4aRy+VGSSAK/YSQUfcl6mVYrLS+d+
         diBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=e54ZSInu+cMAZ+p0YTYfmTmTkyYNkCHGNrDCsCsvKy0=;
        fh=cj4yBrcjDoHDLV7XS7qxdttAHI5+/DEwvQLCfuMx/1A=;
        b=ap2pCeHRTSqirFjLdRfFtTxZwbaJgnbAPpTX3lENLebDZHC1F7H8FDKhLbvYC2FWaO
         EAKP2B9sdw58rH+xmLqdkHBFCFdIEUAHtQKX4ux7bVCfHupPN2v+1k9th/kIlkdZHLON
         DutMQKzNntSp1MsU1kgaqcy453mA4AuhbBZ0xye6P8zaccgznlOaqCT1S39IVetDOdt4
         DLYsAB90rhu0xsHRftXRVMh9jCqgD69SeWdIlFgrM6pyxWtyi62ct8X0+9zcgZh0zO+O
         xjiSf7NHzBHaNybIEyPLAtoVErzhwNI1AefXKsQgWvcfwm4rXHraNbybfYoiUGfaFoej
         pAfA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776109540; x=1776714340; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e54ZSInu+cMAZ+p0YTYfmTmTkyYNkCHGNrDCsCsvKy0=;
        b=rmyeBh7Z5IzWhoI02YNDqv7hEZ6oNEqQmxLcCfMiccvJAUde2VuaUhRU95S9lKxuif
         sq1Uzs5yZzDjF8+A4YZBL1ZCeikhq6O0SQsBaA0+VpcGEWdLwV+tSJHM4Yw7RDI+w+VZ
         Av/JvLjJ66QHywACgILT+km4zsHzC2Hk/vrQw9dFViyRgTrtg7Y+NJqLI9SqWtMGe73L
         TE6p43E9gL2dWDTlW1LjSK9IWZkYrxgcCUwsSVesBNZeqQ1Prs2XD98fU85XYtVOM8DP
         c7p/aGypQRUHG6ka7cuwbmFtw8+UraHc/vFTIDMky/uQJCeKRFA8dyQpgRR9mDQ0a3kH
         9Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109540; x=1776714340;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e54ZSInu+cMAZ+p0YTYfmTmTkyYNkCHGNrDCsCsvKy0=;
        b=HHsRcBqGIHfZLKWOeC+peZOGfiIc4tj2EpYtGNYhhJHUsip/ziWX1gkrZVy3X7xOzJ
         Z7OLjqcQReXcFfPGw0flAVBX1OIaJpzKRh0CmewaZjLvc7BTdlxlkG4UB4LaxNxzc/sK
         BbTn1nZ+9X+CELUjHfp9i6s+s0ZanJDMKtpLUnGrgHvRVJRTscIESIXVXyl4E0/d80g2
         TVEbnQka8yt+/VLoR4gWALndeb579il6pSXuLBAVD7aukchycTGCAtIQXDS4hZFYTrjA
         pS3304paL5z6h4UgdicKyuH2iFZ1ZIVuODQQ0ILlIucVrrHUiNrSgvz+sqXxKfqIM4a7
         dM6w==
X-Forwarded-Encrypted: i=1; AFNElJ+Yu0xRyLAhIPhHYwbC2aVKNes1byNIJfLM3M13hWaj2jI/2Gh9YqjN02VmrSZCGXOWycT19vkw@lists.linux.dev
X-Gm-Message-State: AOJu0YwTELA3arzqUvUv63aT601KdF05e7Vx8U+uAnxxQACk0SQGxW1+
	Y8MVcEVZbrhxfOsM8JXOA+f1O6dUdk1FE77GzgY4HzuUMSJsAN1Q0Uas23KCnuuqmZjyUK5MX5N
	J7yCDP9a36oHaeXPARDWYGVfwCQVby0Q=
X-Gm-Gg: AeBDieuoqmKAaagI9bxbWGcdez5yqRc2HgxIbQU0kCw3vn4xEnZI9ANKxbIsylKvnN5
	z1WzcdO4GMu2s/RWpHN0Z2PQGdhxENZxh/cqzDsCYgLEWv8SQaQqrdVpj2CmTepCkwqenqR9rOi
	+UvKHYol73xaS7d/V/rVamzHcwfuGtHtWOmQAvwnkk6jlFxo86bzn5dyWQ4B1P8NKwmAVWEzm/N
	v7DlcscESZ0LcPEveNkkWgvEdPlO0vR03GgrinvMfB0S2OUJiv7wXeEkJN0KiU01bNFqKn3d+gT
	AxNLr3YDMaVD8iOSDA==
X-Received: by 2002:a05:6512:3c8d:b0:5a2:b379:22db with SMTP id
 2adb3069b0e04-5a3efb4e970mr5853399e87.18.1776109539984; Mon, 13 Apr 2026
 12:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jay Sridharan <jayasurya.sridharan@gmail.com>
Date: Mon, 13 Apr 2026 12:45:27 -0700
X-Gm-Features: AQROBzAAyv8Hp8trSZiirH8KkEMzFsxiSmDfUqcVQOV09UpS0MULZTcWeu50jJ8
Message-ID: <CAGNKwhAAFtaLL=Cv3hpFDyL=tn=8=J4RMgTwGBQ0RB=9mA-Wnw@mail.gmail.com>
Subject: Re: Minor page faults from memory compaction causing in-band transitions
To: rpm@xenomai.org
Cc: Brandon Ho <brandonho667@gmail.com>, brho@relativityspace.com, 
	jsridharan@relativityspace.com, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I think it would also be very useful to add these considerations to
the "Caveat" page in the EVL documentation.

Perhaps some discussion on the impacts of CONFIG_COMPACTION,
CONFIG_MIGRATION and CONFIG_TRANSPARENT_HUGEPAGE, as well as the
impact of COMPACT_UNEVICTABLE_DEFAULT.

I know the Caveat page already has an in-depth discussion of CPU
isolation and SMIs, so it feels like a good place to mention it.

Is there a place where we can submit a patch to the docs?

Jay
