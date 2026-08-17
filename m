Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136353C76AD
	for <xenomai@lists.linux.dev>; Mon, 17 Aug 2026 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968069; cv=pass; b=fAIAV1ZScL/0jtuvg5vY0/pqLLANuoH2XxTrSwmAvgCMWGGfNvfvnJvnMLE8OLqoBoWsSghDZ0rcS6j0YdQHLXaXCj++q0xTjF+zUefe2KOBLHNEqten+rpTB2Ystsb6VLzjIbKS8wjaFlREsSxghL6nbKYKzDMA53q/COjJUo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968069; c=relaxed/simple;
	bh=JsX55gbzXPgEMYao/cO6ijJ+OX0htbrlv9kLxolE32A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a87ul3oEGuqWOj97I4J2WoQJmyY1X7cAYWVyVQQmCCfCRTWDF5DfDXql6yULDX6mORatnqr0sn92aglRfE7I55h4mktVqEDk+avRYdsJU/6NcrDp1r+k4GvoHmuAiPS9H6ZQ57LXSYKaPQ/AqAx6vcai+x5Axb81mjZVblHq3NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com; spf=pass smtp.mailfrom=lmitechnologies.com; dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b=lQVo3Mu+; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lmitechnologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b="lQVo3Mu+"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15c42a45adso627778566b.0
        for <xenomai@lists.linux.dev>; Mon, 17 Aug 2026 05:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786968066; cv=none;
        d=google.com; s=arc-20260327;
        b=Bm6u9NPPjL2LklbaJ4RD3dSE1n4BUY7RQCOaf3TkT5ADq1F/ik148Edo5D9THlnYzB
         N8lInZhT9AaEf8rdOLcu/ua1sZgNmAd0++u2TzORw3YeoePhJmafnqK27nwKkIBzHKcy
         9Du0aBqp6dtC9XQih/vekgeS732x7IwYHNJqD2QJQePEHcFp2FgNJLGUVl2jHFK4Kdkc
         3qgLR8HeS7CxvJDjKsh9l9h3nSR+94dk5D14FEmtxRANpqTOcqx/NGywpOFX/uTsGykO
         IxbftPqqdJW8G32NKwPWzI1mDn5x6sbfCU7q376/3zVYNqyaDW4neOtJqcFyto71TvTI
         JXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1T8hCW5syGItiPiKLHx7d/YISAoUedocq7QpXbbDKQ0=;
        fh=fb/tJOninKBe0aPINiBLBq9bQiRXLyJcIC5EGSHzyUI=;
        b=IX+9BX1si7LS4yjx25bfooeFr5Ulq19xKJq5g4EM4q1WLehTt/ULzw8OR/OrpKu++U
         UbCe0Y7szb6Zih/W01yByvf/Wc583vPtFsCW0iejNTgYl9RpzPg4cHd4GJ8r7kYkAFj9
         L21HYLyJS1QUqHKlEu8aSluwdjR9Cc4hxFxjjLObUZNl5eUxrKhDftnSLDD3KDn26LxU
         6ILnUs0qAbqMOlitaNgQVGF4UhHowlpYeSeA/jT16/abg5T4dMCt9tf0CCxCe1x2K/d3
         lz/PA2niu0SGdrQPXCApFLRetBJyb7wSWauF/XQ5O9mx2eTYOK2XfXH5H6xZ1p2690C+
         t6hg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lmi3d.com; s=google; t=1786968066; x=1787572866; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1T8hCW5syGItiPiKLHx7d/YISAoUedocq7QpXbbDKQ0=;
        b=lQVo3Mu+Q50M4OUSS51AARZE9YpNsWYBDYPWWWs8X1l5X0qdQ4xE7QTi7N3W5vUxI0
         QyONAUxWUgF4vD2/ysbbFqwKgOlnHw2KY2ZnqR7MRoDJSCVgnrW9SIueYrt9FP8pElC5
         MEu0BLM41geN/0E7mJeyrMqFHj2Vf9JnMZSHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786968066; x=1787572866;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1T8hCW5syGItiPiKLHx7d/YISAoUedocq7QpXbbDKQ0=;
        b=IFNzIxhBLdRpJKiatz0TbsuqKXdgJIJ/OAdPRakdMzfQ91v/I5R+zyjMHac0wlkms8
         9wMV7U/n/s40gNIiP1J8lUlLpXB6tNNhHCmLtKrmZECOMrOaQTPn9mHnRwfuBJMEprli
         oXvksl2AVhmt1yqPlNJyDX5xN7DY6x00pA2QgItH38YU/sY8MLh3SXlgEKZaOoSk2oLi
         1XEU6q7bfI+yE9DipX4JfGgfRIMETG+hsZbC6xosdl0v4Ia/mw8AGrYKZTwJceZwg7aw
         VfdXFgguT4NRciYUnN6KXo1mN/lOPb8bk7kZ1Y385t8o2n3dBXz9akuoGFxnis8SGLFn
         GLEA==
X-Forwarded-Encrypted: i=1; AHgh+RolLftJALg+InIT2ZwTiLBmdsabG5PSJkYo8EgshoK6bQMTjz34b9xiTpuHVE1P4KsD+j1L+4I0@lists.linux.dev
X-Gm-Message-State: AOJu0YwUXy8eLudfyB7VX4HDbtMZiCWBBfmAZjaA3j+g089WIK1KrO1J
	CB10N7hIck3C82vbTSernHpxx8hs05knw2w6+pPvycCzP9cezMj9w/kDebt5bMcVml3vXC++aVG
	7OrOWQ1lXu/e3/2xsPOTjb8flBOa/Vwnb6UyeqcEfS6Ps1elXShW8jfVsl0XDGy/X08oEz5sLGj
	+yReCXZrIYX2q7tzzOXMWs4abAD711+xSCZhbhwtqUDxocIO1t/HFMeJ5zmanjPK26ib4mXyBiA
	F5eXVSfP4Vp6WQ8quA+3KoGLZrPJLQ=
X-Gm-Gg: AR+sD10ixIvWVJVzXDqCCruIZ/cwA1hHWRjwPq0+A7zexyaIIa4dQp0Ze+Esclfqijw
	uVXlrt8h3pNQf/SC4xhzG6U+2lLccMfQKGHFR3Ascmz/6N/Gl4cA3RhFBo1ENtiDBL07yKGn+e2
	Irg3D4IYlTIpdgJu73npGUfkeKvIiziLPrl3eOQNRpVFIVq7nNyVRWPvHMoY4puq/dsyipUpNQe
	qgTaNlyZ9ve6FljaTNAZYwILXf1eXMgQMBez1i6uFYP68Fz4bqtAEXFLb/njDUbxeIZNPU3clJa
	S6QpIWJOLOD9HmLQCQFc81ypUDuTOSuIkHJFySGKZKz3buhBc4u9tXQ6HV0juhxauhzW6GYsE82
	90Jl5yoRhZTgCvwfTfywqeEpECwSmk/sA2voGFn7cNIlSg2y5VvAwtxXvj/hngyQ=
X-Received: by 2002:a17:907:3e9f:b0:c12:8a:7d7b with SMTP id
 a640c23a62f3a-c2109e5c438mr1742583066b.1.1786968065563; Mon, 17 Aug 2026
 05:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
 <87v799kt2q.fsf@xenomai.org> <CAKndYJFhN5MfybdumExs7b5gTqW_CHa_i=cOL7R6xgjad1ytDQ@mail.gmail.com>
 <b7d8d1e3-0353-49dd-b626-5aaae76f7526@siemens.com>
In-Reply-To: <b7d8d1e3-0353-49dd-b626-5aaae76f7526@siemens.com>
From: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Mon, 17 Aug 2026 14:05:48 +0200
X-Gm-Features: AcwNN1U7b9Yc_afq8BlL_t7H178w-oVz-uOTuzOMCVw4XUcDR1LMbt6YCGFL7lM
Message-ID: <CAKndYJFsiha4BZ1VmyM4-XADyNJ0RusC+TPJAm9k2q99=khLLA@mail.gmail.com>
Subject: Re: The state of Xenomai 4 on Xilinx Zynq-7000 (or ARM32 in general)
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hey Jan/Philippe,

Thanks for pointing me in this direction.  I've done a bit of research
and I'm making good progress.

It actually booted as soon as I disabled the "scutimer" clock source
via the DTB.  This made the kernel fall back to "arm_global_timer" and
now it boots properly.

So, the original problem may be in Dovetail's "smp_twd" handoff under SMP.

> [..] if someone is willing to set up a lava working with a Zynq board [..].
> Still, it would also need someone to look into regressions, just like now...

I'm unaware of lava. Aside from Xenomai's patches, our boards need a
massive patchset to function fully (NAND flash, FPGA, etc.).  So, our
board is not the best testing vehicle. However, I am happy to help
test periodically, that's a small favor to return.

Let me know if you have any thoughts on where to look in smp_twd.c;
otherwise I'll keep digging on my end and report back.

Regards,

--
Gerte Hoogewerf
Senior Software Team Lead
LMI Technologies
Wiebachstraat 25b, Kerkrade 6466 NG, The Netherlands

-- 


This
email and any attachment(s) it may contain is confidential and is 
intended
solely for the use of the individual(s) to whom it is addressed. 
If you are not
the intended recipient of this email, you must not take 
action based on the
contents, nor distribute, nor expose any part of the 
content(s) to entities or
person(s) beyond the original distribution list. 
Please contact the sender and
delete the email if you have received it in 
error. Thank you.
