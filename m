Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046223E351
	for <xenomai@lists.linux.dev>; Wed,  9 Apr 2025 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192071; cv=none; b=MZK279+l7rSG6zmy84a+zhuIlN6T7bpKY6f9kE5Dd009ncAhOt76+MwL3F7zXyTmQPP/RUhMjmZ40jkjzuEO9rj05ht3x457mHYqoDwF91eih2twNjD3ff124zXE7aucQrOpLSNhoDy4TkYRxQZWiPWIYEhKG9j3IJuWDRnWZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192071; c=relaxed/simple;
	bh=CmFtnnefYn/4Mqat9quvyqGMhEKY/tTjSaBczDiimqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhoU24/BDFOecEad/A/MHoWK2cf1EiCUMSkd6Yv77df5yGLWD6ooaNLBKxVMd91muy7WjWrnI6Vo0t99K+d9wrK8IwuJYGZgwLnt5ZTQ9NFYZjEujxAum/hjX95JSx7xyGnuMgYhRGPMdCIcyPL9crEfXNrBpl6gl7WNDN3QQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=lA71G5RP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="lA71G5RP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso31443045e9.3
        for <xenomai@lists.linux.dev>; Wed, 09 Apr 2025 02:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1744192065; x=1744796865; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmFtnnefYn/4Mqat9quvyqGMhEKY/tTjSaBczDiimqs=;
        b=lA71G5RPk1JXiHMSpDXpuV1LAT1B4iU2oXyCGp3xVeM2y2QcEsHIS9VSIVtSB4hxtq
         kidLVRA+cFAaZCZ3AiVdUKDnhuHMS1OZf/B30ooFh2JFSARy/w/+VZbsDi7cVM4DYYgc
         gmAtnwKSjnLldN3YROhVoLeMOSE7bIWkJJFiw/+rp8SCsEgQ9j3rJW3kM88wad2vxkq8
         Jzio7Z4GAWp+bJkjF0JFN1XtI6OR7bKBF17n8IEceWkOGjZSRgwNCOg87AKn6GKHaPgI
         m1J/VBCXKdZ//P3pp+HK6lU0pbyh3gwOfK+PzMOkdmSnDxDuAkYE6kahwF407nGqRWnQ
         20Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744192065; x=1744796865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmFtnnefYn/4Mqat9quvyqGMhEKY/tTjSaBczDiimqs=;
        b=BVAv0GMP/5Ohy2ZdOFdw0ObRyHdzEnlRAy+qoR1TaffIW7uzsN6RLDUo0Bzz+TTHbA
         2xMObbx5TTRGFw5ajDd6QBznGqrumW1S6rgWbocQJ33bysBJArxQuMQoXGXCsvonbJGg
         6ShMbfuPs8z/wu9lytVYnOiNsCkqjadnscNNiXI95Ujs6MpKOD2WixN39ZHx+ZQhIZcM
         deV4jXaA+12El1GRsuCj9xHJNU+ZW7brwfz7P3F0tgI6LSLMef4H3I1kgpTEW6SIW2ac
         cmSaoI3cIJToiw+VQr4Y2f3dAZM/wDlpHHYDbnO6uNJwjQXFHqscV0BQJobVHwkJGgb8
         eZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWlHylLUu8gJSj32HKrG3jAGUw45Jv3IaseER8WaU85x07b/TRoxAauOFSDRlbjrmp15A9MREYZ@lists.linux.dev
X-Gm-Message-State: AOJu0YzphrmlfTn4H4vW6M3QRbv0J/G7yfGYOxMpxkCeQPDXcRLipsMO
	WMIaynmXv31dBWO50Yg/ZdfGatBYePEmC06Y44KVCXeo+sKpfKhceRzKVNaRXSE=
X-Gm-Gg: ASbGnctD8XCi8hVc5KL3Cmaw4UPbumhul70pNEWEKh22GGdWg1C5L32zVxIIaEPzIS/
	XERsNArZmPFThFl/G8FXE7mo5tPbDF/C3S9FnwyKaXeUccX/8eLfvzUzXy2F16azgYe7l4nRiY0
	dhLZpeEipG+KYyhDU3L51mIvAtKfT5rn4R2wXk+LeX508tMTHJHWtmE9y+YFKjaxl7Xs/X7pnvD
	oJ1GcyjayUgIwI2nM2cGDC4zQsVXmsTLgEXQcp4gZNbnRDXeFV1YNt3cMtJp1GuUwxMsPqqo8Vx
	eETtPm9CULE7D2jOVWVzcDlYSd/vYbQn5D85qwYIKyjaGk3OmZNh9RTSpV1ymu5VSNV4OAN+iVP
	pIFGjTSRW
X-Google-Smtp-Source: AGHT+IHVEdI+mOk/N8w5USmfe4EwUm5mej0QxvW4HuzsnoFPi557H3ycHbfIve45QWETK/E8VxcV3A==
X-Received: by 2002:a05:600c:3ca4:b0:43d:fa5d:9315 with SMTP id 5b1f17b1804b1-43f1ff4729cmr11342095e9.33.1744192065240;
        Wed, 09 Apr 2025 02:47:45 -0700 (PDT)
Received: from somecomputer (84-115-238-41.cable.dynamic.surfer.at. [84.115.238.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm14597655e9.22.2025.04.09.02.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:47:44 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev,
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 Lorenz Kofler <lorenz@sigma-star.at>
Subject: Re: [PATCH 3/5] arm64: dovetail: Allow early return from traps
Date: Wed, 09 Apr 2025 11:47:43 +0200
Message-ID: <3083486.KX7oQKdZxJ@anvil>
In-Reply-To: <a28841a2-cb96-4356-93c1-ba08eb954210@siemens.com>
References:
 <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
 <20250408123423.627477-4-nikolaus.funk@sigmatek.at>
 <a28841a2-cb96-4356-93c1-ba08eb954210@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Dienstag, 8. April 2025 19:06 Jan Kiszka wrote:
> On 08.04.25 14:34, Nikolaus Funk wrote:
> > From: Richard Weinberger <richard@nod.at>
> >=20
> > Like on the x86 side, allow early return such that
> > handling the exception on the Linux can get avoided.
> >=20
>=20
> Which traps can be caught and fully handled in oob this way? From my
> past experiments, that list was not very long - and when I look at your
> Xenomai 3 changes, it still isn't. What was particularly hard: DABT and
> memory access faults.

The list is indeed short.
So far ARM64_TRAP_UNDI/BTI and ALIGN look good.
=20
> Point is that we need to have some kind of consistency, between the
> archs and between the reporting information (Linux vs. OOB signals). Or
> we extensively need to document where all we are deviating (and ideally
> why).

I'd vote for the latter.
Plus improving the rt_signal_hist test such that others can
test whether some exception handling is good enough or nor.

So, I suggest exposing more exception but mark/document the known good
ones explicitly.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


