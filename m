Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A029814C581
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895445; cv=none; b=hi8QZQB9YaDzNTMyIjkm181+xeAJz/0tCmBF/96kKp0yMBE72QqQxNQ7Gnku4JzXzAOND1dEwt0dSS1Wg691LMoZn28Fh22a7ht9REHII6AWN1gqUG0Gb3iC5HbPTaRV0iOuqe3/AHOo+OUtYdotYbdLibS1YwIptG5WlnRwhGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895445; c=relaxed/simple;
	bh=IlHl4xcwweA1KLa2zwOVsn4OY5mmSQ1qVaGxggNk64s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q43YBqCVUTjh8uyTWUnKrP+BnFKTjNN0m5gwDvTREzmDujbqYkMi07WfFFurpeXXBlz6VNt8xeozkulb8zGtoIDTxzl75yFeDn1qLL2joBREeNJ1SvB/o/wjF91PQsS0fgJKA2pceuJc+XE/PM7j+LjrfMNsic61oRFCVOIuy+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rft51QoD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rft51QoD"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6dfefb490f9so1170883b3a.1
        for <xenomai@lists.linux.dev>; Fri, 02 Feb 2024 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706895443; x=1707500243; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlHl4xcwweA1KLa2zwOVsn4OY5mmSQ1qVaGxggNk64s=;
        b=Rft51QoD7gV85thkreYLQH3LOwdRhU3nAByATfW7bYWv25+Y2X798yXC39IHgI8agu
         Ddq0AKoIFFgJNIKX6mvJXOolSNvvmwZKpIkHPtqL+aGaNSXkOY3yx6Ll3IhlxgVErlSA
         28637PQ0nJJ1UpqoX4Uq45jR97XbQKo16lZY6Ymh393UARIij+XdePHxyosHfLO3GOn0
         Ni4v8vMMsB6jsoXfs3uCx1GhHsAGIDzvFpuq0w1epk4qLs1T43ZyBigHA9xlKU2dxmEC
         vy6jEBHL1zlrBk0La/oF+c/X+a48LUO2YC81c3R9jBIN8ZPVBvy8Gx4DOkLAI+Ny1IjQ
         zxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895443; x=1707500243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlHl4xcwweA1KLa2zwOVsn4OY5mmSQ1qVaGxggNk64s=;
        b=lfq6tNkmDxGYfNqB4foQoaGWL8jvDp9QVNyU1BeT0Ry1QldOmEB59eQA3mVlUW11IF
         Uj3G7/pLzoqJCMR4utqyJJN6I5q7EUH7/z4UP2lcLLMQEJLVS6zLw7AnhhuvjkLjXbdt
         yIAamTSx2MzyUiDk4jIpIxbyHexWvZMId9XtOUqFgu+I7noID/FKRKkuj5Yf65XzSdrp
         1RSpNKzPrMOl9VVx3Cy7EMCL/j8DWyetsNcNL5emOeosk9icJRL8eQxbSLr9xRCJ0lnu
         60lqd6x9ZvP7Ivoq67jUG5ECbrqPhIRcAv3+YReEGLc4/PD8iO6jI7xTwXAsB1AsdjcI
         vlCw==
X-Gm-Message-State: AOJu0YzsUrYk9AB2g93wJs+pNvaoZcrxnVlMkmO38XsOl5tLAEEYK4/8
	aFneg+exnkSpJeRBLUsYSA1FXkcSKa+IQQGOxl6ILasbL2IXrwFsNPPsDAHq6CrNsOKEdMLYj9P
	fa/PHIVkge1a0KP6cwCrfiPcU0yM=
X-Google-Smtp-Source: AGHT+IGDvehBAiJUA5f3ZcLywjCA+I7vj4OCpfrKbng6QsAse3OTfWibjyzyOjMIedrqd5CixdeEZZvtykjFd1IOlaU=
X-Received: by 2002:aa7:8710:0:b0:6dd:e398:2a84 with SMTP id
 b16-20020aa78710000000b006dde3982a84mr2786912pfo.7.1706895442778; Fri, 02 Feb
 2024 09:37:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com> <20240122160105.2452024-7-clara.kowalsky@siemens.com>
In-Reply-To: <20240122160105.2452024-7-clara.kowalsky@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 2 Feb 2024 18:37:09 +0100
Message-ID: <CAFLxGvx+KPwkoqSF0FD7Xnp61WZLrJJPEncs_w0CffOr+jbZBw@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] compat support: lib/cobalt: Fix VFP detection for
 arm on arm64
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:56=E2=80=AFPM Clara Kowalsky
<clara.kowalsky@siemens.com> wrote:
>
> In arm64 the floating point feature is fp and not vfp as in arm.
>
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

--=20
Thanks,
//richard
