Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB294A1F
	for <xenomai@lists.linux.dev>; Mon, 19 Sep 2022 10:58:30 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id z14so10288864uam.10
        for <xenomai@lists.linux.dev>; Mon, 19 Sep 2022 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=YwT69w/wD1s8B+dB0y7yyiWcOzEiPz0plvhUBu4dB10=;
        b=EzYIXzck+9YK7lNC7hTjAihlTTx2Vtar42gE7trUOllZFdmHwr9N6OlbbWpBYwDzvA
         2Dyrg/OmRf/HNUan8RCHD5CLLmxUbuj2btvqqJdeqJppiTCXOPr7qWZXI/OdNvZ77/of
         AptT7vSVkDHX7LLdVI2OLpJiJ0h4eFQircWeh8Zo4NE7MuT8khf8ms6ZV19L+NSQp1nd
         fNOxDeBlc25DYDj4383woW9HoQfIHp1ko39oxZQHzRcjPfP/Eaje0Nh8PvnrEJ0c2QdO
         HosIvDGKYbB6sJcsl9rRmFjxaE1UE47wFql+83lsBBfz6jodRHdzMLinMFhQBRUx5cfS
         Ri0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=YwT69w/wD1s8B+dB0y7yyiWcOzEiPz0plvhUBu4dB10=;
        b=DTWt2gXcPyLZqPx7yjEWHgMsWywdtbiwtTMACexx7YLO7hDAFxnlGpsoFq5AWHZchg
         rv4tIBSsRwO0/P1gjuEYIncbayxwMtfFMmiqha2Hm4ty7h94dSd28GF/+V5Fgxe+P/+Z
         VTQNF6DadLfCbxBNV3bngjbCRuqyJUNe8o6vvIlDDhk1i+nc9nrUsow+2O6fILMRUGBa
         xwtuvH5UrTwzZhocLSpKs5Uo7pAq+qjUW+YSgN8HNN3oOknUuaHFc8S0Qbg/VBDa8C7U
         496+hi+gw+q5zX2x3jNvugdFEZGMk7US87kBjm7RGHdYjunwEqy4gx9Y5gxyQ3YXLp71
         wivQ==
X-Gm-Message-State: ACrzQf2FCfi/+xoiYsNt70rWlGJux3J88y8vrvg2O1m9SUW30faIMxj1
	/xcLqJ4dt0XweDghbLYg7z1HUpvKVnGl0Ym8UCjbcdBugsI=
X-Google-Smtp-Source: AMsMyM5hryRlhH4nkMk8zaXNO7WJtosXSoZFzp5oySw4x0npgiPAGBhrJnO9kpLsE77YzyDSXE0yLtpn1byenyQ4R34=
X-Received: by 2002:ab0:61d1:0:b0:3ae:2405:b39 with SMTP id
 m17-20020ab061d1000000b003ae24050b39mr5790706uan.69.1663585108496; Mon, 19
 Sep 2022 03:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Oliver H <oliver0189.htex@gmail.com>
Date: Mon, 19 Sep 2022 12:58:16 +0200
Message-ID: <CA+QDH8KayORooefjRhqJqacHZySJmyziobUsFPmXGPxFJyzavQ@mail.gmail.com>
Subject: How to debug linux-evl kernel
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I am working on a project with evl. I have setup qemu and gdb to debug
as classical kernel debugging. Starting with I have build the
linux-evl kernel on x86 machine. Made the kernel to boot on qemu and
verified the log
Boot log : [ 0.341581] IRQ pipeline: high-priority EVL stage added.
[ 0.344071] EVL: core started [DEBUG]

I tried to run the init process with a pthread application and the
kernel boots and runs the application.

When I tried to run the init process with evl thread application the
kernel boot stops with the error
evl: core not enabled in kernel
/test: evl_init() failed: Function not implemented
But the log shows [ 0.341581] IRQ pipeline: high-priority EVL stage added.
[ 0.344071] EVL: core started [DEBUG]

I dono what I am doing wrong. Would like to get suggestions to solve
this problem. Please could someone share their debugging environment
setup.

Thanks,
