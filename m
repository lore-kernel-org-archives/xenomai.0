Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706E10FD
	for <xenomai@lists.linux.dev>; Fri, 26 Sep 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901470; cv=none; b=B8Sy/k1U+wHy4ILLEEjYv7NlM9Gvvi8tZo/dgPSs9nZHncNTN37A9TbHRGh1sv61OBVlII4cD/lYhTI+MvhGHc9FHqkcbH8qkI2xIMtmG+z8efxRpP4NpufqRTqpDR6Mioq3UhsWiv/F20cJUPYQ0HOmxX7dAxLU9SmPzTtTR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901470; c=relaxed/simple;
	bh=vlZcrWWDpr0OrzzJznWI3A8r1+aa8vWckGR6BS8by7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNUFwicgjmA3vyXLjyKbHY3uErIopM564bb3BgB1XoKN7itMMBPNR/so+s90bHBx3jBASi7tp7yWKkRXzAFtn+PrYWJA2Zw01gKRwv8ddGgBbr/wLK7rUdO6JEaOFthZvb+pkRDGDhlJ4hxoZNPeBoK0lEjxlDjRyaEIUaqHq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=hGkWEWBW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="hGkWEWBW"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso2327608e87.0
        for <xenomai@lists.linux.dev>; Fri, 26 Sep 2025 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1758901466; x=1759506266; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJNsVL9OMebeEh3GhVfR2GUIqrqm5FgOinSlaM7lQ40=;
        b=hGkWEWBWOCjMt71hF+EYS0xbsYkJI9d7iCzAzzjkVGDbTz8RdsAfGgmTLSHKGXhi27
         8n9jEb8oX6vrf6k0baslDwqD0NS1hc3+NqUnaLlj+r3p1jV2DMV8DqD9dpl+QclG52Eg
         2nMVh5ygfry5NtULud/POa9kGUarQT6ml4+Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901466; x=1759506266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJNsVL9OMebeEh3GhVfR2GUIqrqm5FgOinSlaM7lQ40=;
        b=rWxH8Kjai14Isj03jOQ1ATjsJbq0VVuJsZQcJsxE9IJrrxZF8IKVHQhFECZ016alT0
         TjI3Na9XSpl1fFdg5UozQwrmBmxUoLeQk8aP0Dyky/QbaoHMHBmCqNNatlNFTy+NWtBN
         QhATtTkw+7czFoarrFB9nN3Kq9SLKgcLsgCkYrXYr85/ukTA0jkXSE+/E/i9NY/vugfx
         q/gMDTC9Io9H69WTNfGtMQRqU/Pd0PDxFAHKgj4boz1OIb1tYuvFvt2mLuE86ZiPZpfR
         pMQ423Ob0qETn1SWx4MO6mJRT3yRmwVTEHJKV04s5KmDCmwHyTcNuToPBUSOJYBw7fIV
         Lw5Q==
X-Gm-Message-State: AOJu0Yxw7PMaQ1m5iZdMMkL2juG2ZkXJyz2WEketT1Zecq0I4XG3RDk8
	HEh4i4+stinrC+kcT4Cajecalq2E8WVBwOY8gEkOSTsEswRFlj7xMGvhuQ9f+Jl3HTOVVDhddRE
	59xRRpKPDyuKFBgRPQTktm7jJLWwjKh5xqn2a0NJXUV9Q4e2YUDrI
X-Gm-Gg: ASbGnctROEzv0Bj8iXqz2yOjCLPFiThX8mpZX5f9g6/QsLGJfW7Rh27UkE4aEVAfycr
	mfevnZ3lep4HvhgMA/rlEw5p6AKsxrDSmsw9TLxqLSEuNkkVV5mE42ZVucJ1tRlgpl5UtMiXQI9
	H3sD3PzGZtllbJC7087rhFo5rMNXxUjfDP9BWIFK19fahTkAsu3uILKY19ptenG+vkNIvZ6fSxF
	OZTBhq6X8gPy9jLmAGYORIM81wRjZFGgV1/ddiQohtdU3gaw9g=
X-Google-Smtp-Source: AGHT+IEQ+pudHG0CXBwIGwYXJdpMcGesQInH90FzrK8ptuP1FdVIP1SrzVL0/zaBjkWhinnJ9eNG6CKSXpFEHQQqimU=
X-Received: by 2002:a05:6512:12d6:b0:57a:d20:d499 with SMTP id
 2adb3069b0e04-582d37cb373mr2637964e87.51.1758901466314; Fri, 26 Sep 2025
 08:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0vEL8-2vhaZpw5wHFjxCSMPCniQWL5AL7R_w+kQC=5PMA@mail.gmail.com>
 <87o6qxha7r.fsf@xenomai.org>
In-Reply-To: <87o6qxha7r.fsf@xenomai.org>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 26 Sep 2025 17:44:15 +0200
X-Gm-Features: AS18NWD237X-oeu7PQ2r8tTfSje4l01_2OP2kPF_eVjE3c-ztMX4Oy9HbV_Wm8c
Message-ID: <CAFc1U0tCXd2BSRabj5xsenJZnpcrnuLs=-DcV5=nxz5nQeEPWQ@mail.gmail.com>
Subject: Re: Running main() in the Xenomai domain
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I saw that doc yesterday but I didn't test it.

It works fine now, thx for your help.



Le ven. 26 sept. 2025 =C3=A0 10:47, Philippe Gerum <rpm@xenomai.org> a =C3=
=A9crit :
>
> Pierre FICHEUX <pierre.ficheux@smile.fr> writes:
>
> > Hi,
> >
> > Maybe it's a silly question but I think I did it some years ago but I
> > don't remember how to do it.
> >
> > Is that possible in Xenomai 3 ?
> >
> > Thx
> >
> > Regards
>
> Yes, see [1].
>
> [1] https://doc.xenomai.org/v3/html/xeno3prm/group__cobalt__api__sched.ht=
ml#ga14f50e1f5d815c90f1f4225eca5d3a8c
>
> --
> Philippe.



--

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
