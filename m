Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52735D30F
	for <xenomai@lists.linux.dev>; Mon,  6 Mar 2023 05:19:05 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id z5so8367269ljc.8
        for <xenomai@lists.linux.dev>; Sun, 05 Mar 2023 21:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMQClZw1/OEtJ7JJJOVY0mZDMrGgovNM9PyB+Y52BHI=;
        b=vj/C0Ylg+UqaXkGo9s8G4N3IVC8GSq47q6VsZh24gPfowiUXazOs/buNOS6rVS2Wcb
         rhA4MP+qHMyapSbvDHFXTtyvu/3m+Yqux4efSqugTstWjUh0A3oVriBFWgLMuTFbj+3s
         TekDq2YXqbUQjCVNSfP3fKTlONQAsSranYxLWqMIKNcj6vdWw8Nsi4FDIY3VfmfP7K9w
         cS89SWT0m1wqcQ49+EEV1YxBfiSDY4Y+BKISiTCdlrc5Q7tGFA+Dlm+PQ/NFG9cWXJvq
         Y4Pz+aDCIUrYWc7lCpP2KYld/Zf43/tsMguDbuvoTZrhpngF//u+WQoYZbesH4/AkB+c
         rsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMQClZw1/OEtJ7JJJOVY0mZDMrGgovNM9PyB+Y52BHI=;
        b=UZ+9qG3nVodVwMzZyDbBhpXiY1q2lKiISJKe/J4QQSqxa1v8NHmuBEoy+sWzMrEbdI
         ZZ1GPNALrSHYfTqBLOMjeDpfLqY8UHj4PPZIY7ki2NB+YNV+4jKr5GjuZvajj9DOFC+o
         /O1j+Qu1OOBGIm+nad7Hc2iuoARi/8BAutXulNaChlgQUEs9AJYIkpjtJXGEfepuXTs4
         5/Ex+JOpzHcSeLCq6jIEgYWUvPU06LUkeiSIE1y25Nl4yCT+E5bSp/sTvT36Hm2a+U6U
         9KQ+1bPk0Pa/p1SkcMIa3moZnYyaK5g4zMJGiSPqL0q9kWfhAacTyPz8mlGMoPaiWatn
         /K/Q==
X-Gm-Message-State: AO0yUKWrMKhwL5sSES1PPDTgDn5Cd0vC4koMRbD4UdCW8vJcyqWdfviA
	eH9op6eB4qqZ+wQPFPOvRwC+HwyIjUFqX6ivViJuTw==
X-Google-Smtp-Source: AK7set8iXUvgp7zAsYwvXZ0tuZoCIXqimTU/DC6cbHeRHgdzHhsxg3FB3ecAa6LLJ5xBaMCHtHL/OQSCt/AJA+3qJJc=
X-Received: by 2002:a2e:8e26:0:b0:295:942d:9b6 with SMTP id
 r6-20020a2e8e26000000b00295942d09b6mr2650285ljk.7.1678079943124; Sun, 05 Mar
 2023 21:19:03 -0800 (PST)
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
In-Reply-To: <48dcb04adfc2efc2936c554747660cb0c504fa7b.camel@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 6 Mar 2023 00:18:51 -0500
Message-ID: <CALLqZ8Rq-TZZ3vHfU-JPgrGVrYZaC5Jgx5vBUWVeScpiMt2K7g@mail.gmail.com>
Subject: Re: arm/arm-64 ipipe release
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 3, 2023 at 12:50=E2=80=AFPM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
>
> On Wed, 2023-03-01 at 13:08 +0100, Jan Kiszka wrote:
> > On 01.03.23 12:19, Florian Bezdeka wrote:
> > > On Tue, 2023-02-28 at 09:12 +0100, Jan Kiszka wrote:
> > > > On 28.02.23 08:49, Florian Bezdeka wrote:
> > > > > On Tue, 2023-02-28 at 06:48 +0100, Jan Kiszka wrote:
> > > > > > On 28.02.23 06:18, Greg Gallagher wrote:
> > > > > > > On Mon, Feb 20, 2023 at 1:42 AM Jan Kiszka <jan.kiszka@siemen=
s.com> wrote:
> > > > > > > >
> > > > > > > > On 20.02.23 06:27, Greg Gallagher wrote:
> > > > > > > > > On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <greg@emb=
eddedgreg.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
> > > > > > > > > > <florian.bezdeka@siemens.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Greg!
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher wro=
te:
> > > > > > > > > > > > Hi,
> > > > > > > > > > > >    I'm almost ready to release the next arm and arm=
64 ipipe patch. I'm
> > > > > > > > > > > > working on stable release 231 since it contains the=
 patch that
> > > > > > > > > > > > hopefully fixes the UART irq issue seen in CI.  If =
there's a problem
> > > > > > > > > > > > with using 231 let me know.  Finishing my local tes=
t this week.
> > > > > > > > > > >
> > > > > > > > > > > Thanks for letting us know. If there is a chance that=
 you publish a
> > > > > > > > > > > public available -rc somewhere, it would be possible =
to tweak our CI a
> > > > > > > > > > > bit and trigger a full test run in our lab.
> > > > > > > > > > >
> > > > > > > > > > > That should help us to identify any leftovers upfront=
.
> > > > > > > > > > >
> > > > > > > > > > > Best regards,
> > > > > > > > > > > Florian
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks
> > > > > > > > > > > >
> > > > > > > > > > > > Greg
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I'll get -rc releases out this weekend.  I'll post back=
 once they are
> > > > > > > > > > done and the -rc tags are pushed up.
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > > Greg
> > > > > > > > >
> > > > > > > > > Hi Florian,
> > > > > > > > >    I have the rc releases ready to go.  I'm going to push=
 them up to
> > > > > > > > > the ipipe tree with the kernel update (5.4.231).  Does th=
e CI system
> > > > > > > > > pull the current ipipe release based on the tag?  Would p=
ushing up the
> > > > > > > > > new point release (5.4.231) break the current CI?
> > > > > > > >
> > > > > > > > We are pulling from the head of ipipe/4.19.y-cip and ipipe/=
5.4.y for
> > > > > > > > ipipe-arm[64], see [1]. It just takes manual triggers so fa=
r as there
> > > > > > > > are no ci files in our kernel trees (unlike the xenomai rep=
o itself).
> > > > > > > >
> > > > > > > > Jan
> > > > > > > >
> > > > > > > > [1]
> > > > > > > > https://source.denx.de/Xenomai/xenomai-images/-/blob/master=
/recipes-kernel/linux/linux-xenomai_latest.bb
> > > > > > > >
> > > > > > > > --
> > > > > > > > Siemens AG, Technology
> > > > > > > > Competence Center Embedded Linux
> > > > > > > >
> > > > > > >
> > > > > > > I put the beta releases here:
> > > > > > >
> > > > > > > https://github.com/ggallagher31/ipipe-arm
> > > > > > > https://github.com/ggallagher31/ipipe-arm64
> > > > > > >
> > > > > > > Branch names are the same as gitlab, once CI tests out the br=
anches
> > > > > > > where are the results located? I'll look to see what debuggin=
g is
> > > > > > > needed.
> > > > > >
> > > > > > Anything speaking against pushing to the regular branches direc=
tly? No
> > > > > > need to tag/bump revision yet, you can do that after CI passed.=
 That's
> > > > > > how I maintain the other repos/branches.
> > > > >
> > > > > I can tweek the CI a bit and trigger an internal run. The test ru=
ns
> > > > > will be visible at [1] once build stage is complete and we enter =
the
> > > > > test stage.
> > > > >
> > > > > Pushing to the regular branches - and a failing CI afterwards - m=
eans
> > > > > that we already "released" or at least deployed something that is=
 not
> > > > > working. No?
> > > >
> > > > Released is what was tagged. I do local build tests for my branches
> > > > before I push, but CI is doing the rest of the qualification. Then =
I
> > > > bump the revision, add a tag, and push all that as release.
> > > >
> > > > Jan
> > >
> > > Update:
> > >
> > > I triggered our CI infrastructure to perform two different builds. On=
e
> > > with Debian 11 (gcc 10) and one with Debian 12 (gcc 12).
> > >
> > > The result of both runs is the same: We have one failing test job on
> > > the Hikey board. 5.4 [2] does not show any UART output, 4.19 [3] is
> > > fine.
> >
> > Do we have any early printk on? And does it only show that issue with
> > I-pipe enabled? QEMU arm64 is fine, right?
>
> Nope, no early printk enabled. The qemu job is OK, so it seems board/hw
> specific.
>
> >
> > Jan
> >
>
Let me see if I have a board here that has the same uart as the Hikey
board, I'll see if I can reproduce locally.

-Greg
