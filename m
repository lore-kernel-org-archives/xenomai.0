Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD358339361
	for <xenomai@lists.linux.dev>; Mon, 24 Aug 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568867; cv=pass; b=u5oedyYbxmTq4WyXUGyaHoeVWouFTKSvBQDlr1Z0Dy1sUG33o1TrbRTyuDDifCj9XnqHeySmZM33y8bQgmA9K5wh7YC723wL/3TYVNobHaq384iBhPHZltrrXMs2UKPAk+fAKPGm/o6F1pLK+7G4bbpOm0Rjtf/2OBFDtd6n5Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568867; c=relaxed/simple;
	bh=3zO4tCJXDe5GeXIeQpgXU/z5KsbN3MuLQvMpWbEAbW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSKDX1oarG0F62UVWK/kqR+JtHbJc0ibGOT06tKiZAFElgothXL+vzbuim4k8AZMVB2wNdlejmjRNtoTll1bx3yRobQFGNJ16bKCUi73cmO/gcw5IIuHtZ0Y0dU1SZVlcwlCLfaobpkTdxIFX4xE+k4eFn5bQSCJh97AD2Ql4nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1NHcY2P; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1NHcY2P"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d53197d8b5so32078135ad.3
        for <xenomai@lists.linux.dev>; Mon, 24 Aug 2026 03:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787568866; cv=none;
        d=google.com; s=arc-20260327;
        b=p3Ze1tl6odR4E1/s+B3Ktm803U+rUSpZcg1eVDZkDAiFv9JQC0RFq80CKopPmndFFh
         Tlvlwc6m58D1t4V6nBbtMmQXWBGhM+fXXP5wQ+flKBrE3BtmWTK3JvUpipOjH4WgEHOR
         2lAKD+Hbuqq12t8VT3TZOm9CG1fUnnKmB5ivx5TfwKciBJIsgMouNQU5SDMNZa5ACUhx
         Xp3g4w/54eTmFu8EB9Ym5vheWHB8p7Xv0pfV1kNEGz09sVjjpcGylQZrXekuXWy3JMsw
         j0AU2OpNm/YYsvWTzXZlu69O1nWAO3NIP3R+0UZNudXM58MNdoX5hNziERN0LnJb7aYv
         8ZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3zO4tCJXDe5GeXIeQpgXU/z5KsbN3MuLQvMpWbEAbW4=;
        fh=25jYWcWnv/w+DQdyIKWjPcltKzttxJOG4ZqJ81GW/D4=;
        b=Fwg3NPe6OElh4xOy/i9XGBbpFuOlL2Aj8RDkdz7ejcluuRV5nHE4b6YkrzNsXQ3GTg
         TByKZlIGw3hJWuZPL9JlimZfovGlJEd6B6xCSEejILUxoEJcfiS0mXABkJIksvlyUq2S
         la86ahoXrA2ed8wpKsQlO/+8rdo4hIV2Jy7mPmcYWRfCkZoLAQN/gEmbv1Q8yJL7DOBz
         hwoF4EQwkf+ToQAq7vIqisggq6Bhkve244bzgeucozWriPxIxrQI1vIsw5VX1rUHyYiW
         kCOESbX8Lc06Rd2fDsTw6iKVcssQ2t8tfWGWMV7q6vuNaYUA7SLQTkLwESEVKFaQyx00
         A81g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787568866; x=1788173666; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3zO4tCJXDe5GeXIeQpgXU/z5KsbN3MuLQvMpWbEAbW4=;
        b=h1NHcY2PxSQ1CJ378BNAmFFPNu7XT1gH1e76hJU6d79d1rTAu17md5PbUOH1vZ79u2
         SB2LoXNkChNaJKidJXLlWop4lL8tohij5OBT/ZtamBALvAl3vasI9UjuTHKkY/dxc5zD
         bkq5wNt1Q8fQuqK+yL5GfHFnYPZbfewRIdEHBspdGUBG7Dc+n2D3lSdzip0oiGfwK3ha
         0LGL2Lc6TSm9KRxppY8eN+HfkQKUfhXpqKXJ3UHO5LatidbpQ4NL8Zj8GAq491fSAZSy
         oArPdFe2SYR/ZTEMucg73OkMlbjnb0dL6Rg4E4o4Ey/xg/ay+PhMDL3ckY5Qlj+fMg9G
         4PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787568866; x=1788173666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zO4tCJXDe5GeXIeQpgXU/z5KsbN3MuLQvMpWbEAbW4=;
        b=Unz49Pef2v8C19UKoLuEe1Z44eAz4f+kMK2Yhhtt+SeQFV4dRPTossNcA0/3ipcMeK
         7Q8ZvL1hj0TT9I/8g8nQ5w48R8+9hETfxY0kSMzM62TG7HWXRADVMhiigBtF6YwlJKqp
         mHEzxIaXRYl88EKfHIIfOB+iHM4eqAdv/phgulxMHV81wWEeAN/gLwiBKXdDZTpEY3r9
         M7lS5tM7kqjV5sOcOgEOiwyj0FScQDrKJoDiAruczKSuBVamh+xWyWWODdTgma7EqRoI
         Khi7GaL9Qk54YUjIZenyUCPwGwFNPpABdo4ZpvoUzjN43muDkL6vOBhJPSGDJSSJySFY
         jrWw==
X-Forwarded-Encrypted: i=1; AHgh+Rrkg31bKd3vRwwFdCTm2/tcYMUTmwenw5GXa38omYtaBbkVW67zdDWxpJPmOKZRIGpoo3g0bbAU@lists.linux.dev
X-Gm-Message-State: AFuF++ngskWVAEn/3wwiDSVKw5KlKM2kla47wmRZhHtOrehZlGWFEO8z
	Tve0OeDyCPVg63zJYNprWVq0LJ6G3TD6FHf16gxEhdKXWLNcGX6dQj8CMrVH+MmjlNvQeuEwQYy
	UOuCjDZ3UyGbH8wAQLpx3wUTyHwh8i44=
X-Gm-Gg: AR+sD11iR12UZ8jKHHgFGVLGxCL3rqEpSibvvbv6J2veBqgDfFw60FEm5VJjc7p8BC0
	hOS6Z8zFiNVjqR2MzuJjqaEwpAVVehststLiyDT8PZwSV/c2JPQV0XStWnx6TjOE63jU5dpiDUi
	Jm2nNrKBUcwKKOeG3QMDItD25eY6jjhow1qG2T1D5gH11ch6fuPJBDmM9PChCXitEFZQ3dEoBsi
	AxBr1/VHYBsNxZS/oDeBgj8sTBEIyqUSaIWhmJNeKxvpo2xfudSdauEODbMOEJvj7r3MY5WYAGs
	f5Z31VNOpEwNusO+NYvN/Hyjb4xARQjz+Dn9PSUwQIDKBGChD0tY1g==
X-Received: by 2002:a17:902:c410:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2d64afcc8d2mr418522645ad.7.1787568865924; Mon, 24 Aug 2026
 03:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com>
 <87bjefs6cw.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
 <a006030cc98da209b4764b5117c41d93fa3d9399.camel@siemens.com>
 <535f40eb-3af9-427e-85db-2afaf69b847e@siemens.com> <87h5nvl5ct.fsf@xenomai.org>
 <2894b9cf-09c9-44ab-945d-cb3edbe5fd60@siemens.com> <CAFLxGvwSE28X_PG2NsyhnFxq5SGjrS3WH9bhJcX4gyrroV2z1A@mail.gmail.com>
 <d8c7650d-d0cb-4fda-8664-177adec000d8@siemens.com> <CAFLxGvxXvMq5THr1i7u5AFUu2SB=HgBA7rikBMM=Fa0nskz8UQ@mail.gmail.com>
 <796829a8-f7f4-443b-8995-930ca11c7e6e@siemens.com>
In-Reply-To: <796829a8-f7f4-443b-8995-930ca11c7e6e@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 24 Aug 2026 12:54:13 +0200
X-Gm-Features: AcwNN1WV_McReC1CFcVOYsqVwaobwT7hD9y_o-UZClOmyS6nxk3Y-b00Iyt8ZWw
Message-ID: <CAFLxGvxLFfBwwxxxzQsWb-+jksttFHk4iX=hgnhpYRWWTr9nqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Richard Weinberger <richard@nod.at>, 
	Florian Bezdeka <florian.bezdeka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 12:43=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
> > Just to be sure, Xenomai offers no way to wait until a thread is
> > finally suspended?
> >
>
> Nope, it's fire-and-forget when you are targeting remote threads.

But the order of events is preserved?
E.g. when doing suspend, resume, suspend, resume, I can assume the final
resume will make it and the thread will not remain suspended?

--=20
Thanks,
//richard
