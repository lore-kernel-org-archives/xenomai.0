Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2003815D5
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682881; cv=none; b=cHSoPBHC37F0Qbrj5KRJJOrvxM7uRvOMRNT0rkB2UGS+bdcP7BY+wPq+Naho+uJr0L4Qu/+Zczpgt2R924GBBg8BlZxLZgGQ6c7e/8ZiJhJ2+xq/YveDRKZJFz6SmjdUq1Nj1bZHKBUEddd0v01hQNKRSYnpx51LC+ZYdhmsvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682881; c=relaxed/simple;
	bh=A4JIvmj0HaQ7927BIcHeM8mKmHmE6etapgQ/50w7Nfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+dNA8n91DnOEcgD+e/YLEkB6Os46FMdHadmuzqDcuAvDjPS20Z9RADzopbEWDON2fey2omo4belAXP2iDFQhqWL/oRmADVEJdN3634QJygo3KwMEdzP3jen6nXWb7A+1HfhYycprZXt6fGRc91NixrNbkwQfy9zhk4JiK6FxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=KgNLHx1c; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="KgNLHx1c"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee2715254so4427575e9.3
        for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 02:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1769682878; x=1770287678; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4JIvmj0HaQ7927BIcHeM8mKmHmE6etapgQ/50w7Nfw=;
        b=KgNLHx1c0L9sChgiRxPoZ5IeVZormOuzfBmnd63rUlJZXM1Y2Sf/s0W+ay6+3w1qfl
         VA8S5Kt328dN1HP7TCUSJ+PKOOGYRcHGIbFDhgtynama1ByIQiIhs4HZBQFpfNZyVQuK
         3UL+pcUvKfUzWYVJRC8DU+d61bsG3ZQy9y21JqMcLnFQG69kWcRKLUtvLbe32enwZFq7
         l85vzj1EqzJDiBw+uNvAmjnJSKkU3F3u7nZcFkD/5m6SieWuGW6KkluWcsW65r8liE/j
         VBt+ZhoQnkAKY/be7FzYbfNaLTj3ZSBRGqBuW1shL1osngfhR5p4Nrj0Z/I/7ucaNJtA
         YDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769682878; x=1770287678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4JIvmj0HaQ7927BIcHeM8mKmHmE6etapgQ/50w7Nfw=;
        b=h9uOpN3XUQnYArlM+uiYTebJugl6nOZOMhnM1MP+kr3M0LeJtn1sncgO50RYY2U+30
         FHpxk4wQofzE4i7aksHsJYjY/7GKDMQCM/BHCRpNdKy41wd7tdd0/g+0hf4qd15X4Ge1
         2Kt9uhf49A4RY8Lnn0AMpcw6E4zKfUQYGoU68T1yX/xczQE8+onNNvfJ3+LJ8aY179P7
         cgSg/oPtsykG1Olzh4gRXy+raqYjucQubWgbmIdIZQBYV70YXihGmxCNQ7CUJerxFcDi
         njWS6YlqQ8Fr1cpvHeOlKzGi4Osm+efVhaHodfwjgueWsSlp3UcyeuV6PfsWyQeQGGM4
         t+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVmloomsSCESVUDTOdEa3TGruKJ5khitkCTCp37ovs6B7Kp7dEYcA47aP2Rm3F3bP5OItXBNtJ7@lists.linux.dev
X-Gm-Message-State: AOJu0Ywgp292EGgP4tFEZ5hbw5aBJpIQbnyT8pLSOKPu3M2ogbByInx8
	3ZgdKuyL3ZsAsO8EoiOUWAG3yvVhMX20MWNWulIcBaSIuadWsMgi+1brNfErqnIex/tEumti0B9
	3qMoL
X-Gm-Gg: AZuq6aIXV14CTGbZafTf9W+HJVQn9BuOQUZ+HdrUrJm3RXa0/OOGDA8SZA2a2TMip3Y
	4CmPOsj9xpdr9WtDUy1JM1vIOHy29agGUjMsauf1YwHBpj8+iNsjGQGI+N73mk7N3OCohQvfT6Q
	NbBPNXKd/YW+J5JqpMGfJyF0OtKo6Jdb2I6fOgEBJpqLKJ6dQ3TJwVEad0VWUv6MMtDRmHUlwvZ
	9LLs1yII33DQO9sJnUwkbxtQD/0XkbqiVUkl/XaA4yaPjTc+VN5lmQ4fvnl5Mo1AtNMO88wSckM
	hamXKy2L8sJNV24VEa2RNXZZ285L9ZDuCIP9lMp1qk9yKWmexi3WjhWnhoPWd72Uhg5QG76yjbI
	xewspn7oMKdxrrpKxVDqqsJFFNTxTffAxxgFMrqXDfiuj/Q7ymNHEqCD7KxdzpoDEd58TcAJvGv
	QOUWXZwhvEsq03YZPqtzPoLLo=
X-Received: by 2002:a05:6000:2386:b0:435:a52e:7758 with SMTP id ffacd0b85a97d-435dd1d8c12mr12689614f8f.57.1769682878436;
        Thu, 29 Jan 2026 02:34:38 -0800 (PST)
Received: from somecomputer ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfe7sm13240988f8f.14.2026.01.29.02.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:34:38 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 upstream@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Cc: upstream+xenomai@sigma-star.at
Subject: Re: [PATCH] Fix race between RTDM task termination and xnthread_join
Date: Thu, 29 Jan 2026 11:34:37 +0100
Message-ID: <5491679.p2sp48Hzj3@nailgun>
In-Reply-To: <1310f7ea-9326-4200-b92f-17a828975328@siemens.com>
References:
 <20260127213927.26960-1-richard@nod.at> <9873549.lNWL4n7ouV@nailgun>
 <1310f7ea-9326-4200-b92f-17a828975328@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Donnerstag, 29. J=C3=A4nner 2026 11:29 Jan Kiszka wrote:
> > Hmm, for userspace I'd expect that Linux frees the task struct only aft=
er
> > the parent fetched the exit code? So, after zombie state.
> >=20
>=20
> But Linux has no idea if we are still holding an xnthread struct referenc=
e.

Yes, but Linux does only free the task struct, not xnthread struct.
xnthread struct (being rtdm_task_t) ist statically allocated.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


