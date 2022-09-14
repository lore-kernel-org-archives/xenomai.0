Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF197F
	for <xenomai@lists.linux.dev>; Wed, 14 Sep 2022 09:12:29 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id h3so9033004lja.1
        for <xenomai@lists.linux.dev>; Wed, 14 Sep 2022 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=bCltuobw34j9DXPoHTrdcYH7eyKgOtTR9UZgtbQo22M=;
        b=HVyBkJe9YjRvhPKdXGdLvQvfkOr297DxzwWXz+LaDYpIazw0ZYBip78H+EbJj6Tzlj
         FtnfXaCY5Ef/jydK3HMOfX8vOKVWGOKWvioVl/SNClHEzue7LAHiWZqoSLhLuoFjV2Bo
         NAwAVymLWAAiYRl9FdjA9ClFq91y5siAI+7cBNOrRm64+ntYxD3upP7AJsRjf1j70WwO
         Fgvg6KQLowDoLWkAguT9W4RISWM7N9s3dW/LZJ5I2NN9PV/fyeK4SDjmG1JaP9MlL4ii
         xDnEAYNDmDQiyQYDicsEeRUNLmSPLKlmT2niv0qLiX2DB9b7ELiJ0e+Vvi+/gKDUvoeU
         LPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=bCltuobw34j9DXPoHTrdcYH7eyKgOtTR9UZgtbQo22M=;
        b=mtxhvoOSCKcdhJ3COTG8UbX41UTzm2f8gRD3kTrqfwilxvsXK4lY9oogKCrF/n+F6J
         NCUaWdd2MUe+GrFez9H1MhEgavf198XiV8CR0F2XTLZNAA6/0dw5Q9tMf6tISdEMLDT5
         uMqnHgaJpIogpWOmNd89d4WgtAXP2INIyTX8rX6rP854TaTr/SIn/wCAczu4u787NxAc
         mP5Wn6vH6+WSP1h8J9ZUqAKDkf63bUL1Bz2s948ztALmFZaWWEncjdxz9LdObmWlLeuf
         x516i1U0l56it32ZIwzENCd6zRy1Cao427qm4DT3HwJYvMb55SdjI/LUW71lhmPG1o1H
         r2LQ==
X-Gm-Message-State: ACgBeo3aMawsvrK9bvgNAM6VUuCSryuhytLqWYcxb7yGpDNqcM7ZgwjG
	b2+JlYSlSvQrCI8gsSK51Jv/IEk5e1Fb8knOK8wG4tM9YeLgcQ==
X-Google-Smtp-Source: AA6agR7A8MrGTGA4xvjWTwXW7PSJae9zbE44CqSKX0XBJRTuurqrWKP+qQqA6aKqYmiZ562XPVSfNuslQhvZBKBuHPo=
X-Received: by 2002:a2e:944a:0:b0:24f:10bd:b7e8 with SMTP id
 o10-20020a2e944a000000b0024f10bdb7e8mr11239764ljh.238.1663146747104; Wed, 14
 Sep 2022 02:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Luca Costantino <luca.costantino@gmail.com>
Date: Wed, 14 Sep 2022 11:11:50 +0200
Message-ID: <CA+vfGHYGjDVQEX69GDY0S1SHwrqnpav=ukesCHtaZo0fGb=bEA@mail.gmail.com>
Subject: Change keyboard layout
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all

I'm pretty new to Xenomai, but definitely experienced with linux in general.

I need to use a pre-built image, and the keyboard layout is set to DE.

I tried the usual way to change the layout to US, without success...

Any hint?

Thanks
Regards
Luca
