Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A513C820
	for <xenomai@lists.linux.dev>; Wed, 14 Aug 2024 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723676533; cv=none; b=nOcjznhITlfSQDIvSyu2rSL5wXFpgiAR5yOEwep38Heak/8XEFOMYPfDX/Cy4Qysnd42GqeBvHUiZSnjKE5HMKOSKsb4cqMoZ69cCir/0YfVONo1m/LC2XFy1KxYfnm+xfEGIP6Svcop8p1rh7FxGF7QwZqmXkanQVShw+t1iA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723676533; c=relaxed/simple;
	bh=gRdNaGXBif7yBlvFw+ZSlmCwCtXIwX8I+F6VGjPntig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMzkahgSI64D5y+LkUwCqmJbRh/lta5OFezMBF9yaN+JW2ku1w6fHPZsJD0QMJ4M18Q8eDzGPx/iyHZhWi4BtVMnyt0wD1QsRbB1nFK5D2ct9QSanHkbbWLsP7FBKVscaXrRrrjYFMWiRcLP21JbUo+R2OYxAszDmyGVHTEx4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2AfAPi5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2AfAPi5"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so71959666b.1
        for <xenomai@lists.linux.dev>; Wed, 14 Aug 2024 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723676529; x=1724281329; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yy5hULOj4RNfcj223RDwMvHdwWcSp9dWz0xUCteia7Q=;
        b=j2AfAPi58fEM8aiNdqAOZwjbc4Ac+CJAqBHGo5OBMw3FrVHX5BO2ErRqqUuQq3gLSJ
         VBc37SWOLDX0KmuEct7cwx4SU0tsmxSY/3fpZHoUCIUXNDP8w68I+qBmgoXsSIyfu9EV
         qpFRVAdCNZyZnvpDHBStRZpAltvDLB/Ng6XOxYUtTsavRCNrI0LAkXoADzTeNDvzTtFj
         8fJUc6XjeLPIadUK/sLd/nehc7fsLNI9BDRrd2D67R/hD776ay8LNQnTFBhl70yqFoSn
         FrE7pMTFAbYSJJvEnqLCirzT1c2fn2cFhcBSaHb6EmgnJzgodKolGteFK6vMGkWd9EvY
         53BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723676529; x=1724281329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yy5hULOj4RNfcj223RDwMvHdwWcSp9dWz0xUCteia7Q=;
        b=rZ18GvwcNayxUtOdQ3qpMubc/uh3FCrSt57pcCvz5V4Odue8NG0KObWuVu/Y3wRWR8
         qbmGmHVeVIhxPQLZcW2R+pp4Yu+IFXJxMP0OVSB0LzJub0lwyl/f8owveFdrOHYw9aq1
         lLyjORKTHo/MmiZGlRHlwg6t+WoMpaHsBCed87BAUhndljvX6jA9ZosG8DdKeAFlQEa4
         q4LSfcUSUzFg6+aIHsjUoQZqVwf1+jmKWmmJQt2dcRWt2cmWb6xfQDFwRKsjNEseLG1K
         ORaHK/FnTU/tU3+BVxo1ZXiishhB/ozZ9O876jSFooI1KLFC7ry7sibH69v0pvUrRiVo
         jmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPfUhU2eAh3i15rR5p3xhAji2uTjnkcLOMT1LpUP+8MJSTb4IvT++v49ZZgFcfVD/a/fg2akq0/g2Be9tgz6+fcdsh9vFIcQ==
X-Gm-Message-State: AOJu0Yw1GqNIPNwBzMTgguSxCLnledb/BCuoDKffNnrqsyDkaPb9olGI
	ej1WhTKt+BWTr/PrDlUPsgKN5qY0s3S4UU/IhR4oEMO5e0JAYVTQJTqhTF0pkid28MBFwcRRIik
	uRI7Jdk207XIkrXF5UNYkDOS4TfE=
X-Google-Smtp-Source: AGHT+IGGcosLV9CSJS1TKWiBKnWGkvKlKH50jHkjgHrJYh/MIbom/Ww+tGl9bht8SO+N8K0rZT0SPaP/gnyjpd6dmgg=
X-Received: by 2002:a17:906:f592:b0:a72:7245:ec0a with SMTP id
 a640c23a62f3a-a83670d7158mr315514466b.58.1723676528626; Wed, 14 Aug 2024
 16:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
 <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com> <CA+K1mPH=JAwPY2PSGX8Wcn7hqVuJ-t9zdEStQ4FZdeHFy57YWA@mail.gmail.com>
 <d3c212fa-154b-4f5b-b568-2816f585f311@siemens.com> <CAFLxGvxpYZxV6qQre_uQjmF=nAa_Wea5EEWpH1kjreuRAi8CWQ@mail.gmail.com>
 <CAFLxGvytCz=B5M3dhvuBDcg5=mJK0E+-TUOESbkM2oSkz-qDPg@mail.gmail.com>
 <0e2f567d-06e1-446d-b34f-02b9b9fc3165@siemens.com> <CAFLxGvwm3qCk4e2d-Mf7bZGgcnfX8Eyd2yvEGpMf_tydw2H0-A@mail.gmail.com>
In-Reply-To: <CAFLxGvwm3qCk4e2d-Mf7bZGgcnfX8Eyd2yvEGpMf_tydw2H0-A@mail.gmail.com>
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 14 Aug 2024 16:01:56 -0700
Message-ID: <CA+K1mPF9w=QuXFpAsgZQqRj8OjyHNzw9znmpUGNSAcRFgs9hgQ@mail.gmail.com>
Subject: Re: Thread stuck in IDDP sendto()
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 11:55=E2=80=AFAM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Fri, Aug 9, 2024 at 6:01=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
> >
> > On 09.08.24 16:08, Richard Weinberger wrote:
> > > On Fri, Aug 9, 2024 at 2:50=E2=80=AFPM Richard Weinberger
> > > <richard.weinberger@gmail.com> wrote:
> > >> This confuses me.  So, if a thread dies without calling close() on t=
he
> > >> IDDP socket,
> > >> RTDM will *not* run proto_ops->close() implicitly?
> > >> (The source indicates this).
> > >
> > > Well, I has to be like that, of course. It's all within the very same
> > > process. :-S
> > >
> > > As soon one side of the IDDP socket vanishes without closing his side
> > > of the socket,
> > > the other side will block in sendmsg() when the buffer is full.
> > >
> >
> > This kind of makes sense, yes. You could still use a timeout and fail
> > that way.
>
> Is there a reason why sendmsg() doesn't return with -ENOBUFS if the
> buffer is full?
>
> > Was that your problem then?
>
> I'm not sure yet, as I said, I don't have the application on my desk.
> It is also not clear to my the the receiving thread vanishes.
>
> --
> Thanks,
> //richard

I have a test machine which is exhibiting this behavior. Indeed in
this application the sender thread continuously tries to send to a
killed receiving thread over IDDP.
So you're saying that all Xeno threads are the same process? So
killing a Xeno thread with an open socket doesn't do the "right
thing"?

Some possible next steps:
A) What sort of a timeout can I set up? Jan you suggested a timeout,
but I don't see "timeout" on the sendto() manpage.
OR
B) Can you give me a hack to the Xeno code to implement a return with
-ENOBUFS when this happens, like Richard suggested.

thanks,
-C Smith
