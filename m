Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577398474
	for <xenomai@lists.linux.dev>; Fri, 25 Nov 2022 21:13:28 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id s8so8564382lfc.8
        for <xenomai@lists.linux.dev>; Fri, 25 Nov 2022 13:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0jbVoLtILN/2pqc+r5n1+EH38jrA2Js33qp8xUR/3o=;
        b=yCDdzEwV35fKO2q8k2EjJzvdlCDmN1SJS/BnV3hSG1r99LCPfwPTcx9oZv7JVAiJv6
         wvYsutIfspibfl1d+YLsyOdD8v0gO5vjogKYyuo2FnBxZpDZHUCV1IqvkapB0AOnJpdI
         eUVTGSsiUQi4UL3b0yVehCnxpM0ZciPuYmhguZ6jOj38Vr2GtRzYV0i+ND2g/kqhVUEP
         9cOaYN9iFNqYaighKeZDzW2DjW4a2lz3whZXAAIxjKFHZ7IE9QzpW6+aUr5ygmU9gpjy
         BqNLJDSYLhJBtT6f9h8ofyp/t2OHfvSDlOe5wEDD98+FhrleqyAoDpKJOX9JvZ5XFAQS
         fggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0jbVoLtILN/2pqc+r5n1+EH38jrA2Js33qp8xUR/3o=;
        b=JLsd5ST2wq2lDqapYgZmqGuPEpWunYYELrNJ5zqlla3e7+hLZZC5QToTqrk0280Pz3
         /UJxaEzA142GFat7qMqUxi5gO1c6MalVIs2pCP11SJZwaWPUnBtJWfovViQHfVqBvDZ8
         7AZ9S6QZDH6PzPdCRgRUVKGwbrL8TUTunzqjmHEJmbOtJDd5MzCp/1PF8Eyrpq/1wR17
         uIfLyY9OBTzBbvZXxRbFM+c8WzWO6eXvBaI8sP8zHt8TT5Qdrf3XSb8U3WA9zVhWkPhQ
         bXZkkUDw9XKhF9oQZaGmxErfrycZk/oohj3LSAeWIHfzaotVL/ggTadm1+beZrpHM0kJ
         Q8BA==
X-Gm-Message-State: ANoB5pl+AECW/pm95pQkcGuLFOMfJcpq41VNi6ljDHLzPo/+idV5C0N7
	T7Fbao2g/Gg6uA8ojNf0mEsLWI9w5QOiIwPdTewCKw==
X-Google-Smtp-Source: AA0mqf7dKx0BFGEw/t/JbyA79JuPcVADZxSRiHbODlUB2dN8E4Q2BM77Z8yIoSFjYgpLSAk/LuE8+OkUuwDm6+F4fho=
X-Received: by 2002:a05:6512:2a98:b0:4b1:4612:6d06 with SMTP id
 dt24-20020a0565122a9800b004b146126d06mr13137055lfb.683.1669410806226; Fri, 25
 Nov 2022 13:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c7b9c30c4f0685adbd3f3829b9bba4b42835177a.camel@siemens.com>
In-Reply-To: <c7b9c30c4f0685adbd3f3829b9bba4b42835177a.camel@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 25 Nov 2022 16:13:14 -0500
Message-ID: <CALLqZ8RgN_WNdf_k=My5m7kyOKFw=gmVB36e3ztQVUjsN9V_7g@mail.gmail.com>
Subject: Re: Synchronization request of supported ipipe kernel versions
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2022 at 9:11 AM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
>
> Hi Jan, Hi Greg,
>
> while tracking down some ipipe issues that appeared while trying to
> modernize the CI toolchain (Debian 11 =3D> 12 update) I had massive
> problems with all the different kernel versions that we have for
> different architectures.
>
> Currently we have:
>
>             4.19             5.4
> armhf   4.19.229-cip67+    5.4.180+
> arm64   4.19.144+          5.4.180+
> amd64   4.19.264-cip84+    5.4.223+
>
>
> Might I request to synchronize them?
>
> It would simplify things a lot if
>   - all 4.19 versions would be based on the same patch level
>   - all 5.4  versions would be based on the same patch level
>   - The 4.19 and 5.4 versions would be based on the same stable
>     patch set. Currently 4.19.266 and 5.4.224 are recent versions
>     with the "same" set of patches applied.
>
> Concrete example:
>
> I had to update my 4.19 baseline to recent 4.19.264 to make sure that
> I'm not hunting for something that is already fixed. With that I pulled
> in the following upstream commit:
>
> 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottl=
e")
>
> This commit breaks (or will break) the pl011 driver in case ipipe is
> enabled. It is part of 4.19.253 and 5.4.207. The only tree that already
> has this commit is for amd64, but it's not a real problem as x86
> normally doesn't require this driver.
>
> a) I'm currently not able to fix that for arm/arm64
>    (too old but not yet affected)
> b) If 4.19 and 5.4 for arm/arm64 are not based on the same stable
>    patch level I have to backport for each arch/ipipe.
>
> Let me know what you think!
>
> Regards,
> Florian
>
>
>

Sorry if this is a double reply I think my original didn't go through.
I=E2=80=99m good with this, I can update the arm/arm64 branches this weeken=
d.

-Greg
