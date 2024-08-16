Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC478063C
	for <xenomai@lists.linux.dev>; Fri, 16 Aug 2024 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723837416; cv=none; b=dip3pBx4ybd6t8xqgPtaENSVwJ99/y69/EUEz4wR6hxP6vRp8vzxzQLxgRBL50r1R1m5QGHwAIN8m87pkPPLQGltH4q8K1NnxyJR54StoPqBHjFn70h20MowXrVFpPBOt+y54tUv7PyEgrCA42aZjvkX/BZLJxdmg7zAb4rjSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723837416; c=relaxed/simple;
	bh=OfxFgS+Bj5znf3zk/uNhZO3eaf/wjZbpeXsyF6D7bWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPSHTXKlwvwLZdJWu519ozUXab7jj3WB+NSPM3UrxZUojmlNuFl9r+Og+cmtTgnzGv4x7XOb0GQTZl4mWeH8D5jpxIM015FxAKjNWhU3tyAvZ52IIMRiYOQwLzfi/bXKA/plflTk/rmlvemZafaXKlJAiDr06EDIRxNd+4OKKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXHUnjdV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXHUnjdV"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so1600276a12.3
        for <xenomai@lists.linux.dev>; Fri, 16 Aug 2024 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723837414; x=1724442214; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfxFgS+Bj5znf3zk/uNhZO3eaf/wjZbpeXsyF6D7bWY=;
        b=HXHUnjdV27cpfzxwlGSTurgB2tg2sjNPbykRhoYYtXedL2TkE2qBSl7L8+Wl/SifiA
         WmajO88a+w3ln9HGRp8QSqyVfg+N9+9jCe/BwvN5vDi2akZOVL/FpehYRpu8XWlB/7WT
         SzEmLew2vqNZDTVk6gYmgQ8TXR55j/CKF0/sY09JyqRgnAGEJ+ASA/cF6GOI2rqAi6oz
         cpNLXDEiJ3uKSz7sfpBqKJYdVOwiQUWZvZT73Djmng8O3+i4k9PHHHgTUSdtwMphqQlH
         xZDPQoncIx/dRpu8F/iSr8R7oe7NpD0w26+OpN8pW8l7+5tcMvy9UGS3qMNEAb5avo0b
         gi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723837414; x=1724442214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfxFgS+Bj5znf3zk/uNhZO3eaf/wjZbpeXsyF6D7bWY=;
        b=koNuctz/4PgQT65rYW6FprgHUDl7VlOpv6p4ydR3NaJDG0uWAN9a1IxxACX7WNt36H
         byJl9rkiQ88QgIzJd8VkYwWgjyeiXHgDVUfFzYRGa4K78HQz+IXf0pgyLdQdjLoW6QEa
         biFxf7/jiOaPcy75eei3WL9XcJpgR3x3ldPP+eBOI3JmZpm1z/q5uRvDLD8Vw8R+J/RG
         UWouJJvdrJSIhtGxhbhQj0tbsgSAaiPIAukbViKmzPOi4N8N833kFvsnP9a44rDnoezY
         IpL5kcJWobooxzL1VWFl86FBB9jwYKlVXYcR7LUe4qGs/EdH1MJNg0h1VXsBtUFgqAxC
         IhQw==
X-Forwarded-Encrypted: i=1; AJvYcCU3kEPnRyG3kWO/iWGU6zUqpW7VqDZwqqYiMo+4YU8s0nxVjbW45zN7ti+nQKRwG+3rVWET78SH1Tr3R/zYJ0ghvmVf0wEUxA==
X-Gm-Message-State: AOJu0YyS/KZXtHZqFxnHeWQtA2b7ZMqd+G2i5IDctFpUIyH3YPdA68oi
	STr3zLTpWVA4aEW3DNXryukZSC30/DC246ytvmz86BTiZVPN30QpqjzDV51bvg2mNS+IA/Nw701
	e/B5z1b6x+hNFNtV+Ugj8Dv5zO6g=
X-Google-Smtp-Source: AGHT+IHZwJXUcJr40vNZSokGuWBbdusqTn+mOp11q2EMNQEgkK/znWWynGQlZHZbwprziVbhhrsg1QW2RI6ISI+ntUQ=
X-Received: by 2002:a05:6a20:c90a:b0:1c1:a25c:745e with SMTP id
 adf61e73a8af0-1caa360c469mr944858637.17.1723837413917; Fri, 16 Aug 2024
 12:43:33 -0700 (PDT)
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
 <CAFLxGvwQpf8kWckq_t6K4iKt=GMqP9awDc8gUbhYgFK_SVogCQ@mail.gmail.com>
 <351a2c7d-4fe2-43a4-ae87-045b194f1919@siemens.com> <CAFLxGvy0Z3TPYN8psZBXSB-idpJbSr+TQ69JguqiGNYaWM3KRw@mail.gmail.com>
In-Reply-To: <CAFLxGvy0Z3TPYN8psZBXSB-idpJbSr+TQ69JguqiGNYaWM3KRw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 16 Aug 2024 21:43:20 +0200
Message-ID: <CAFLxGvw_m1ChknHFRYHSGVjG4vDYOZahfS205OCv7LwRiOSPPA@mail.gmail.com>
Subject: Re: Thread stuck in IDDP sendto()
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:58=E2=80=AFPM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> On Thu, Aug 15, 2024 at 3:30=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.co=
m> wrote:
> > Thread termination has nothing to do with socket closing. It is still
> > the process that owns an file descriptor, not a thread.

After playing with demo/posix/cobalt/iddp-sendrecv.c and modifying it
to work across
two processes I'm sure we have a little problem in IDDP.

The setup is:
Two processes(!): process A is the IDDP server, process B the client.
So, A does recvfrom() and B sendto(A).

If process A terminates, iddp_close() is called and a subsequent
sendto(A) from B will
fail with -ECONNRESET, all good and expected.

The problem arises when A stops consuming from the socket, the buffer
fills and A terminates
while sendto(A) in process B is active in __iddp_alloc_mbuf().
At this point B has a reference to A's socket, so when A terminates,
iddp_close() is *not* being called.
And as a consequence ret =3D rtdm_timedwait_locked(sk->poolwaitq,
timeout, &timeout_seq) will not
return with -EIDRM.
Since the default tx_timeout is RTDM_TIMEOUT_INFINITE, B will block forever=
.

--=20
Thanks,
//richard
