Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542F19D06C
	for <xenomai@lists.linux.dev>; Thu, 15 Aug 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712180; cv=none; b=aydTVe1AoAJLSaWD/bML+p9a38P+gM71J1lE+3FgbjWfcQlcGOR3bkelKn6b/HUOqUIhnmmKkHcjtY4aONXruQLPYRg3N9DScbCv/FKtVZ5gHCcLL4qfBYeYg1tW1oNSmY8wAKoSpnFVtZoxnCuuNbokmwqFP0mFoVeA1tuVX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712180; c=relaxed/simple;
	bh=nZiaXZaZAOmiwYzIwwPEFqZnLLoXyJ3BszgJteoqBKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xt1t28gFTC0gHo8k8/ShKuUyjE12AXCwh8timvkPqdnG40toBoIytHIEejJnPiQyTusSwiEliMdWwDfB0YssdCbkotusd79PSrVN6zSLy7TQBEn0RBMk4ae4votkhCuG+HJEjfa36XT5+0yLwmXvWkJzJ9SwW9xvvcuApEeF2js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/Oj7UCL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/Oj7UCL"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d394313aceso486406a91.3
        for <xenomai@lists.linux.dev>; Thu, 15 Aug 2024 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723712178; x=1724316978; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZiaXZaZAOmiwYzIwwPEFqZnLLoXyJ3BszgJteoqBKY=;
        b=D/Oj7UCL2hSVzaZ/640Y9NYWJhVPDhbFqtPShnzbtdEkiuIsQ+P9EYmZ3CeV8WIq6y
         pzdu2/D75ca7iXdh1X2tMfLPXFNUkXROOkKd7WCHiRvolUMlRAKdMyBBstTFkYi2usil
         3Vn+Bxoym79ie4+DuCUitrMdAdAPEMgIIY+5lqjvD+OJGnpG2QTJ6ZFx9ViotdNrjtps
         io/aPsuxC10FANG2Te92STuoun9szGDYu4MF4EmZDApug6Bytb5tDX/tgKQbvxv1j8Cj
         P80Jc+X5fy4HlMu1bPOuSva1/lo3+9b/FjAAUDfDWjau2KI4c9XL9qVaNIq7ImZcuXZG
         M3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723712178; x=1724316978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZiaXZaZAOmiwYzIwwPEFqZnLLoXyJ3BszgJteoqBKY=;
        b=GIXhK8BvUXyOUkSlxsuFTBnaFYp8Kh3AogOc3lE5GJDe71scfOysdiK8WTmQYrY6l7
         PtdSjY9P/r22xKji+s5mo5xXfwZrzzv1MFuc6Nyy3N+ehNgfavLKoPy6XMFngcAhljdA
         ghK2rAj2zZc56myOPRRHB54VN8kU/urp5nTAEJymw7gt/NSZZ96sdlr+DSeylIZVcsfP
         1UhgIpuNmOw24cAcT9kzX4N3OmPAQWu7yfwAb1LsQVwXFEM1GurGlEnB2iQOj8QXtwBx
         mkYgPTfCki4DZDiTdufPK0kCNKrl2ow2quGVHS9J/3vTwgmLvB6N3IIwuKu3TLWc5WhS
         CW9A==
X-Forwarded-Encrypted: i=1; AJvYcCVva06MozLZ1jhMqZW/RfO5bDnQzCJqxrmr8mEQeAxufRyiHUHX+SDwtitD6iGE9TeYBKPyua/vB4B/oUDn+OWe9cO4nSF0TQ==
X-Gm-Message-State: AOJu0YyCYo7WXHsXzIwklCtxdw1DCeFdr0jjbAoEjU5CMJ9o3WqbGR8V
	/xdb9OB5aUFrK7VZ383w62s0kBZwf/j4DdFCdP8x7JvpMBTb5xUE2ga7XsfLEeZvCfYIABRGcOy
	Z1Nitupgyyrfql3mlsfYAp3nwrWk=
X-Google-Smtp-Source: AGHT+IFEoDHEbfPF4LtqNVqziY6+fyKwYzaO3m0gQJvsfcMiInSVHhV09OOSI5nF+fsick/Kz40ERtmt8FFSLYHkih0=
X-Received: by 2002:a17:90b:3ec4:b0:2cb:5aaf:c12e with SMTP id
 98e67ed59e1d1-2d3aab87cf0mr6628676a91.37.1723712177846; Thu, 15 Aug 2024
 01:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
 <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com> <CA+K1mPH=JAwPY2PSGX8Wcn7hqVuJ-t9zdEStQ4FZdeHFy57YWA@mail.gmail.com>
 <d3c212fa-154b-4f5b-b568-2816f585f311@siemens.com> <CAFLxGvxpYZxV6qQre_uQjmF=nAa_Wea5EEWpH1kjreuRAi8CWQ@mail.gmail.com>
 <CAFLxGvytCz=B5M3dhvuBDcg5=mJK0E+-TUOESbkM2oSkz-qDPg@mail.gmail.com>
 <0e2f567d-06e1-446d-b34f-02b9b9fc3165@siemens.com> <CAFLxGvwm3qCk4e2d-Mf7bZGgcnfX8Eyd2yvEGpMf_tydw2H0-A@mail.gmail.com>
 <CA+K1mPF9w=QuXFpAsgZQqRj8OjyHNzw9znmpUGNSAcRFgs9hgQ@mail.gmail.com>
In-Reply-To: <CA+K1mPF9w=QuXFpAsgZQqRj8OjyHNzw9znmpUGNSAcRFgs9hgQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 15 Aug 2024 10:56:05 +0200
Message-ID: <CAFLxGvwQpf8kWckq_t6K4iKt=GMqP9awDc8gUbhYgFK_SVogCQ@mail.gmail.com>
Subject: Re: Thread stuck in IDDP sendto()
To: C Smith <csmithquestions@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 1:02=E2=80=AFAM C Smith <csmithquestions@gmail.com>=
 wrote:
> I have a test machine which is exhibiting this behavior. Indeed in
> this application the sender thread continuously tries to send to a
> killed receiving thread over IDDP.

What exactly do you mean by killed?
Did you hard kill it using something like tkill(2) or rather pthread_cancel=
(3)?

> So you're saying that all Xeno threads are the same process? So
> killing a Xeno thread with an open socket doesn't do the "right
> thing"?

Yes. Killing individual threads is always a challenge.
Ideally, you just signal a thread and let it terminate at its own will.

> Some possible next steps:
> A) What sort of a timeout can I set up? Jan you suggested a timeout,
> but I don't see "timeout" on the sendto() manpage.
> OR
> B) Can you give me a hack to the Xeno code to implement a return with
> -ENOBUFS when this happens, like Richard suggested.

There are two more options:
C) Use the socket on non-blocking mode, needs rework of the whole
socket processing, though.
D) Make sure that upon thread termination the socket is properly
closed, depends on how you're killing the thread.

--=20
Thanks,
//richard
