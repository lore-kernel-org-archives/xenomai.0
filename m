Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555447DFA0
	for <xenomai@lists.linux.dev>; Wed, 14 Oct 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961025; cv=pass; b=F+Tzv1a2qCmRI7vPjHttB/hTuue1KSvOu6JWS4k4cQutsD2tOgQ7U6FQks0IpapAbKRLM1gZCb50giOAilg2kxk0m0YsL+7F8LFJAPBfBFCpo3SKYwGXd13nBBPSRdyyt5yGLcogrcvCfcSl7Aa3GXsYNubp7qvsL77Z3ZeEf0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961025; c=relaxed/simple;
	bh=xdzffF+4fpieKfIiqRPQwXzsEfdbl1yW0/IfTwbVW70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evleJSAyCX/Tx5e7xqnY1SNvYIdtQhpOSs8X0h4tV84uyG0ZSdFRJzv17T9QhcpTxFRxs/poezgFJ5hMXQG9zTOqbSKjNpHob2D9DlNhSvpt8yboEAzzcVl07+P2ukBwqbLYZ3+TvF3uhXwqeM9FnI4t8X+DaXWQS1Bs6NKEqso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q3m1J8N5; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3m1J8N5"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-89a756e5d20so2887510b3a.2
        for <xenomai@lists.linux.dev>; Tue, 13 Oct 2026 23:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791961023; cv=none;
        d=google.com; s=arc-20260327;
        b=VoObMKmBrwMz0WoLiZYeWTPUcp07/a60+9eP3aF0qf6+0S6X7a39TwJACMmX5ryNis
         iJxyl/Wsk0a9EY/XuzNshFpvjxCzCyxZ3hoQXzQ4KeVbUfRyYnTtEMkS3ExA3NP3D/5U
         kno21TSNMS2GE2eZkNbfGVTvxllwSq7XYWnSKvGnOQfRos/cAcUp6riCilU18hGoJx/C
         SKPK6Z4Z+i2yRx/94OsISvjOGWSersYgo49oS19Nb//8mEW2LV1857+6rM7nqZX7zfW2
         JcWQXpaXzCrS4CNBr7YiBQhpjdFpPK6by5yZtrS4h6ISi7jL15ff3dfuqqa05Kq02AMp
         KNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xdzffF+4fpieKfIiqRPQwXzsEfdbl1yW0/IfTwbVW70=;
        fh=I+B7A6ij37jUBjAo3DJlPY+5gXOE1OnfoFZlwlyPRhk=;
        b=UDGMadyWPkH+qzzowSBPSLdhWVlYPG06LKWq9mw1v/i76zwmeYI8sUH/3fjRLKWil+
         vzTyU+4uHpY0kc/5szDuZmjr3FGUeIerIs6VFXarOy39rgxJR+kMX+exLxNz6/c5TBey
         fArHzqaGoBAJ0XoCY6bfszhXgDs78bVudI9elXSVJcXiZjfa+HxraWvTwL85lq1kT/57
         qR2sTtvMXf8d+3PX8nax92nyBpcbZ5l5d6KVLPzqOFcDVVTse6+tqzZ2dfDX/52r8VZH
         UCy5babvVZn4O1M9DVw/oP3DtA5Bq5ILkcbi158k4yvriN9+nUqLdjneuDgathUfhM+q
         v1DQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961023; x=1792565823; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xdzffF+4fpieKfIiqRPQwXzsEfdbl1yW0/IfTwbVW70=;
        b=q3m1J8N5TqwH25l/K1DN/IsSDdFOEQTe6JB1MQtcRmbM+9j6dXWytBVg6v7Ny4ZEkF
         d8msIYiLRfsDeCtkVaeVfFHZLRw2DHvFmp3TvpKQaUPzNXa/yqMrLwOZ2TidSyBMrbyt
         +YUjfntnsdoxH4b1ajhZDDL0PYcK53pDUijCZ3wSa9xWNlQsNZoiowPO/rtiQp+819bs
         16JoISDBA9O+x+GtSdCd3nD1uDWpchZZ3Y834WSK8kw+r9EsBkcIcj7Ejr8Lgq8nihIK
         xzKG/rdAX984tl1HsJPXahLxXtzHwkEMbfm1LIP/8L5TbpqhH6hjkZUzqKOmqVSL0qIK
         BlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961023; x=1792565823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xdzffF+4fpieKfIiqRPQwXzsEfdbl1yW0/IfTwbVW70=;
        b=mz329GrCkoZIfT2A7brHUMkhlCphHz1oYOZchEEHxfD8vfdpRmxCQgIZk37CTJbG56
         HXdRKTk+r9jonqo7Orc29dYjPv5Te4++XlsN/YCfbI4MC7qtNuxvz1kjv2qLqo4pzr3r
         cgepZKnyNg1HrgRt8bMZ3iM1zsX7XMOyX2pb9Y2QhnI+pxDQNICK4jhijlsw90fDD8o9
         N7Y1aNu2v75E+nhvsd5T/Ozxb+LMFQSvTe6gs0ZgKhwxmYAotesf42Jc3hWql0AP1WZ3
         2Br18jnrfkpaPh9xemK2EiwZFOJJUxAsdz3m9nSeTeYk3FXOf+R7jatzomvC+GO19yNY
         LjEg==
X-Gm-Message-State: AFq9FYKjU48Jy8ONGYFM2ZuMurEyp3eAucsXiHXHUrGJMtt/oFCqnsIB
	PQYz8US7lPJuAST1sL7lYiG83OXFQE7nzVC0HPhQjMQw+/aIWo3jNBRsgGGEGbzW8qhYcOltG/w
	bhdaZsjImEsdCcDu7ZPwTvpK7Gl42S5s=
X-Gm-Gg: AYBFou03f2A4OzW7GLKfeszbHlC8F8In7FNDTXP7TTYu6WbiUYYMxrMAIoAukTJoW1L
	BWl4YKi7I6PM6Xn+l7aRJHOmEVIn9B3hrGK//+NuQKLTSoGglsgYXeulIKkRP0O34fxuWr2kgAG
	Hlvd6g+uubhHt7zZiWopp0hP0LNni75FS+frUof+7nFHGn9ggbsDmvCKPBVfgAAqmN9Gdcjhmvy
	00eU5pkRCqkHsx1H69NuNEz6UMeJfyjLd+DNpQ/AE5U5oGGJ9ogusom1S3aiCVfwRr0M10NVr9E
	JaAJOT48VgbQ6JTMz/pG6gjEpkAEVFN7aYq9+HX/bnHut21kQd9JYg==
X-Received: by 2002:a05:6a00:2e25:b0:882:7bed:3b3b with SMTP id
 d2e1a72fcca58-897c78d7073mr12851756b3a.36.1791961022711; Tue, 13 Oct 2026
 23:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <98caad22-455d-41ca-bfaa-f32289c7c8e8@siemens.com>
In-Reply-To: <98caad22-455d-41ca-bfaa-f32289c7c8e8@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 14 Oct 2026 08:56:49 +0200
X-Gm-Features: AclHuK8_18pa-QiBu37hWtK7kHrg5MW5YonWlkL_rArEms8b_t3bIm_k4DbSd0M
Message-ID: <CAFLxGvxKcWEvwOBnTOX9VQ2wQiUsML7r267zRMD_ixL3EyUCdA@mail.gmail.com>
Subject: Re: Call today
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, Florian Bezdeka <florian.bezdeka@siemens.com>, 
	"guangfeng.wang" <guang_feng_wang@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 7:10=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> Hi all,
>
> sorry all, I won't make it again today for our regular call. If there
> are topics, please drop a note if someone would still like to hold the ca=
ll.

I was about to ask whether somebody has (long term) latency plots
for i.MX8M mini SoCs.

--=20
Thanks,
//richard
