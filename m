Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B66C126
	for <xenomai@lists.linux.dev>; Mon,  4 Dec 2023 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axBRC+C2"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bf4f97752so900257e87.1
        for <xenomai@lists.linux.dev>; Sun, 03 Dec 2023 23:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701676067; x=1702280867; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ThahpOf9A+EAIMWWiqtVDumZ6JdooIbxtvZzu8iBWA=;
        b=axBRC+C2JxQnwhvbslHYiLpOdd6vyzQF39nslg5VhCTUf7W9xer79FPjetPkxJ1bpX
         rRqfnWTGYoR3v89b9mFWU/aIYIYXmcig3Phg6v2iXSecg2BPKzHHhXiQ0nZGQj88gXwS
         JSMTFqgR0Vkk1l28c1Ns35PZZLaOsQRx4vWiU50H3p2QjmkMOAj+UZi973rvL6+cemhy
         SwqWx1L+c5g9Fu6rGhgIVUR4lkplT/hCo4A+skUQ/mscWyIrTW0jHKPWjwzjKpSj/Y16
         Ob8kKQzzSEoBzvZuduBls58GCJdU7wz9qMmZW8GPIM2nTOzre0Ag+vhK8gP5Ss9KJXHe
         0fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701676067; x=1702280867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ThahpOf9A+EAIMWWiqtVDumZ6JdooIbxtvZzu8iBWA=;
        b=EwXDGC/7WLh3cFgTo6yQ0AP5XDJ9/bbxBTUw8RZoBOAjhUwAKytBRBIKsLBWLS4A8f
         uqjozM0hxKcpNwiJa2nyYaXkWpAtWEYMGZkHHzuzCYTHDGGSoj4nBSBIIzbM+WR5Eh8F
         WxQv8uQ5OnUxHeTQE4y8hrZKdJAtj/M7oX1xRRcVVfsKAprKwjfl3nRt+BKaeFUuRTrZ
         ncl25MfL7pfdnZ6rMf2eewKy9BvS3r/niLZCIPCf7X5RecSf5scLIB0zp1XTjXGaRP8x
         JcoKIu4Zm/1fqGj1iKvBmLNXgcgtK1BuiBxcvCAWAsJDtQVm2FcCrk0rLZcAziILMOD9
         Vjyw==
X-Gm-Message-State: AOJu0YyZ8Qx6ectbcB0rK5GEG1CUQ2ERcgeraxWPKM0YoDNAro59LezU
	bvKKC4+Hll8KGbkGHWrLKZhEJCNW/IfLlO0wKvk=
X-Google-Smtp-Source: AGHT+IGWAhQN+MCSFMO2ofiG46h0G1WzM/KXqlDbmzs+UdbzugPE1rywBvK87b5hLUwuRn0UN/cplAx3L6ToZb4pKWk=
X-Received: by 2002:ac2:5222:0:b0:50b:f262:8d00 with SMTP id
 i2-20020ac25222000000b0050bf2628d00mr833927lfl.43.1701676066657; Sun, 03 Dec
 2023 23:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231203221711.339018-1-fontaine.fabrice@gmail.com> <acfd97356e832f0160e16f135ddfc13a3e726906.camel@siemens.com>
In-Reply-To: <acfd97356e832f0160e16f135ddfc13a3e726906.camel@siemens.com>
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Date: Mon, 4 Dec 2023 08:47:35 +0100
Message-ID: <CAPi7W82vYitqhy8ut2x_Fz_hWh8BFBPFChnaBELJzTB+PhYiCw@mail.gmail.com>
Subject: Re: [PATCH v2,1/1] lib/psos/task.c: fix build with gcc >= 12
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan, Florian,

Le lun. 4 d=C3=A9c. 2023 =C3=A0 07:00, Florian Bezdeka
<florian.bezdeka@siemens.com> a =C3=A9crit :
>
> Hi Fabrice,
>
> On Sun, 2023-12-03 at 23:17 +0100, Fabrice Fontaine wrote:
> > Fix the following build failure with gcc >=3D 12:
> >
>
> I'm on gcc 13 here and didn't spot this problem (so far). Is it really
> gcc 12 that matters or some configure / compiler flag that makes the
> difference?

Indeed, you're right the build failure is not only linked to gcc 12
but also to -Ofast.
There is no build failure if -Ofast is replaced by -Os.
I'll update the commit log in v3 (and also move ERR_OBJDEL to get_psos_task=
).

>
> > task.c: In function 't_start':
> > task.c:398:16: error: 'ret' may be used uninitialized [-Werror=3Dmaybe-=
uninitialized]
> >   398 |         return ret;
> >       |                ^~~
> > task.c:364:13: note: 'ret' was declared here
> >   364 |         int ret;
> >       |             ^~~
> > task.c: In function 't_resume':
> > task.c:444:16: error: 'ret' may be used uninitialized [-Werror=3Dmaybe-=
uninitialized]
> >   444 |         return ret;
> >       |                ^~~
> > task.c:428:13: note: 'ret' was declared here
> >   428 |         int ret;
> >       |             ^~~
> >
> > Fixes:
> >  - http://autobuild.buildroot.org/results/bc1b40de22e563b704ad7f20b6bf4=
d1f73a6ed8a
>
> The Fixes: tag I know from kernel development is different and normally
> points to git commits that introduced a regression. Not sure if we
> (should) follow this convention in Xenomai as well.
>
> I like the reference to your problem, but maybe we should change the
> "syntax" a bit.

I'll replace "Fixes:" by a simple reference (i.e. [1])

>
> Btw: When following the URL I see Xenomai 3.0.10, that might explain
> why I did not see the problem yet. This information is important for
> Jan as well because this patch is then not targeting next but the
> stable branch.
>
> If that "analysis" is right there must be a difference between next and
> the stable 3.0 branch that matters. Maybe we can get closer to next?
>
> Best regards,
> Florian
>
> >
> > Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> > ---
> > Changes v1 -> v2 (after review of Jan Kiszka):
> >  - Replace SUCCESS by ERR_OBJDEL
> >
> >  lib/psos/task.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/psos/task.c b/lib/psos/task.c
> > index f678be61d..cc7e5c9c4 100644
> > --- a/lib/psos/task.c
> > +++ b/lib/psos/task.c
> > @@ -362,7 +362,7 @@ u_long t_start(u_long tid,
> >  {
> >       struct psos_task *task;
> >       struct service svc;
> > -     int ret;
> > +     int ret =3D ERR_OBJDEL;
> >
> >       CANCEL_DEFER(svc);
> >
> > @@ -426,7 +426,7 @@ u_long t_resume(u_long tid)
> >  {
> >       struct psos_task *task;
> >       struct service svc;
> > -     int ret;
> > +     int ret =3D ERR_OBJDEL;
> >
> >       CANCEL_DEFER(svc);
> >
> > --
> > 2.42.0
>

Best Regards,

Fabrice
