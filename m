Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47673501
	for <xenomai@lists.linux.dev>; Wed, 28 Feb 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127895; cv=none; b=Xyxq8QF8X23neF76bQncqzlKwQ99wFFDtYVpqLzgoDl4gPBsDLfLBQXTLW19gyEyUmOZdX4d16ZDw2KumQdxze0go/T/c3h3tgWkGY9grzEQBbNTB4/UBwJoHaDL58eJ/d06/cPUtFDO6et8rPl3Yvz+6bnQn0ACOlFMTbHCbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127895; c=relaxed/simple;
	bh=ODVX5ZHRVBYVlF3c+cVeDE7iXEX1gJRk5rKsfHp3Y6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plBDNdKDIcRwIbYgCT/7/CH0gEuLYUI+nNOS/Ln5ZCZbXdhadBh3I0b0ZjWCNKDbkXbxpxeqVuED+LNrDTYyKlJWnl68nnQ59IhWjjntBmoiA1URbAXtRazyWYyMYU8u75PKKJ85PQ6v88LIGBH51etPE0RFLHYL2xnhFCPTrDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljg0sSVi; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljg0sSVi"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so3079449a12.0
        for <xenomai@lists.linux.dev>; Wed, 28 Feb 2024 05:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709127893; x=1709732693; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z16cC8zMmAkFjQXpu8l3DkuVuibFBW4S2IhlkdtT/aU=;
        b=ljg0sSViW0zeBLF1CFpCD44mfp0K7sifqAOQWMBqZcFvl6ukb83xIhR502sd4JgzA1
         6z1sdPotjXUhUS1OoSt4SlV+V3IM6fjoEqStfBRf/xNN6e1CKQEyalUBuUXg8J3WZjPV
         aBKxxsvm2fhTHPfIHwwk/PLbg1O6PCkOIDzwzoY5GFKAAF/pFUhGQEq5ZSGOxWqfMPAt
         tUJ0RrfZjA38jkcp/WQvKl4QnJvJw/toy2HdbQPQzFz/ZBX7tiNWwhUVzv6fT0iY4rzd
         GUuWsT1m/gmh3D44cDHi052WvMzG+r6McPH6rAUe6k0+mLJbEwJev32U5quL/evP8qp0
         zINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709127893; x=1709732693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z16cC8zMmAkFjQXpu8l3DkuVuibFBW4S2IhlkdtT/aU=;
        b=POpEWtHnRme+Lj3jrvLnLdHbLeXGGrl5gDY6CUHO3DWqHzO5Vx1Rq1kQWV6R91YUQ1
         gYvUWTzMWCN0Kc3oPvQaSfuVwBojfsgv+u7H2p5DCUR1BGBv8D75jgfD3p7V2rvKGIFI
         LFvaM4ZFtJiYs4gXmC4yruN5iMjOnqMk4i/wGVwzfFDVtKRugxTpIdJ0aTTPpqHoMQGO
         hBUPjDKQPFBhyzdrSQ4+Nua+rypzLWpvGstSexb5LiwpHNSaGY4yA5B6X3HViiWOtuLa
         OvrUUwt6LlYjP2eeZXTJYD/lVllHqfbOWpejpXMm6zF4MSxO91lJ+HZnoaX5LCY2p8jr
         J5OA==
X-Gm-Message-State: AOJu0YyeAt8JUDVyvT7tbJPiCQ7VeG0jNcFhAQXa33hwFtlVhfNi1o+s
	sKzJXpuNz+efXLKxgavURGGn4qNHXcUf/+kz0HKqB4cmrSaJCLMJrpUHC4jeXbW9PAkwk2jLL9m
	2T2utLQRZNdme8qUi+FIdMV7wxXeYtbjkxjU=
X-Google-Smtp-Source: AGHT+IHfYCvwhLqHig+zdAzRgnrs+8pFEreg/TEgJnnKBEUWRVVarMwByHaqZwTwaZF744JJZrrfSir41MjjqdGPDds=
X-Received: by 2002:a17:90a:bd98:b0:299:e313:b0ad with SMTP id
 z24-20020a17090abd9800b00299e313b0admr12002519pjr.9.1709127892916; Wed, 28
 Feb 2024 05:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvzXWdySKjXmWv=onYk0urPzkn8bxWuvoFEmLzLyuQTj1Q@mail.gmail.com>
In-Reply-To: <CAFLxGvzXWdySKjXmWv=onYk0urPzkn8bxWuvoFEmLzLyuQTj1Q@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 28 Feb 2024 14:44:40 +0100
Message-ID: <CAFLxGvwE76ud4K9iE-Vh8XOdsePWC7JPuearPxZu0omGTFE=ww@mail.gmail.com>
Subject: Re: ARM64 prefault weirdness
To: Xenomai <xenomai@lists.linux.dev>
Cc: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:24=E2=80=AFAM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> Hi!
>
> The more code I read, the more I get confused by Xenomai's prefault code.=
 ;-)
>
> On Kernel 6.1, David and I have the following situation:
> 1. A kernel module does vmalloc_user() followed by rtdm_mmap_to_user()
> with PROT_READ | PROT_EXEC
> 2. Arm64's prefault code triggers VM_BUG_ON_VMA(prev !=3D vma, vma); in
> find_mergeable_anon_vma()
> 3. It triggers only when PROT_WRITE in rtdm_mmap_to_user() is *not* set.
>
> While playing with David's reproducer I discovered that even without
> calling cobalt_machine.prefault() I don't
> get page faults in the RT application while accessing the area.
> rtdm_mmap_to_user() calls for vmalloc'ed areas vm_insert_page(), so I
> guess(!) we get there already
> page table entries.
>
> Can it be that cobalt_machine.prefault() is not really needed on arm64
> for vmalloc'ed memory?
> Maybe older kernels are just more forgiving and tolerate unneeded
> calls of handle_mm_fault()?
> The VM_BUG_ON_VMA() assertion is also rather new and you need to have
> CONFIG_DEBUG_VM=3Dy,
> maybe nobody noticed ever.
>
> What do you think?

FWIW, with this change applied I get no unexpected page faults nor the
VM_BUG_ON_VMA() triggers:

diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 99d54f58f..c2061b776 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1721,6 +1721,7 @@ static int mmap_kmem_helper(struct
vm_area_struct *vma, void *va)
{
       unsigned long addr, len, pfn, to;
       int ret =3D 0;
+       int skip_prefault =3D 0;

       to =3D (unsigned long)va;
       addr =3D vma->vm_start;
@@ -1740,6 +1741,9 @@ static int mmap_kmem_helper(struct
vm_area_struct *vma, void *va)
               if (ret)
                       return ret;
       } else {
+               if ((vma->vm_flags & VM_MAYWRITE) =3D=3D 0)
+                       skip_prefault =3D 1;
+
               /* vmalloc memory. */
               while (len > 0) {
                       struct page *page =3D vmalloc_to_page((void *)to);
@@ -1751,7 +1755,7 @@ static int mmap_kmem_helper(struct
vm_area_struct *vma, void *va)
               }
       }

-       if (cobalt_machine.prefault)
+       if (cobalt_machine.prefault && !skip_prefault)
               cobalt_machine.prefault(vma);
#endif

--=20
Thanks,
//richard
