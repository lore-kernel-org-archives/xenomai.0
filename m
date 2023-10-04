Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424F610E
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 06:53:51 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50567477b29so2035102e87.3
        for <xenomai@lists.linux.dev>; Tue, 03 Oct 2023 23:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696402429; x=1697007229; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUv7gi4/o9Hy6qdqwKt2letdUpweyOIGKwPjzHPpqw8=;
        b=XoqftPQCCPlzkBe0dGISLwSN6NhDiRRQXJ/DUclFBVsrufgXqKwZP8h0COTDf5+hy/
         L1bI0QTwqj9/6Xw68erJ2UpjsF20OMMfyzaC6va7WyCre7DZrdxzSphOfd2UIFCoZA6c
         QxUj72Hausrj06hxEMVhI+K/u9+lqZSa3WTbVirFLfB2HaNE9Tg9SwvtJSXeuLj/4f0g
         fP+6xmdfrzVtzqKanAVH5GbzzK1StpPgJIEyY3DrIfGYhU/yu0DBI/p7ekB6eGJBopI8
         YttdfFKc48ODJb4Z1vEzMZ9O4iwIfawEA+La2kdj4KuogySgKwMgtRHUU/V03D8z1l/2
         5a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696402429; x=1697007229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUv7gi4/o9Hy6qdqwKt2letdUpweyOIGKwPjzHPpqw8=;
        b=Mj6HSyC5Sos+ou7nN1EieIfYkLFoRGUm0g6Ga/t1gwWrjnBWPBszA/wJVfAOcXHQ2S
         /t/luoxMSxCbneLwDrCDII4Y+9EA9WigybGgLx+vTxKs2SO7fb4ZnFJm+95A9m2AXwAO
         PSXViAT5/Y72dUmzUEH3EDIXigpkJXBP+1f4alPyBgFRlsr55wOUNHyYsVg1H16WIwhY
         HyIZaiHmgcL3/4nQEAUxs2UyXS+Z1X84yoD7RrTgbcs7lsPC0AqFMfvAfzMmua1/Xq2L
         qUa3mO+Ckz4H4J5uRLVjAdcNVix6Fti1IOBN/zwI0VbJd52e3LOg7S0r5gGDKYPZH1oX
         h6sg==
X-Gm-Message-State: AOJu0YwsgOjFz64tRMYBa5Er7HxYfpY+0Qp+bTH3Q0AR5skcIXbiLu/h
	jhlUNM73jXb0ulFV/xxkIYI1Ejk47AL3jZcDK5E=
X-Google-Smtp-Source: AGHT+IFzqwUt1oQnc2l1XVJ3fy3sNVsxdSz6w/ydjDgSlWVSWFfeI1UGH9IqmkC2kMuSbjlh8iWSRH3hSjBFXNcS44c=
X-Received: by 2002:a19:6d1a:0:b0:4fe:7e1f:766a with SMTP id
 i26-20020a196d1a000000b004fe7e1f766amr1073029lfc.24.1696402429244; Tue, 03
 Oct 2023 23:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <MN2PR11MB4285288BBE0F81E94669D614F2F9A@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB4285288BBE0F81E94669D614F2F9A@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 4 Oct 2023 08:53:36 +0200
Message-ID: <CAFLxGvz0Rov5jmASLW95ndxmAH-shKBRgwb0eFr+uFk=-fU+Jw@mail.gmail.com>
Subject: Re: Reminder: Xenomai community call on Wednesday, Sep 20, 2023, UTC
 7:00 AM
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 4:17=E2=80=AFAM Chen, Hongzhan <hongzhan.chen@intel=
.com> wrote:
>
> We have the Xenomai community call today.

I'm lost. What is the current community call cycle? Shouldn't be one today?
