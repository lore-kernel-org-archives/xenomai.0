Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F846439
	for <xenomai@lists.linux.dev>; Wed, 20 Dec 2023 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAUfARah"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3536cd414so46463035ad.2
        for <xenomai@lists.linux.dev>; Wed, 20 Dec 2023 08:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703091105; x=1703695905; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyOefl8K8Q5mpVmKxr+O1+wSjJnVXYW4NWU3ocMlHq8=;
        b=BAUfARaha1YYVhUsc7YQ9iXN6Ga5EsoavBF9c5HCpAe1WEL6DGnNpxjy9B+J56/l60
         oZCLbPNXzbFZuMWzUNuTptzcKvu/11wVqHeAzIwM4HKqV/qvTTkaoGaRRRX/YkbZCPpM
         sEgAuUCu1mt0JIRnMYedL6SBW2tG555TlHflzrzRYQ/F9+XEmxkSy5m2/QTHdh26SNTN
         CtZxXl/tbO0op9boniMZC2Z6K1/s3TxZtk+/AfV841VamXOfk2L6sGrW88ych7ylhmaN
         1h/BFgOUMkbwk3fU7wRYsiSpK0DM4bE7DaOVBRj5vjF7uEtVfuGLNWlUHZ5m5yxG06cG
         Orcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703091105; x=1703695905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyOefl8K8Q5mpVmKxr+O1+wSjJnVXYW4NWU3ocMlHq8=;
        b=YcDPgzNdlE3IJOfePz1z8KltpG2fXAU8PwXQfe5JXXCu5Ebgd7CclNKPrmdPtmPW5i
         cEA4VXoH1KmSGdk7nnAPLRTLPI1dZcZppkB9p0rqkpsum9RwTcVeOKoIeX5FtlZ9cdwP
         9jcFRygLn5N0ZeSChN2oEabMHFxzfTU9HdI0nir+hEhrFdLNe4K6XZvfOPjpfd9gsyOk
         S7wlkKPfgQnng9b8Q6KxhT+3voe+drv5/EWZeYP1XWoRUbp6gdEjTRDVzvitLq4n5bCT
         i3PxT6kBizltmj16UJEJ3bBuT1PtlP0VASQboffcPY5pJLUdCpNcUFz6imltslHhGyF2
         gesQ==
X-Gm-Message-State: AOJu0YwmISzCjN4EBXjr8vbob3ADg/c5CuRk3EqJppF6illYWX42xW8Z
	Vx7BrL+Ug8M1yOEBJ1GzSR6IkgJOalL+J/ztxAOUHX02/rB79w==
X-Google-Smtp-Source: AGHT+IGwXYEzJQLUTtT3oUE9pghx/kcR4idr0JFazDaJ6GDxcuWKy6q5sZoZAkmNu8bXfkviVw8kIV7XBAclqx+CRns=
X-Received: by 2002:a17:90a:5915:b0:286:7063:2475 with SMTP id
 k21-20020a17090a591500b0028670632475mr14209259pji.54.1703091104780; Wed, 20
 Dec 2023 08:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH0t8y2Y6OP0g1c6duLKK6GnEjd2AYtsBfGJp_GKUprz+-kz7Q@mail.gmail.com>
 <e7624208-3436-44ce-b46e-eeb8e73d9f27@siemens.com> <398875541.48372669.1702980839753.JavaMail.zimbra@telenet.be>
 <CAH0t8y0Ck3A9A311Qy9qEXaXNFK3fmVrjycDQOB7tTyB_k_q9Q@mail.gmail.com> <CAH0t8y3nsRRNRmtP_YqKH1Vh7EiE==ruZTOrE1vJfmaDj+_OmA@mail.gmail.com>
In-Reply-To: <CAH0t8y3nsRRNRmtP_YqKH1Vh7EiE==ruZTOrE1vJfmaDj+_OmA@mail.gmail.com>
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Wed, 20 Dec 2023 17:51:33 +0100
Message-ID: <CAH0t8y1coFFvBfN9o5n3zphsjLu0eq9MGNW0H7JNL6m_uniAtw@mail.gmail.com>
Subject: Re: rt_e1000e and Intel i219
To: g.strobbe@telenet.be
Cc: xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gino,

I applied the patches to the xenomai-master tree. After that I tried
to compile the source from v6.4-dovetail-rebase. I run into an error:

In file included from drivers/xenomai/net/drivers/e1000e/ich8lan.c:41:
drivers/xenomai/net/drivers/e1000e/e1000.h:24:10: fatal error:
rtnet_port.h: No such file or directory
   24 | #include <rtnet_port.h>
      |          ^~~~~~~~~~~~~~
compilation terminated.

It seems that this line:

ccflags-y +=3D -I$(srctree)/drivers/xenomai/net/stack/include

is missing from the /kernel/drivers/net/drivers/e1000e/makefile. After
adding that line, I got a lot of errors like these:

drivers/xenomai/net/drivers/e1000e/ethtool.c:160:21: error: implicit
declaration of function =E2=80=98pm_runtime_suspended=E2=80=99
[-Werror=3Dimplicit-function-declaration]
  160 |         } else if (!pm_runtime_suspended(netdev->dev.parent)) {
      |                     ^~~~~~~~~~~~~~~~~~~~
drivers/xenomai/net/drivers/e1000e/ethtool.c:160:48: error: =E2=80=98struct
rtnet_device=E2=80=99 has no member named =E2=80=98dev=E2=80=99
  160 |         } else if (!pm_runtime_suspended(netdev->dev.parent)) {
      |                                                ^~
drivers/xenomai/net/drivers/e1000e/ethtool.c: In function
=E2=80=98e1000_set_link_ksettings=E2=80=99:
drivers/xenomai/net/drivers/e1000e/ethtool.c:278:9: error: implicit
declaration of function =E2=80=98pm_runtime_get_sync=E2=80=99
[-Werror=3Dimplicit-function-declaration]
  278 |         pm_runtime_get_sync(netdev->dev.parent);


I assume you compiled this or a similar kernel tree succesfully.
Please help me. What am I doing wrong?

Thank you,
Tamas

Tam=C3=A1s Pa=C3=A1l <paal.tam@gmail.com> ezt =C3=ADrta (id=C5=91pont: 2023=
. dec. 20., Sze, 11:09):
>
> Hi Gino,
>
> In the meantime I realized that I need to apply the pathes to the
> xenomai master tree.
>
> Best Regards,
> Tamas
>
> Tam=C3=A1s Pa=C3=A1l <paal.tam@gmail.com> ezt =C3=ADrta (id=C5=91pont: 20=
23. dec. 20., Sze, 10:00):
> >
> > Hi Gino,
> >
> > Thank you very much!
> > Just for sure. I should apply these patches on the Linux kernel source
> > tree, and the result is the xenomai driver source, that I need to copy
> > into the xenomai master source directory, by overwriting the files
> > already there. Am I right?
> > Does the v6.4-dovetail-rebase Linux source tree that I should choose
> > as a starting point?
> >
> > Best Regards,
> > Tamas
> >
> >
> >
> > <g.strobbe@telenet.be> ezt =C3=ADrta (id=C5=91pont: 2023. dec. 19., K, =
11:14):
> > >
> > > Hi Tamas,
> > >
> > > Please find attached the latest version of those patches.
> > > They were created against the v6.4-rc5 kernel.
> > >
> > > Best Regards,
> > > Gino
> > >
> > > ----- On Dec 18, 2023, at 5:49 PM, Jan Kiszka jan.kiszka@siemens.com =
wrote:
> > >
> > > > On 18.12.23 13:33, Tam=C3=A1s Pa=C3=A1l wrote:
> > > >> Dear All,
> > > >>
> > > >> The current version of the rt_e1000e driver does not support any I=
ntel
> > > >> i219 network device. I found a mailing about this from 2019. This =
one:
> > > >>
> > > >> https://www.mail-archive.com/xenomai@xenomai.org/msg16000.html
> > > >>
> > > >> The "unofficial" patches (created by Gino Strobbe), that upgrades =
the
> > > >> rt_e1000e driver should be there as attachement, but I could not
> > > >> download it. Probably when the mailing list had been moved to the
> > > >> archive server, something happened with those attachements.
> > > >>
> > > >> Does anybody has those patches? If yes, could you please them send=
 me.
> > > >>
> > > >
> > > > I'm afraid, those are lost in the unfortunate settings of the old
> > > > mailing list.
> > > >
> > > > But given their age and the source kernel, it would be better to re=
sync
> > > > the driver against a recent version anyway.
> > > >
> > > > Jan
> > > >
> > > > --
> > > > Siemens AG, Technology
> > > > Linux Expert Center
