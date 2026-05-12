Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA5394E91
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591722; cv=pass; b=CF/rB3Vx87LYT6wlo+ni3K8PiBBlIsw1zv2u7Ia+PgKjCHoG1zeBLXFVeRuekw1fchQWgsiXLxwRlKI5Fo0ovVHmYgLHF/QcCvHg3Qq9SZaGszbY5FI5GJk0UJWyo4Vjipig8wp0+npFHQ8pA8wOIU6GCeTSZGDFHNJanC5Xu84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591722; c=relaxed/simple;
	bh=uGk6wMULmmorGY0FybdwA0I7kdI+xPU7pDREV2zt+hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTsmEmbPA+DxnxHK9oNn0QZee6VNZjtc7s56oegRn0Yp56K8BUO0XNF/uR34xw6L8OENWj9ZZSVGjoHcnVKlxDa3Poa9rV599Fhy1CLL6dxuJRKbTlDpHeFgOaOjXP8VHGgyD5MR4Rkk4mfFUwo0YYjrt0jbIv4eUj57Gax8BEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tIF0Rhuy; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIF0Rhuy"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bce386d5b85so423759666b.1
        for <xenomai@lists.linux.dev>; Tue, 12 May 2026 06:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778591719; cv=none;
        d=google.com; s=arc-20240605;
        b=aJ54RQoLOPese5wsAZ3xstMWXheK5eTSfkdxSb3Oam33h38vjR3LyhTy8G/LzNrNvY
         Xg6R0djZOjI/9fjN96WPzS+UkuNZLZ2rdsyzcTabBOMyVOXOqAYDKicq1Yy8Qdt2XlbV
         vBnbo1Q80ASrJniO1OolgbqTP9fp0YTvtnULyW3koYiLb2/PQT7kIki17sReWostLw39
         Sj6hctPQTYrWwIE2BITS3SpTAbkw1obULTAHe7jo2JnEVg4a3YROhnihoXYqTUTWrnSO
         mZO96WyEdtBHIFcz7vNzEPuP2fQLtSD04b/urTo1Ji0unYMgmDM+zBbIWjvmB6KTBbKS
         HfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ec3pSiTcauabMXE/a1gH1ajsmL6Yd8Hr8iLpGTxXUgo=;
        fh=zmwBJn7k+d1VHO9OzMkjRDUrfoQVCLWwW1Mc2i+w2AM=;
        b=hRIH4783NZhzpXyNt6gXKvMAXLZX2fAgshzP1xjqhELOKgfEINC2SN0N9qFWizOVDH
         Ox29lLmLjebTIric3gWTZdAfQ3puPrhJk52Y4fRDNPuC5abWL93jlpS2ncdAUYPPwT1p
         H0Wc9x2nL4+sBexGWmAw/fD0tLStK2ZTk4TeU5HhjV4r8RKkGO5VLiKF/s9smzLSbubD
         CsJ4lWwIZY7RlXFRsRnDqM/ao226DeryJQRtG1benWi6HAatkqLaWUvzkd57xAGmCI2f
         H5zwsina2lbJjHhvY9qTb9ld/tv4xhSEINhVdhSw/FMSuUYwRq0Oi0q8Hsff5pVJzBxP
         MV3A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591719; x=1779196519; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec3pSiTcauabMXE/a1gH1ajsmL6Yd8Hr8iLpGTxXUgo=;
        b=tIF0Rhuy4rRErdKQiDZv0R6wCBa/PNti68uJhcbB5TyIveej6xVPeShoS5tRupfGnd
         T0NUFxKbGLoyav8drPJGOnBhhoh836V+NzuzxX359/NFiDeUmDPzAJcxvLYPFLAIqgEi
         /KljyHVhtV9v4mWfQCel6q+f828ReNIb0CfSgi26VR9A11J/pakrEp7iuoRNBGJj1Lue
         MysP4L932KQxj+dBA7mhrppeK5DR7wfGSj2yjK37ONZq4be4DGa6nGpN6eMQsvIwl0BJ
         AbMd7GkKMV4egoKx8U821lKbu/DEsxUiIluJ7B8TTzXdTKsO4UTTavXazRtIjhVK3kRG
         Zpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591719; x=1779196519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ec3pSiTcauabMXE/a1gH1ajsmL6Yd8Hr8iLpGTxXUgo=;
        b=SU3dvAGWOSBSAcg5vyQvijBbCD986gJzAVe71JQ2HoN9QDC9hCNOsSSaaDBVOqDJkL
         uyqSo/LyELxubLlhnb/aIHd65vqovvKCtOdB/df4gx9vzv2r7EnA2AdeWeIpROghnmDy
         m6mFgJvmtVXKMc8QRTb3zp2U3Zk/yeYb+E7FTcVSrGECXnxvMo4eBGKejzK23BpT19i3
         QRowbWJcy0WaTvs6+DuDJQ3mbdE/fu5Xd4kp9eNPOzc96NlKj7bTgSZg3L5bDMC6fAQS
         jkSbaVYNHwYxzCQxGUqbXHwFoqqcLcc/k4RQS2AdDGLBm/kr7UCFwLs1O+iYpQOUHXan
         LPZg==
X-Forwarded-Encrypted: i=1; AFNElJ8RqtUY5wfZ4fCcPFVJmKul0WXhhGJTaiX26jUPrVI3TshD3ShXe2cojPDUIa/vSIk/eTh7HzqV@lists.linux.dev
X-Gm-Message-State: AOJu0YwKU5Hh0Uzy8e8fvFY53ckSl0q4N8apNBU5PuCvI66ZFZX9p9B2
	T/XpCvzoNJXNrPFx5whe0bEnlWEfBsVY8NKNLveTbAGxFs5X2jp/mGBovPtDw8DutA7LgpMTMQE
	bamQWpXjpgG+T19i7ozmU4tNu8fPF8qY=
X-Gm-Gg: Acq92OHuNU+NpoMplnVaTouUFSwwUG7IkV2KxK4jAtK9NaF/LaE0FW9UxKVIu/ATqc7
	I7MISJrMBiIS2TorGNHr2Jd48neKa45IOOK/Y/t+I+e6nBFePu+nx2sNXH6g4XPYHPomE6YjV2n
	Cn5DRZjQ3nGKsuaSsc4TUEctQ7wuifn6ra7XX4Y5b7JIRpYZRUfDp6luctium673ynEP62i1+iz
	nGuojzWRAjNgTH4RF2K9jRrY7ztfWWfNZEedouhH2yyWmmrM96tHE034Jy7KVr1O9Y5x2xhsY9V
	EO7/9wE=
X-Received: by 2002:a17:907:3f9f:b0:bd1:4da0:b0ce with SMTP id
 a640c23a62f3a-bd14da0c877mr423150566b.1.1778591718906; Tue, 12 May 2026
 06:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260507122357.2463483-1-richard@nod.at> <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com>
 <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at> <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com>
 <955375516.2805.1778158548523.JavaMail.zimbra@nod.at> <84f6c3a9-b764-4774-b048-eb8e0c7fdc99@siemens.com>
 <472857942.3063.1778163004494.JavaMail.zimbra@nod.at> <2961c9be-b80f-438e-95b6-a2339f14d738@siemens.com>
 <CAFLxGvzYXjy3kkZMSiOqFbHgWTOaBccg3oBtVDKbyB97fedfGw@mail.gmail.com> <dfb6996f-1afc-4526-8b47-5972bccb2c39@siemens.com>
In-Reply-To: <dfb6996f-1afc-4526-8b47-5972bccb2c39@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 12 May 2026 15:15:03 +0200
X-Gm-Features: AVHnY4JtfjGhGskgIohIGsYwZb28fKhyyo6VtmX4uXG2UmqhRNcezwcGlAStABA
Message-ID: <CAFLxGvw+Bnb_OFaBD8KnPqpY769VMnMeCK-tLxLoUyiE_eSyiA@mail.gmail.com>
Subject: Re: [PATCH] Add build time guard to detect off_t mismatch
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>, xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:08=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 12.05.26 15:01, Richard Weinberger wrote:
> > On Thu, May 7, 2026 at 4:22=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.c=
om> wrote:
> >> OK, given that Xenomai intercepts the mmap path, we could argue that
> >> this is also stable relevant.
> >>
> >> Can you confirm that this issue is truly gone in next, whatever mode y=
ou
> >> choose on both sides?
> >
> > Still had no chance to build or run tests with Xenomai next on my ARM b=
oards.
> > But I had a look at the code.
> >
> > I think it's still broken, at least for the following scenario:
> > - 32 bit application built with  _FILE_OFFSET_BITS=3D64
> > - 32 bit libcobalt without
> > - application calls mmap() using __RT(mmap), so __cobalt_mmap() in libc=
obalt
> > - off_t differs in size ass seen by caller and callee
>
> A 32-bit app built with _FILE_OFFSET_BITS=3D64 is supposed to call mmap64
> (as symbol). In you scenario above, it should run into an unresolvable
> symbol error.

Hmm, not here.
I'm building Xenomai with:  CFLAGS=3D"-m32" ./configure && make -j 8 instal=
l
Then a program which does __RT(mmap):
$ gcc -o hog hog.c -m32 -D_FILE_OFFSET_BITS=3D64
$(/usr/xenomai/bin/xeno-config --cflags --skin=3Dposix --ldflags)
$   nm hog|grep mmap
        U __cobalt_mmap

--=20
Thanks,
//richard
