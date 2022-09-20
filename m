Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFC610F
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 14:08:45 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id o123so3221964vsc.3
        for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=idpUPw2jpED+gfPqesPOUHn1j44T9ZciUGvF+jFot7w=;
        b=HkBj1pHJcD0ayPKLduBzkDlE7C72Q9maJ1l+0I102hCtMP9yP7Du9ibci1RSQq1uQk
         YoBAjs+kcwWxKGCAiFok91xvAEqb6wKUY9xSkcvvp7UlOrCH6be0IiqgslIwoMbYpvO9
         9mx1HG9xRNHBBnjyEAKuKIsmImwNJtVUvVDnbbLzHuGAnOl7qsnb92ehUu6aEXyxFNHN
         AtXbO/KVtjpz1zYOzOlT87/pWAJxQdUgJ10BXYyDuCHoapkcDAOJqNOrbSoH0njWhmw3
         MGYiDasgw+xRkkzlBXaaCoRFvFrDTdYufvbfECTInI3mjxs37qXct4Fwnw/Al2Hv4RKP
         nsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=idpUPw2jpED+gfPqesPOUHn1j44T9ZciUGvF+jFot7w=;
        b=CWwJR5Xn4iJayX5B7E9AGXzCrQdQjZ5ugyMMm+7t9i31gGX2ixR8HTOrZVxgyKfM1M
         qOGWK5iMdHLQdw6nMAwx48gkJ/G4Gn573kL6QMU/j/WGiSsRt7gHjry6a4w2BmTwQm2W
         Y5DbzCUNgawq6RQwYhnLFEe9D2z3Qsjl8yz+ik9NUMfML8ksT+pg3r4xdlp+Q6yVRBis
         IByuLLstAAFPeHIW/PLKgEKm2eiKsBRMogbUEXc21GpkF7ztt7FiltaSGzNgwsPYYy0X
         kiCb+J6zOIbtUaFvn6vf4nOuJ1/6nVgpLs9YRS7n1XxxMhlvZY4QRWOKD1yWjxs28u8Z
         tT9w==
X-Gm-Message-State: ACrzQf0x4n67ITkkLgTNuRq+FN9U7Aa+ZLroqMuBLkimry6Mq1E5c/oO
	TiKYp3QWhar5I/JSOMTBtG5kNuJQoNnjZWBaCMyJXXj4824=
X-Google-Smtp-Source: AMsMyM7pENm0Ae4kcpRu3MpMGqyP0PapST5CalSFwTwQsKRY+LVdP/EgxsGD2n0Pw8yq1eommDvt2Nh7Nq4m/E+QHwY=
X-Received: by 2002:a67:af12:0:b0:398:1072:47af with SMTP id
 v18-20020a67af12000000b00398107247afmr7454153vsl.39.1663682923725; Tue, 20
 Sep 2022 07:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Oliver H <oliver0189.htex@gmail.com>
Date: Tue, 20 Sep 2022 16:08:31 +0200
Message-ID: <CA+QDH8KX8XOCppR+8fokRMUMXVd_2_YB9wnnzRobW2+=daWOkg@mail.gmail.com>
Subject: [Xenomai Debug] Unable to add breakpoint
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I am trying to debug the linux-evl kernel with qemu+gdb+vscode.

Inserting breakpoints on mainline kernel files is possible and able to
debug the kernel files. But when breakpoint is inserted in evl files
the gdb fails with "Debugger was unable to continue the process" until
the breakpoint is removed.

I have no idea why I cannot place breakpoints in evl files?
Could something be wrong?

Thanks,
