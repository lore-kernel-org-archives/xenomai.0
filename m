Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC27498
	for <xenomai@lists.linux.dev>; Fri,  9 Jun 2023 07:46:58 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1b00ecabdf2so5437405ad.2
        for <xenomai@lists.linux.dev>; Fri, 09 Jun 2023 00:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686296818; x=1688888818;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h3TlUM253JqucMmVlACRyScpb4wHfu6xs1+S/Ex0vJ8=;
        b=RgZ0RDg9c4eNf1x4lXydM3dg1WmoaVQz3oC08srsY5qHzer0Vl1EzB2fjsYj/2BwQm
         J0cHm6wp7myWy5qLqkD4qlP/DCczBNCjsTMUb1HnwJsTKUmf8MgPwLmAGDsyhnZlsLKD
         3Khv2qWqQnTZquMTKSGmwekwAfUAC63rA8a0FFR3QS8mOHiYpu5gW+Wx129s9sPuxTNl
         Wh0dyl9fJzxlFgvtXszt3S0FHt+Z0gotOiWeDssvrYj/KFjrL9yuppYcjJfTBuAhIkBv
         i3zA5oWnmC5Dzzm4Pv6MWOz2XaZc3zzzKZtV0xu6Xr4JP40m91B+iwK4lgml36HNx1ef
         qdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296818; x=1688888818;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3TlUM253JqucMmVlACRyScpb4wHfu6xs1+S/Ex0vJ8=;
        b=MKPOuWqg0dlW3aX9OPc9UzuBB5qrUcFWiJ3D2h12EujobAQS39H8+riY+S5Ut9kdv2
         R6OwEvYESntGBssZej3pu3tHsvXaF/iZPZAFNneroWGluB6VRDY0VBizW+n3KB7PppLj
         0zokZZUCSsUl6CyExp78pQ5cVwoA+RfNeXghZTsUFFpAtW89At+2gyvhcfikj5RQJJsU
         /fquM8ONk8az1pz3UNzsLcN4CbpCmSn21st1GK78LCzbCsW8S9/nveVK5QFBuCBMYVCz
         3EbKCCklVadhbN/+6iDsYwri1zf6R9U8KbiuqLOf3sJiL2FgGSt7XI+ZDCc435fHEfK6
         zxkw==
X-Gm-Message-State: AC+VfDxZKinD91llsXCzb3btrAZUs3zs/+pMZVERudtDZBOh2+YV4JTR
	qJFmwNWzCxItifB24hQ3pHnRWsROPtg93DCaCdXHB5gMtHk=
X-Google-Smtp-Source: ACHHUZ6EKkVF1C7fsoHTdHZDy5qAl1o+vu7wZCrurqCUvUO0JJhU0C16HRFmSosI1gBQFByOZVbWhNgW92bBmWmWoQ8=
X-Received: by 2002:a17:903:2290:b0:1af:e295:ad56 with SMTP id
 b16-20020a170903229000b001afe295ad56mr694686plh.49.1686296817804; Fri, 09 Jun
 2023 00:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Fri, 9 Jun 2023 09:41:25 +0200
Message-ID: <CAH0t8y0j9zdJNo6X9SfsYGAJx2WJiGtvw866EgqMnRQwB0pOvg@mail.gmail.com>
Subject: Set irq affinity from a user mode task.
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear all!

I am using Xenomai_3.2.1 on x86.
Is there a way to set the IRQ CPU affinity of the rt_e1000e Ethernet
driver from my user mode xenomai application? (I mean without
modifying and rebuilding the driver.)

Thank you,
Tamas
