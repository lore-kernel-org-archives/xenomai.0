Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB13101B4
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226992; cv=none; b=TsiHeC4vOKslPwEd8Q2lEoybIjpuUe7SJL/ZvyLOZfvWqLP+XKCMRR2qnYYuwXSI/tFBb2APlBIyfVtnVlO7L/dNclNfR5BK+QRC1tWJTQhof6hMhGRIP8qSFX0VbaSh9iiPAb+0jMjheR34s8lYy3AjM0lyyJpbsg5nDrp7ye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226992; c=relaxed/simple;
	bh=GdGH3aJ6EIE7GDNqjZ77s95c/FG1WSM5Knom4bK6w1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFCdc20csxuJyHa09L1wdIGznvlAqNi6dLiQY1HoII7eNHSWkQrJEuF0fLv1Mz+zrTup9j6Is9JQm9EhOL03J8bKVqN1cKYVbTmoXJMnvlm9sqyHifvLNDr1NsBZAEeusMnZe1+4lOP40vTiqHSkKOc9EUrqa5UaYqU6Pjp/lGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=sngfjUyv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="sngfjUyv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-435a517be33so87779f8f.0
        for <xenomai@lists.linux.dev>; Wed, 04 Feb 2026 09:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1770226989; x=1770831789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdGH3aJ6EIE7GDNqjZ77s95c/FG1WSM5Knom4bK6w1Y=;
        b=sngfjUyvMHcSrdlO+SEH2PHlHmRat3lfmDCJ7WlVi7aSpkzVrVLi44nTAzZvKxlbw+
         C0r3UCxqgQdm3CNPsOU/2sK48/ouGTnEOjkpgidKdlAVJ368EvG1NIxcAYi3dKYAEur7
         7B3HiSM0Oga/FuEnIndDaja9iUKHwXX5Ze8O0IZFmMOU/JeuDQiBZ/lLhkWwQaBpCYMT
         8kxaaKZwD02zqKaN8/dEDOt9yUC4H8LxGoZyHodA+wvAPgIKyatWugp0TG6F7TA0Rg/Z
         zzFhYUcTHapwnrgH5tBuikQhLn+SSBbaRe2P+Z2Wpc56a6d+FqQiYx6axl68P3u1JLtM
         +1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770226989; x=1770831789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GdGH3aJ6EIE7GDNqjZ77s95c/FG1WSM5Knom4bK6w1Y=;
        b=b2ETb//40IBK47Dg6RtDwqhMz/NHLR7zFbBhNqvz59IfB2byZ6AlSmxbGK/L2PIHgW
         n/T4WR3Lx3ppUc/hZrNL+0gtINxpCdqjO23ZoTvMO3tmQfsQxCxg6pDflVVSbuc4sCfp
         +uWwv7yQDMWh0pcgS0v5cPMvPUKwZ9leAHrWtxHU1mE60eyHPJneGhKpA0t+9F+eRiju
         syds7LY5tnq/66xtgXZRK9WewtNgmCTS5dXno+b8SHhgVJBtTSYEz9kz7j8QCxvgJF20
         yWNzc4zo0wHJQbeI7a00xMojE7fcK4pF7zANZUeKXTQ66OxovJJpK1MTpG/shKyX30eI
         WCpQ==
X-Gm-Message-State: AOJu0YwzIv4tj3CXZw0Qz3OpJ0HsrtVub3GdaPGtyxZtfDIQfiyEE9iC
	3plj49vFwvzn6q1rrHeBdv3mVyi/1tLGqhlUZDZw73NT3dNpzc9auGCEIlhcZLi3QGRcGzrukE6
	u4Nhl
X-Gm-Gg: AZuq6aIaDy226/3M8U5o/EsGBxL6VBsPsseeOEiDX63XwgWSOEcdjJnq55Oz5KOvW4K
	t1cee6DlH9l0pXNFrcP2Znd8x5gMk0QCn/EzLqxoWh1KB8Sf0bRRYJw2wk2x+NIAGbBdG66w2Zw
	zyAqCCW8GrJRguejJR64q5gh2SD+SUjtPCSCWc+wQkJAhEYzOX8zo+t2Yl4kjLkrsguJCMTQY+E
	SCkrupQg2GvbEYzJy1IRgMyUeFRhU6HDZZ6XKFOExDEsuofaPnGRNbt3GebswZXPKG3FT9O+EZr
	ZkrZ+Y90poNbI1NL7+ehtOn6YYZNSJdsFAM3n/yjKxrDbpXpJsooAIXvLz2y7dkOzOJWhRNTGfd
	Xe9PgkGMMmYiINqfzn42nSqmpaqUcCX1HnIhEfRyaiq15tZ2lbjgeOpJbYFZcPsKCY0RtHdgY+R
	nXWgmjwtn0/6VNL2GSf2e7S8vIMSsA0Rw+kLWK/cIZ0ZBKUMD1EIaQ
X-Received: by 2002:a5d:4dc7:0:b0:435:e451:2f93 with SMTP id ffacd0b85a97d-43618063037mr4542012f8f.60.1770226989097;
        Wed, 04 Feb 2026 09:43:09 -0800 (PST)
Received: from somecomputer (85-127-105-34.dsl.dynamic.surfer.at. [85.127.105.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617cc9515sm7236964f8f.0.2026.02.04.09.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:43:08 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>, upstream+xenomai@sigma-star.at
Subject: Re: [PATCH] Fix race between RTDM task termination and xnthread_join
Date: Wed, 04 Feb 2026 18:43:07 +0100
Message-ID: <8859804.d8oTp23Qrx@nailgun>
In-Reply-To: <ee18b4b8-22df-480f-be6d-38e23a3d6c1f@siemens.com>
References:
 <20260127213927.26960-1-richard@nod.at> <5491679.p2sp48Hzj3@nailgun>
 <ee18b4b8-22df-480f-be6d-38e23a3d6c1f@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Mittwoch, 4. Februar 2026 18:28 Jan Kiszka wrote:
> On 29.01.26 11:34, Richard Weinberger wrote:
> Thinking about it, I came to the conclusion that it would be nicer to
> keep a copy of the host pid_t in xnthread directly. That nicely solves
> the race and even simplifies existing code. Patches will follow, tests
> still running.

*rw mutters something about PID re-usage issues* ;-)

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


