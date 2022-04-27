Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C1CA3B
	for <xenomai@lists.linux.dev>; Wed, 27 Apr 2022 13:17:34 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id e24so2453432wrc.9
        for <xenomai@lists.linux.dev>; Wed, 27 Apr 2022 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=contractor.linuxfoundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=FxFf9WEj9UsW5jECTUztwYZJ2rEoiXw/yEchfcTc6Ss=;
        b=Ag5HPMRmIquKiqpIKG4/zyrVo4PtNnWtPW9GiVtqR82J74yNqNwV8NXNNmNAblV+Wn
         yj7/Vc3yi3CLpAEPmWuChmVAcxvWjZA4VS+ZbqR7udxBXnLquihxUFMvv9hx3OrNmTuX
         h81d87xy7RrRWcQr4UDfk9q1AwMv6O3iu5z3Wmr9WUycE+ObJtlls6kT3y/rrv6u2Eiq
         B9naGLUe7Lygl8GubZk9Wny6JMqGeKwvYXMy1VGZ5KY0JxQDtyVh01fjTr/FwUmQTMwu
         TkMkZUkBs5EyEzUCA7TTGHcS0GYgA8yiqIDj6r0cBIL4Yg882N1SLWKlt/Sz8xa6wTX4
         847A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FxFf9WEj9UsW5jECTUztwYZJ2rEoiXw/yEchfcTc6Ss=;
        b=5J1YNPbLRXgtfiMI64IKdD4VTavG6UqPuOz9qLkznLJa1Gd1tnbsbkl6YstOS1b0Zn
         giYbSJlCUDyp74wP99pKoARdNsSHmNaV3CjWrvGoRUYRA5CPl/UiCpRNeEhSBydehT6E
         XmA+26Ao0KN2b/C0UTw9rUppBpc4mXWH4oQdbtMCciKeSmnTtViZeJ1YHFKGADOJhk8p
         R4zjirgbVAs6yC3m1QULn0Yw/urkNDgkWosmDBrbvapGWqoRYUJdo3ynZvn8fOJZL1Dj
         Y1nazkq76G8H0GfM2sU9xWE+GS2PpNTgNonDBF7dQ35CF+6bFdOq99ITn3CFM8D9Ogd9
         x6iA==
X-Gm-Message-State: AOAM531nYNdAlbXFsE0oVYBFw9IprQ7cPw7vmHwadBJL/6HkLBy6hCA3
	tQhZrN5rPhYpj6mUWfrv2BoAKIBy1iv57iqR5fBE+oOykGtCyw==
X-Google-Smtp-Source: ABdhPJxZ/xTK+fxZp5AGMpCH4afpNG/JSrFZNxpm+U/L/g38o9Ru54ZFf8O61Kk3/lptRlWdjl7WgEX5Xz36VCtUQ14=
X-Received: by 2002:a5d:5441:0:b0:20a:cdc0:6e90 with SMTP id
 w1-20020a5d5441000000b0020acdc06e90mr19670521wrv.566.1651065452657; Wed, 27
 Apr 2022 06:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Shyam Kumar <skachukattu@contractor.linuxfoundation.org>
Date: Wed, 27 Apr 2022 18:47:21 +0530
Message-ID: <CAH=dH98yhK2OQveoZo9tj7Zk8pXMNGfQSwe-cMLsk+O5CsLcWg@mail.gmail.com>
Subject: Test mail
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello

 This is a test message to test successful delivery and start the
 archive for the list. Please ignore.


-- 
Regards
Shyam Kumar [ RHCA ]
Code Aurora Forum Admin Team
The Linux Foundation Collaborative Projects
