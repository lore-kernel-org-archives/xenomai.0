Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EFF1AD9CE
	for <xenomai@lists.linux.dev>; Thu, 15 Aug 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737540; cv=none; b=t/d3wZdLmjsxFbnshEhbj1My+hrxQGODV2AYNAWLSmosP82K0GvFWCtyW5unJ7yFeqOcI1N8nqbTvQybfvziTc6eapUuQ49VdcLHcpcpn4VMZ6VUVk6npulZhDobxZtA2p9muDX6WQ6iCJH2URNYAh3HDadG83YtPk704IYq0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737540; c=relaxed/simple;
	bh=x+ZTIWFozHMpsBqN6d75k+OOLmsU/vDojR6BNarmkGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJal9quVu+HR+bOBNHeFgNT0+Qd/809dFkFuO2EH+kOZAfnkST6+6Y2oNOzX7HjvTgyE5NpJSCZ0ESCMHnlJ+ZCwAnJKiN8lSgmGlq8Pko+F0JQWzmQrvO019Lg/vX6OBNXWtHW3x8Ftlu4OxcCrIhRYB82B9d30mOwFAxYBgvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAf+kCh1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAf+kCh1"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3b5f2f621so795778a91.1
        for <xenomai@lists.linux.dev>; Thu, 15 Aug 2024 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723737538; x=1724342338; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+ZTIWFozHMpsBqN6d75k+OOLmsU/vDojR6BNarmkGw=;
        b=jAf+kCh1V/nt0b4fMb6/iUTNxLWdA9j/t1N6CiPt2f8DRx1XnkQku0lFKe06s2fCLP
         LV7Z3aKT5v3OazpniRO4UCwHo1iwgabmGSFMyAksiB/n1gTM5C2noCJegHxe1baEI0Ya
         9nQP67GYT6ZWJICs8HUPHwB2l+WBujFY9h19+T+FjeTbuPXTyDfiBUdQBRHQdL30sMPo
         YKLasLkY1v5h6lJ1U+7YB2IPO3fmJnC4oxDhCUj5u2wo2r/s6JIA6aJ/XpOsg3TaL8QH
         Ivs+ODsLEQQJyPBQR4rR7kRB8hY3PH88icmzx/mxsfylmyZAkRAl+6jstkAzliVBRjit
         b7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723737538; x=1724342338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+ZTIWFozHMpsBqN6d75k+OOLmsU/vDojR6BNarmkGw=;
        b=dBJIWb5cMTzBRJB6UYIIq+Eh5BnB1wswm/g7NaKou3IrLXxlcADGnJu22jmjDc4Rus
         xSwEKxJFk5Vkv5MlEnXzkdrvowk49HTFlWwUaFttoikrW1tdeU1gjuuBjyG+vQu3Yt2P
         V38VlRWRr4883gRmrqrA76SO01Kf+LasNDr3DZuNVUpPn5QogSFxBH1PRrtbIFoSKvsd
         5QjBTT1Z+TOMde+bdxdYaqLxjdMTDTpBrG8n4hpOX+liQMru8HGZYeQnaoCzCffp8SR1
         SKC2QFJjMwVaHJk842xt45gNkNumbEWewGJliI7Af8rs3jh5iQMOK/wnaX2sMXiYQqzy
         4/VA==
X-Forwarded-Encrypted: i=1; AJvYcCXP0msxg5JNxtGFubYbtRZdLPZUJNhun16zU9wWsICpBq1YSSF+mfTNMQcqw0zpDSVmxstSk/YZ@lists.linux.dev
X-Gm-Message-State: AOJu0YxibgsxSgYnG7T4fRt3Paaogkj/Eql5ykRszI++nWvavR/e8VC5
	9eWRdJwjTFDfPGJsSM2YuGA9cjHukctGR4PZ56Dd6dg0IoK3k/p5NGyWkEg0iji4aw4H3s82f9M
	3+VB8jO9DH0daHL2o7xVhPzeIwV0=
X-Google-Smtp-Source: AGHT+IEPTS1psWe8ISIYiMJd0pRqjtVGtgKoi7IIxYMZlMJ5AdGWoSUCsSbc5gfrW9DHH8bVLRAZCQEdslGamvQtOOI=
X-Received: by 2002:a17:90a:ea15:b0:2d3:d7b9:2c7f with SMTP id
 98e67ed59e1d1-2d3e03ffc16mr61947a91.35.1723737538194; Thu, 15 Aug 2024
 08:58:58 -0700 (PDT)
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
 <CAFLxGvwQpf8kWckq_t6K4iKt=GMqP9awDc8gUbhYgFK_SVogCQ@mail.gmail.com> <351a2c7d-4fe2-43a4-ae87-045b194f1919@siemens.com>
In-Reply-To: <351a2c7d-4fe2-43a4-ae87-045b194f1919@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 15 Aug 2024 17:58:45 +0200
Message-ID: <CAFLxGvy0Z3TPYN8psZBXSB-idpJbSr+TQ69JguqiGNYaWM3KRw@mail.gmail.com>
Subject: Re: Thread stuck in IDDP sendto()
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 3:30=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
> Thread termination has nothing to do with socket closing. It is still
> the process that owns an file descriptor, not a thread.

My idea was closing the listening socket in a thread shutdown handler.
e.g. using a deconstructor of a pthread key.

--=20
Thanks,
//richard
