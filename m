Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E0315D4A
	for <xenomai@lists.linux.dev>; Sat,  6 Sep 2025 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757141458; cv=none; b=IqxRY9ioF4t5CQTYCYHvLuaofIN7yGDB7CI+lAG7LVfd82hEz5X214lmkXMN4MnyXPTqhhIeNBXlvknvjCit8kASfNGUr9J/X6Nf2SbsIf+MrBf2C90Q5uUyWnU2tWaza+zF6YiDEk8FrGw++7MpM2Kr2u4jXITJt0BMJ2p6hCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757141458; c=relaxed/simple;
	bh=NEyhI6NujHPomh8WrhnoVTZhL35WwUmE5fZaNZZb9tc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ntOYfzOj0kBO4FrsdVn2ATA8+2ALjbg3XFgnPUnAnj6hW4/EneOtIlyfntwnij3BOlzbuYIXbbXEzaTFMy4CgbADO+86MddwIsvo/4MMj0mJK+SqpCaPDAmcRU4tlXcmdn1+UgsD7z9SrvK9yYpqWpFIs6BcYTANprqmcvU1IP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGMO8YgT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGMO8YgT"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7ace3baso519364266b.3
        for <xenomai@lists.linux.dev>; Fri, 05 Sep 2025 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757141455; x=1757746255; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M1hXIoP5TwhVwnz5cYLKTPvzLiKsuF3BAd05d8FghT8=;
        b=SGMO8YgTbNgX7pcKUADHqvt1nUEKvS2TeQ87jEwSBP7iAYSihx+smmDJjX2xLD3iWl
         l5ztYnfPdXEIDRW57DiCssz4fM+lRLDS4iZrHbST0gNXR1Aj0YlRbNhdE43pT9wGrV/I
         0+VlY8nMJAL2UBJpxI0OVByf07qvPfUUqlXbEWXL7qBeswzEgWlRi/VU7ZeK5tjgGdc7
         lHra/AjfPT6KU19oGvE2LTGBnqn4klSX5k0zz/DrkpzPqVbIAwYLpXtGASaCxIi4/2TY
         nDzBtP4eZoQs62KGNmD5DPRk9Q6X+G1XU65I/ZOn9w2DP2UseVlvqPltUdkuOTLRvjLp
         vq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757141455; x=1757746255;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1hXIoP5TwhVwnz5cYLKTPvzLiKsuF3BAd05d8FghT8=;
        b=IgQydSHmAqTKFlLlU+rcOrAJ4Z6JVmDBDMtv2F5R7IGF1LOTuGZJuTz9YIpoN/3EuK
         2XTaUOy8SXB9lnnm12WPxTgBc9guB3qlezzGHFrOghKgwXc0Dyeb1xkDqglqNPSAi5kq
         XQjW3+wK5cJ7nPyjq7/S8z0rYJ//CxY8VYCn+V9m2A3XlzgBFhxtlxrZ5x4oAYuBAnYq
         aFgElM4AL3r/YFJ8yoVAA3ylgO5h4CyRoArg1aVsfR5Bn7I8g9y0o7lHWLA15iEJK10e
         jOfcNG9euLxwyV6czfClp3LI4YCSWipDnSabn7LI6yPtDBCwkUqJN2CMVQ5gZdVDWPqP
         m5Lw==
X-Gm-Message-State: AOJu0YwkDBf0EhosFTusx99YDE5HUxTPtg1gG4XpLrDgk10nVWkBBFP1
	qk4FbApNUQm6EUXDOlB/b9UN6Zw8YeW4qDTXbKA/LiZiY23UDR3w00p7AI1dSeiYEMB+2n6bCGy
	8Qi3Cop0TNjFb7F87jZOC6v/WmJy9wHgdreZ2LQ==
X-Gm-Gg: ASbGncu/27yBxUFxPs1nJZRfw6ITZwrXlXw2c6PvkTqoWQoi5S5kOuNIsDFBy3dThB9
	AuThUUBd+HkrEBzDd9hOcqZ4nMqCyh+P7YVdcA8yjR+pRRzswhKsHqHkdnpdlNYBf2OBx+LNTma
	YxXPqDm7/7lJ2BsYoTXmUOZPLFWWc5HyrqAJjcA1uqTaGNFrsS9s7OquBJfdyTdwWD5B8d6fXE/
	dhNo5mRfK9sN4RKCNxQElVdiUXKLvsoi4Ir3mfbuxasoSEdJ/ggvH729AAVjp8TFJhBrChtXpJQ
	8Ls+e3hqWEcIY2s=
X-Google-Smtp-Source: AGHT+IG2/ck77cmKpbfJXj5awqlT66VbiDe6ELviNmmP1VZ/44XrYLx/D08Z/DtB9ACxRJjETvmoFyv1R4Ck4hJ8keg=
X-Received: by 2002:a17:907:7290:b0:b04:32ff:5d3a with SMTP id
 a640c23a62f3a-b04b10081d8mr127077366b.0.1757141454899; Fri, 05 Sep 2025
 23:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Serhii Bulavinov <thebsvi@gmail.com>
Date: Sat, 6 Sep 2025 08:50:44 +0200
X-Gm-Features: Ac12FXzAtPsydVMF3m1ZVCizGlALJX669tLu-WE0YXL48_cvhzvayiOIz7d2rBA
Message-ID: <CAFnWUrcgQideZ8CnoKeKzv1_Fmofzm4755apuB_z1SN9tQZz9Q@mail.gmail.com>
Subject: [QUESTION] GDB hangs when EVL attached. Ptrace sync ongoing
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello Xenomai community!

I am trying to bring up xenomai4 (6.12.30 kernel) on my custom
embedded board, evl test passes and hectic reports with no errors. I
need to have a vscode setup with possibility for debugging for other
developers. As a debugger I use gdb 15 with default buildroot
settings.

When my thread is attached to evl and I single step inside a function,
(or place a breakpoint on any function call), gdb hangs.

- evl ps -l reports status #T -> Ptrace sync ongoing and Stopped on ptrace event
- If switched inband, problem persists (and as far as I know, any
signal switches thread to inband anyways).
- If detached from evl (after being attached), debugging works.
- If I press Ctrl-C, GDB regains control and then behaves normally
again until the next function call.

So it seems the thread is stopped at a SIGTRAP but the event is not
delivered back to gdbserver.

Is there a solution for this?
Any guidance or known workarounds would be much appreciated.

I'm pretty new to linux kernel and came from bare metal programming,
so maybe I'm missing something obvious, and LLMs are of no help either
:)

Thanks!

My test program, hangs if single stepped in func() or over
evl_switch_inband, compiled with -O0:
   volatile int i = 0;
    void func() {
        i++;
    }

    int main(void) {
        if (evl_attach_self("hello") < 0) {
            perror("evl_attach_self");
            return 1;
        }
        evl_switch_inband();

        i++;
        func();
    }
