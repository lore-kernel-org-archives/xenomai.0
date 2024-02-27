Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B2136999
	for <xenomai@lists.linux.dev>; Tue, 27 Feb 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025877; cv=none; b=TJ7p7tIC19iibkIEsBVSzlLh4S83mDxKemhXDvPhnbce4PToxAg/4iwJLr5dvmdEHw3Cu78BqlBJOnrcLOcNVDFzJp2dlgbqsEnYD/6xHJJua6qzGezPlOSQjkrrkMWbHYRF5oK5co0XFlSffvqjg2mhVXLgwsRc/TSL0eySnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025877; c=relaxed/simple;
	bh=43BrKcDDONcBjmPjw4L3DWXJjDRmu3v1N4eCkvmqItQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=N91A5oSqLoHjPitmGOn0hytT8djcN7zQE9YurlUdzrQ2IYbWmJRJg6SDhOY0ZCESoiVgQAQvJHx/J44plJfhGi6FmtxgOmBqIZ309ZmbMxYul1rOiJwry0a6YPSFWvSL7iRWKXKNTFhUgdAcD70wkUtTGCATfcUe4Ag0y+9N5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcRklQdo; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcRklQdo"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bba50cd318so2976400b6e.0
        for <xenomai@lists.linux.dev>; Tue, 27 Feb 2024 01:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709025874; x=1709630674; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tqVJdT8BIdAgJ5HzcZow1Z/dUykRQzAYr8AjY8kl+48=;
        b=FcRklQdoRLgW/ULVL8XEMlZlK1A5Fw9tWV7ecTgx9BFqlrb/e/mZO9Sj8SMW6+by0z
         1h3Ixh6JSZEjbMEwCxHBi9Dl93YuNLNaTXq2u/sEHylJLrPUlq6joLAmIwKHff6zuyfD
         pLSklVLKsT2IJwA0Drm4qkE3zsUvMGdJ8N0DGB1MxLJYfJBvz/VlJf+DSIgCWF0f613N
         kaL32ODfxSdttb2sqVUHIK4qmibC3iGlW34xiq06+ipykWS1VFnBQUZ0xGjc02vA1DNM
         rAlg4gsafDSynmxFil+GTjt4FBh711dT6WTKJqZC7z7NcpgaLIuEX/6Djj+lb/JxuZQW
         V6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025874; x=1709630674;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqVJdT8BIdAgJ5HzcZow1Z/dUykRQzAYr8AjY8kl+48=;
        b=AWNA+HoEoRMOtxMnffxlCLYNIFaC4xi95s5RrpIGwC305/62yHNf/K2OdrUp4ln67H
         QVanrruw/RJ5HcPI6vawHE9u/X7VQbcG95c4jQTYDvwNJr2AVtBnaOAWajTQC3KPXjXc
         QEuXiuiuAQ06fSfna1VS6yNkFt14gJJnpeQSrvdBA/FfeWUMmEYxjc6rArCFxFSXIcNi
         7XtMZx8A04pyl4WijCvU80m7PMeqcAkJ5tRaO0OZluXXiFj/RAH0ySj773AihP8lR/9/
         1FkbOhsm31v1gNlUf44wsU5xBeDPC1d0fOOzApkG0/taKk/bhUmRu9uGke0ToYePN86W
         dFqg==
X-Gm-Message-State: AOJu0YwYTRqEUCimOX+TUGXrUnDaDfS0ICxAjPj3J6zy1meN5tOTH2D4
	L9LyCcMwYikfOQhQCnJjwL58rYAQaz7DshvL1DAUrbg6omkL7nVjoP6h34rYCzyXq1qeZI3ZhRb
	QO9EVY5umLW9DkeRtupI9EIvodkETrrkWgfw=
X-Google-Smtp-Source: AGHT+IHZ9aFQDgCRgS3kGEzxL9lcfCruIMMpJygQ4yq9A1PB7Cz9qwya5942XY/lp9qtg7MuP1Cq21Jof8d/W1nYqIs=
X-Received: by 2002:a05:6808:1646:b0:3c1:a9ef:e8a0 with SMTP id
 az6-20020a056808164600b003c1a9efe8a0mr1689674oib.48.1709025874618; Tue, 27
 Feb 2024 01:24:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 27 Feb 2024 10:24:22 +0100
Message-ID: <CAFLxGvzXWdySKjXmWv=onYk0urPzkn8bxWuvoFEmLzLyuQTj1Q@mail.gmail.com>
Subject: ARM64 prefault weirdness
To: Xenomai <xenomai@lists.linux.dev>
Cc: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset="UTF-8"

Hi!

The more code I read, the more I get confused by Xenomai's prefault code. ;-)

On Kernel 6.1, David and I have the following situation:
1. A kernel module does vmalloc_user() followed by rtdm_mmap_to_user()
with PROT_READ | PROT_EXEC
2. Arm64's prefault code triggers VM_BUG_ON_VMA(prev != vma, vma); in
find_mergeable_anon_vma()
3. It triggers only when PROT_WRITE in rtdm_mmap_to_user() is *not* set.

While playing with David's reproducer I discovered that even without
calling cobalt_machine.prefault() I don't
get page faults in the RT application while accessing the area.
rtdm_mmap_to_user() calls for vmalloc'ed areas vm_insert_page(), so I
guess(!) we get there already
page table entries.

Can it be that cobalt_machine.prefault() is not really needed on arm64
for vmalloc'ed memory?
Maybe older kernels are just more forgiving and tolerate unneeded
calls of handle_mm_fault()?
The VM_BUG_ON_VMA() assertion is also rather new and you need to have
CONFIG_DEBUG_VM=y,
maybe nobody noticed ever.

What do you think?

-- 
Thanks,
//richard
