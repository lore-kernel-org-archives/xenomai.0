Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4690E395AC6
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581560; cv=pass; b=aBoeDYYU3WZv2XS1v8zlv3sJkP2HsA8BVMsNtfSjG1FMYFIhpoVTEXRw12oJPkBiJ5ZK2hbnrh16dJP0sZLuDbFOJjUWSTJVzLXDuySzHfkJC1aFCidtHxGzm+yCUtU94PPbnZsmO6l3mhr3Y78/2Arv/kiCHZ924/opgr/P6l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581560; c=relaxed/simple;
	bh=WHxjSryWkf9DcTeU3EeI+pT/8hB+DD0vmivACPon/HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTjWoUpeZZOYQhVq247lXoZBiG0PToCrgQlvOdmC+UdyLgDKJ1qC+lHXJHxdWM53Gbc8RcAFPssKeWlHJQUG4wh/RUg1QbZKhA7PM54hL9XYtQmYav875djX4Gc9EmpD7zrHpWmEGYsv+KNAIuA7uITu5BDpZjQjEcwRejf/JQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opa7/WFj; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opa7/WFj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba6485d219so34552765ad.3
        for <xenomai@lists.linux.dev>; Tue, 12 May 2026 03:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778581559; cv=none;
        d=google.com; s=arc-20240605;
        b=K3jYsGTAuPsL/IHiqnhsPrW/ZwnjqoP5qbosy/Tv7iAFK20f0nEV3v2majO6Shrcd5
         nk6df15n72dfAqhy4VoD/kcYczApDc4SyG6dqzZiH8c+ym1y6aMnEXPxA/DjIsyzzKeI
         tKgfCEnCG+3Vo9zm/pCxJudRR/ozcc3K/a/aILxeupd8mquvW58o8pWBjhFfB0A418AU
         HI8seSgcvhxafGxfx2yrULxDH35jx1TV2HXj0mZQ5UOOxm+e7WSNbZHUPB9a5ZUhyroe
         lIU2qyqzvoa1rYwcFLAEqTg1Hwlr+MXFsJB314utZEHRm6as8df95PBrA8SkKX7pAj0N
         IW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHxjSryWkf9DcTeU3EeI+pT/8hB+DD0vmivACPon/HI=;
        fh=Gbokv2cqjXipI/isbuuM2AkWdnz5ZRsDr4BAyqPfOQ0=;
        b=GVnorg1KX8lmG9/CuFonX42TpvuU7NarZ7fjCmTcqU8R7B54EinhPf/ZwoRo3wpX0S
         R5yH+8Yfe2znNZ4K2gtTSrj9Asi78PczwbO/c5YZHfXzNNlMqX+J77wMqzG3shhv0n2T
         cRuQei72oyW9fHUJ2dbS+Rt/X8NBs23jwCw+2z6U5Pg/HQnRu3g9QlkNyvzOxzV0b7Hx
         k10A5P8ePd/V7x46Ew7w1GJATyJHdtJwbB0b1gRxsrgNNymFgHYwZIPfiRgtistlaSHn
         HkJOET4OTGkl6jts5VMgQBx1IzIp24M3bZmY+n7BopY+2SbN5q6s3P6pmVBF0I5AG683
         O60g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581559; x=1779186359; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHxjSryWkf9DcTeU3EeI+pT/8hB+DD0vmivACPon/HI=;
        b=opa7/WFjBl444qcmdbqB6nd+9GvqakW7FjZMqnrDQW3PFdfH4qB3H+/r8P8pPzxWS/
         5lVc8TiYuxUlNRKg86KaSfWDaS8E4kxKeal8vEQRud5dH/LHs37Nmm1Rr/K2muQ04ql8
         GHp3hDMN8TRXb/mKS1rFO/B4OBxTbiCBENqj71jzB8V0UeBS+wzxEDkqfLsFIxhU8ZPQ
         RXNPcon1/kDE4QIHEEMmObjPUIfvlAXqPg1OfdvzbUyA6ImnY3rFoumust37VeP2GK9V
         P7uIUXyhQyo/Wtw+QIlw3fFs0pliW6PxfBBpBylftCQDLB8dXTV6Ai/GfcEQZvz4kO1W
         ttsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581559; x=1779186359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WHxjSryWkf9DcTeU3EeI+pT/8hB+DD0vmivACPon/HI=;
        b=b4OwwEBwfB6JlcXcVvzPNwOan0o0BkaMzPfnA6xY8G4ZOS/Da7s24j9/BgMUvaZyCa
         R/jhjSfFPK7d76yR+OEviHLB/ZW1r3DcIDsqV+nP+2i4ZCaY99BgtvfkvgGlOV/iHnYt
         VfcYWrtknQpoFyHGHD45XlfiwD73y5tS4GsqmSy64HkfY2uD9d7w9PR3WpH1/M6hphNb
         uok50cihQSQf0/H89I9qlTtzfKsKmuTNI7ci6TtRXkD7R7GZ54Sal1LAZ4ujDIylgUXy
         TWLLU3G95ZQG9r/C6ACMnVkFHxXSxXKjPctBQxx4Ru8lqh1RUqxxmzz/kVaG9xFjyrqT
         W6+w==
X-Gm-Message-State: AOJu0YzkRqTUbfuGCus/yg/HBKWhfit/Hu4SDRzCYSfXQ/ioWr/2zOas
	Sn1VRYzvRx/i16HdW6q+zUZZymntKl14yTOAw+PAZ1lSrs1dEZMXcFZbaf+3kUyYlRI44y4QOkc
	M4yu/YLGi8u45kWQd/Ful8nJiFHBiUT6ZSQ==
X-Gm-Gg: Acq92OFnRi4dF4XfU48bCu3iTBSfrWq68Mu4bRKIIcG9Kg8eM8vqCowwTK1ERB2Rf7W
	gUl2WR5VFh/nKXqkQ3MO5hTJ/jj5VvwauIb/6kd4sQNZEC6lNwDizILZNL5SqRqMuVc1Z9AkWea
	TwqWqyPVbX/Mh7SLaze7mvfd/8TsVHdM+DnTLTtw0hk2X0atDXklJHmtX/W6ZkpVRtDxUMbFkJL
	e8BiC6rX9Lxp7SJVv/zjF6vI3KGgZrdl+U+7EDI7RhIJTTc6UZ2XQ8e+niTv2fKYakvfFWwLiXL
	7fHADA==
X-Received: by 2002:a17:902:e74e:b0:2bc:6784:525f with SMTP id
 d9443c01a7336-2bc67846b90mr173663485ad.15.1778581558534; Tue, 12 May 2026
 03:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvw_cRpJbBKg2YG9_oi5Bv_DU39OB41nPyJcq7hv7hK6YQ@mail.gmail.com>
 <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com> <CAFLxGvyUZWXEYdvKynRhJEkJGnEKomCmKYvZg3+Z7DJUM+SUPQ@mail.gmail.com>
 <94e64297-32e5-4818-867b-a8fa27d0c630@siemens.com> <CAFLxGvxA5q++HKe9AREfP6qmiNObWTch8E2Gh_ZiUaUyUENVVQ@mail.gmail.com>
 <b36655bf-b372-423c-91fa-0b0120a13e3d@siemens.com>
In-Reply-To: <b36655bf-b372-423c-91fa-0b0120a13e3d@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 12 May 2026 12:25:46 +0200
X-Gm-Features: AVHnY4K1A-9UsjX64FMLyyhr6i44lf8uoVj6VEcm4oK62pZjLcTlCcAGHgMPcGw
Message-ID: <CAFLxGvzCgjcAaj5=ewOPxjBKYM-cvFNfoZ-57WPdZ-YfOhmv-g@mail.gmail.com>
Subject: Re: Spurious task resume due to SIGSHADOW
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 11:30=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
> So, at least for resume story, the unblock is pointless at best.

AFAIU, the unblock is needed to break waiting on resources such as locks.
The management logic gracefully stops tasks. First they are all
suspended, then unblocked and finally
resumed. In the final resume step, the all tasks can terminate gracefully.
Without unblock, resume would have no effect if a task waits on something.

--=20
Thanks,
//richard
