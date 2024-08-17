Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B4824AF
	for <xenomai@lists.linux.dev>; Sat, 17 Aug 2024 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723922094; cv=none; b=uV2NL7Jd+WPKEcAAlQ9q2R0cZbrpzz0ZW8GfHwx2IBz0gPvO8UL/9YdV3KqV0+zggMtrhyviwFbZ1sMAVgxLkWo4Gg0y4C2gy9QoWhFI+e5HbnERaSh9lRTDo3+xbIuVE0oudZyf1/LC0UEQrRtHkq1eGSbJroNC+UJ3xw1dK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723922094; c=relaxed/simple;
	bh=3UFRm7NjV2JITT5EAZwbuOOZXM94DUTwS9h6mIymT74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8MqZppV33T+KBNFsXiF62osobyf6L/RmCTJYbPaX+kMbjPMZjT6x1R2hprhLnyzaBf1Mz1VM7dZ803b61a1kZohvcWGbitvFSFxA1nRJQysMnIoTFfGf8cRKB91mqDgjR/qOGBL8T28tnPzJfkoYYpiqQ5gLiCZRcSkddL89fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0OCqSlc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0OCqSlc"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d41b082aecso229654a91.0
        for <xenomai@lists.linux.dev>; Sat, 17 Aug 2024 12:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723922092; x=1724526892; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UFRm7NjV2JITT5EAZwbuOOZXM94DUTwS9h6mIymT74=;
        b=V0OCqSlctEU7zjqt+sxdr9H5uYfLoXpTz98Oi1eoOo/pBA9mWhg2Lex7UIH70g39H8
         YPpcjhx+vI3Mdhj+6Jnw2v9FB0vette9Ik2HK3gNH3flcQ1Tbmu3rjja9qy26z2BQpuj
         N2nv/hS1Hv3DroV0tMJEz9c4fkYsrrXt236Qq/mYcPCUbaAvgkXq8MSFGHuPASCCwsRn
         mwsWyhr5+v3suvtQYtY4aL+F5DlXmBeK/RY1ZVo4xYvevD1cU9+64mpqtuoOAvwtN6bV
         KGgEG7T/f6Xf/93Bp7rEUO/jT0BsQAu498XD+P96kaiI2m3jVOz0sfaBkRz2Lo8gK+l7
         jDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723922092; x=1724526892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UFRm7NjV2JITT5EAZwbuOOZXM94DUTwS9h6mIymT74=;
        b=uezktJtlWcQcGUsJUq0OBy6+GLLSJjadP9NwwfyE4JG/zpRdbOWXZNUXFLRqS1PQyr
         k42ScxC0WwgTrqZ7P+kk6DXQJmGYCbUuN6E1Mr7PEnL9qkUmPTXGV1DeZCAKpIjZC1nl
         ii7TnI8nPIEp1SMlfkURyjOb5kqOzoIsODDnjNXNb+PSh6TAK4lES18uNNt3LeK2QyUa
         1Vg+AHqNuO+bGjXjB5w0Kz6m0LlZh+nvtQEreiiwNopHKcYfXbf6wZ94WQFeWBDzYpVJ
         CB9KDIGwECLB31jNxEPjIW8pkhvYaai+4p1dPgo7rSmvw8pWj/YWy98WNTG4yVMtlmav
         R60g==
X-Forwarded-Encrypted: i=1; AJvYcCUc1QQWHAbD+OOFrODQg/zLVW4+Me0VJBrrKZguFYjYrK/L5n7XLupHNXEbq70NDtUdRCp0fTkiMInLKtqmHBHvdBByGn/weQ==
X-Gm-Message-State: AOJu0YzCajwLN2lXTVIiZ6+nIBg3R0gPIuSBBquxaDzYWB5lX9708SrL
	zXF9k2Jos+f2EqdQ1HOxj3zvFaqGke/gnP/GlHs1RwI/ltB5RvnJp4pTRtU7bMPJSr6cgmNIWO2
	P27L6g78WYMX3CjzCp9XlZ0asnqp2eZQ8
X-Google-Smtp-Source: AGHT+IEo1dNORhn3zuEwkbUvinoZBmZhwzrr8yV+Sn0deoE7ViXI61ET/tDNfuVIOELEso/r1Z23clU+6VPisEFGKVI=
X-Received: by 2002:a17:90a:fe13:b0:2c3:34f4:5154 with SMTP id
 98e67ed59e1d1-2d3c38dde4cmr15362154a91.1.1723922092262; Sat, 17 Aug 2024
 12:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvzFcqXintq5U6tCZaSp=8quTpB03hsgkmteonnvX8Bpkw@mail.gmail.com>
 <5cca17c1513b8e978e17f2bd5a9812dd5c08baae.camel@siemens.com> <5e35103a-afc1-41de-9103-791380ce21b1@siemens.com>
In-Reply-To: <5e35103a-afc1-41de-9103-791380ce21b1@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 17 Aug 2024 21:14:39 +0200
Message-ID: <CAFLxGvw35sdp9EKh2-puaqNXW0hTaBAJ+vL1owv+o3-PJNj67A@mail.gmail.com>
Subject: Re: Xenomai Meetup at OSS Vienna in September
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 3:36=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 15.08.24 12:08, Florian Bezdeka wrote:
> > Hi Richard,
> >
> > On Thu, 2024-08-15 at 10:46 +0200, Richard Weinberger wrote:
> >> I expect that some members of the Xenomai community will be attending
> >> the upcoming Open Source Summit in Vienna. If there's enough interest,
> >> we could arrange an in-person community meeting at a local beer
> >> garden?
> >
> > Nice idea! I will be there and yes, there is interest to meet.
> >
> > I can already tell that Jan and me can not join on Thursday of the
> > conference week, 19th of September. Every other day should work on my
> > end (- can't speak for Jan though).
> >
>
> Hehe, just realized that I have a double-appointment on that Thursday
> now (RT and CIP). Definitely no space for Xenomai.

I'm also blocked on Thursday (RT party).

> Wednesday might be an option.

Do you know when the OSS related events will be? (Speaker party, etc..)
Maybe Monday is safe...

--=20
Thanks,
//richard
