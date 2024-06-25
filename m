Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D4144D2D
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351297; cv=none; b=nvaRJH1VpRGh53FVD+Z9Objiw5HhwlbvufshccFgfaRMu0nIhv2JwWBrwCpUbiCTqZbb9Rj/9pNVxkVGLuKNUWilk8Jf0gpdfsi53IRPBpl05UB08AfkdngXfyh+Az31N2bSZGqgY+1X58582vxuop4qZxtrRaTQZKJ+sDIe4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351297; c=relaxed/simple;
	bh=zli/xT3WUTEhCdEQx2uzqpIM8AE8kzoL7OlnIGkHt8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/Nd1Cmv9MatCJJjDU93S/Gewr00oF/h7ksAiMz7xbuc85OInGP6PTSoVWKasjqsJ+j5rTVorP50pC5D/LW5rPvyvpN3EDwiEfJZtwvkdTpL9VycXVD9zN9GpeUcqnGoaPsN8uB0+qAGj7HcMLAr6HyUnPBxdleY95u+Khx1zc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=GacQaD3k; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="GacQaD3k"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35f090093d8so4011227f8f.0
        for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1719351292; x=1719956092; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zli/xT3WUTEhCdEQx2uzqpIM8AE8kzoL7OlnIGkHt8w=;
        b=GacQaD3kzBBHFiNnUko57YFK6JoAXEu+HEZX5p4mMAw0G9lCGJFSkme5Oy1O5X+OYF
         9pg3PTSOO+QtWfBPj2u5EcC2hyYs9GmMB9LtaKU9UVQ3BeyOJ0uODnnP975NvydohCq2
         I1Vt5IhW3sZu3CnDuVcPUlt6LNbeL+9XXWZRp/mRSEnz2g8wP+UhLJ3fMT7OyuCHi9/W
         6EEcauMd1L2IAhYxWm3HdQE2TNDBAI/99IHFeT26wzun3uMPPHb2/5xGLg5h+1Pryxca
         6J1fFb1AYT+dPMkdL/CKbdOn2o79DxfV4l1MHmpFXpjMCTcZvd78xfuRLJiX377/gQon
         Ncng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351292; x=1719956092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zli/xT3WUTEhCdEQx2uzqpIM8AE8kzoL7OlnIGkHt8w=;
        b=q1tN/21cseJgJfuMBJm0pxtQgk1U7xHsMp2ItTpAxmTQDL5jL12qM8tzmEsAKmmIOG
         EPRO+Q7rYlHk/XIHjB7j9pRlFgKvPY9GmWuWKdPhhKa7bzQMvRYQ1TewrIYmguXMQ4ov
         0Nb7DbxTKzskR4r4C4aa0jhCfRmvGLc4kFf+xUzCOp5R/MYPNpH1aqL080wpYM3gqWbV
         nh8l6vgdis1eaV9BxZwix/yMp8FnktSAxVVU3a0rS9JA5EcXXUtDx+7XcVw7H9cHj9zT
         jJINu7rHbzCCruzccYg9OG/z5/Ofe+pzSjQNQSvf0vNCEZuZl+SiMfxc3d9NRRagNY10
         WT7w==
X-Forwarded-Encrypted: i=1; AJvYcCU0HHfrkYrVU8HP/nkpnCRZPp/UVj71B5EmTzc7DADkLI29fABgvLI9wgTZr1bvA3ARPVgYhYnnEtkdLBhkCDww6e/W7p+O2w==
X-Gm-Message-State: AOJu0Yz3gINd5YXat8RN2hUx1hX8pR8QfVjyancr8vhadMQ364ojYCf9
	5/4cJKGYhSlx5JfVtxP+zrqoxB7wS95EyDoclgoUumGToNXPAz57esmbc9PfpyQ=
X-Google-Smtp-Source: AGHT+IHbcTJMBGgpaRnXusrwlcZmFQwX2XDYPogKgiI3U3dEFIZndANdbHTp33RmLC4XvzgVawWb0g==
X-Received: by 2002:a5d:6a09:0:b0:35f:26e7:f978 with SMTP id ffacd0b85a97d-366e7a3752bmr6512990f8f.37.1719351291584;
        Tue, 25 Jun 2024 14:34:51 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9c1aasm13835645f8f.55.2024.06.25.14.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:34:51 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev, upstream+xenomai@sigma-star.at
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH next] prepare-kernel.sh: Tame link mode cleanup code
Date: Tue, 25 Jun 2024 23:34:50 +0200
Message-ID: <2189790.YxpEyTPbXf@somecomputer>
In-Reply-To: <a7ac3dd9-f28e-4d83-9b34-792b6d8905a7@siemens.com>
References: <20240625203815.24997-1-richard@nod.at> <a7ac3dd9-f28e-4d83-9b34-792b6d8905a7@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Dienstag, 25. Juni 2024, 23:19:24 CEST schrieb 'Jan Kiszka' via upstream:
> This is still fixing up patch 2 of your series, right?

Kind of. It fixes existing code which became a problem after patch 2.
So, this patch can get inserted before patch 2, modulo the $reverse check.

So, I'll send you two patches that can be inserted after patch 1 (prepare-k=
ernel.sh: Convert to tabs)
which will replace patch 2 (prepare-kernel.sh: Add reverse mode).

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


