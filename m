Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9846AD28
	for <xenomai@lists.linux.dev>; Thu, 16 Mar 2023 20:11:25 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id bp27so3857645lfb.6
        for <xenomai@lists.linux.dev>; Thu, 16 Mar 2023 13:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112; t=1678997484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yDr8tLe6gB0ah6RwMGVavfZMgXlc/O3Jyv4+WMwjTk=;
        b=NC9V7lBS9PTd2jKagoNOlqIP94jCHYsSaQpaDzPwCFVEj0KGnHxzNIemB/3UwXmYrC
         eeykhjJEHYV0WP3l+T1RzwVcfWoeio/pREj0PYC+0zNyFYPkZgRgI7QviCz7ltuctJiC
         C8we0RSmDHTlOm1r1mYbBdY5qwLtYub62C+Tdte+UU1nglfAhN07hcq/iScL36swzi1L
         +ffxzuDlzz2XiI+dEdkw6cATmgP4yauQYz2Ik84yTP+qZWClQmyb1D+Pfn3TPB37F3Dv
         vSIdGpRMx6fJaRITvpOKC5MIvdj9HLcRq2F3dT1s5QIuT3F31ofukSSbSQ7iMmlNGKsE
         XwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678997484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yDr8tLe6gB0ah6RwMGVavfZMgXlc/O3Jyv4+WMwjTk=;
        b=tAoMWUFfRE4RHv+WpmQa6rELtAoNwryqU/UTqkjpguNH4QNL0pibkrCzQpSu9+5AUB
         JFeYDgihlvP9PXQtzl5zrSKIYGHJtRUbC3vWnWkyw1AN32zp+8CW1TM3HrT8toesemgd
         G2aD0PC4GoAFkWLLzzqlwAsyIUWxi1wswwXHiUR/F+jmL3J3cRO7xxa4YfypvC/ZZR14
         za8Ghd+fU3+lL8EE8EHEXdupwp7scvOeh/b64TW1Rm11HT4KdHvu2LtNvIedq9pFTUAH
         WStDBw3zmNTtKrYBp5wC/6BR89u4nEsWKf5m4TQRu2USRyMA5lBkcY/9X/kMBGO3tu0f
         m+JA==
X-Gm-Message-State: AO0yUKU1WtKzR8jmK14Ac5xnyGPX616OMQoOrS5+OraiaChf/i/ds+ow
	8XA3A9qpeX26Inc6p9apHg8O1Z3C8qGT7miqhjHqxQ==
X-Google-Smtp-Source: AK7set9RhSwVuyWQQXUMV1NbZ9mr0wfZgXMG1ocnW6r3obChhlgGtVR8Qwrm0BuoKqQEZuLKYXbuvjj2j7+4jWNkXRY=
X-Received: by 2002:ac2:533c:0:b0:4d8:1c0e:bfc7 with SMTP id
 f28-20020ac2533c000000b004d81c0ebfc7mr3526590lfh.13.1678997483703; Thu, 16
 Mar 2023 13:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
 <252602b1508b13bc480f6c971e13b02ae7702071.camel@siemens.com>
 <CALLqZ8SiSB8e1VJcCv06H7Gc=zwiLf=6kBisB73yCT6VhRRRug@mail.gmail.com>
 <CALLqZ8Sk2OejX_aZRSiMqdDunY-5nG_Gr5Guf032HhS41ewD=Q@mail.gmail.com>
 <9a49e98f-2de6-168d-51b2-22c68c2d8084@siemens.com> <CALLqZ8TA_yUvrSMvqbrLOD1_+pqE+SVxZ5-=FwgrPX+k5KgOpQ@mail.gmail.com>
 <954672f9-5367-603c-1721-1047a4e18283@siemens.com> <88c4c9d231886bc3df0ede57a66353b19c4eabf2.camel@siemens.com>
 <327eb2af-b4b9-b78e-4456-32f61ce7b03d@siemens.com> <fb67c17c9b2c67b3a8b1b67dad9df4c77391ea14.camel@siemens.com>
 <8a97726e-46a4-422c-07b0-086dbf36c249@siemens.com> <48dcb04adfc2efc2936c554747660cb0c504fa7b.camel@siemens.com>
 <CALLqZ8Rq-TZZ3vHfU-JPgrGVrYZaC5Jgx5vBUWVeScpiMt2K7g@mail.gmail.com>
In-Reply-To: <CALLqZ8Rq-TZZ3vHfU-JPgrGVrYZaC5Jgx5vBUWVeScpiMt2K7g@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 16 Mar 2023 16:11:12 -0400
Message-ID: <CALLqZ8SSVzhLH4augLVFR59is6atMhWHdbX9Fq+d82txN8u6NA@mail.gmail.com>
Subject: Re: arm/arm-64 ipipe release
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 6, 2023 at 12:18=E2=80=AFAM Greg Gallagher <greg@embeddedgreg.c=
om> wrote:
>
> On Fri, Mar 3, 2023 at 12:50=E2=80=AFPM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> >
> > On Wed, 2023-03-01 at 13:08 +0100, Jan Kiszka wrote:
> > > On 01.03.23 12:19, Florian Bezdeka wrote:
> > > > On Tue, 2023-02-28 at 09:12 +0100, Jan Kiszka wrote:
> > > > > On 28.02.23 08:49, Florian Bezdeka wrote:
> > > > > > On Tue, 2023-02-28 at 06:48 +0100, Jan Kiszka wrote:
> > > > > > > On 28.02.23 06:18, Greg Gallagher wrote:
> > > > > > > > On Mon, Feb 20, 2023 at 1:42 AM Jan Kiszka <jan.kiszka@siem=
ens.com> wrote:
> > > > > > > > >
> > > > > > > > > On 20.02.23 06:27, Greg Gallagher wrote:
> > > > > > > > > > On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <greg@e=
mbeddedgreg.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
> > > > > > > > > > > <florian.bezdeka@siemens.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Greg!
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher w=
rote:
> > > > > > > > > > > > > Hi,
> > > > > > > > > > > > >    I'm almost ready to release the next arm and a=
rm64 ipipe patch. I'm
> > > > > > > > > > > > > working on stable release 231 since it contains t=
he patch that
> > > > > > > > > > > > > hopefully fixes the UART irq issue seen in CI.  I=
f there's a problem
> > > > > > > > > > > > > with using 231 let me know.  Finishing my local t=
est this week.
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks for letting us know. If there is a chance th=
at you publish a
> > > > > > > > > > > > public available -rc somewhere, it would be possibl=
e to tweak our CI a
> > > > > > > > > > > > bit and trigger a full test run in our lab.
> > > > > > > > > > > >
> > > > > > > > > > > > That should help us to identify any leftovers upfro=
nt.
> > > > > > > > > > > >
> > > > > > > > > > > > Best regards,
> > > > > > > > > > > > Florian
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks
> > > > > > > > > > > > >
> > > > > > > > > > > > > Greg
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I'll get -rc releases out this weekend.  I'll post ba=
ck once they are
> > > > > > > > > > > done and the -rc tags are pushed up.
> > > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > > >
> > > > > > > > > > > Greg
> > > > > > > > > >
> > > > > > > > > > Hi Florian,
> > > > > > > > > >    I have the rc releases ready to go.  I'm going to pu=
sh them up to
> > > > > > > > > > the ipipe tree with the kernel update (5.4.231).  Does =
the CI system
> > > > > > > > > > pull the current ipipe release based on the tag?  Would=
 pushing up the
> > > > > > > > > > new point release (5.4.231) break the current CI?
> > > > > > > > >
> > > > > > > > > We are pulling from the head of ipipe/4.19.y-cip and ipip=
e/5.4.y for
> > > > > > > > > ipipe-arm[64], see [1]. It just takes manual triggers so =
far as there
> > > > > > > > > are no ci files in our kernel trees (unlike the xenomai r=
epo itself).
> > > > > > > > >
> > > > > > > > > Jan
> > > > > > > > >
> > > > > > > > > [1]
> > > > > > > > > https://source.denx.de/Xenomai/xenomai-images/-/blob/mast=
er/recipes-kernel/linux/linux-xenomai_latest.bb
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Siemens AG, Technology
> > > > > > > > > Competence Center Embedded Linux
> > > > > > > > >
> > > > > > > >
> > > > > > > > I put the beta releases here:
> > > > > > > >
> > > > > > > > https://github.com/ggallagher31/ipipe-arm
> > > > > > > > https://github.com/ggallagher31/ipipe-arm64
> > > > > > > >
> > > > > > > > Branch names are the same as gitlab, once CI tests out the =
branches
> > > > > > > > where are the results located? I'll look to see what debugg=
ing is
> > > > > > > > needed.
> > > > > > >
> > > > > > > Anything speaking against pushing to the regular branches dir=
ectly? No
> > > > > > > need to tag/bump revision yet, you can do that after CI passe=
d. That's
> > > > > > > how I maintain the other repos/branches.
> > > > > >
> > > > > > I can tweek the CI a bit and trigger an internal run. The test =
runs
> > > > > > will be visible at [1] once build stage is complete and we ente=
r the
> > > > > > test stage.
> > > > > >
> > > > > > Pushing to the regular branches - and a failing CI afterwards -=
 means
> > > > > > that we already "released" or at least deployed something that =
is not
> > > > > > working. No?
> > > > >
> > > > > Released is what was tagged. I do local build tests for my branch=
es
> > > > > before I push, but CI is doing the rest of the qualification. The=
n I
> > > > > bump the revision, add a tag, and push all that as release.
> > > > >
> > > > > Jan
> > > >
> > > > Update:
> > > >
> > > > I triggered our CI infrastructure to perform two different builds. =
One
> > > > with Debian 11 (gcc 10) and one with Debian 12 (gcc 12).
> > > >
> > > > The result of both runs is the same: We have one failing test job o=
n
> > > > the Hikey board. 5.4 [2] does not show any UART output, 4.19 [3] is
> > > > fine.
> > >
> > > Do we have any early printk on? And does it only show that issue with
> > > I-pipe enabled? QEMU arm64 is fine, right?
> >
> > Nope, no early printk enabled. The qemu job is OK, so it seems board/hw
> > specific.
> >
> > >
> > > Jan
> > >
> >
> Let me see if I have a board here that has the same uart as the Hikey
> board, I'll see if I can reproduce locally.
>
> -Greg

Quick update, still debugging the ARM64 build, the arm side looks
okay.  I'll release the ARM stuff by the weekend and continue to look
into ARM64.

-Greg
