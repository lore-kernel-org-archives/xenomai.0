Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF115AD86
	for <xenomai@lists.linux.dev>; Fri,  9 Aug 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207873; cv=none; b=lZw1tTUxcMBf66F/SeLDlAeKI+uvbTxN3+iQNyqMneYARRu9f1WtEBSmlLoeqaFymNC0LuzVW2bit4k54LKPi/hk9MZgMXU1pniOMgPfogQ/EBDx8m84Weq/3Zbd8oLWdr/c/iNgn0nRuzDUASaySsfVWl9a3ZvdJnqTAkE1S24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207873; c=relaxed/simple;
	bh=4Zyf67PFkiDqM7iHp2jZNhURf1E3L5wUstnc4fWDx0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CS/p8Jkh/yX+wBxo8b7LhaWWB9KJjPvX0wfa9RssNCtkxNRrNZxmldRnaeqS3inKQoVv0U6qMBI1V/7wF7MMxe92uq11uHp9EpCKpoD9Rmxi8x6N9r9yhHEjV0TNxhsBL/gf/NuWhd9YXwMjtsree7k055zPxajaUPtQensLDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE2OaG3s; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE2OaG3s"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd90c2fc68so17784875ad.1
        for <xenomai@lists.linux.dev>; Fri, 09 Aug 2024 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723207871; x=1723812671; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPFivsOAPh9VDSf3Y3t213XBNzz0k2vIS5vb+u0U6zY=;
        b=YE2OaG3sINhii9Dyi9NtDzmDmVe1/VnUqgY8Q5tX0FWcCMyerGzqPVXVHSwacn/gPZ
         YgIf5LxbyF6M3ohCrunCFlZl2VH9PgTKkky9Ni6C8mZa8A3dvg/8jeQS9tMiLU6VoH2Q
         mv9HdUN99Nt8LXZVKOo5vwcylCYcmM/KNqYfxTO0ECTAe0DFruppHNc+BpKeGdZdhMEy
         ZWntJxcDRTp7O1wtLK4be/1gP5KJKLR2i2vyVYIhxykSKKkrZiA9o4saVXbT5PMyAA0I
         C6NpoXhFP0URMrPUkr3rxffHm+e2xr215RMRhXdPhU+zAWKA08c7mJe8PxTinX9Z5VrB
         ZGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723207871; x=1723812671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPFivsOAPh9VDSf3Y3t213XBNzz0k2vIS5vb+u0U6zY=;
        b=A0aWwpCLbKLUk2hg5j2GG84xWL0KqXIeL7gYgg2VNyGf0eqDc6+kDGWXDPe2WYlu+E
         FRhvJvMuTSZvv28esjlOzwBHgtpaR/W5YAumJlnnpcsehgVobyYeklQbBg/HQgvfHUR+
         9ZDEPCUScgHFpnLm81A7fw1PkjF/BJJxExjFjmXaTPsCTppz0sbxKHxsj0NU8FWxnPER
         IMwsiOTzaQVCPVHhDmlWtLs3H92ez2OSaN6lekjbwoedcFDKxE/XdpWgk8AWm2uOaQbQ
         BUx4bbvi4IOywBoxloG0XDG0+YgwgNcFX/6ETx78UFmVGK/Egjpj3us3h3ZYZNfK40To
         jdcA==
X-Forwarded-Encrypted: i=1; AJvYcCU0fTOMDn9iMQU9xYvqq8sM9WAwvm+cijGPxVAb75FEjqFYPQDNdERYGgsIBFGIm76FfSPG1l3dxucwkrFiuRCZ/zbmAkIELQ==
X-Gm-Message-State: AOJu0Yx/jJ08htinchOFnVONXkHxlY0zxnfn/i0LGkdB5MvRscLYbmTe
	B3xiLBw7wAPiyMXjwgx83U8am+tMsGl/ID9m8d18HCAi9+ZoFoyLhSzNFi6U2L+ecG+Pn++UEB8
	FluT3ubpa5AFNK9Hgrz7s5wnaCQ4=
X-Google-Smtp-Source: AGHT+IHh2UyacuNvqTCdLhm5lAIF9qlY1BhbwlNPPLVS/kLaOztcJ4UR6/xu9MS0b+YXMycf2YDn8kzLfu+3skYF3rw=
X-Received: by 2002:a17:902:e809:b0:1fb:9e80:b501 with SMTP id
 d9443c01a7336-200ae4ba83amr13738295ad.2.1723207871453; Fri, 09 Aug 2024
 05:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
 <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com> <CA+K1mPH=JAwPY2PSGX8Wcn7hqVuJ-t9zdEStQ4FZdeHFy57YWA@mail.gmail.com>
 <d3c212fa-154b-4f5b-b568-2816f585f311@siemens.com>
In-Reply-To: <d3c212fa-154b-4f5b-b568-2816f585f311@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 9 Aug 2024 14:50:58 +0200
Message-ID: <CAFLxGvxpYZxV6qQre_uQjmF=nAa_Wea5EEWpH1kjreuRAi8CWQ@mail.gmail.com>
Subject: Re: Thread stuck in IDDP sendto()
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:24=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
> > The second app (the one which did not stall) is truly killed and thus
> > disconnected from the socket of the primary (stalled) RT app, if
> > that's what you're asking. How can I verify that
> > rtdm_waitqueue_destroy() was called?
>
> It is likely not because the one side is not getting its own socket
> closed just because the other is terminated.

This confuses me.  So, if a thread dies without calling close() on the
IDDP socket,
RTDM will *not* run proto_ops->close() implicitly?
(The source indicates this).

--=20
Thanks,
//richard
