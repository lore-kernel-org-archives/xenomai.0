Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158B1CABB
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331830; cv=none; b=XSvEba6PCy7rQY2vhV/6hfc51lGJAyVZMvG58muZJAtpRO6PL5df8hstzchQSov8Qgf3NU17Iz9uuPdjPAUHco6Ihyl9ItkhVuPqjy0/Po1xo4L1Uh3/nnmk1nETb9fKUbNjN9BTCe/9Pktv+B5XGYhypEQCWUuKSaPsCAcQvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331830; c=relaxed/simple;
	bh=LMt/+xe9TCpaNNuqMyV0BQt0i89RQyNYEALbb8Cvps0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0l0zyguVy2pPAFmOdR1zwpXEr7LhMaLHsK5CpU1TFXZpAlY0I+EcwTjnrXe/ApeHcbkCQvFlJGfakYFeI2LT6lSz1a2Q5Zr/zjWzp4C4PX+mhpIyEzw7H2uULxGMfNLZq5RUkjbctdsvYgshsn5OiNVKXl9s8wrIJaRZEzmwzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=a2pLFHeA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="a2pLFHeA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3658197cdbbso3112531f8f.3
        for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1719331826; x=1719936626; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmplZcA5GSRwsjSqggiqgXUK44TWUYLzh0bJe0n9Nb0=;
        b=a2pLFHeA1cebFPJDYk6CaLGbjNoGInuOToEmYgd3obXDlONPFAMJGtLZzawdK5kRde
         DIV7ieEtbst2Ve/TioiJZQAVighYRfJLSljJFt4WCX3btIVFL7HPXCTYmjqMU72AJiOi
         1fyLbeKu69Kg+5SmnD/hUuhb4lkrEQqlTI9UAizdqJYh/UDUD494ShKWNKcBqhTkI57T
         LskKTsgahxt0XfzBOL2B3GQmchUmC9fPFF8zZv2mhAPfP5OJndJcrzZyWMO/VcRNIl2i
         B5C2UvjhuwgxIMSlRDPsNQpfsWMTckbry9Sh8mmTjqrcX1hZISA7nnAmCwhcIEdth7S7
         LRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719331826; x=1719936626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmplZcA5GSRwsjSqggiqgXUK44TWUYLzh0bJe0n9Nb0=;
        b=JVC3wdMznn3cvMcIcb9Qd3BTQnHUtktaF5K9TcCMyP+ZHuywyKcFurd43UibFILgX6
         Z73TZXOj3CkGd0m2J4epk6wyCWCFiFl3tkpvprPblPVT42W950kE+SP9pPT9fUVkaKWH
         abo5YxqQilP282wZNXCmmrROj4ybtUoVr4RY0o2FhN9D/rBI2iArCR1hZoN824/xmY5D
         L0aOrVLRxaa7utAvWBFtyvF/+jknZfjZZ3MIWQ92rrqEGV1aws4cV2pLF5/m6OAtn0/L
         30TZQKFGDciGCLHDVYxc8d4vvIKzzwj0tWxYjfQkxZYyqbvS5F5FPCdfp+Bt1ESijPDh
         ZGsA==
X-Forwarded-Encrypted: i=1; AJvYcCWSbCEqp3nLvO5E89w64nR7s6x0Q3EXNdMfEp4psV4SAlfdiGbMt2pxZ1EqAF+KgCGyWvpLKtzOn+MtzHIiFxujgnMDr4Zvuw==
X-Gm-Message-State: AOJu0YxJ/vsOHBYTLDBL+nzx5n6MAl1WtTueV6VuosSX7AQ3ZsAuEEjg
	NjC/mVYxEII1kzcM4H2L82YX77UAWfo+53TcgmmW8w4H+GmV1l6OzIGPfq7TEic=
X-Google-Smtp-Source: AGHT+IE8D9roWFBWS3uMHYSbT5qrvsUuzL9+S8t8Y9Nw8Cxaz2o6N2GKimhNttSPYZ1tOYoLtOhmCg==
X-Received: by 2002:a5d:614c:0:b0:366:fa58:af5f with SMTP id ffacd0b85a97d-366fa58b0edmr3283940f8f.43.1719331825960;
        Tue, 25 Jun 2024 09:10:25 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366f973b7e5sm4530337f8f.14.2024.06.25.09.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:10:25 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev, upstream@sigma-star.at
Cc: upstream+xenomai@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 00/14] Assorted Cleanups For prepare-kernel.sh
Date: Tue, 25 Jun 2024 18:10:24 +0200
Message-ID: <2240902.sGnKIMrFRI@somecomputer>
In-Reply-To: <35962c14-e3cc-48c2-ac9e-d5d36c32f0fc@siemens.com>
References: <20240624203341.6263-1-richard@nod.at> <dfd637b9-9ffd-4952-848e-5b57cde21ec3@siemens.com> <35962c14-e3cc-48c2-ac9e-d5d36c32f0fc@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Dienstag, 25. Juni 2024, 17:58:01 CEST schrieb 'Jan Kiszka' via upstream:
> On 25.06.24 17:46, Jan Kiszka wrote:
> > On 24.06.24 22:33, Richard Weinberger wrote:
> >> This series contains the following improvements and cleanups.
> >>
> >> - Implement --reverse to undo the effects of the script
> >> - Emit changes that work on any architecture, renders --arch=3D option=
al
> >> - Switch from /bin/bash to /bin/sh
> >> - Make shellcheck happy up to warning level, info level is still a lot=
 of work
> >> - Convert the whole script to tabs
> >> - Remove dead and in vain code
> >> - Various fixes
> >>
> >> Changes since v1[0]:
> >> - Rebased to current next branch
> >> - Reorganized patch series
> >> - Worked in feedback from Jan and Florian
> >>
> >> Richard Weinberger (14):
> >>   prepare-kernel.sh: Convert to tabs
> >>   prepare-kernel.sh: Add reverse mode
> >>   prepare-kernel.sh: Emit architecture agnostic changes
> >>   prepare-kernel.sh: Improve kernel tree check
> >>   prepare-kernel.sh: Disable SC2115 warning around $linux_tree
> >>   prepare-kernel.sh: Remove --filterkvers=3D and --filterarch=3D
> >>   prepare-kernel.sh: Remove interactivity
> >>   prepare-kernel.sh: Don't depend on bash
> >>   prepare-kernel.sh: Remove --forcelink
> >>   prepare-kernel.sh: Fix dovetail check
> >>   prepare-kernel.sh: Define command line variables
> >>   prepare-kernel.sh: Remove dead code
> >>   prepare-kernel.sh: Don't allow uninitialized variables
> >>   prepare-kernel.sh: Remove kernel version check
> >>
> >>  scripts/Kconfig.frag      |   2 +-
> >>  scripts/prepare-kernel.sh | 587 +++++++++++++++++---------------------
> >>  2 files changed, 268 insertions(+), 321 deletions(-)
> >>
> >> [0]: https://lore.kernel.org/xenomai/20240525115806.12101-1-richard@no=
d.at/
> >>
> >=20
> > Thanks, series with smaller adjustments in next now. The final diff is
> > limited to whitespaces, though.
> >=20
>=20
> Does not look good yet, at least regarding backward compatibility (we
> didn't change our CI rules, so...):
>=20
> https://source.denx.de/Xenomai/xenomai/-/pipelines/21335

I'm checking right now what is causing this.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


