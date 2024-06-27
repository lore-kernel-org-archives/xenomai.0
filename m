Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD534D11D
	for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473111; cv=none; b=BjneE383pbygvnKUwWF0jQZqjNk9E1zEaFec6JbeNUGaTRvXvuEnVKFDWB3LVDsGOO7LZ14plyMF3cSOI/A7Mc3LSSYNIispRkn0fYrtxXs/3Q3VtuqPPbwbMPB1Z9IzH1UAYlre0GYM7xzcym7vbEXfXcHBWbh3APh/o6XGgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473111; c=relaxed/simple;
	bh=MAJFkueWq0/p4DmieWrCIKWYGt5934kWuU5QbTr8zSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICBtLWMcM1bIPKLSnubGLRG60rncreZj0tq/OKYzWxa0RZ2VxCDuysOZXNI+sGC29ZTTpRC4PiLPx4s+8+OM6bszzNvOYrWJhgOz/bNAYihEpZpRGz3+OqLmppGJisZwTWQjOAeTcHT1vOUU4g50kkTZtTBNP8E+gW8tpKsw4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=K+7Uj9Cb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="K+7Uj9Cb"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424f2b73629so16774365e9.2
        for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 00:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1719473106; x=1720077906; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seG55tsV/V4lp4Zg7bYSFc7W4p0b9THqJaF5gZLezr0=;
        b=K+7Uj9Cb1CsniuMqRvuACSgVHyyUFe745BrusYIcYvHq297rbAEd5Bhu6uCmSDFqOl
         CGWs3Hq+BaqsR9L22qeO+UpvK5B0mM4Jxpg5PG8dPsMmE26F8TEETS2y4XOQjEAiVPjT
         b5/I6vh3UDkCUrrjACgJOhRW5ilUUPnPU/Bj5WKB9gsayOwOkL2CqrIUAJ2haWZeKLfo
         vyrBRz7vyPiokScEzPs+qHQLTLiRMMHJ7ZB0TdkGbedYwqWEEbrU5S/kXGs0BT8vgqYB
         y+7ilKlJ5VgSkQY/8ofOYgHWYiIpRv+3xiOKhRJUpxWlIluFPRQV55p0q4yWJTdBRrc1
         Jq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719473106; x=1720077906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seG55tsV/V4lp4Zg7bYSFc7W4p0b9THqJaF5gZLezr0=;
        b=GkA3grVnPo3Tr3VqdOJx6kMzVBgcGK72gnYcEHpTUxOMiaSXPOGoJVzNcX87v4cydc
         svGwo6GC8B5oBDBfLWCohxpZWIbsaPj6a7VNxK0gE8LPRFluAw8tAhQtUZHf638N9Adm
         htDKYpni0iRXqv9h2LRJKvLsQnpj1HgpL6IHleueW27KlCtVlYasnI+cZ2igEskPmN3b
         jgRMaxKdNGi1kPj/q7ukk6bcDF+upB7tgZM5cJ+jf2R8UblbCXkn4abTxJPBJnEd+zel
         wMtdkDaF4uLg2HxD/UbTx3KZQuV1tQoLkU+5Wqg+wZcRhDtw6OWJ598/5kK+0BkPn+fm
         T+EA==
X-Forwarded-Encrypted: i=1; AJvYcCWMj+TmmEHuBPmD+dfypeFH5NsTkdILmL0kPDaa870Pf+ccA3+yxYUm2dyIUTj0fyiX1BG7wE+7Ry9TQ5fdagErjyLpUIA8AA==
X-Gm-Message-State: AOJu0YybhaFXXEuk6MMoDxCGOhJms79jMt/XvBQVLyYlQHgJ318bnQqC
	fkRMo8cr7KePeg3EL85BnOKVHOifJZTqRHCP9BOy7cr7qG8Mv/8hfTKmzqCXzVU=
X-Google-Smtp-Source: AGHT+IF/lf+u78rWQ0Usk9ITO63IzkZgNxRawcjMe+gYaSdBqvFIeSs8ww0W4xEg/yXOrNw2oicEWQ==
X-Received: by 2002:a05:600c:348c:b0:424:a5ee:a81e with SMTP id 5b1f17b1804b1-4256456c30amr8448025e9.34.1719473106277;
        Thu, 27 Jun 2024 00:25:06 -0700 (PDT)
Received: from blindfold.localnet ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564bb6caasm12637115e9.33.2024.06.27.00.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:25:06 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev, upstream@sigma-star.at
Cc: upstream+xenomai@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] kernel: Clean up generated syscall_entries.h file
Date: Thu, 27 Jun 2024 09:25:05 +0200
Message-ID: <4209190.8TcEBkooeH@somecomputer>
In-Reply-To: <77eb1c15-be5d-4f99-b023-844a679699cc@siemens.com>
References: <20240626192625.14745-1-richard@nod.at> <77eb1c15-be5d-4f99-b023-844a679699cc@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 27. Juni 2024, 08:29:46 CEST schrieb 'Jan Kiszka' via upstre=
am:
> > @@ -31,7 +31,7 @@ quiet_cmd_syscall_entries =3D GEN     $@
> >  $(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(s=
rc)/*.c) FORCE
> >  	$(call if_changed,syscall_entries)
> > =20
> > -target +=3D syscall_entries.h
> > +clean-files +=3D syscall_entries.h
>=20
> target is generally needed to prevent re-executing the build although
> that target file is already present and recent. Did you check that a
> second build will not have this problem after that change?

I thought you want re-executing because of the "FORCE" property.
Why is FORCE needed then?

Why doesn't the "default" maineline work?
e.g. something like that:
diff --git a/kernel/cobalt/posix/Makefile b/kernel/cobalt/posix/Makefile
index 5b4f3214a..e57628cf1 100644
=2D-- a/kernel/cobalt/posix/Makefile
+++ b/kernel/cobalt/posix/Makefile
@@ -26,13 +26,13 @@ xenomai-y :=3D                \
 syscall_entries :=3D $(srctree)/$(src)/gen-syscall-entries.sh
=20
 quiet_cmd_syscall_entries =3D GEN     $@
=2D      cmd_syscall_entries =3D $(CONFIG_SHELL) '$(syscall_entries)' $(fil=
ter-out FORCE,$^) > $@
+      cmd_syscall_entries =3D $^ > $@
=20
=2D$(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src=
)/*.c) FORCE
=2D       $(call if_changed,syscall_entries)
=2D
=2Dtarget +=3D syscall_entries.h
+$(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src)/=
*.c)
+       $(call cmd,syscall_entries)
=20
 $(obj)/syscall.o: $(obj)/syscall_entries.h
=20
+clean-files    +=3D syscall_entries.h
+
 xenomai-$(CONFIG_XENO_ARCH_SYS3264) +=3D compat.o syscall32.o

LG,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


