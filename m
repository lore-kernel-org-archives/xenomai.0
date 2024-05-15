Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE855C3B
	for <xenomai@lists.linux.dev>; Wed, 15 May 2024 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779941; cv=none; b=ZAGk/jJ/IK15SirWViH+LG/TtxoC9HYOb7XhteXa4tfyDgWe82u9Pbl6DrJufkrf9UGppqhJMlgKW90uT16F68XZoAOZdqYFtHzoMTSiMcqJLI3Ak2v0URUPPHqyBgBkSkgv952XZ/U8X9/Cs5PFeiZ+7DnG3xU+GLLbCazFtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779941; c=relaxed/simple;
	bh=gyRYUv1RRC/caH9N7z2UPi0aNAHcPkCHsY1IT3vImSI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=JKvFl7acSc2MqcPtb7sDPgZgcXtiDTPbzMvoBU1mc1r/xAre6iegTvWIk2dEOHdjuL4lhA2rM45afza1o1QvztVHK5czjIGBe6G0jsvbS8TG7erniqHQ9vVJXe7wBtmvI3uqQ0RobTE/0w9BZewkZGdvjqCxdd3hPyAq1v7zyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-420180b58c5so22523005e9.3
        for <xenomai@lists.linux.dev>; Wed, 15 May 2024 06:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715779937; x=1716384737;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gyRYUv1RRC/caH9N7z2UPi0aNAHcPkCHsY1IT3vImSI=;
        b=ddMEUoSnGmY8PYeVqyGbGHytNjqBJW5iqOwKpUZFVZPZXYw4yNeJ6pz4mSZf9BMc50
         q4iuu3WbiDEXa1Z+QmuUbsK7HZWO4j4Eezx5VilbTCKnRm7XV71Cr8e8ZvldbwMG37hh
         s8jS0WK4PoJuBI/q/8cd0M1/hrT5hZwCXSIELw60cgY/h5sBsL45PTxGoL15RgaNx1Ol
         DBB02h5ZsEoFhK8+rZqFyeuD8s0yXrJirVVwPBSaOuWO2MtFAr8sAFbyrMNWZLXqQG4n
         0vOQNl/erzuGFRlfpGniZk8+Q838ezI2PpEp1SlQnqDHe0zKO+Gm4zLgGws12uQcTGFw
         h0yQ==
X-Gm-Message-State: AOJu0YxAC3p2caMem4NBXqlIQT5dy1O8Ze26IN5bjppna5pE4gt+TJ3m
	fEAQXEPQG2/qmCfCriP9BGkDNNN+4MPaQqJ3iJQwi7hxIFWCeiN45llRrA==
X-Google-Smtp-Source: AGHT+IGwPXX+lfV1O+9Jl3v3UcMVjYtuZKG+hSEUHkwS7su0vpwrdbL9V1op7sXGHHKwLe978L7FEg==
X-Received: by 2002:adf:e88e:0:b0:346:1ab6:dbd5 with SMTP id ffacd0b85a97d-3504a7379b0mr11533221f8f.20.1715779936694;
        Wed, 15 May 2024 06:32:16 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3504660753esm14861248f8f.8.2024.05.15.06.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 06:32:16 -0700 (PDT)
References: <11ec-66436800-89-7933f400@102269812>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: xenomai@lists.linux.dev
Subject: Re: Dovetailxenomai handling of heterogenous cores on AARCH64
 architecture
Date: Wed, 15 May 2024 15:27:37 +0200
In-reply-to: <11ec-66436800-89-7933f400@102269812>
Message-ID: <87r0e3w690.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:

> Hello,
>
> for a future project, I was wondering how/if dovetail/xenomai could handl=
e scheduling RT threads on heterogenous cores (A55/A76) on AARCH64 SoC.
>

big.LITTLE has no impact on Xenomai, except higher jitter figures when
running some real-time code on the low-end cores. I've been running
xeno4 on Odroid XU4Q without any issue for some time here (one of my
test systems). This does require a Dovetail-based real-time core though.

--=20
Philippe.
