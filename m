Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C441C20
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931638; cv=none; b=TIWudhaJhbBWRKdzOn7XHYMdtBrybj1B8qeKwNnK7GdKVehryEWbctUyGDaMxXFIXJfOw5fanpS3YH5OIzZX4mBCtfSlgsiRRFwleGsSU60GQxXw9zvmy48vEFX2yvh9qs6ty/O1/WfJCiam7raXWzqO0JntAgtGiKevDKYLRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931638; c=relaxed/simple;
	bh=UhzPs3qSANqqzuJzIqyNieTbY2Sg2YOCZCepsgvE9ck=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=GeR4raKZq5JgIp0+RfoWs62Ko+I/YxO3byYntOFhClmp5OUJjkS3eHK1cMp5fijlObX8ajLRgd1ZBlyjxMnCkqTy8w4ZDF2ltHE6hj29dpdvSzSMHiostEDM9TRTwu/B/DFTK0uBv2g1GYXGjmk8KkH2A7uX5/DZebzw4WxI3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1617278f8f.2
        for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 05:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931635; x=1706536435;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FSSHHHUuM6Z2ZKr5ZwdR2/hTG1EbpDXxqhNBMQQXFA=;
        b=fNO5h9XTRz2fFJ5uixHL1qr52TUrvHVD4tlILN78X737ZCog/PfClS4spp5i8Szs4f
         riYY9V4KQvqdMHM/XpP1I4TOsyaFR7YoZcUPJDmGp5gRC6/tmTWIiNCYep/bRUHGkjC2
         MxiuIH9zOnKnHjGgDJWXZralO9+MFiU7BD+fBmy10/56vpa3F8yVIh4qL9a/IEJOwPYl
         6Lm/R4tmxavBSNdHawxC2lQ9WDBvWH1IyDc+VTKJpXhRpsY+6jaNo6zmkrovIccwaEpg
         xjfsBUdyw3KM6aXYvZwBFYdFbHz/5UmUn/tnc3T6uc5voRct69T3iwrHApgK3g68JiGq
         lp1Q==
X-Gm-Message-State: AOJu0YxbHL//i+5Q31olP9P2rrW28WMdIDK2xCeaTiQyNAp/uqF4sFg1
	Z3RwnN0dYoZWYjDZoiSN6LfuV3mkrmBQgKvw0POIe7T5GmHz5K30wSY7nM2c9aE=
X-Google-Smtp-Source: AGHT+IENVuMsKc7+B6gd8ySR4rcK105UPf0ai+q4qvYi7dGv8wLwrnM33CqyAQ/5GqcOInMTy23YyQ==
X-Received: by 2002:a5d:4e0f:0:b0:337:c54a:1991 with SMTP id p15-20020a5d4e0f000000b00337c54a1991mr2522481wrt.77.1705931634680;
        Mon, 22 Jan 2024 05:53:54 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm8724571wro.85.2024.01.22.05.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:53:54 -0800 (PST)
References: <55f09668-f73b-448e-8c4a-0d43c67af092@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [ibevl][PATCH] Install tests under libexec/evl
Date: Mon, 22 Jan 2024 14:53:49 +0100
In-reply-to: <55f09668-f73b-448e-8c4a-0d43c67af092@siemens.com>
Message-ID: <87h6j5fp8u.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> /usr/[local/]tests is unconventional. Better move the test executables
> under the evl directory.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  tests/meson.build | 6 +++---
>  utils/evl.c       | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tests/meson.build b/tests/meson.build
> index b831725..140b862 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -79,7 +79,7 @@ test_programs = [
>  foreach t : test_programs
>      x = executable(t, t + '.c',
>      install : true,
> -    install_dir : 'tests',
> +    install_dir : libexec_evl + '/tests',
>      dependencies : [ libtest_dep, libevl_dep ]
>  )
>  endforeach
> @@ -93,7 +93,7 @@ foreach t : test_programs_with_m
>      x = executable(t, t + '.c',
>      c_args : '-Wno-array-bounds',
>      install : true,
> -    install_dir : 'tests',
> +    install_dir : libexec_evl + '/tests',
>      dependencies : [ libtest_dep, libevl_dep, m_dep ]
>  )
>  endforeach
> @@ -106,7 +106,7 @@ atomic_dep = cc.find_library('atomic', required : true)
>  foreach t : test_programs_with_atomic
>      x = executable(t, t + '.c',
>      install : true,
> -    install_dir : 'tests',
> +    install_dir : libexec_evl + '/tests',
>      dependencies : [ libtest_dep, libevl_dep, atomic_dep ]
>  )
>  endforeach
> diff --git a/utils/evl.c b/utils/evl.c
> index d14fce4..eed0d96 100644
> --- a/utils/evl.c
> +++ b/utils/evl.c
> @@ -124,7 +124,7 @@ int main(int argc, char *const argv[])
>  	if (ret < 0)
>  		error(1, ENOMEM, "%s", arg0);
>  
> -	testdir = find_install_dir(arg0, "tests");
> +	testdir = find_install_dir(arg0, LIBEXECDIR "/evl/tests");
>  
>  	setenv("EVL_CMDDIR", cmddir, 1);
>  	setenv("EVL_TESTDIR", testdir, 1);

Merged, thanks.

-- 
Philippe.
