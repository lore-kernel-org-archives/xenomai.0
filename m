Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2BE1F543A
	for <xenomai@lists.linux.dev>; Tue, 17 Dec 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445598; cv=none; b=XbamTvHO5enjX6UerS3qdHuKejsohX1j7tnnPhbb083YASa42aJJ8nmydUQ/s7ss8NCQL9VSoNBO4YZkeFiPXwjsLRFiNmbiARg39Ct1qRHKDPv0ELcNGpVtoDaV0Jsa/a3Q9UuD55dy930cXj6ciIzw/7EsT9zk2aBnv6mJQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445598; c=relaxed/simple;
	bh=QryXVE9PgvcLYhLBQ0/xAzNvp1hHCyDBtEjFe/gAPMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUuM4ByNJWSmle1hbBLtpilnU98j8n6vMsTMvycSJIWHfs5q+7MuWLED7+tYGUt3KSQ9pqukiggmZNmJ1QCVCByk1Og6UQD+T1Gwpoo5lpyR50Pk7cOKH5v54Wn/wGkxI7G6jNRe9HVSxF4J9ef4lIpVM8FJHCFPbH3DGtP8UG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5Lsd/Q4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5Lsd/Q4"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so5596502e87.2
        for <xenomai@lists.linux.dev>; Tue, 17 Dec 2024 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734445595; x=1735050395; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g0yuznATNrlHst/Ztl5TTNpUVHbyLsu4KHUhcgl8IY=;
        b=g5Lsd/Q4ayHwfg2apnyQZKO5BMoqQf/peTf7o7YilNLI6RDhfHEX5rxm2X3Pm380hW
         iwahlFw5PxgH/LSEXzZ7P10T6UQLEfR4gt6K+RDZUCtAUSqNhvxdaHaI37Ph953o3XM4
         mueB54dBWvq50060ihwbwKUfZA+DAr25/rbkxl22yMHP5S7hF+49ZdRGYNmbUCVkbig+
         rnz5Fz3JEDVFN+XeRbbZY3cKp+lY5uRUU4jR9iRITZVqiUCXY0XhhKri8WlmW172Sw13
         fKls1d5ODEQ7d1JayVnWEoGCL4skHS2WUMgKHqVg7Gj2tys/LUJgJkSHr679L3TzM3Fg
         I3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734445595; x=1735050395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4g0yuznATNrlHst/Ztl5TTNpUVHbyLsu4KHUhcgl8IY=;
        b=wD7nW17CSxGS2pJiPGeUkj2J6WE60qEYYTdZ+g5wrDC346R1ZwgBAIqAVplVMV3kcY
         AoXuoH/GMLFCI+bPNfjmAyHVbVda4KBm/ULmUX0boOjR6NT/PQ2JJGvr+tzOmCBsLiHD
         Ekhuf8GO5QydpcPawE2qREkItXJgZd/Yu6fDUTh/vxPbuZ5RXnUjziy/LBGbF5XIyCaW
         D3sy+V8abaG8f/fQV9WfHY7/tUKUtY89KaHlLqXuHhDIv+uQEGURogy0O56jH+WJhyLg
         PHNRgoPBsPVSSdRZagJOKeumRwPXoj8Al3y7D41dB50m/uMLaQXLnrCdzQMOPL1ivhs5
         HLcw==
X-Gm-Message-State: AOJu0YwbCUy/umt8vkQRpFsKG049E05TPx/PxbIxdbzQg8tMUXHlYTW5
	LNvRA4FG+SjiNOd+nfyJoEw8zBd2mdRRtoHFgu6NYEllDjX+Be7NL3WdW0b6Q1KaODcuGot5+E3
	bnPTh/hxrYXnyc4XqYr6OK7VN1kPL8Ru9Hza63Q==
X-Gm-Gg: ASbGncv83o7awJCyxv+GCVcGXegPUwbgoqBsdPGIi6N1WseYbXv4w1aNfe1NfqTzS10
	sWZdoY3aIlVRXT/JKGY+XKGR5W3UF9WT+xpnd5IF7OMn648dwUGIz26H1gtkWzrXLLUeCHUw=
X-Google-Smtp-Source: AGHT+IFWdnsNe8wECouYrk2jzWBwlsbxXvjapnSWXbKiX94GpisPnUnlysXG/Fk7bzz7/MnrTa1F9G86Q5cZpGpSJGQ=
X-Received: by 2002:a05:6512:3a83:b0:53e:385c:e881 with SMTP id
 2adb3069b0e04-54090560bd3mr5251278e87.30.1734445594169; Tue, 17 Dec 2024
 06:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <8734iwc334.fsf@xenomai.org> <20241211152730.864059-1-ruiqurm@gmail.com>
 <87ed27emid.fsf@xenomai.org>
In-Reply-To: <87ed27emid.fsf@xenomai.org>
From: Qichen Qiu <ruiqurm@gmail.com>
Date: Tue, 17 Dec 2024 22:26:21 +0800
Message-ID: <CAHR=ZXGjPQm8ksTmABjK9ms6gtQ5-N3eD_H2xThx0Upr8kx9Zw@mail.gmail.com>
Subject: Re: [PATCH] evl: replace `remap_pfn_range` with `vm_insert_page` in control_mmap.
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your suggestions! I will take your feedback and send an
updated patch to the mailing list later

> - Why eagerly clearing the VM_WRITE flag from the vma?

I initially thought this was to prevent malicious flag modifications.
However, I later realized that the monitor might also need to use the
mapped area for certain operations that require write permissions. As a
result, I have removed this line in the new patch.


Philippe Gerum <rpm@xenomai.org> =E4=BA=8E2024=E5=B9=B412=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=80 22:22=E5=86=99=E9=81=93=EF=BC=9A
>
> Qichen Qiu <ruiqurm@gmail.com> writes:
>
> > Hi, I used vm_insert_page to map the area to user space, and it
> > successfully resolved the issue.
> >
>
> Thanks for the patch. A few observations:
>
> - for this to work, you definitely need to update the system heap
>   allocation method accordingly in the same patch, i.e. using vzalloc
>   instead of kzalloc. This patch is incomplete.
>
> - Why eagerly clearing the VM_WRITE flag from the vma?
>
> - the short log should refer to what is being fixed as perceived by
>   $user, not how we do that. The latter should be part of the long log
>   instead. In this case, that would be something like
>   evl/memory: allow system heap inspection using GDB
>   The long log could then give a few details about GDB, ptracing, the
>   VM_IO issue, and the reasoning behind the change of interface from
>   remap_pfn_range to vm_insert_page.
>
> > Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
> > ---
> >  kernel/evl/control.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/evl/control.c b/kernel/evl/control.c
> > index 2d1b44f3b0dc..eee4bcaad390 100644
> > --- a/kernel/evl/control.c
> > +++ b/kernel/evl/control.c
> > @@ -338,13 +338,22 @@ static long control_ioctl(struct file *filp, unsi=
gned int cmd,
> >  static int control_mmap(struct file *filp, struct vm_area_struct *vma)
> >  {
> >       void *p =3D evl_get_heap_base(&evl_shared_heap);
> > -     unsigned long pfn =3D __pa(p) >> PAGE_SHIFT;
> >       size_t len =3D vma->vm_end - vma->vm_start;
> > +     unsigned long addr =3D vma->vm_start;
> > +     int err;
> >
> >       if (len !=3D evl_shm_size)
> >               return -EINVAL;
> > +
> > +     vm_flags_clear(vma, VM_WRITE);
> > +
> > +     while (addr < vma->vm_end) {
> > +             err =3D vm_insert_page(vma, addr, virt_to_page(p));
> > +             if (err < 0)
> > +                     return err;
> > +             addr +=3D PAGE_SIZE;
> > +             p +=3D PAGE_SIZE;
> > +     }
> >
> > -     return remap_pfn_range(vma, vma->vm_start, pfn, len, PAGE_SHARED)=
;
> > +     return 0;
> >  }
> >
> >  static const struct file_operations control_fops =3D {
>
> --
> Philippe.
