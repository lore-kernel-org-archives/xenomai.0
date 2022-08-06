Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD911386
	for <xenomai@lists.linux.dev>; Sat,  6 Aug 2022 12:11:17 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a7so9166504ejp.2
        for <xenomai@lists.linux.dev>; Sat, 06 Aug 2022 05:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=eAmNTcL9chRUPrSmGmkzJmlVj7SzPPrCOlaRvcZ9RTk=;
        b=PmLOr4/lD+07orjrDndkgBIsTzvhQrC9D709hiubi7V5YMTmee0oluyCijCAUt6qZc
         obLUsDqd7ELVo5RxN23FrbtuogPD7jQFpEkHBF4yAzIkHR10+7luSOLjsyRjV+R62uba
         2xpU8AepI/B+oJurT4lZos7KWEZgPKFaA8XhfnZKcDh7dopSC1vI9lQw/ZOuFcNxurZ7
         335vQ72ev6Ta+m4nDRemUsx5wrX8o94S2CJkwdMvgr5VYBXfPnfH0ASYDJeuPo5j0Gg5
         de/EgsIf17KQQK1uo7Vi3ptVREmiz82mJ7BcI7AbzY6PnkJvxyXy7tkW2aTA47bXAbXB
         3eTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=eAmNTcL9chRUPrSmGmkzJmlVj7SzPPrCOlaRvcZ9RTk=;
        b=XGXP+k14hNT+1SUJi5JoDCL9z8L8JGfovsXc8IiehS7OSAk/3w20TK73dV4bqi4SJ9
         UaIhapUsAgxM1JCvAyT8GMbMcpzBTFJgC4vJ39AOqD149OAqrwknpXoJYVKV6Q1WrYiP
         XkVgnbXdn5tXhJgruFNmZtYq5Tz6ocxIyvrmUUn8cIjvRtnAoGSA34JHv/B21B94/zRh
         EkYPURtuBGRlA4TfJwQpHF88QGh/8XdXU5pmVnC8xZfoKJmC9xIPKrHE3bKOeRHtSEB4
         q4KWSjhYFoviGvKkMRoVJnix6bp/gFoKQ8flboK8aQ/4O4I/Y2KDZm0WUHgamV3A4MCB
         Gllw==
X-Gm-Message-State: ACgBeo3efRZP/vhl8cQSy27fQz/T5Hfz8pEMhF+J/iq/r0CgoX1F8Y/H
	j/32fUCtqC8ar+O+2mtf3pZyRzFHQQUFKSokJdxJm/oE
X-Google-Smtp-Source: AA6agR5UmohpPBxsPtLCxOjWDYZxkG8cC5RhWBtLy+nlt/zLtbIWUxm51ML2vTqvL1qCzfn2+j2mnZcT6QMpPgzVJMA=
X-Received: by 2002:a17:907:6d16:b0:731:17b5:699 with SMTP id
 sa22-20020a1709076d1600b0073117b50699mr3012726ejc.23.1659787874661; Sat, 06
 Aug 2022 05:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yuri Zaporozhets <yuri.zaporozhets@gmail.com>
Date: Sat, 6 Aug 2022 14:11:03 +0200
Message-ID: <CAEkURaZO-2uDFwx3ZnS=229z5XZT27WbeFs3kS5Qdq7MMPAiKw@mail.gmail.com>
Subject: Crash in xnclock_set_wallclock() if time/date is set early
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear Xenomai/Dovetail developers,

I encountered the crash in xnclock_set_wallclock() (null pointer
dereference) in a custom build of the
Xenomai/Dovetail Linux kernel (version 5.15.32 or .51). The problem is
that in our custom kernel the clock
is set quite early (using do_settimeofday64()), and this implicitly
causes calling of xnclock_set_wallclock(), but
the whole xenomai_init / cobalt_init stuff hasn't been called at this
point of time yet. The variable nkvdso is
unconditionally referenced in xnclock_set_wallclock(), and, since it
is NULL, the kernel crash happens.

Would it be possible to add the sanity check of nkvdso, and do not
reference it if it is NULL?

Thank you in advance!

P.S. We call do_setttimeofday64() in x86_init.timers.timer_init.

-- 
Regards,
Yuri Zaporozhets
