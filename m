Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4EA375F82
	for <xenomai@lists.linux.dev>; Mon, 24 Aug 2026 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566861; cv=pass; b=WM3Ks1nLb7t03yWWFHsjuGPbt/PhV7YsJoD5ATgdUkhjjNgPZ6SyTeVnqOKruA1w/zxq3fMrQQSINopaI1uM2j9AzMRpbT+8b6NQbU2QKPetJedAcTQpaqXa/7kzM48a4ZvUv3y5g+tDb8ARbVFBaQaXTq1st1oS67A0kQvFEMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566861; c=relaxed/simple;
	bh=Mx319t95qSI5TOZ4yPkLlQF+qI8BgepSHceojtHSPMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlHkXA73UlToMtAvcntpUB9Srb1otWcUFwaNUYO3oHuLqOmJWEe7QNfLMwFlSxSxjfKNzPvGGHdFtw5Br+iebMmA94T1XXJdUQr+hOz2Zi65A/Q3PJnv5DBanJzFnxCZE+XampMwt6NN5HCbmGmWpuGwit1eqjn/R9a1j0pauTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/a9AWVX; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/a9AWVX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d530328efbso27588975ad.0
        for <xenomai@lists.linux.dev>; Mon, 24 Aug 2026 03:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787566859; cv=none;
        d=google.com; s=arc-20260327;
        b=CsUFJMrUMrHA2P/r6pMJg2zSfClzGsSHto9ch2a7bImxqegzP7C0iKN0OQDS98V9S7
         gkNCxBYRFPsz6d28DKr0htW36v5e6ZexZv9qtZyjjZoDif+t6EwfZveUK1AxFPI+JjRA
         Oc05jru8w9RFbXjr9Lva/JUMAnzHz2xNAdTiJ7Nx3Ac6bNLe5X7aXOx21FyDDV11vK2a
         lER/aL3W8lwIZHlPAXWguqwzuN+iRDVzxLkarqq9sHSj+fNwfD0Cz1Y90Kgc6Pmi/K39
         59UzZxt9K3Zh9DA1qw1c52K39S6eNw6bci2nB8sQ9US5uoWrB9Px5QPhXspNezlq3CND
         iYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mx319t95qSI5TOZ4yPkLlQF+qI8BgepSHceojtHSPMo=;
        fh=BRf0IsbtH2z4y188Kjopq6KZF6xycslFj4WIy4xxTnE=;
        b=sT+hNkkKN55gb8Oq6crr7Zm4mgxM3EP8bBrF9+BegAK/5ZHsc+SNHWnQTOPKYdGFU9
         smQUtPnOlayGvXmRbnynC0uh/xCr5FKkDdaBhvx4t80EQWFS02e2k2ZaBkrVQM6ntxS1
         8MDk10IMPjKVg3cyU21Hb+15f1MZS4wFOoGeAB/rYH5QdP/guWVLRlxOTL9wXGIasE83
         kS2ngCKp7HB+/nCLyTzRQWvb5JuLkMugDGPL81x9TaWJ0L6DLBgKBsf948fI2Q5CRL52
         JwKrN/PTEPr6yNFENES29ed5Z8StWUwVUIbk3/iTbwhQ/eHGLBrryGJUOs0MUsHSHpZy
         UlTg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566859; x=1788171659; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mx319t95qSI5TOZ4yPkLlQF+qI8BgepSHceojtHSPMo=;
        b=f/a9AWVX+FMj38P9CJ3E566x6+tea8Gns3or6rq6AFNkR4aqBYSBGi0c7dYBsMgASA
         j8ehcxiYBkJY5he0yz2073HQ60HPvUe2M53Rc5KyUdEvTDdM5/RRQyImRZUHJ9WLGl0b
         A1no1tYz38LUd5Dmv+3G0+pfHYDHhfWGtxIclxByqw2H0J5mjAifzYb9yNS+oVJOT963
         nLieh+LrusRyy7MV00YX3BlkqJTCrubZJDXKFOCEc+Z/8cNshJQsTqTDQxLKGydScR7q
         vNvTSTYCHFY3lfYFwTOi9bT99z3aiXh+3JGrpL58TbD9wc/FnUTYhow8Xw/Gn5ZKwG3a
         V+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566859; x=1788171659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mx319t95qSI5TOZ4yPkLlQF+qI8BgepSHceojtHSPMo=;
        b=rrdHivRC/iuKKH+6DmYhTuiyVo3n5yd4bmaMvjzM8XaT9CYrSiXLmEXwoMXUb2GRd0
         vVkulh7c3CrPRUIO9dsqhaO0nP/jVbygJhh9tAM6UPu1p/23D1iXTKYpo8LzXOhGlsmB
         hkRLc2IW/fah86xPsnB8IDsIIgysQcgXGJ1wELhZIFOL3AkYd76kIIJL20Cwe/MUfXEt
         cLCxxrGNHddYTvUL+xK4AzMifLwUmZJCQi2i4jS4ybPpnHYcP/KB54bmHXtUWyfYNzYK
         llE/9f1+ckCE0CvKIIzzyS63y22jWYkHt2IIJg2ZNrBax7EEnenq3h9WRr7vZ8+Ktcpi
         gksw==
X-Forwarded-Encrypted: i=1; AHgh+RokkPBbD7ELwVQoyH9Jwu0y+kKn/N6EEtvWxBs5QYB/mXvtbwCZru63VaRYQOnbcinNO2296L9+@lists.linux.dev
X-Gm-Message-State: AFuF++mYaZC7phimUICPcMOzDwZ2/w9UI/B003mJ0P7zsI0JfinZU9D/
	Sz8cZKAqlqOL6L3TYgp/5MvaoQUcb1olYSgJsEip0mHLAqm47dVJ63Y4GIyFvI6kBch+z6Cq1/R
	r8wd9GNS2FBdxHMkUfkVHDW3wZuuwbxc=
X-Gm-Gg: AR+sD12GFuaTTJDkzACTwxhX+Uo+kkIgUxmrtcesCCGinMHqz5oLluGNFpRxlLMqsZN
	h3RWYWrPO1FM1DKgA+V2z7Ge8LsrtvZpnK+ardMO0+xVjgoVsHeO4HFLrmRIuQJpSE64wCp5OZp
	p1JiWFcjKli75OJ+DZ7l4NzsAkHaAhViubiE+ugRgtm7ZDA4Z9komxPxiLhlrCDlf8h4sWvuTwL
	aRdOf88dMuWrpeuAO0xrEObmcnM7ErBzJEHGrCAArtiiHmf+ZvYIqZkI/3Y21KFSx+myRaFlbrr
	+QwoJqUWTsALnsnWyYEZYLYK0M/rzbA+CMQ0i4BWABnhitD1HAQ4Qg==
X-Received: by 2002:a17:903:46ce:b0:2cc:9179:335 with SMTP id
 d9443c01a7336-2d64ae3ac93mr485817265ad.8.1787566859040; Mon, 24 Aug 2026
 03:20:59 -0700 (PDT)
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
 <2894b9cf-09c9-44ab-945d-cb3edbe5fd60@siemens.com>
In-Reply-To: <2894b9cf-09c9-44ab-945d-cb3edbe5fd60@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 24 Aug 2026 12:20:46 +0200
X-Gm-Features: AcwNN1WWvQ--gI2EiTcW0cHaPdGNi48ohcODob8l338PKLc8EzmWfmsagQ76ZT4
Message-ID: <CAFLxGvwSE28X_PG2NsyhnFxq5SGjrS3WH9bhJcX4gyrroV2z1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Richard Weinberger <richard@nod.at>, 
	Florian Bezdeka <florian.bezdeka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 2:39=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
> > Finally, there is a now a fairly exhaustive test in libevl to exercise
> > this fix which could be easily ported to v3, see [2]. It managed to
> > trigger several tricky issues when debugging the fix, so this may help.
> >
>
> Thanks for the pointers, I need to drill through them - unless $someone
> has more time this week (I'm hanging out at Embedded Recipes).

After some time this issue re-emerged again on my desk.
IIUC these two patches have been dropped.
If so, how was it finally fixed upstream?

--=20
Thanks,
//richard
