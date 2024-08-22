Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005C1BA271
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325414; cv=none; b=MAb99TlukOvbifsfaMeYjgE68pu4EtFkZlb9KbI8hM0q2majauyUQJXm2h1aihaTiXM8Io8Ag9YHL7SsPXAasEIzvRr2dSYOvnOWL7RpUlPEgJ/mciDOWD2e6+AlZPaK+i0VnnIHES345lQhVq2qxb+3dq5HBjno6zwFmA6Xs4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325414; c=relaxed/simple;
	bh=laHCQIzeEX1kMWiYHyA56uLWpA21VWf2u2Wc/ntPcb4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duk6bQfZtdqDVGF7rk+cPmkCWsG0GQPWmzstf9H213mUySc1651cAssg+CX5p3aLdQnLJTXE+QyfbnXTMGsAfiLPN8JMZ9xFTcrtloe1q1gcLWx0n6UGooeMyQWaUC44r5P/jWblu3UqpPX6fQTKYKZPUnWOR/cJC4js2AianCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=l9X1YQZJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="l9X1YQZJ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a867a564911so96353766b.2
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724325410; x=1724930210; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laHCQIzeEX1kMWiYHyA56uLWpA21VWf2u2Wc/ntPcb4=;
        b=l9X1YQZJr6KXzcLG+gTRrVugXHC3MkP5mGJ6apVNy72vrs+eZHZnNijGX1dd6LGZTy
         O2357Og4np5MgeNDc0l0GhnHgDBxOD4IWK22mEvVKhI6Eood/nEepEbEMRbEvTLQ2AsE
         p+HJUrGE2whkO0vYTgQ+v334iwJ71NXPUkp50UVGgsX5PoNEOPawWWrqlp5dV2PmEsWh
         dMpEhC/J6YAAKO3PZAfC7U90+EgmtYVSk6NEhEtMjwVCSH7RXdS8z64yqbWqubjHDC4O
         9+uzn+7VVurNW6931hcUUvPhB4Uf5Y22lZoKmpQDlpB9jG9xpR9dpBibklO33iZPcMMx
         LmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724325410; x=1724930210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laHCQIzeEX1kMWiYHyA56uLWpA21VWf2u2Wc/ntPcb4=;
        b=uRikx4udJSVeJeypTzJ0ZK4cIF94NZfknXmWN8smVV9LziBSeoP8PuYl9iI+rBZsil
         iJqt4QK/AprlzxarNKTaNXpmNwNKBAcZL+9iDgP0DkpZGeIhrLB9TH8C3+fwjaD/u7LC
         6HqdpKCW8kmKtn3sRYywqZMcVWY0m5wdSHx5RfENloZaRqpwr4f/N5gsGM94dF1Iw0xJ
         6RuRZabLh0Ws7xWGV7DElyRP9VByjfm31+AKJxo000thuyIeBmBKYaExkTNawQKZL/Go
         HVC40lLqk5+t91rGkjFfiIgddZYwLAZIXTo2kjCDzSSMK3jcIje2YnFH08zx7jQOBrP8
         Av1w==
X-Forwarded-Encrypted: i=1; AJvYcCW3N5d/OAYyCUed8kATevSkEEPtHy6gunWfOMeczRt8Hs89iBaydynDTeuNhONs3MKzdP99NHnG@lists.linux.dev
X-Gm-Message-State: AOJu0YxJlQuDgsMf0i03nlCITT9D/mR7X7wtSoUjbhvq1m94Y3tM0k2E
	GTqAv1/r937/7PJvmyK0Q5QnisSMK87CjXC7x7/ZwD0gTPmfspEzJsh+If/iKKE=
X-Google-Smtp-Source: AGHT+IFOkRmyu7naBlT2nsGYngIsrbEDn87aSdjEO24OHCjrlAexvvEdEyvRl2gLD/eDkXKzZk42VQ==
X-Received: by 2002:a17:907:940f:b0:a7a:ab1a:2d67 with SMTP id a640c23a62f3a-a866f11f784mr373826466b.1.1724325410051;
        Thu, 22 Aug 2024 04:16:50 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f41c0sm104637866b.200.2024.08.22.04.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:16:49 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev, upstream+xenomai@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 1/3] lib/copperplate: Get session name from env var
Date: Thu, 22 Aug 2024 13:16:48 +0200
Message-ID: <3358517.AxlXzFCzgd@somecomputer>
In-Reply-To: <bbdd9183-fd27-4cf3-b7ae-358498aac6ef@siemens.com>
References: <20240822080737.17939-1-simon.graber@sigma-star.at> <6235310.YiXZdWvhHV@somecomputer> <bbdd9183-fd27-4cf3-b7ae-358498aac6ef@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 22. August 2024, 12:59:54 CEST schrieb Jan Kiszka:
> On 22.08.24 12:57, Richard Weinberger wrote:
> > Am Donnerstag, 22. August 2024, 12:51:34 CEST schrieb 'Jan Kiszka' via =
upstream:
> >> On 22.08.24 10:07, Simon Graber wrote:
> >>> At present, for two Xenomai processes to share resources, they must
> >>> be started with identical --session=3D parameters.
> >>> This is cumbersome for extensive projects involving numerous helper
> >>> processes. This commit allows the specification of the session name
> >>> via a global environment variable, namely XENO_SESSION_NAME.
> >>> The --session=3D parameter overrules the environment variable.
> >>
> >> Hmm, did we discuss priorities already, and did I say that this orderi=
ng
> >> would be best? Then I'm no longer that sure, and my feeling is rather
> >> that env should overrule command line. Still looking for other example=
s,
> >> though.
> >=20
> > I remember, but the other way around.
> > Env overruling commandline seems not natural too me.
> > Passing --session=3D to an application and seeing no effect is not
> > user friendly.
> > IMHO, the environment should be a default/fallback.
> >=20
>=20
> I'm all for least surprise, that's why I'm looking for existing patterns
> now, rather than personal (my included) feelings.

AFAIK, at least git, curl and GNU make give command line options precedence
over environment.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


