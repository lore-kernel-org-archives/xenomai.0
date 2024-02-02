Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735814A4D2
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894464; cv=none; b=RJmoVZE9Q/eVeMAiAX1+HLspymx51qdLXCAnf0wZwhwMiOOW2xEVuq/wYOlGwVfLFbudzMi3ckmMSW9bQmQwIRjPhYW/6ElkPYZFnFzfWhhcXsUrdq0Er33JttlqTlomxQAmwlOrr9qrGlSCVeKswRWyypolsiri39/u9GcpRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894464; c=relaxed/simple;
	bh=nFFUTIXsnZZPF8jPuZTf9RmVI63UZe7xf0Hv0Mi/Vj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3DEkYiquJHnmUdf3DuiMmN/h8aeW2+/CVWOB2GVMEqGw/Q8aowYwWQ5sng0LuMXbtlUA0z/aYsJ6wnAwmgEiAT5XyVWXIipdUYFuF0TUMBDA6v2PAbyNcdOmVZQxm4onLvDehtyAS3HLarTeMHFNEPmDxxIdwdpA0FiUekLxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbHT2MCW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbHT2MCW"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso1907220a12.2
        for <xenomai@lists.linux.dev>; Fri, 02 Feb 2024 09:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706894462; x=1707499262; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFFUTIXsnZZPF8jPuZTf9RmVI63UZe7xf0Hv0Mi/Vj4=;
        b=lbHT2MCWcCcn1wZ/S2sGnTjy276Nj3XwCODKU3JJItAyh9XElJ5mhgqRq+YG6UDMqb
         vW0BcfNsDJqYNfEVgM2HXaAyj9XqG9NqnKtZ8EsmeQZm2jml6JwnelolL4DQbFU3U5br
         3hIPsHzFGYQ/RApelguOGAdsUy+WXDxmJkXRJYSzJtcEdQtMPLaQYWsjSLejyp1y47un
         5KnvSB5mVDIQFcJrGX51CIExZhvmeUo0aGpSN3RVZ20T4ubyen5VOTjZwOk+2URzmc90
         y1ZrP2h8QgE2t1LCjL02ug7JgJzKLfYH4B5/jHTxSYT7fIFdH2CqBTdONC5iJkbPezeG
         D5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706894462; x=1707499262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFFUTIXsnZZPF8jPuZTf9RmVI63UZe7xf0Hv0Mi/Vj4=;
        b=TXJ/JKYX+eRfLlCjp+bExJ2H7NOIelJM0V/c2btGz7mQP2Dc+HuNl6MkRUCebwGVbH
         60T7ns6jts7fMtNPredpq4qqNq1BJC4eQvQj+wz/r8zTWj1Ts/hWJcX9GtajfS7w1GHO
         qmz/o9+KVLDLC+5OJwkTvhjagF7oqL7XxjCo9taOiCENinLV8vtE1yet8w69XPvupDop
         JXP2oGP5Gr77+oCqLw7vxc8hfWIAe+VF5r0BQWJQlIQMxD3YIHnGDIIqUWw2cRiUZ86p
         g7s3HcezxABeiJC3xgnBIrNZhMAGwRVrW6g6ishXJyZcLHvjho8prpfnJHh5w1NlbZWb
         xW2w==
X-Gm-Message-State: AOJu0Yxwj29oyZfXHrCrKUqYEiBgCJRSFNhxXoYRm/7Yv2KADlwz+E0s
	uw+Y1BhiHvAheXMC/LWnZAmQpUubLdJFVgy2we6BSAnU1/FAKIHfLR/eH44CuRPB6O/8WnUSw5e
	Yg8XMjIjKnFOIAdWL141D3e0YF0HcISel
X-Google-Smtp-Source: AGHT+IEzO25YP00gi0CD2dHRCWRVwM5lKXH+ATFNWZTSj4abq4wGldAXu3rfQX+zfZKRHLVuRstQi4pw4hBYz8gceRM=
X-Received: by 2002:a05:6a21:9218:b0:19a:fa19:23e7 with SMTP id
 tl24-20020a056a21921800b0019afa1923e7mr3007339pzb.55.1706894462473; Fri, 02
 Feb 2024 09:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com> <20240122160105.2452024-2-clara.kowalsky@siemens.com>
In-Reply-To: <20240122160105.2452024-2-clara.kowalsky@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 2 Feb 2024 18:20:49 +0100
Message-ID: <CAFLxGvw+x0gJTGdE3wvCp5eeqMwSGwf9QVXQUtRQZLwEPgP12w@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] compat support: cobalt: Move 32-bit compat files
 to generic
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:48=E2=80=AFPM Clara Kowalsky
<clara.kowalsky@siemens.com> wrote:
>
> In preparation for the 32-bit compat support for arm64, the compat files
> from x86 are moved to the asm-generic directory. This allows us to use
> these files also for arm64.
>
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

--=20
Thanks,
//richard
