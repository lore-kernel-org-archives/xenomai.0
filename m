Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58518CC10
	for <xenomai@lists.linux.dev>; Wed, 26 Feb 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576903; cv=none; b=hXYSDRQsEMJhU1Q3/NtwNwFHV9u5mCxMPTLuER+yRRtnYKr2q7qZgInQWs9otdER5yOba+LSlKfqVFS8FLKT7/Y+iPgDANKCGF9K0BG76Mbrymvv/wQNrHGHYsMOr3AqrVHl2UVywNNf5bSqcY59gXITE/2wfRXcmuKVbg/rzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576903; c=relaxed/simple;
	bh=FMZpkaZAlImdd3DCjdi/T/0pbNMpTw2/HhwfpfJsfQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0zhoFfWmg8vRqOnQvXi6bk902Tu1MnBqmDbQru+FA5xrq0QAUIAKw4iYA2/sRoSy+otU3owEb6PTqXFwC9FaPuvDPUCxURXOKxrfPpWCPNXSLS6EqzPlgXOJQ7g73g2YUIuO2Pkb3Li0niF0h8AXShH2/pJONUb2wVm4O6HL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah6qa5u4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah6qa5u4"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso10054169a91.1
        for <xenomai@lists.linux.dev>; Wed, 26 Feb 2025 05:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740576902; x=1741181702; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMZpkaZAlImdd3DCjdi/T/0pbNMpTw2/HhwfpfJsfQM=;
        b=ah6qa5u42KjKfA0e5fbs981Ama88pO+MyM9Xc/3XTd9is3wGLX9Ke/UBh6pqnjaaEd
         8hVX92slWf6z7puOwCdjb1cLrbOoylGXmQGoeEi9+Gmu49m5YqmOz02EEYIU2pifpB+0
         rgwtW/worPGU4aQ/fLrWWcYLy7t1YPTVA38t1WbA3b4e8dRm5vPsQ3WR4K7Rt6/VsN/W
         Cm7TcIOa7PcNVGuWZXxGbJfv2aJsRiaPpuGUmskJ7PvtnA2ynHNjCJ0f2myK+UWetOtT
         Z2ND0hFXwu56M8vJoyqpDBgroy7Y2AzIxmL1bvEcgqANZP2DVKeicQMxR9ZJgclPmvzp
         G/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576902; x=1741181702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMZpkaZAlImdd3DCjdi/T/0pbNMpTw2/HhwfpfJsfQM=;
        b=nw4jMxDrlaZhqvCttWxGTJMnOQQCaCrxDGSxxd16Qypy5faZEyCFntBajqqYKXmceD
         n6kXYbfIcNOlsQsjxlO2VDOM0dQGaPrKjoB3nxjdPSgt22GgzMJqZs8e7R8Ooe8NtZKe
         qg+nzXhBoEZYjqzQL+V7nmk8EJYwtL3Kj1vEzz6+zzK3/Rx7J40RNoqxvdpSVDrEkaC2
         mq0n58Xmq99TQaS7kcUOiP47ZOx+JnkiiTapk6lF884lg5d49r38C0zSTb8+2xKbaSz9
         +5IAXk/8VR5FE+bjy7Fl317KCgjTJgKYfQKoWIoFMy5me2IieE7bmkJBYP9BRgKq8LOe
         gSvQ==
X-Gm-Message-State: AOJu0YwDtGnHAeRX5HOVjrGIPaPt7OiROvO6VpN7qfZPJ30M9rpxXE9K
	7wRYQv/GYOh6nHJqCijBSSO3SVnzv3YAhKcijhJFh3knX6UGDvatPUGd3P9cbfIFUo12E2h8xGJ
	sWf6WpuAsDp0jTLeRONWDAqI0jYo=
X-Gm-Gg: ASbGncs+SvJ3tyBG8eR6t9EY7qjOHO5MJQZplqi4RTQexsZpBIVe1xPbKoAoEdyIemO
	2Itf58h5WANhnPXHIvaeyrdTybSzIu9ZGMxPg/s0zN90lryToSfdYeQ+2NuMDVP+co/F0EV+E6R
	iPTSnWzw==
X-Google-Smtp-Source: AGHT+IH44t/NCji38RP1hP9G2He019Qs7x4/82VVPE6Iv3gHQkhdVfOH0VjA3fUdH/MfnTSECmFkRJgviA77IJpRgoA=
X-Received: by 2002:a17:90b:3b4a:b0:2ee:bbd8:2b9d with SMTP id
 98e67ed59e1d1-2fce7b23b8bmr28212626a91.34.1740576901660; Wed, 26 Feb 2025
 05:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <927cf7ac-678b-4a54-ad5a-4e09f07086dd@siemens.com>
In-Reply-To: <927cf7ac-678b-4a54-ad5a-4e09f07086dd@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 26 Feb 2025 14:34:49 +0100
X-Gm-Features: AWEUYZn0QmaXEwYDYH6f_pTBxIOT-aIHbnfjUxsNXjQjDQNojjpw0M90ygS7SoM
Message-ID: <CAFLxGvxHw2jxccajmHedHA8L5rya+gmCpjsubUg7dkoPMFA1LQ@mail.gmail.com>
Subject: Re: [PATCH] cobalt/intr: Restore support for IRQ sharing
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, Johann Obermayr <johann@fam-obermayr.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:15=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This was lost while porting to dovetail: Sharing between OOB interrupts
> is also with dovetail still possible, we only need to request the right
> type from the interrupt core.
>
> Fixes: b1daf55bdfef ("cobalt/intr: dovetail: implement interrupt manageme=
nt, handling")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

Maybe Johann can give it a quick test to ear a Tested-by tag :-D
