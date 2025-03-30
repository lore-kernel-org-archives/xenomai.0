Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B18836
	for <xenomai@lists.linux.dev>; Sun, 30 Mar 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743319267; cv=none; b=E/lQc7Sdx+KYrgn7S0328sw5bfsZY4PgcSqYu21x51sBF9mIK6mpyYip79PzPZFumssOcRELbMsf30h/hKYkcBx3g9Hgn4elIAw4hgKO67uuB+XcZ/M1y1mElgfw5kdkVCRFoNhThYXgok2qeTjbQofNKzirr0R2mMsOzlRzr10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743319267; c=relaxed/simple;
	bh=60MIE3ZlhQnas0kP+glU0/wHtYn5NAIR6B1fB+uC5Vo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YSDaNtnduZwkXTTYweluxOqgdzGdPsaKZ0KruWcBgZV+6yal+23yns1zHphRW5YJqPUhYNC4lnC0FnCUm2ghS6qJksZ46dzy9LRxArAbIvPURwv/qA+31kuDXA4nMexeUruFOyWd1aUpE3wIoqBPXvYF5WQIC0hZ0H3IuBoW07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=THqEh81H; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="THqEh81H"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-549963b5551so3526583e87.2
        for <xenomai@lists.linux.dev>; Sun, 30 Mar 2025 00:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1743319261; x=1743924061; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/AyZ5WMpp1zzE+ISUO0eXD+JMa3JJ02Qi2c4mTf3tNU=;
        b=THqEh81HcFPNJrhkjKw78Vhp3zlsC2EQqXQ2iHhHdJJtw3A6oupDmKJ2h+x0X2ikAT
         J+rWYvMKBj71tB9DzNOCo+EuDRLh+YhlWN2ne4NizugRwxSyJT9X53XD3SIn34uNwPEG
         dADHIzNZHXenrqzVt1ia+e1TB3lryEkwn8USY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743319261; x=1743924061;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AyZ5WMpp1zzE+ISUO0eXD+JMa3JJ02Qi2c4mTf3tNU=;
        b=qvR3yWb8Kpsblow0UGYbker2ILpzWcO2f5KN+++4moY+NA/0SSNpx9enZUNgoGclgQ
         q2n0TfO9CXp2fwrkzgtKewKbPaRhTN39y6KSwT4ZpJ+Zy7cyrSEHWWoytipX17r4P0Qi
         Fzlc2+MTxhBmfLQOEi4TFK5PCR1cQVfvRuqO4CZpXr827ElrzCWkHSCYYhFuKWMpr+Db
         sZEwaahGPVxOOY+3dLvGWqxk5m/Vr6nmNQcWIunAa7nNPWO+eICqOEsGQ5TIg9xBkBrw
         sz0uTxHNUyPMs4EzpA/HRXYBv/s8P4gROFsAK+jYROCvr0Xcmo3RxtocPGR0JBq8APfm
         XM9g==
X-Gm-Message-State: AOJu0YyNcEY+yizeJfOfyQu20Pyb5yXsa2En6tY7BNFgEN0Lo4CHswA7
	tJ4ULArh1OPAOSG9YZX1QwLox4jjNEizqwX7GGAa8nVEPiLVPw4KDEPXk3+AY8JKH7SxPSbT/bl
	bfYWG34ICKcHPEJ4pQniJph0Aq++pSUQlL0MVo6gjmERthlox
X-Gm-Gg: ASbGncsXNYJydaUCNA8PtXbo2JV6AjurZfQPbfBq8Lv+zGmRDVpYxHIuhcJjxEe8M8/
	O42IUQLE5lWz4Zwl4wAnUth+hKI5KXgMkUq85mxIvYOSK1dWMSLZFL47WsBxa4SukvgvHHYmtJP
	BliMScvWgWW59yn/XFl2PvusEZKpYdvVHARI6CC/CkibQZwerL6HgE/80NXw==
X-Google-Smtp-Source: AGHT+IHCF+Xg3a7TThysYgXatVgLpkCsWQTJC9BXGSHSrVe05Q8EgLBAt10gG8CFuw7Pos/oREcPSb/4lpkrh/SffsM=
X-Received: by 2002:a05:6512:a92:b0:549:91d3:4f0f with SMTP id
 2adb3069b0e04-54b10da72b8mr1374707e87.11.1743319261424; Sun, 30 Mar 2025
 00:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Sun, 30 Mar 2025 09:20:47 +0200
X-Gm-Features: AQ5f1JpNzVF9UWHIS8s9qQsPJDx6sc4a2AdW2pz4qD2498BrtEn8V2u8LEGZYiQ
Message-ID: <CAFc1U0scz6GaCTgaoXFzq_KEtNw-GAeJNbQnMR5qeSw2Y0fOHg@mail.gmail.com>
Subject: Building SDK in xenomai-images
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

Is there a way to build a SDK for the target selected in
xenomai-images? Such as the following command in Yocto :

$ bitbake -c populate_sdk <image-recipe>

Thx by advance

-- 

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
