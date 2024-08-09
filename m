Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D62F56
	for <xenomai@lists.linux.dev>; Fri,  9 Aug 2024 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229702; cv=none; b=RDRiYj6Y5/2BBg7ry0+yVqHu0UNG6OG4UkQE4ecuMcBcKFNtT6KOXvvcPfxxMTi99ImtZ+eeeC0bfE4FSxkwL8NjsguVRS1Jc9De7zwncq+EyrvAnmUhshHjW1M7kRsBCCw9IeuPCc/a/SzxXAxxRNkpm4jecEBrRm/bZTez978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229702; c=relaxed/simple;
	bh=3pMvv/XLk6LvjYqaD2cM7gRakvJ0TlSyRrYXknuOI5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9EsVASK+zIdzkeAuYmME6BQn1LbgU5qluV5nwMHl2Tszv18mETlSOiSin+HxDBW6KrsPKjiBaAQDwPF5B6luaP+Yg8eD35hMGjLIkVLXXZfACPQI0OsjG7dORRMUXnx9dFquHEPbLzgeLjTxRHkGm8lATPeLT+itIXX8oeUrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAkkiDxR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAkkiDxR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb55ff1007so2011248a91.0
        for <xenomai@lists.linux.dev>; Fri, 09 Aug 2024 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723229701; x=1723834501; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAXbJ+n/J3IoszyeJj1YPOFTyklJ1mYEsS0UyYRz3H4=;
        b=dAkkiDxRTSSezH+W+OjSInt7Wy4YUVeTieWWeLRoRlhdtQ8+kL4SCg8x/DgmM/XHG5
         2HEgp+PvXA00WaafCJrLAxS2PdkmFE8BhKydJjT0UuQ1ZRm7YlsVZt8pJQ3UCTQvZfnt
         TvFyL2j6vmptm6MA+YSIBO069Wu7CNE19qkhfBJtIYp14tLvGQEA6elEUOeurUHWuPDG
         en8d8wb8A8sQpAbGmyCsN/RnFyh6kmghn41JQRT//O0H57tRAJecISXrE1svbXg0WHxM
         Jmet1LGmVymJLzWVi0zICi5kjnhA1wFoCbghe8db5J2CSwK307XLVixmOafDUkYf0GZF
         kWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229701; x=1723834501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAXbJ+n/J3IoszyeJj1YPOFTyklJ1mYEsS0UyYRz3H4=;
        b=B2XlesHUNyzm19n/pcZbWSUvZ8luBSMk1nZ8aT7EWIDqfZKDK77oj9R4PAvJthht51
         qtL1A7nBUMAR6MRyZsaWu8h30IV2TbPjHRYN23NqWeRafv9WNniAiZM5310B3XqRyOJ8
         GLzPiEBJl/+9bUfWvHf0ZaJwYT+fUOdzXbWZTEkZkketptdE/7oeQRpz+n6S5AbBIiss
         mVSSLCNTF3fAGwAW86M1612O7YtIf+FjluUVZTU+ghA7rKhDtNpHQ2sBQuHgDswpwdUj
         kWfYfLPWe6Q5WHN3Ij2O9ndxN9JrOulplm7jDlz8hTKoWvYOSf2aEW4hRlFnMet6tcTp
         ZfNA==
X-Forwarded-Encrypted: i=1; AJvYcCWG8HxkkcfQaMwKNFROBQxusK65Tg5VVUWSEByL9jZbqpCDlh1OD0gs6eThVZ+ZPmwi7QaR5GrjBy9jczlmqBM+o8Vr5wGAzg==
X-Gm-Message-State: AOJu0Yw9hxKN0cQVm1WR+WhC02BqE8mWpA2dh12Zz3r51qjDgp4+mQPP
	J/SKEP+mEXartPMsH8u5PQJ0pVw6CZZnJf0v1elcY3IbE2Y0R0Pr0qAbtKQ7ycW0EyMA6424Nta
	4XQKe3YOwrn4Qrym+igyqAo+EoAc=
X-Google-Smtp-Source: AGHT+IHc1P/oOy3neCuuQRLEMfkEkTiHnBH3SEII9IpCpW2tqHQyr0efuFxz4pOKmsMhRtCODVaKfKJEt7G3RmddKyo=
X-Received: by 2002:a17:90a:8d12:b0:2c9:5f1e:1a62 with SMTP id
 98e67ed59e1d1-2d1e80a2e16mr2773472a91.36.1723229700635; Fri, 09 Aug 2024
 11:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
 <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com> <CA+K1mPH=JAwPY2PSGX8Wcn7hqVuJ-t9zdEStQ4FZdeHFy57YWA@mail.gmail.com>
 <d3c212fa-154b-4f5b-b568-2816f585f311@siemens.com> <CAFLxGvxpYZxV6qQre_uQjmF=nAa_Wea5EEWpH1kjreuRAi8CWQ@mail.gmail.com>
 <CAFLxGvytCz=B5M3dhvuBDcg5=mJK0E+-TUOESbkM2oSkz-qDPg@mail.gmail.com> <0e2f567d-06e1-446d-b34f-02b9b9fc3165@siemens.com>
In-Reply-To: <0e2f567d-06e1-446d-b34f-02b9b9fc3165@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 9 Aug 2024 20:54:47 +0200
Message-ID: <CAFLxGvwm3qCk4e2d-Mf7bZGgcnfX8Eyd2yvEGpMf_tydw2H0-A@mail.gmail.com>
Subject: Re: Thread stuck in IDDP sendto()
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 6:01=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
>
> On 09.08.24 16:08, Richard Weinberger wrote:
> > On Fri, Aug 9, 2024 at 2:50=E2=80=AFPM Richard Weinberger
> > <richard.weinberger@gmail.com> wrote:
> >> This confuses me.  So, if a thread dies without calling close() on the
> >> IDDP socket,
> >> RTDM will *not* run proto_ops->close() implicitly?
> >> (The source indicates this).
> >
> > Well, I has to be like that, of course. It's all within the very same
> > process. :-S
> >
> > As soon one side of the IDDP socket vanishes without closing his side
> > of the socket,
> > the other side will block in sendmsg() when the buffer is full.
> >
>
> This kind of makes sense, yes. You could still use a timeout and fail
> that way.

Is there a reason why sendmsg() doesn't return with -ENOBUFS if the
buffer is full?

> Was that your problem then?

I'm not sure yet, as I said, I don't have the application on my desk.
It is also not clear to my the the receiving thread vanishes.

--=20
Thanks,
//richard
