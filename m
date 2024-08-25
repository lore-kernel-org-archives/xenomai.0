Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBEC4A2C
	for <xenomai@lists.linux.dev>; Sun, 25 Aug 2024 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724615041; cv=none; b=MOo8HV0l1uGQcm4VA8c8bWiDRht5fb5ldcuGj27yGwj4CniMMTGIAqd/0sqKWZWOmiTw3CrapRQeJWWk/S16jsBcY59dLYqeVDNVhk5A0D5z9sGaoVSkEyWY9mXyqfrctfJbQhq+yGsIAGZz91f9aiHXCCZ2GJ4nDYhVe9TfkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724615041; c=relaxed/simple;
	bh=tKnht20BPTocZMs7wPX420EwEGLSvbvXdBy41SWPAlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMIdipUiaZcnC6fLgA1IJDr1ayb4kI/Y/94f/mIcdahZykZ6qQEwgIN8PT5ODrL4VZJa9A3yyiAkv92p8//wwXpBDPfUmf7ML1UyHgNOX/MwPZB9PrJhkptf8yZrT785cVLNa/ImInvQpe7lacoHcAQPDMOHN+08iUJVuU1Sbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWx6UYGk; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWx6UYGk"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c6aee8e8daso2587672a12.0
        for <xenomai@lists.linux.dev>; Sun, 25 Aug 2024 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724615040; x=1725219840; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKnht20BPTocZMs7wPX420EwEGLSvbvXdBy41SWPAlc=;
        b=XWx6UYGk9/5+VTDjYBM8aO2P0MxaqKB1/s0OrE1UEWp4Ro+w0AxmM+lC9QUL4mxLpK
         wzMoiBs1qvcVo329RcbYF0HvNytbtEQQspjJOnscHCyi3QtpH5fc+1IX6rWeBSX3palG
         78Gp4qby8Jdr8XZlPo8PJBnlnkIw1rDe1CoCcs8WWP85I47rTAoPWE4xD+AqV6UwaSL0
         YQX5MeinlUNjJSjy5eMwXtzVi11GqJ4uAxgB7ipIkhUMu5S0brh7uBnf6KJUdCTvaOMo
         wob1UwrfP77fIlgDNwd9weQZUTnASEVVB/E/0O7Gk6sgI5zZjmkGiv9CM7Qz5Rm1x8Fd
         o6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724615040; x=1725219840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKnht20BPTocZMs7wPX420EwEGLSvbvXdBy41SWPAlc=;
        b=mbPTaw4jLwNtSGuq07ieGaPMIrVTbHRPEILmPvhhMka6HVGHIHP9MXxhJg/XsbYzz4
         5tL3tD0CNz711oNMF56R09CIpNjmAz39G0DyWzQ8i5fzPDgs1f1tY6JfJH/X5ZtEVEzJ
         +qNqEK33zkjDFnIQHZhhddyM54Y440W7SPkE69mnfPcc3toFSgbNz83x/5FWhI1EtlMO
         FZR/L5CynSOTjuKXz+3XqIc31MgPAR0YT+U78U4iiHEAAB9B0l0HcjdjeHI2MC5MaCU2
         vVR5l9vJ0/vU+2jirxNVkVapaw/bheyYjnK3JGiMIFvJ1lVNdmYmm52hLT2Ny2KVua/0
         A+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCW7IC7CjspvIW5Igq9WIph93hWSskhz9cBlZAns/gla7qbqW4AQHSOnG4n1znEgc9NyD18Viymd@lists.linux.dev
X-Gm-Message-State: AOJu0YxWNdm9AD0camg0redgRrXBd6DFiTAceyjLVd1iQZyWp2AlDDUh
	KhN7UxfMbuiWXJFz893unnF7U7Hbj6vCLUvBCyG9BJeZqWF1J8aiLVSEx9wcXe3mqqrZ3R+x3tw
	7eCH4MF+Cu8sTPVA4sdGsRkQ13O8=
X-Google-Smtp-Source: AGHT+IEw996z88GB+gHRM+9NKuCQ0iMx0lbH0uMVx837q/uPMhx999pShrN0XDxYJlqzqwVaij/u/6antdcP9rVW40I=
X-Received: by 2002:a17:90b:1b52:b0:2ca:7636:2214 with SMTP id
 98e67ed59e1d1-2d646b93e57mr8750392a91.4.1724615039621; Sun, 25 Aug 2024
 12:43:59 -0700 (PDT)
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
 <CAFLxGvw_m1ChknHFRYHSGVjG4vDYOZahfS205OCv7LwRiOSPPA@mail.gmail.com> <CA+K1mPH_6SBO2YJt1eta7HFMmsYeoia+qNvFd1mpUUG+ZqqkAw@mail.gmail.com>
In-Reply-To: <CA+K1mPH_6SBO2YJt1eta7HFMmsYeoia+qNvFd1mpUUG+ZqqkAw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 25 Aug 2024 21:43:46 +0200
Message-ID: <CAFLxGvxqpNLnNo-DpZSjVossKb3zOOdk+dWLocGj8gSUwi2o2A@mail.gmail.com>
Subject: Re: Thread stuck in IDDP sendto()
To: C Smith <csmithquestions@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 2:33=E2=80=AFAM C Smith <csmithquestions@gmail.com>=
 wrote:
> > After playing with demo/posix/cobalt/iddp-sendrecv.c and modifying it
> > to work across
> > two processes I'm sure we have a little problem in IDDP.
> >
> > The setup is:
> > Two processes(!): process A is the IDDP server, process B the client.
> > So, A does recvfrom() and B sendto(A).
> >
> > If process A terminates, iddp_close() is called and a subsequent
> > sendto(A) from B will
> > fail with -ECONNRESET, all good and expected.
> >
> > The problem arises when A stops consuming from the socket, the buffer
> > fills and A terminates
> > while sendto(A) in process B is active in __iddp_alloc_mbuf().
> > At this point B has a reference to A's socket, so when A terminates,
> > iddp_close() is *not* being called.
> > And as a consequence ret =3D rtdm_timedwait_locked(sk->poolwaitq,
> > timeout, &timeout_seq) will not
> > return with -EIDRM.
> > Since the default tx_timeout is RTDM_TIMEOUT_INFINITE, B will block for=
ever.
> > --
> > Thanks,
> > //richard
>
> To clarify: the test case was originally two independent Xenomai RT
> userspace processes, not two threads launched by the same original
> process.
> Also note that an explicit close() of the IDDP socket in process A
> (before exit()) did not help, process B still blocks forever.
>
> Using a patch from Richard, I was able to work around the original
> problem of blocking infinitely. Essentially the patched iddp.c returns
> -ENOBUFS when sendto() experiences the transmit buffer full. Process B
> sendto() then does not block at all (I verified this on an
> oscilloscope). This is the desired behavior.
>
> It seems to me that at present the IDDP sockets do not exhibit the
> correct POSIX behavior in the above respect. This is the case in
> xenomai-3.2-stable.
>
> Shall we submit a patch to correct this?

During the community call I had a brief discussion with Jan about this.
Returning -ENOBUFS will introduce a behavior change and existing Xenmai
applications might get broken in subtle ways.
Before we can do this, I have to do more research where the current behavio=
r
comes from and who relies on it.

--=20
Thanks,
//richard
