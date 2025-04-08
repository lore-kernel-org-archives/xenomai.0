Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41E320F
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118691; cv=none; b=O2ocF5s0/aN6ZhlaMTAcFcJIO7Qb+1bukG6bxx/mA+xIjlj772naoVsiDrszp5JsYphwxS2Tvq+PIj+8fSlCHg9Cnrp8KsSZ+6jyVDT5u9d/ABqv6ARR4FHnOF8CWL+0f95AYjr4KImRgrh0zOW/jeQrJ5mNxpehNPgKwOr69kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118691; c=relaxed/simple;
	bh=lHLPRXGTCzXZXwZ9KZPLAeyX+XWnG3iErGhqb1pjNGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hR+sstg7zGyn36WTMB0gQtdiD5tx1qX0/Pk7/q5DNRZN1/oeQnohKQb+9TfB1OtvFqzw1FxUehRa9S4NoxctnVSPUVmhgOH+Pj7oF7OXGvIU0tGk7zz+6Cq8R1QjQOZhd/nUDhNnvsKdugb4awm2wfcdS6y52UeWMMzLkmjKauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=pgK8kDA3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="pgK8kDA3"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so60329305e9.3
        for <xenomai@lists.linux.dev>; Tue, 08 Apr 2025 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1744118688; x=1744723488; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2ssOewxHE3RnB8U93uEVmxtPWugpg/pgs/OmRrqDqc=;
        b=pgK8kDA3QP9s6o6eDfM6sd1sQAOwa1NnblMAsF20dPZ5tTKBLhkIFu9fRzTr+V0Gxa
         Zcu5OdMwV4Rfs8T6545/7EUq0yXltAgyHfNEVJQ3Br4ZgvDGUBUxZrBjkiloFz4wSNd+
         qhzxg52SjC+Ug1I8dmseXZvbR1+Aj2FAWZdMIFiR4tYBUP4ztilisyZ5YtMLOrSXWr/d
         k83SNFnZOXvu1Z4BOx+k/BVtOwLGRPa7MsoK4cOf8rWQWLUHi5eciFQESAnYzdJ4O8rL
         YpLPYKMKV1xKTFpQvcB5Fe3GqhvgAg23Y5a5lTPpoHElcnfuF7tiYnmBJao5dQB9pf37
         OXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118688; x=1744723488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2ssOewxHE3RnB8U93uEVmxtPWugpg/pgs/OmRrqDqc=;
        b=MhcNRbWY39CyGL9gyS2Mw8hnGlIdaOb41pdyKITH+nhd3XuidnGSCK/xwgEQdu3ASH
         BMVwUIW5UK7CF1IFbKPlHEMJ5devZe2T/B870gXGzI4SofuMu4BwwZUCX8f30aBNIuq3
         WmFiadrv2rhyrEWY5tx74VA5CgDhHVGymDrOPxZibrzD0vrTOU+8mPE+cRCFs00petxa
         ttDMCZkHvJA2I6fXRU+rMdKpoRdUnzIB/Es0FZzERnnOxPxDa0iKh0iVBMyWzFmHq87n
         BlyXhI63pqsJEZNDAN8tag/8wX/wnC/4vPplbsEWBqapfqqaQtZrVBF7hL7QryYGVTFD
         q+0A==
X-Forwarded-Encrypted: i=1; AJvYcCWwethPWnWdeb0KbIhNBO5OG65bpnTGKd1OnXcYyTMENrRgA4gvYOpl+mtfF8FqdcmQPE3Llp75@lists.linux.dev
X-Gm-Message-State: AOJu0YxzaK6kCAh0mgTpAAJALxohvg8w5QjnwoPtbJLlCtgErXw6EAgy
	9addzn1Mcm1PM/kVHzumrrjMcw6YNRPtBA+bQ2y+rmtIMo3r5GQ4vVKJRJtbdsyxq6StysEvzCy
	K
X-Gm-Gg: ASbGnctEee6BTV/wSWb0ESCuRsKO84+vRO5LEKzXCDFOs++uYN7FkLCU8UCparLxB+b
	q1xNFSxpkNKQPzKoHfi+Fj5g+Sl1s0UUPJ0AyjppITPhNJ0HIdyWvgd1ZljjMryic3RKPIXIa+b
	4h8ra1Jj7rG4tbBnsfYBUyEPOJrBBPY7aAgV479qg2Olds/Jf+BhBAp9Pj2Icb5mt0AoC+RCLI4
	BBS69Eh8O7+5C+c2Haoz75/oEx5A0i+d2O0qdErzEdLQVRQCoPe4mzeGrQjrdHEvJwmzxbM6+XI
	0uU2Zdon+v9u7/cMbLh6HurLNP++7LNkLMPoGxm2vUtE7QmEOtmzctfH
X-Google-Smtp-Source: AGHT+IHJrQRhnwD73qM1b662gk93KpItYHm2ZUTfR4o0W7bcJ0YWWSqyriRc9O5yNaZ1vGUMJvmF2w==
X-Received: by 2002:a05:6000:4012:b0:391:2d61:4561 with SMTP id ffacd0b85a97d-39d07ad4ce7mr12716046f8f.6.1744118687987;
        Tue, 08 Apr 2025 06:24:47 -0700 (PDT)
Received: from somecomputer ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1794efesm165326225e9.28.2025.04.08.06.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:24:47 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 Jan Kiszka <jan.kiszka@siemens.com>, Lorenz Kofler <lorenz@sigma-star.at>
Subject: Re: [PATCH 3/5] arm64: dovetail: Allow early return from traps
Date: Tue, 08 Apr 2025 15:24:46 +0200
Message-ID: <4088969.M3a2QDmDih@anvil>
In-Reply-To: <b7a88e1a195a47892cb40e29ced523cda043d533.camel@siemens.com>
References:
 <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
 <20250408123423.627477-4-nikolaus.funk@sigmatek.at>
 <b7a88e1a195a47892cb40e29ced523cda043d533.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Dienstag, 8. April 2025 14:58 Florian Bezdeka wrote:
> On Tue, 2025-04-08 at 14:34 +0200, Nikolaus Funk wrote:
> >  void do_sp_pc_abort(unsigned long addr, unsigned long esr, struct pt_r=
egs *regs)
> >  {
> > -	mark_trap_entry(ARM64_TRAP_ALIGN, regs);
> > +	if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
> > +		return;
> > =20
> >  	arm64_notify_die("SP/PC alignment exception", regs, SIGBUS, BUS_ADRAL=
N,
> >  			 addr, esr);
>=20
> This hunk looks odd: ARM64_TRAP_ALIGN vs. ARM64_TRAP_ACCESS?

Hmm, yes. Looks like a copy&paste error.
Should be ARM64_TRAP_ALIGN to pair with mark_trap_exit().

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


