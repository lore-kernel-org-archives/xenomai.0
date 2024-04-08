Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49853368
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605586; cv=none; b=aPjZHlLtOi6AHSb020kEgl7a3AM3LAkFaOxe/Z/1O062CZh5jLJP/l4oi7thrHhYlJIFo28747WsCItXYVRvr9ROkdQljBz4UA264UGNDgP+bBFF7geu7rLsz1nxKBCAKsKudgzpCUGRCF9ma2Y3sxo/bZPOpfUWBQpcfQUNqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605586; c=relaxed/simple;
	bh=zjixn3jm0HZRiRaxBXDIR8KcZSYiy+V/9Sp2yPaoRgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5QQF2NFcvzxKFO0umVmldiWYZVKBPY25DtAwQXzDjnfghBBZD4OJ9TRXXcuop9oej4J7vWvwQ3dvU/dhg1KJ+C692zkwDkJCaBKDF8xg5LzHedrlsoxPQSoyIt+H4ygvfx12AbonDVGM7IUvTb2uzQRgsQTy1f/vCKU6whmxz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2u58Ozd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2u58Ozd"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a52c544077so851744a91.1
        for <xenomai@lists.linux.dev>; Mon, 08 Apr 2024 12:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712605584; x=1713210384; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjixn3jm0HZRiRaxBXDIR8KcZSYiy+V/9Sp2yPaoRgk=;
        b=M2u58OzdOy7aV+EqTbVQYjsBhRRA7mQFlYNTaJdViKhPGCHoXgzWDrNJpP29TTqF0p
         ZGqof07DJAVtYgHZQUmT5OwW54nDYGOE2ncOMueG+6btp+RgiokHENogfAMGB3x9mYzG
         mnuSu7RnYBcZmxvBWAVrdplJG+/0CjtRx9oKd4+jADSLfE8s85C7A5iyOlVM44XFuaw3
         VHZYBrJdvdOcAy2hNxtCevHRtKVk0mpK/fKa7BIv7O34LyRThM2MYgZHww5T8F1XtuCG
         5BY/Rzx5a4sJRIXjuiDlagFW8ZhX1pT3VfvQZ/nGvAYMKcVTBHdyirPIyc2TTgX4DPWx
         8Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712605584; x=1713210384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjixn3jm0HZRiRaxBXDIR8KcZSYiy+V/9Sp2yPaoRgk=;
        b=n6xq0s6t6X75yFrcqFF5UnwUYk9UXgngtpGFrs0cQ6/CrzAdi/IB64QlZZXmilcekm
         kOFdwAhBpyNSjsahOn7NFKJX66+6gdfygLF9tHLzsD5wSeKeGVfca/PeACs4hLc9dfuh
         fJc6M7Jw8SZx6HpoZbPqvBkopWefIdee0XM6q4FV1GlDG5r1EprA50/bx+wdT1WLpPAy
         PLAHiGUSwF0PBwDrRHdxp01jCv6oyjAL2cfSBI4eC9ex5hgPa8gwV3RnEL9TUqTRIZUz
         w2xaGPXzFbPQGoeT/eClNIfDsRjdBWC6sr4ARbNv2XKHYnGSJYgb8/+gzWTgZHX/Vpfu
         NQjg==
X-Forwarded-Encrypted: i=1; AJvYcCWLjXXTgB75iSh60F+MpPtD9Ilh1zOCpq4fg9/ehscvbHWNj/g+xBWTt0kOnx1Rm/Bt3T6LDHnVXCSZLhWjMG3PJsg3bT/b/Q==
X-Gm-Message-State: AOJu0YytPEiUCqAmH5/BFmTV89R+a8h53FcAsdP7YP6A0U7BvCeBabx6
	BtuqsxIvKTdxf7H/neLE2jhmV107t4IEqWIfEP1T7UAoiAklD8fbluFe6HF8j9Up/lKIYsDqlko
	/p5liZDi/zMFn0ZV6N27uqRWwld4=
X-Google-Smtp-Source: AGHT+IFHTzeYy5rwRnRIDuEF/ExsaDeAjuYnsFNEGu5ZbG1N4ez4BWfgu2IjRMW+oPsR5NqnS/o/n1oI7cfIXSUVV80=
X-Received: by 2002:a17:90a:708f:b0:29c:7566:a1d6 with SMTP id
 g15-20020a17090a708f00b0029c7566a1d6mr7687553pjk.25.1712605584518; Mon, 08
 Apr 2024 12:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240403214811.8979-1-richard@nod.at> <20240403214811.8979-2-richard@nod.at>
 <3f3e21a2-1f44-4737-b530-ae8b62619c05@siemens.com> <CAFLxGvxTuEF5sseZz4_tAwA=YLj95rZzFOM+TyYEvK_K1zxn_A@mail.gmail.com>
 <428fcf0a-6471-499c-b6b5-cdf102a0f69e@siemens.com>
In-Reply-To: <428fcf0a-6471-499c-b6b5-cdf102a0f69e@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 8 Apr 2024 21:46:10 +0200
Message-ID: <CAFLxGvxTQ1JB7XmA=4pxeyQo7t+fV8ueFp5QiWxyKiZW57jr7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] prepare-kernel.sh: Warn when result can be defective
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:42=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
> > It triggers, e.g.
> > rw@foxxylove:~/xenomai (prepare_cleanup)> echo zonk >
> > ~/linux/kernel/xenomai/lock.c
> > rw@foxxylove:~/xenomai (prepare_cleanup)> ./scripts/prepare-kernel.sh
> > --linux=3D/home/rw/linux --arch=3Darm64
> > prepare-kernel.sh: warning: kernel/xenomai/lock.c already present in
> > Linux kernel tree, resulting source tree might be inconsistent!
> >
> > Only when using the --forcelink flag existing files will be overwritten=
.
> >
>
> Nope, the file is overwritten without your patch. Now it is left
> untouched behind, and the preparation is indeed broken. That's not
> really an improvement...

Dang, you're right. Just tried myself on the master branch.
What is the purpose of --forcelink then?

--=20
Thanks,
//richard
