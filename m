Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024BC23D5
	for <xenomai@lists.linux.dev>; Tue, 14 Feb 2023 04:01:45 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id f34so21767542lfv.10
        for <xenomai@lists.linux.dev>; Mon, 13 Feb 2023 20:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qdv0uiQG14Tu3fyoSeEaZexin61KoNKxozbinEmOp80=;
        b=j/Pgq0RzFJe6p0R7s01oJKRADnwQ7leHajcEjgjFiFfRPDp1TYyyWkiaL5rSzKAdN4
         HGrMFC6GjKZwm3/CaJglGc4QrAuGCl9lshc4uOMNsItIZcBuMOuF6c1YxpCFZ8zNhpoL
         Bz1cMjeymZbAwEsMPUeYgYNczhJ/wNiKxQHRyxRrWmXGmDYEZ7ZOjF+SY6S7UvuMp+XY
         qnRNkFkJiq5Bh8SSvXj79amv6E6QXfMHLsAYjCd6XDiev/rBiUrthBxDecoNr3WxJaVM
         spHpsNgCw25AQS32NVgSAhSmlk5U3GQ9yY+DX2M8Fd2EJQxZL/qOG/4m5a6biUbkrgf5
         oF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdv0uiQG14Tu3fyoSeEaZexin61KoNKxozbinEmOp80=;
        b=MkTr1XGZRxMlckgWkqK90hpRiJRkb0rHU7bOIzusgE0zkZXr/Bi2dO5To/8r0xk3Pr
         32vogIPomMuKbEu4OA8TL+9pdKZq9mD+NyS4vH8Ef55vZa6pkJHFwGE0bWTQA1h3W7H0
         QCOIjYv8o6YzqBzHajFN9lxXHEsAZXTTgYHJFgfJXEKDe7uk6/9i88TRcvXWEDf2D+Lj
         yJa2kheio1N5mtCqEqNiIV6dbvRUysUHA+hpue3WAeGbt6VROx7wBF4aPzaynhlB/Fs/
         4yyB0sxpDSmDrKzuaAWl9Y2xZj0DDc9UfJdcNFywbfrAh5yWirDlqCa/rPScVrTU7SGP
         TccA==
X-Gm-Message-State: AO0yUKUo9OF5ZfflFMGLQ/fQkJ4y8/+wDPWv0u+t18fhv1mfeGCUxDlh
	f3maSsVd+gDSAybfbNWAZzJmRkjzGUDkZQt0YPVVog1zsq2/bA==
X-Google-Smtp-Source: AK7set/Mg0LdETxvEvyC9grFUb8FXcyEyo5j+R+5VLWBzWDBrCUoUCmQz6XT9MqnH4kfMKADsg+dKL1jUlIVqjRgYKY=
X-Received: by 2002:a05:6512:3b0d:b0:4db:173e:812a with SMTP id
 f13-20020a0565123b0d00b004db173e812amr79708lfv.8.1676347303313; Mon, 13 Feb
 2023 20:01:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 13 Feb 2023 23:01:31 -0500
Message-ID: <CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
Subject: arm/arm-64 ipipe release
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,
   I'm almost ready to release the next arm and arm64 ipipe patch. I'm
working on stable release 231 since it contains the patch that
hopefully fixes the UART irq issue seen in CI.  If there's a problem
with using 231 let me know.  Finishing my local test this week.

Thanks

Greg
