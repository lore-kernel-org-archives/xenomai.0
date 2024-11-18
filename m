Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933E18E25
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917485; cv=none; b=AfhmrJQOvKL3INDnRwZ2V6Tk7ZzMPiHN7tP3WzkXBhqscKXIatjb65EFU9XZxWPZlsKIpCdwXioHSsn3Hpd8+g6d0IhOl3nLC2MkgNRYEpELq5vrcGpKr9ce3jLQieP0DgZY+M/AVIDoZSrYtHtBSjySCXZFuFTNzj03nLc5TH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917485; c=relaxed/simple;
	bh=0nvN34kOx/J1HIyqdx4X0kzFLoc3JV4OmZ/NdMTClts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqrhjrTrerBkWgj4bCvAaQwqcf4r2VN6OD+CKq1AdGDSeD1OUiDJcj8dmIZQBuWOZxeOlEIn1l9ZAAP8w3lPjhWCuWQkHQt4v6N+6MTusu7wVMRRRWKauP0aiZDQORWlnndQKDGmW+U+M7h9msQKov1f9sRyINpr4praiRZfA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=J/KuCnMJ; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="J/KuCnMJ"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 0DDF0100006
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 08:11:21 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 385EA74003D
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 08:11:20 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-539f1292a9bso4474210e87.2
        for <xenomai@xenomai.org>; Mon, 18 Nov 2024 00:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1731917479; x=1732522279; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khGb3iY5e7qgIubzJlQ+Vl3xOdt6P84x+DjQlk/6K+w=;
        b=J/KuCnMJheAjMd+fFahbhjZy8JdWUMe9L7BQkhydrMJDuT4Mlu56LIJD+5lSvKOv1e
         6T9XpFslIP80eSVM2QtCq/UdO326vv/Nfkyl+Rbz+7/bp6h0iBZHWvirSSACvGe83hKL
         K51IZy2Z8gwRYoh4qC3FCYPHtxqBhmxk+OyMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731917479; x=1732522279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khGb3iY5e7qgIubzJlQ+Vl3xOdt6P84x+DjQlk/6K+w=;
        b=BRfpHVXdu3QIN+EQVByXVaf751NXa3yrO1/MxgLXoJiBab2/6MIDc3Q44aHk5tTIo3
         enwJvdO+X0e1iAMRTl1dtT/sKkaZyD0Z/ILc2YIw4gSI9oW4DxIykYhBCVrbrjC3QdWs
         1haPOr9hWGCz2vC6qGSb2jXQ6xe3JT1xETXORZuV+y2/3+PKAip/nzxyW+R7JQXPC+zn
         WzQEkpA1iRA6B/aBVcMhwGsCiUWdNdJrdMZmN7c4xMFSJ9u0moCfXbs0q36mVoYleuwE
         SW3S+z1abJivTJlqz5vnydZJG1HYcRZei6VgsEkDqs/dmqNoEN0qJzN30FkCrfdRAQeB
         4KxA==
X-Gm-Message-State: AOJu0YyZREbCRt+qGUdMhpXCFFLkiNBINmtg9bDmOuF6tGkIkiYZGgoI
	73OLn4UI1DOvMCu2W64ojUu1MZmn2r/38QU7afke7Wo75xnojou/aoYQBSKcIZIkMHA9lUeTo/+
	8U84FZSTVBS8TvlRq91ltZLvgRCAxE1Xwz842djwnYX6EfyesmzzoNQ==
X-Google-Smtp-Source: AGHT+IGcbuvqFC3WdUxHIT9eWG9hvWP1WwDFbO1xbaQAiS/dSFp3ifvqiMkITZaMo5Q0hEaHFzDR7TFznN5CWiPt+7I=
X-Received: by 2002:a05:651c:88a:b0:2fe:fec7:8adf with SMTP id
 38308e7fff4ca-2ff609be35fmr44413151fa.38.1731917479264; Mon, 18 Nov 2024
 00:11:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <giN3vearN1y6Zs5xQuBxzIuE9sPhO-y12RSvKKFYPIZnLJJW7dN1vmlmEpLBDuSVKuk8qYA3O_I--946KsBwJRceRx2BKlYxkHLaAJic_Ww=@protonmail.com>
In-Reply-To: <giN3vearN1y6Zs5xQuBxzIuE9sPhO-y12RSvKKFYPIZnLJJW7dN1vmlmEpLBDuSVKuk8qYA3O_I--946KsBwJRceRx2BKlYxkHLaAJic_Ww=@protonmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 18 Nov 2024 09:11:08 +0100
Message-ID: <CAFc1U0v1O97JkW6oP_CvsT0ZxuPP2s7XEHdXsTu7eQpwab5M8w@mail.gmail.com>
Subject: Re: Using Xenomai in Medical Devices
To: Andrew <andrew.penner@protonmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::133 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi,

A long time ago I did a Xenomai training for GE as they wanted to
switch from VxWorks to Xenomai (we used the VxWorks skin).

I don't know what happened but they were interested. Some other
companies use PREEMPT_RT.

Google is your friend, try "xenomai medical device"

https://indjst.org/download-article.php?Article_Unique_Id=3DINDJST9768&Full=
_Text_Pdf_Download=3DTrue

Regards


Le lun. 18 nov. 2024 =C3=A0 08:46, Andrew <andrew.penner@protonmail.com> a =
=C3=A9crit :
>
> Hi,
>
> I am looking into RTOS for medical devices. Since I am fond of the Xenoma=
i project, I thought I would check if there are any know use cases where it=
 has been used in existing medical devices (name of the device along with t=
he 'yes, absolutely' would help me convince others.)
>
> Thanks in advance,
>
> Andrew
>
> Sent from Proton Mail Android
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
