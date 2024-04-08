Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A069DF5
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576693; cv=none; b=IJXZGsp1Skdrzk5+kpNY8FhD8CWK3Ajr9DyjtUqK6XRmsLG0qvI2DuhwpL0aWYdMvqp2OATCvGv0Gi3wze5pTXgG2A9jQBVadZiDPHjf4wQUAUGF+vyhPYI6/UUuAROBnQoJ8ndccYQxN4ul8rVef016wUg7woC8H1EDYU+srKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576693; c=relaxed/simple;
	bh=LTCaFB7btxFzjV97eAtwBU2vUU9Q/f4sup5z2tm5NXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnwDrevVa/eNjkMLr+HwVd6xhF1n1+rSBem1aYxUy68mHhAXAza/Xk6Z0k4gTf4UqA4e+bJQDKH1bKSvSUsSpKj1Q0esHt7DyXP+MHGcsM7T/YG00WbJHwCK0fw9ys8EvMxHnPd92/rYIVDoPKqgYHAOwq0LLHyhnpr61X5YpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGKOgk+w; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGKOgk+w"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a4bdef3d8eso923019a91.1
        for <xenomai@lists.linux.dev>; Mon, 08 Apr 2024 04:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712576691; x=1713181491; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTCaFB7btxFzjV97eAtwBU2vUU9Q/f4sup5z2tm5NXg=;
        b=IGKOgk+w5EZupTlJsoGBnqZyiAkMlxQMGkhv2w0RDnGuTHv2a30VY95EeXAlDYdDMy
         60nmISnDpWIdxaZgcWS+ta5AGYLIL12Ml2ypq7wd00N586KRNQUUG53IsyjIm/9ywl/J
         BrWzCC6Oy6AKr2aZ31NlXzkbo79sI2I64bX0t9HAQQ2dTAZNpnhdECByGgUMKNgLzuy1
         0rhd/s6MvtamV6HZyAYknJbClWKychIZu4CASOXsnwMQDfeNpZquoUcNyYjheQAOwcTw
         aV4WqlqIQuLKo6YkyCWofr9Neu7+FLN8mfI0VltykiUIly1jRT8oP6SGZb3fzk3T1RId
         vgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712576691; x=1713181491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTCaFB7btxFzjV97eAtwBU2vUU9Q/f4sup5z2tm5NXg=;
        b=eSdu0HTxmoFOxX3FyY137nhoU1W6WrpvSvhxSIpiXMkq3N9LGCPU4bcZy0eTeTxgQM
         zsoYq/F1fu12qOVAVUdNLzEWs0UwFTCGYpGxGtshTBTYJ02Xxj9NKW81ibPXAzH5ghty
         yiV0jDCIzrYNw9EBv2ZVhvKT7qK+fD5ge//4Bi0HgKZlEnVSRHr2mplEGNJ7cJ15VYpT
         mnkTHnoKJ8w69rpEzBsSUHzfE4nic7CYdeBUFbMMXydGhpKSfVguauel9U7I3yv+9qdX
         5nGlQ4hPE85bo80AjCsQjCO7KmPYYfn2fz5oJC5glBgbvizvy6AuN6rc1u3LQEMqnf4V
         Kjhw==
X-Gm-Message-State: AOJu0YxN8d6BYTIk//+Lo7I0gHaBYDJLpCQWC1RmkuVzjXN4+AGMv8n8
	+52wMast2C5NcNIyesXy8IPUZWWK+4Twh10XU3HFdH140cW5bQmTRSWKamovktWWht2UefXKS2l
	jbcbXMh1cE29C9515tfxvnFZYIWi3kCaR9gg=
X-Google-Smtp-Source: AGHT+IF+00V/RCjaZyaEl3DuWD0E8YfpocaDJMRunxxD5/98+g2lnnAYratLZOH7mfOjV7EitVmGiV2+0M7sUsKUP7s=
X-Received: by 2002:a17:90b:3e89:b0:2a2:f281:66ed with SMTP id
 rj9-20020a17090b3e8900b002a2f28166edmr6312658pjb.21.1712576691354; Mon, 08
 Apr 2024 04:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <AS5PR10MB8173D2257B87726D7E4A9B6593002@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS5PR10MB8173D2257B87726D7E4A9B6593002@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 8 Apr 2024 13:44:38 +0200
Message-ID: <CAFLxGvwWy9YCOOBQmHcPjGmFa+aSGNgtSaLsXhPTYJBuLdZ_WA@mail.gmail.com>
Subject: Re: Linux Plumbers conference
To: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Steven Rostedt <rostedt@goodmis.org>, bristot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Clara,

On Mon, Apr 8, 2024 at 1:03=E2=80=AFPM Kowalsky, Clara
<clara.kowalsky@siemens.com> wrote:
>
> Hi Richard,
>
> regarding the Linux Plumbers conference this year, I heard from Jan Kiszk=
a that you had the idea to submit a proposal for a microconference on Xenom=
ai?
> Could you give a status update on this?

I had a brief chat with Steven and Daniel, we are invited to submit
talks to the realtime Linux micro conference since it covers
any kind of realtime solution for Linux, not just PREEMPT_RT.

--=20
Thanks,
//richard
