Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495733997
	for <xenomai@lists.linux.dev>; Fri, 15 Nov 2024 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731705818; cv=none; b=Anx4jK2U4DD9njf/XZFcpL6YC/hkG332DezQ7YNydCPxDOPRZtWo5MMl1CoVO6MgAhitI77Qugjw4IVn1b7LQe9J01IfhP/hK4ziYSTglg5nZe7ZXR5E4xDSusMmuhZSQlgUCc/yi0ewbyJanLE0EEQv8ONspW5Zti8f32GQ5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731705818; c=relaxed/simple;
	bh=bsm7uFRxdEPvXID3qY86wBoqdBYSfuDBusEKXjKJe3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkEjw82WpO4TCaWMyIuDWuOP8rEYwyzbQS3ltx+icUCGiMColaYmN3lFNthX6Cpc4eAmWFxsTsFX55JME9uVgdJcw4K87tQsfRABUTrEDJkA4mqPkzoia0N6Yurm7eBubjEZsjSNG9aWAbHWvrO7P55u3LrqV9iuDSx9fzjiKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWwMDu7j; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWwMDu7j"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9ec267b879so200168666b.2
        for <xenomai@lists.linux.dev>; Fri, 15 Nov 2024 13:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731705815; x=1732310615; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+dPe7WhZkoFo+DKBZKmZcwjmn0M/VljCXzDQx4TxL4=;
        b=QWwMDu7jnLrhjQQoJWGV7/YsMc6fM+ZTOou/bQoOEaGKXemWOlsb18X+ayaWSddM3f
         1pCcwffoMGaNZ94rg0p5sA4wHskYXjn5KdxA1OJ3U/6GTZqXgsazZkZYv7gXeDdfljOl
         dr4UwCqNXjhDhM8RZdXP0bbRK1deGeQkekQ2Nsn75UiAlLFeS77waLi0tGtMgRPd/ML7
         RiLzWT4qw2gXf28wbGuBUBH726r3KpPn31r3CcJTeK/49GKqOWWgcOwA7N3f8/rPP6JM
         RvTbuOxZedJzHOof/bVGjdZn8Jl5cWfH22nrvRd2OHwiYcwQx+2haMXZdRL6RoXMatIE
         jRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731705815; x=1732310615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+dPe7WhZkoFo+DKBZKmZcwjmn0M/VljCXzDQx4TxL4=;
        b=JGmDk3qSnjMiYRTGy4eKjglosCT4WVLuzBkjEyhnhEcTmv+OrP/FLZ67Q95ejC4mcG
         vlxR/yIpOaerdBPchDZ3FPmTb3+7+etQzJ2Vg/Y1JwaFRIX7VEAApfGjUv9z4DWb40Tv
         JAVUEmABQj7mAivT5Kztg/HGvRW5LFGjjffHGUZ2JyJFmi6xPK6GIOu/pwnyAhFYBREd
         NA9VJfSylkdUckPUyhA1xrCpkHWa8QGs75oZko97z6UmFokBsjAMnmvfybE5FMDOKkI1
         zu3ko3PgCGPFJWWVpf7rMjMhE8X/Y9uJ6wp9DTBb0DGCzmSLNrr6b9bhMLSJwOFSVps7
         nV/A==
X-Gm-Message-State: AOJu0YzzqBjw1hArvvLiRvQ14CnmNfsv18jbD7jCrXHzX7/r8RSUsF/I
	x52x6Z4E6Wn/L7fV7aA5JH41JVS7o4nvRVZ1WEtDudn/HCEETDAxXybpK/coaQcdYxmGsiawhBB
	dfFnrCs+MhhsePzw0EOsye7VQ//Vo6Q==
X-Google-Smtp-Source: AGHT+IG1mZcU7cJGGEJDEN64dNfq1iRQepP/JFCa20Djiik/w55W8Xux9hpEf/ygNlvznxWdYFDbAZ50DJD5n47jALk=
X-Received: by 2002:a17:907:c24:b0:a99:da6c:f607 with SMTP id
 a640c23a62f3a-aa48350aaf2mr375860866b.44.1731705815028; Fri, 15 Nov 2024
 13:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+K1mPEtkU71sT7Dz6U2N-uXLiuuTsXEtvniU5jWBog81D1gvw@mail.gmail.com>
 <ec462a4d-e060-49a7-82d7-088cacd381e4@siemens.com>
In-Reply-To: <ec462a4d-e060-49a7-82d7-088cacd381e4@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 15 Nov 2024 13:23:23 -0800
Message-ID: <CA+K1mPFgts0=67-jOYk_0q-Ha4JZ9tjK_REfogp5vsWQYOw8dQ@mail.gmail.com>
Subject: Re: CPU threads supported?
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 2:33=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 15.11.24 08:29, C Smith wrote:
> > Does Xenomai support the _threads_ of an Intel x86 processor, or just t=
he cores?
> > I'm using Cobalt kernel Xeno 3.2.5  kernel 5.4.281
> > I have this 8-core CPU: 11th Gen Intel(R) Core(TM) i7-11850HE
> > I don't see anything in my kernel config that indicates thread support
> > is enabled.
> > lscpu says there should be 2 threads per core but does Xenomai 3.2 use =
them?
> >
>
> Xenomai does not differentiate between physical and logical cores. And
> that means, if you want to get a decent latency (<100 =C2=B5s, on some CP=
Us
> even just <1 ms), you need to make sure yourself that the sibling
> core(s) are not used (e.g. offlined via cpu hotplug).
>
> Jan

I definitely want the low latency, so I guess I want to prevent the
CPU from using any logical cores.

But looking at the CPU hotplug docs they list kernel options to limit
CPUs, but I don't see instructions
on how to restrict using logical cores per se.
If I have 8 physical cores and use the kernel option maxcpus=3D8 would
that prevent the CPU from ever
having more than the 8 physical cores? ie: prevent logical cores from
ever being used?

-C Smith
