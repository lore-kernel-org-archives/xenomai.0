Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C527EC7C
	for <xenomai@lists.linux.dev>; Fri, 28 Nov 2025 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352143; cv=none; b=UL8Q2jlGO2of/cNwAD5Xlyj5tYCuy+NfTNNTtydYMkoBh2FQ1gY6Wt78pPqP3ASDtB4ZnsbzleVdX9YggueLLN9xNokGCX/J+cswwN3Fb41hrYvYCorl0nyuXV1BaPG9+X3s50sJtzkXDp8UiATs1lh+6e3KjzDMleMABdIo+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352143; c=relaxed/simple;
	bh=0zQB/Q2TmfSzhpnsaSL0RtWkXsESjD7z1V45ohufuEs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aJ76yQVI00k0qdzt7RbZORa7bYr6zEcgzrMuLHBBefI9eBD7n30OwnAIB2e0jI+4iEjf7qAcMNsbxoWKfHkeIWUTbLGFbfVwxmuvz4Yb/CDShgHkrTpGvETeXnO3UpKZjpxs9E6A6hfpSV16Igpn583HBmdy0UO3Bz7QZGn8sGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=N6bUrivs; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="N6bUrivs"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37b9d8122fdso19139251fa.3
        for <xenomai@lists.linux.dev>; Fri, 28 Nov 2025 09:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1764352139; x=1764956939; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/M1mLc0skKNhZyEGJKziYXBR+42wyaprlAknI5ow68=;
        b=N6bUrivs2C2+uBtPVm90YhFE/LEuR5FuBzVJvMmiCvJwOF9UKNm+/T+OTiYnGkgp9L
         TFX4/3FBz+9LveNXx12cmFmsjhDQl6xvdlc50zs73Kk9HNA9zYLv/3MjvrsuFhQ2wQXH
         2swqiTpXD3FpkYXa6SdT8yznTqigZpG5Gs/Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764352139; x=1764956939;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/M1mLc0skKNhZyEGJKziYXBR+42wyaprlAknI5ow68=;
        b=sQTvk3WKDqIPl96xeL8u3bURFNQYhZBzWACLkIi9ufGLpavwQzpKcdCi66v+nNP7rG
         LvTdR/IA3uVqnvL2XI9OWXVn8wROzmCePifOs8KslR9Mn4DUvY1HgZAFPzNqOHZa/FUx
         LcBUJ+Z01CiwCTkzycmmW9AIveznVthihH64EGrfXzy8g+YqYm3RYmS5jt2z/1gJJoi4
         LhReQ78GgTfC51hUWOGAyjAYrHnEA6UJ+jInfvvVbHju5c9DNtHMeq7gCFrIMzCZtMAl
         A3KOyzhI5cch/ZvVcpACqZfhwEbgfSZDBeoBpoxH89qLHHZQ/0QcymdLufF5fYtl8/a9
         Nf7w==
X-Gm-Message-State: AOJu0Yx8V28ISS6nW7rV/uTIfjTxQQ0NW5giHEbSVJo1CHUOK4N9tlmR
	pS3CcTn4wCm10eVmsah7M1jXApp59Dd0HuegXFZZrm6Am3xa+2619296EUmJpo2VnxA83KGSSi0
	8PVINOGztCPQ5cQy85a3Y4piF/f1L6wm2v3uZSTqrrgFMTz3M7m4SglE=
X-Gm-Gg: ASbGncvrvCFLxpJ7UvmnDsWIyDgajL17B1aWPGSqckcouAPOahmaajuT1qWDIVWH0ie
	l11WRoT+aBbtFUHegwCkfquMaE2ZI1cX3HMJxH3D8xEX8jcGpVLo6SRzBrnihuHh4RucbRkHGUd
	YK66DatkQLFh7w/NDbT9Vm2mWikdUCN84u/jX+MBs1CqmDlTOCOOZyJreimWSBzVeV1kaimSGWH
	bzsbJGqZ/BXWTCSn1THCf/C6p5U1Pt+QYxv117+iQJ4Bm7V45OgYAY4JgUQmhU7vhfFd4qzKNAd
	o7DfkXcmWPzi1Qk6PJFBWQ8twR93U7NnPClr5Cn/c9ZZ/aWdI+82zCS0BgUPmzd1rli7gChziIB
	TAuhuqphM99NRvaatSEito8Q0emk=
X-Google-Smtp-Source: AGHT+IH3LJtXSXgn06UsHdNk0swmBRG3qyNUxK6QU64NfeU0t/Fbi5t4081zRAPrDmgqFLatxErzhBvEggZ6DKi2JrM=
X-Received: by 2002:a2e:998f:0:b0:37a:2dca:cfc1 with SMTP id
 38308e7fff4ca-37cd923e090mr60719771fa.20.1764352139536; Fri, 28 Nov 2025
 09:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 28 Nov 2025 18:48:48 +0100
X-Gm-Features: AWmQ_bn99ScnnJo9hm8F8yPPy02l6jL_gKU470UZntBzGh0tk0j18ApIQhXovcs
Message-ID: <CAFc1U0sKevnf4i9HFLaRu5nJ-Lajn7khjsLDRtxx=CEFWy36OQ@mail.gmail.com>
Subject: EVL UART driver
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm looking for information about writing such a driver. Reading
https://v4.xenomai.org/core/drivers/index.html leads me to think there
is nothing available for UARTs.

Is there any example of documentation anywhere ?

I've read a post by a french developper (Cl=C3=A9ment Godbille) but it was
in 2021, just a short discussion with Philippe.

Thanks in advance.

Regards

--=20
Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
