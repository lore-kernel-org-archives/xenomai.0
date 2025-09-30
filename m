Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B93C238142
	for <xenomai@lists.linux.dev>; Tue, 30 Sep 2025 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249412; cv=none; b=s8J6u+tlwwbdQ5ejAWYSCpEpEWDyQwJsZdGLccpDK3ygisyMN+fkXCL2xwRc6CB7HE3hFcMNAddo1Gz6T17rytkUdmAW9ShRDB9EJjmKL/BBCwnuFgwYHfeaPMMIas71TQ7teh6lb7N0g191DBxfGaEccARznZkv+B7FoiZeab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249412; c=relaxed/simple;
	bh=5tgoTbkUtGO6J2pyHty2fhGq31c+EXf0xBawz3qODNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4EjbTzkdjowcJwx0DdjfMucHrGZM8tll4fACiyGW/QzgiyqgMgCIZMMUJcmq2Ra9R+Iy6TbLXvt+BphaZK/6ZQW6/Trfmpk43Mry1dszsCacC7ezREpnBEXAUKSL1b8Tra6++M7+BrgYQVv4dlPNDQlejTN7krxHSIFGSTd2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=exI3FL5c; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="exI3FL5c"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-368348d30e0so60247581fa.1
        for <xenomai@lists.linux.dev>; Tue, 30 Sep 2025 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1759249408; x=1759854208; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BMVI9LB831JYjmQqZCUBWYsTW9x5HwOjb5m8c61f7Q=;
        b=exI3FL5cSzcxVmG+wCNdXlYbKi6d+6joFS5o+HAdPWTuDaa/Qt3WN+akiHZ2piIjsP
         BT0oN7AAT+hr8NAACouzl+4qZe12zf9nXjkT3gL55PwPV96xDlehQuHxe7zks6qXQpZV
         1O+1+z8baHff6X9TboLt5VkYnk4gXAOFveEds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759249408; x=1759854208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BMVI9LB831JYjmQqZCUBWYsTW9x5HwOjb5m8c61f7Q=;
        b=D2tkDD3axeI4x3fscZI/46Kdtvcd9srQOQAgMlZV30Q7QQzrVSBzXvdjdSjC1RDtqs
         K3upErIDuz85InaiYBn+vmexpFb7/kOE+NgtIsYvNB858CyF3qpuT0sPMBGzvMn1a3tw
         VvLY3/tpINy7OD040bCTfvyRDqtAnz5LYU6H7CpIoTkkL2PqM8xlb8fHSAmfTRVfkQeu
         pZnOqXck+PGQM14Aw+nIBH+uMsSYf8eGmWwecZTQhl4/7MDwiFk+6EwZwJjTVkZxs7LB
         VjpxcPrIwDeoFvVxfQlm8HciAvQYc+qWamchjWQ2HO2gAhCZksnSsoVJgdcVaCkekhHc
         nEtw==
X-Gm-Message-State: AOJu0YzlQ+65jpdIr9M1lZumu6DukqYEfRmpvHxHVYTMa9PRNp2Z8Sub
	Z4GOQpof08dY2UoZ67aZoSrw/LnADj65AjgQgO+BU8yittY+NiCdRQMYdNmtMeW67U+DCkFd+LX
	SbhJ8LRskDektus30u9WeczNvHv+RLRIVIOTUmdRqdLA6KiMuf7HjwHk=
X-Gm-Gg: ASbGnctk6q18roEaWakNRcfKYSkfJaRVg7KhNwxvy1CGVBHjYj8AVj5SLlCh0LTVW9v
	4HEhb4MRrFkUAy+qWnkiF0KAgiYNToc3FeAOSBnV62Ra/XIFWlejxZWvEqMHhyDFYPYtgm/WfMK
	FABqZOWbv4trdNpZflbF2nBWOHIv0YUBY4nVusGO3LrzNxgH8FHY4m44lf6sTPdhOMD3YkSrm77
	wFtxmTXUSP62raHn+w4wkPFne2OFOuxYe9TnlbNqrOfLlFlKPRmKcUao/9LV/zTLsIhV4WS7Ck=
X-Google-Smtp-Source: AGHT+IEr+ZVEneoga74ICftoiYL5hSHZDWZjsqyOV7MvY09ek+6gs3RzJY44DncDRBuxdM+13K6/T9pt0g7OClOvLvE=
X-Received: by 2002:a2e:bc1a:0:b0:36e:9e8f:ba4d with SMTP id
 38308e7fff4ca-373a732fb39mr330781fa.14.1759249407833; Tue, 30 Sep 2025
 09:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0tVxe4sYCkmjyUxTBZDphUm71V8wfpjj9CbyeDwe9gVNA@mail.gmail.com>
 <8b63c1ef-d908-4aab-a28b-f158bde68542@siemens.com>
In-Reply-To: <8b63c1ef-d908-4aab-a28b-f158bde68542@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 30 Sep 2025 18:23:17 +0200
X-Gm-Features: AS18NWBWoAycczzaz3kHdw0ac4q0kaxnD2iyvb1SQ9vTkOeZ-c7H7oOJEAS0g9o
Message-ID: <CAFc1U0t080fc_iQiCCdKdw3r4Drt5jnZmthmR8G_ZwAC05cMww@mail.gmail.com>
Subject: Re: Used memory by a Xenomai 3 application
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

And what about /proc/xenomai/sched/acct ?

Le mar. 30 sept. 2025 =C3=A0 18:15, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 30.09.25 16:43, Pierre FICHEUX wrote:
> > Hi,
> >
> > On Linux, one can get the RSS and VSZ for a running process with top or=
 ps.
> >
> > Is there a way to get the same information for a task running in the
> > Xenomai domain?
>
> A Xenomai process is memory-wise a Linux process - same sources apply.
>
> > 'rtps' does not give such information.
> >
> > Maybe /proc/xenomai/heap?
> >
> > # cat /proc/xenomai/heap
> >     TOTAL      FREE  NAME
> >   4194304   4188544  system heap
> >    262144    262112  shared heap
> >    262144    262112  private heap[18470]
> >
>
> This is listing the Xenomai-specific in-kernel resource usage of all
> Xenomai processes.
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
