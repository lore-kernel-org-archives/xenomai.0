Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110B1097B
	for <xenomai@lists.linux.dev>; Tue,  8 Aug 2023 13:07:17 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99c1f6f3884so817942066b.0
        for <xenomai@lists.linux.dev>; Tue, 08 Aug 2023 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1691500035; x=1692104835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgNkMkYfFvLxU0SzOmzgF43lyOjSinc+wedY4pAnhto=;
        b=kXF9SAPz1kqVXX81Ha3r+Vcbcb4al10tYhNOAgTBse+OubrgOZVWfRoiUmdqPocFne
         MackjzQVTv7dhoVJ7WReBq5u2s4PcOJ335P5sqdjNZidYhfreG1byqLVGt25gouR3PJy
         SJOkAaht/TQ8xrlb1zHzxeqSY60s8R1h9hATEXeq75+XCSBIoQ+DZwm21/U3mFcVKMvb
         X0sxfrL0IzxiKfDXLDR4zsjcsJEnRy/Mnz3sxC8JO2XfTFYiarQTNhRViicMBkiffMrv
         Z9sFlpdxGeUffwv+MrKgKw2MMCoxPBf4Pyud+zA8Lh9rbhPZXttDjBWpOKxVY1vQcuvr
         ibRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691500035; x=1692104835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgNkMkYfFvLxU0SzOmzgF43lyOjSinc+wedY4pAnhto=;
        b=a1cLoz3z+zxveuxulVgSE3h08lw3P5d5hkS/F89qZqjbQuziXPbrGGMKJzNqzemK1y
         GBANOUPAeYhTmo21jhyoQ9BlS726475KgjAu4HhM5fLGTD5VSN9IBh/IFfTmf4fnnRBC
         iyKVAAPaOpHHZ/9yZWABJoFKJ9PD28v5FaU+PoBfMrzs/ev43uEwrsZLZ+YaGfA0Ydy3
         zXv/eDXI36NHoX4iA652vX988O8FMSgth0Zp4CRQJWl0hNimNKQBzjteFZFVW8BrHdC7
         iRizL1IBt+UygfDZyAOmzaBLDyePC0PuYvhbF3+ovFd9PIt5sh1yIBB9AykOJ3JRWsmV
         kTzA==
X-Gm-Message-State: AOJu0YwsZ/71mIbKpXDgWpT/bPbixXUFoiZ77GaJn065x7PsnZcDnxMk
	b+7FJYh0F3JVvHFs/313bksPPw==
X-Google-Smtp-Source: AGHT+IEGjCTH8SXWWOQIDEoKMyrwKAPqBw1rUVC8glUceJnKRxRjP3XatJHYJJBrxuUgAw5RFoNDJQ==
X-Received: by 2002:a17:906:292:b0:99c:b0a4:8de1 with SMTP id 18-20020a170906029200b0099cb0a48de1mr10502044ejf.40.1691500035554;
        Tue, 08 Aug 2023 06:07:15 -0700 (PDT)
Received: from blindfold.localnet ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090614d200b0098669cc16b2sm5249560ejc.83.2023.08.08.06.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:07:15 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Aaron Marcher <aaron@sigma-star.at>, Jan Kiszka <jan.kiszka@siemens.com>, Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Latest Dovetail patch release?
Date: Tue, 08 Aug 2023 15:07:14 +0200
Message-ID: <2040314.UkFFEUeh36@somecomputer>
In-Reply-To: <9aa0c21529b94d4b82c3bee604050482fc248a7e.camel@siemens.com>
References: <20230808063230.q46u55o7xjzy2dob@mail> <20230808125241.imtt6vqp3lekepj5@mail> <9aa0c21529b94d4b82c3bee604050482fc248a7e.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Dienstag, 8. August 2023, 14:58:11 CEST schrieb Florian Bezdeka:
> > Thanks for the information. Maybe this can be added to the documentation
> > anywhere or as a README file to the (old) download location to prevent
> > further confusion?
>=20
> We have doc/asciidoc/README.INSTALL.adoc which mentions --dovetil (nice
> typo...). Seems we should fix that up (or even remove/retire --dovetail
> from the prepare-kernel script if we do not plan to maintain the patch
> download location).

Please place a short README file at https://xenomai.org/downloads/{dovetail=
, ipipe, xenomai}
which states where to find recent releases.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


