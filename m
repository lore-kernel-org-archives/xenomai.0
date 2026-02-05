Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407B219A71
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331376; cv=pass; b=lD/5oJV4UScT1tf8HxAhJukkH2OvvN0p/IWxheGzSWq+F+Se2Ri8eFLiMoMZCBT6i91VN3h+eHz8J8FwUfdEXRi0Efbe2mTTL6dY7HU9Qg/ZxwtHXNunbyZyw3smHyFAZ4ZawMd1drLa5vvs5NAzp99rgjrGOOeFj4ktRvdtxXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331376; c=relaxed/simple;
	bh=oRgCc78hSsP7Vg0YIp5cjwrAF27FC1jlo6oXtixfgdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLf9tLGc+zJobm7NP/rYLADYN5Iz/uFac6yff0t0uKIeXC4B3Tspvej3gGjcUYm4Q+592bdLW6oM9JtsPdSZGCe7+5vpeM/2v3at2U1TW7kSCJARCAqfoUD/etiW+qxTCdxUAxZ+5BEFnF2jlcdcxWG49AxVEJ8b+2iaYveqwYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRCZqJFb; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRCZqJFb"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8220bd582ddso1080292b3a.2
        for <xenomai@lists.linux.dev>; Thu, 05 Feb 2026 14:42:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770331376; cv=none;
        d=google.com; s=arc-20240605;
        b=Rv7wdKFMct6HGFS4KaXpp6eIii3V+jyAtxqaM4tUJHJzTd3U06Rq2NCRSvHz4zvvz9
         u6FIQyiZQ89YlyWOtyxPFO9aRLhjt3otMGmKIK89M3ADYCEnF8lUtRyV2p2ZCidGHc5J
         ptm1oUZdFC/ppfIWO3DwiOvhsnvObqk1ycTEhW7E9/YUQbLh+FB/nqkbkWbC4nSI5eVE
         h68WXX6X/zdBVP5W85ywpc9+EgKpoOvzhSghPkoLyzaaDjyw0jcNImyEJPvIMuE+Q/Sy
         b/+xhmSHNs3S41uKDzU9LLfyFTHZvvh8nM6uoDLPfGdA/9MKM8jl33jcFd9P5R4KJenj
         IoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRgCc78hSsP7Vg0YIp5cjwrAF27FC1jlo6oXtixfgdA=;
        fh=tgwebcNkoJ2/NGSJumgP9lV3bKs+JVL5OrNDd1IgsQY=;
        b=Sazj89OkMZah64lbMRCzlFUBp0VOxdDWWuYDmC6tkXAaHRZ/2xhjauolQOtoQDNygY
         ICCiqbi0p5VAP6IQpjKxZ4HrxaV2zjYT0pG/S8Toeclxf+G5ybxAfpniEDq3gIXEig6W
         HlcgTvkImGDssUY5GQJ10ZiaGBzl/O+6a5gSsDSEIUvtIxJjlkeovR8xp/I5NEcKjDxY
         93ZIdphhcqQygxPuj8TfRjBVS3YRJdoBBlbxdbagzGr5n4pxtyv7J52MGVOH1lIBmJXU
         fGxYVK+KQjhJmLEvq6wlLXoHikPMexUyln9m0WLfGddnbaAr/JLqhvwqy32RhJHvW7KM
         M1xA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770331376; x=1770936176; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRgCc78hSsP7Vg0YIp5cjwrAF27FC1jlo6oXtixfgdA=;
        b=fRCZqJFbD9iMZHt0RHVaiujS3kkznVswS8MqdVMVmjHcDTvANr4sRrZ6CXaamWzkTR
         1vGbiPJXDylx94Hfb4ZBY2e5qBgBqPWxqYhloveK5HvyDnUMxBf6zYAOAf/AvW3G0qkX
         kdSJ6d7Ko9JGefXvcRb6ffHrPxGSLJDsVInn/apLsCpivkt0OUK4Z2avzOnUUd6w6TfV
         y6L7ruBfB3cr7eHyR16WrO3RnMiCMHoxbJPkCZxhDly36FkF1YKEMuWf3qfRP/KaYUv+
         Vw0+reF0iUDJpUzg8bJcckI6Je+8zaiBWpwv8gusnBnI3andhlnKnoapyjjpIGS3GWmZ
         Aw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770331376; x=1770936176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oRgCc78hSsP7Vg0YIp5cjwrAF27FC1jlo6oXtixfgdA=;
        b=qc23Plh+oyJA6Zqlmd9ASyn2cUWGSyVZwu/B6mkhxUz9ImoxVx4A0OBG1YIA7VKltF
         D7XshSAD81w2MciA2+WW7Klsu4OE+5A5cTacUtkD9cPNuIfUeNVAEAWuUtVCXGtuwcsP
         GGyyhZqaA7F1nCdmC6Zz8LJttQA24e7MiRuJGnw+aAtwim4VRfyMTE+A2avErY7fdX43
         LjYLBOqH/Gw3amTH6RZ1mwHj/+YT31OwbYbjUHS2yKzLzww9zTA4uO8lyie7RfbmLsgH
         z/L3nIKuselerERtJCcvh8To5QOghJKYq0RSw6mMXCze3fFLzOYurwkTuhlVTbMs16Gh
         SFeQ==
X-Gm-Message-State: AOJu0YxxM9W0mkM6p7MYbzi1l3VaFWqjVaAoXVrtIylCrbKqYQ++W7vJ
	45Y/f9K3K+KtkU2itDm51/39Bxo2/wDGwVJi+ltOx81jo29BEkXwE9QdIdds2I0hhRtRE0Z9PRk
	RDNq3/7xPnskdJTOfosA88M42e3VM23T/ERyS
X-Gm-Gg: AZuq6aJxnwdFSOZjU6P8XDihmmZgqVaFyC2dIROwrE0IcBnWcDiHSUzCW8VTpcFQIDZ
	heZ+v54Cy0hHmCId+4zqQG2i4FVpmIgbgAEehIVCj4nCJwUJACrLaF5vxgK60od1AkFP4Ku0eQB
	7PgYoRseKP3XXKj8QsLYsWMSCJkr/Nq6GMWpvJb5QAVsYGVN3pubfvV7sBTlZit+shb1d+yz+uR
	yPSuNuZefPtxhlZoQ//dWDG2GrIeiinTgpji4TR89n9WaIQ/mUr806SykC0WXh0JtlQ9xU=
X-Received: by 2002:a17:90b:2d8d:b0:354:a3ee:a294 with SMTP id
 98e67ed59e1d1-354b3d0ebb0mr411372a91.29.1770331376030; Thu, 05 Feb 2026
 14:42:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvxUmCjBJBrPFWrGDfPimmcL4=xwGGxcLwn3+1W1tUriSw@mail.gmail.com>
In-Reply-To: <CAFLxGvxUmCjBJBrPFWrGDfPimmcL4=xwGGxcLwn3+1W1tUriSw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 5 Feb 2026 23:42:43 +0100
X-Gm-Features: AZwV_Qg8-E9JRa6MZ6U5cKhe_R8PUe7X6WwZ5o01qai3MAu7Y3LthK4Ow0mhKIE
Message-ID: <CAFLxGvxTeqkQOcKTTTSynJ=1BSCWJNmqgy086nzXPh-ZE_imVw@mail.gmail.com>
Subject: Re: xnintr_enable() is a no-op on dovetail
To: Xenomai <xenomai@lists.linux.dev>
Cc: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 11:41=E2=80=AFPM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> Hi!
>
> I noticed that with dovetail xnintr_enable() is a no-op. Is this on purpo=
se?
> How to mask an interrupt line then?
> Various drivers in Xenomai use the function via rtdm_irq_disable().

s/xnintr_enable/xnintr_disable

But xnintr_enable is a no-op too...

--=20
Thanks,
//richard
