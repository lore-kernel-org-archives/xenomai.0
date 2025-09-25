Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285830CD95
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821135; cv=none; b=Mci9IvD2aYfU3433AXbG1b6TqvgJ1qRlW8AKWWhoDCy8iYN8a/V6qbSONC9hS6O4iJd2M5N5UG711HTfsVhRLNLg6pM7R0itneQzCqNVUPfMAxcFWhWvpuo9xrMcTgfYBkFcASAUeo114LHI0RldRuzlzUAxIcapxhylqYR1iAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821135; c=relaxed/simple;
	bh=5WXg6SjWG75Vj1CIHzrF/wdi5C509XGc/dwtbfqOmxE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=g/zR9jDZr8DLI/lA85M263rarL9o4lKrqgxX5nhpERlKzkpqCBGSk7HeGgqUWySNrYwvCBmVcVVSRq2maU3Q5UpW2wOnADJkcGFR5tIkrQCRaKhB0eoMU1OiZeXgOnO7IvxglCtIyKx42swFCp58qQZ5VipuEghXCV44TfTv9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=bz8uiICf; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="bz8uiICf"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-361d175c97fso11520621fa.3
        for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1758821131; x=1759425931; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uvuvpx5LmrV8/18kmxkeg4quNzDUHicZjtSPtAwEPI0=;
        b=bz8uiICfVR5sokot61jmupDQbCFhE+Tj8puRgVSRi2P+UK6zTYoH79DiBIm9l8yQjo
         RjA2Ca9oW+xQhkMhIlRleYzH3wTDpRV7ti6FFLMb2XoK+yshXuoK8Jd8nIpsHfm5ZoQi
         3V3GqYdRqSguEZLqRrMVb0YVzskYQvUhlv/Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821131; x=1759425931;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uvuvpx5LmrV8/18kmxkeg4quNzDUHicZjtSPtAwEPI0=;
        b=BpL3rvKBdGF9EX6ijx0HzoYV6M+c9Jcp0Bkff0wayhgfN0F/u0JxfeQom/oSKahJax
         Nq7+zKK0qJsDkNmKo8rWJllwPAKcPLCqtleIhRazY6yKXBic/7KuH5AthhlwyP1n7Vof
         7PEQv4H23QTPoMBZhqSVMTZHzGlU2KC0pxrLnT2tAqMQT1AgEdjQV4riYhgDNY+LxdpB
         Lm7hCP5O9YNcKgJSmzJY3ePpuT3vyaRbRfAjZfrgOwt0KQ1nOwOnHGKe19Bn3y0U1c0k
         tvPb6z3axdp+yVcPuKtXbvEjENwjMy+h/me0OkvWhF9lDdYebCx6q7/hSLBpXrpn5DlZ
         c6mA==
X-Gm-Message-State: AOJu0Yz93FNR6W9+6pc0nirryXI/YeUbfD7U9wN3eT3eG6hW58PfSZsY
	blvGxIFaTO8mclxGMm2EQiCY0aiPZjJhdLA7zVIBNCXcHTzjAEjxF0mEDlKtDjf/qSwAsjS0Xk9
	8EQ9U9oIu4czzNBPIrApXSt0VQLpVD+/fhn8IMVisacA5cSSIVRom
X-Gm-Gg: ASbGnctTkRmU2XQ5mUsFm4QE1fNEaoS74CjR0N798xbg2+SUUqlbs+A+mOWrAL3zQ14
	CQTNTbkLuUhL9+E0x9R2gMnCECiMaQk/2c59UlyE9Y0UgtQiRf+/DRRiPIl4wjQ6r22MlofSiiS
	C3N7d+6b9XvChUbH3ScUpUpw6lGERCBz3daG4gpYqkEWhS3Orcu0FtoWmLoPg/Biaw1KueDGyzi
	ZoyCIH/I3HwoNDpNrSOr0TQQ4RjpmLYUUd2RXtP
X-Google-Smtp-Source: AGHT+IFrSN4rnNnHOyEEvpTm3YLNPWT0siL1S1JTAGxiIAM94fmSRBr+Kfij4bXC6IvDSPHY54x4emgYhCYWvNeIaf0=
X-Received: by 2002:a2e:be05:0:b0:36d:6ae3:816b with SMTP id
 38308e7fff4ca-36f7d6cd772mr12935391fa.13.1758821131124; Thu, 25 Sep 2025
 10:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Thu, 25 Sep 2025 19:25:19 +0200
X-Gm-Features: AS18NWC3KDdb45hhLs2RRifixkYf0s-YZYi05DJcr7H9UdAEMD2N1eXi9OKowgw
Message-ID: <CAFc1U0vEL8-2vhaZpw5wHFjxCSMPCniQWL5AL7R_w+kQC=5PMA@mail.gmail.com>
Subject: Running main() in the Xenomai domain
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

Maybe it's a silly question but I think I did it some years ago but I
don't remember how to do it.

Is that possible in Xenomai 3 ?

Thx

Regards

-- 

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
