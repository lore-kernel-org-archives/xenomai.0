Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA9166F3D
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324244; cv=none; b=Nc2bFvadta2dLK3H2za/Q20ZbCzh3KApiEFTN/Dk4X/rRkhJj7qabi8hbnwo7Fj6ojZxuj3FW5zTsx6iMoSWyhBIdh3enD3+FSal2gmPgu9rEf1ZkSf2NQmPyLUclQhLm+zAJADD8tEXAV8koU2hnCiOK23lWHbZ7T+S1v6Cz0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324244; c=relaxed/simple;
	bh=V5hPnb9PC304H84BKMEumBdOQeTzpW6Y1NNJeaZSfuc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cq+a5exJnfDOHDejmd4m977iqnuExoFxDTHfbd0zs3RgAsHSsV8ZsEO6P7i8sFGcereyWz4FiF5/hlPl9YHSaCniv3JCyftMYlcGFsH2B4Frcu86UZ29E7xlnxjZCbCiBZS2EwsZiAKEAoLyvlIw/gP9PR2r3S9ItHyW2ZEqujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=ObCW4UN4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="ObCW4UN4"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efdf02d13so835328e87.2
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 03:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724324239; x=1724929039; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5hPnb9PC304H84BKMEumBdOQeTzpW6Y1NNJeaZSfuc=;
        b=ObCW4UN4SCS58W8BNEu04n28za7T4Fj03HMnilEMjoqR+EZYRjJXrsPIXUaKFrJ4de
         mgeKyf9CL2obKTDro+IuwuKvlLdeR+JGIG++KpATzN0yTOgW+9o+QPW+vWYI6y3wwTCF
         8FkSpebD3QYl1LfyP9gG8ib2dblbgFqzMzyihQTgGVPX+0xlGSTynU0zySm0QPf8lz6U
         9ySJEJRhoZ6mN22R+JfCJ/Mt5Am6Gh6obH5+W9vgxfyBwOCF7aRdh2wRf9XBfFjcyLyD
         k6IDMopXqIcgU7THnzp/ZZLfoaF+yaDZax+MUEMDERW6PCQZBd7lagEdIB5BCBqsV9Nu
         lG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724324239; x=1724929039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5hPnb9PC304H84BKMEumBdOQeTzpW6Y1NNJeaZSfuc=;
        b=LEXuKeghzk0xSpqH87TPO2JaddSXR2WjqDtEIIHq/fIOEYIgvz3RuWTefNKqHBRqmD
         5U0B5DtMERXcXFHIqhZjRNcufxzRsu3/pTr7Z7PslSJi24PbDFu9g4uFTLC+ElMgdxdi
         3UNMmbddvqtg1U5e+w4GLayGgTCt/nD9doqn9av6t2DfOTOxMj2MjqQm7dIkV776ZUik
         sfpiNaZESUl6snnyzZ60fJUIo2vaFatomD6G6DG4EvheGT187hd+4p0FAsnEOHxW1++s
         1ZRYRTgRzmrl7/GHhK7rVQI+RV33CyXVYfVZk7ZmBTF65qSu6IZ3I0E3gK253d3OZ/I2
         qXzA==
X-Forwarded-Encrypted: i=1; AJvYcCUjPckHBV9u31sDMyepjyQYoWETVYSd8zWLjHGZpa6TrkRi9yZlepbL1Yg0ZNKJeORRLSHEQm7r@lists.linux.dev
X-Gm-Message-State: AOJu0YyrIyyExOzdRC+83OTnyPF8Xix9r1HCywO05vQGrJR+RHPbNfki
	aBaRkUct84mVbnsF1E5QDXvU8S+Sxnd+zMqh8dqwzFOaX6gFVzytwJeuyrEuBeA=
X-Google-Smtp-Source: AGHT+IF32weCrSmPIvlPyKRA0DjYf4HJjUALhzy2Mb6nELilh/imdEMU6L0aESknlspyvtIpEYqQdg==
X-Received: by 2002:a05:6512:3990:b0:52e:751a:a172 with SMTP id 2adb3069b0e04-5334fd642b7mr1303794e87.49.1724324238537;
        Thu, 22 Aug 2024 03:57:18 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2e6795sm103408766b.92.2024.08.22.03.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:57:18 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev, upstream+xenomai@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 1/3] lib/copperplate: Get session name from env var
Date: Thu, 22 Aug 2024 12:57:17 +0200
Message-ID: <6235310.YiXZdWvhHV@somecomputer>
In-Reply-To: <4b024ebb-7d6f-4382-8427-f16024d2b387@siemens.com>
References: <20240822080737.17939-1-simon.graber@sigma-star.at> <20240822080737.17939-2-simon.graber@sigma-star.at> <4b024ebb-7d6f-4382-8427-f16024d2b387@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 22. August 2024, 12:51:34 CEST schrieb 'Jan Kiszka' via upst=
ream:
> On 22.08.24 10:07, Simon Graber wrote:
> > At present, for two Xenomai processes to share resources, they must
> > be started with identical --session=3D parameters.
> > This is cumbersome for extensive projects involving numerous helper
> > processes. This commit allows the specification of the session name
> > via a global environment variable, namely XENO_SESSION_NAME.
> > The --session=3D parameter overrules the environment variable.
>=20
> Hmm, did we discuss priorities already, and did I say that this ordering
> would be best? Then I'm no longer that sure, and my feeling is rather
> that env should overrule command line. Still looking for other examples,
> though.

I remember, but the other way around.
Env overruling commandline seems not natural too me.
Passing --session=3D to an application and seeing no effect is not
user friendly.
IMHO, the environment should be a default/fallback.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


