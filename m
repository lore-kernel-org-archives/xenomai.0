Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EDAD32
	for <xenomai@lists.linux.dev>; Thu, 16 Mar 2023 20:57:03 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id z5so3070922ljc.8
        for <xenomai@lists.linux.dev>; Thu, 16 Mar 2023 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112; t=1679000221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6nyd+JmUjI4WcLzXP4+N672lzD7T3PEBPmTmYE3v8I=;
        b=qJNNgBlczRgU6fJMXkvTF/r9aWVW+OgQkRcT6UsSlPNRqVtSrg9lrOhqdXepILDkCh
         0YJbeXxR6x+0CCuw+pxUbh8YAegJLOM3OPpCpvCzsOKoIYZtMKBjyRRb3hwjIKtNkUbH
         cbvjjSIxeifxQ6cow9CHPHP2vzuiH7l5CqiXMyLbespV5ukId6tlPmzJKcHwLsqtBM4O
         AQLE8b6LV82BfK1XPvgyQD1U5ZqIuwZ1q3DL7vqRkYvpajcHT/edYKNy4sWzjE8z34tG
         1yD+zsBkHcDYzez1Fchl9xMqttOb7qAyfIfgB6NWw4TCAdZCxoA73Q4/hwfHtb3n+BJQ
         Lwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679000221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6nyd+JmUjI4WcLzXP4+N672lzD7T3PEBPmTmYE3v8I=;
        b=ba5HwNBOmqZhpii8pFT2cBhf13XFZZBIyr8XhntRXX4vZXIeZ5OEoFGksMFZvOC6Tj
         4+XSdCWvNG2OfqMSRzJYqNI3vZFK8ueBOkNAh0xkOLn1FkjcMAegE0W4YmSXPjeSdd4I
         rBlCjb+EDkL3DCC3A+fW1zitIz3Bo+rJgwbQ9Djdf2JJiGpy9PzxXN5cqJ3qe5KwUX+u
         uwMDA8cpszT4dnJ+ZxeVimdT0smA7Ev+Aj5leoZo9IxLqZ0t+ntPG8Bj8mXbSnTpUqsw
         Lbo9dEx7Z6LLCydY2mie5L/1Ac938pNluGMepq65YiW2kkye4jv7tcboSk1g4BCCxBgS
         d10A==
X-Gm-Message-State: AO0yUKU9e1f4EX+WVUpJw6US64Pdm3R0bN4qi4daJvMPQ/YeThSw5HIO
	oVREBdQnmIdIJsHIZLwvHuEwSpoZwnKXOeXntKQWuK9IJJTwLZG2Luo=
X-Google-Smtp-Source: AK7set8YCXOEd/VFBSk+UaYIUpjzlfOZs/Jkuj5NhyGzLUa/33nlOo0Kr8BgNJAuwcRLo8qlDONjA5i/Y5k3V3XT4eo=
X-Received: by 2002:a2e:909a:0:b0:298:b32c:e4f0 with SMTP id
 l26-20020a2e909a000000b00298b32ce4f0mr2102532ljg.8.1679000221395; Thu, 16 Mar
 2023 13:57:01 -0700 (PDT)
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
 <CALLqZ8SSVzhLH4augLVFR59is6atMhWHdbX9Fq+d82txN8u6NA@mail.gmail.com> <51a2aa74da3274aca7959b422349975fd75040b7.camel@siemens.com>
In-Reply-To: <51a2aa74da3274aca7959b422349975fd75040b7.camel@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 16 Mar 2023 16:56:50 -0400
Message-ID: <CALLqZ8SP2WFTneY-sjOewsDdcfKxcfpsNngBZfaSDCi0fEbf8g@mail.gmail.com>
Subject: Re: arm/arm-64 ipipe release
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2023 at 4:52=E2=80=AFPM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
>
> On Thu, 2023-03-16 at 16:11 -0400, Greg Gallagher wrote:
> > On Mon, Mar 6, 2023 at 12:18=E2=80=AFAM Greg Gallagher <greg@embeddedgr=
eg.com> wrote:
> > >
> > > On Fri, Mar 3, 2023 at 12:50=E2=80=AFPM Florian Bezdeka
> > > <florian.bezdeka@siemens.com> wrote:
> > > >
> > > > On Wed, 2023-03-01 at 13:08 +0100, Jan Kiszka wrote:
> > > > > On 01.03.23 12:19, Florian Bezdeka wrote:
> > > > > > On Tue, 2023-02-28 at 09:12 +0100, Jan Kiszka wrote:
> > > > > > > On 28.02.23 08:49, Florian Bezdeka wrote:
> > > > > > > > On Tue, 2023-02-28 at 06:48 +0100, Jan Kiszka wrote:
> > > > > > > > > On 28.02.23 06:18, Greg Gallagher wrote:
> > > > > > > > > > On Mon, Feb 20, 2023 at 1:42 AM Jan Kiszka <jan.kiszka@=
siemens.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On 20.02.23 06:27, Greg Gallagher wrote:
> > > > > > > > > > > > On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <gr=
eg@embeddedgreg.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
> > > > > > > > > > > > > <florian.bezdeka@siemens.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Greg!
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagh=
er wrote:
> > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > >    I'm almost ready to release the next arm a=
nd arm64 ipipe patch. I'm
> > > > > > > > > > > > > > > working on stable release 231 since it contai=
ns the patch that
> > > > > > > > > > > > > > > hopefully fixes the UART irq issue seen in CI=
.  If there's a problem
> > > > > > > > > > > > > > > with using 231 let me know.  Finishing my loc=
al test this week.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Thanks for letting us know. If there is a chanc=
e that you publish a
> > > > > > > > > > > > > > public available -rc somewhere, it would be pos=
sible to tweak our CI a
> > > > > > > > > > > > > > bit and trigger a full test run in our lab.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > That should help us to identify any leftovers u=
pfront.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Best regards,
> > > > > > > > > > > > > > Florian
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Thanks
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Greg
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'll get -rc releases out this weekend.  I'll pos=
t back once they are
> > > > > > > > > > > > > done and the -rc tags are pushed up.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks
> > > > > > > > > > > > >
> > > > > > > > > > > > > Greg
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Florian,
> > > > > > > > > > > >    I have the rc releases ready to go.  I'm going t=
o push them up to
> > > > > > > > > > > > the ipipe tree with the kernel update (5.4.231).  D=
oes the CI system
> > > > > > > > > > > > pull the current ipipe release based on the tag?  W=
ould pushing up the
> > > > > > > > > > > > new point release (5.4.231) break the current CI?
> > > > > > > > > > >
> > > > > > > > > > > We are pulling from the head of ipipe/4.19.y-cip and =
ipipe/5.4.y for
> > > > > > > > > > > ipipe-arm[64], see [1]. It just takes manual triggers=
 so far as there
> > > > > > > > > > > are no ci files in our kernel trees (unlike the xenom=
ai repo itself).
> > > > > > > > > > >
> > > > > > > > > > > Jan
> > > > > > > > > > >
> > > > > > > > > > > [1]
> > > > > > > > > > > https://source.denx.de/Xenomai/xenomai-images/-/blob/=
master/recipes-kernel/linux/linux-xenomai_latest.bb
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > Siemens AG, Technology
> > > > > > > > > > > Competence Center Embedded Linux
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I put the beta releases here:
> > > > > > > > > >
> > > > > > > > > > https://github.com/ggallagher31/ipipe-arm
> > > > > > > > > > https://github.com/ggallagher31/ipipe-arm64
> > > > > > > > > >
> > > > > > > > > > Branch names are the same as gitlab, once CI tests out =
the branches
> > > > > > > > > > where are the results located? I'll look to see what de=
bugging is
> > > > > > > > > > needed.
> > > > > > > > >
> > > > > > > > > Anything speaking against pushing to the regular branches=
 directly? No
> > > > > > > > > need to tag/bump revision yet, you can do that after CI p=
assed. That's
> > > > > > > > > how I maintain the other repos/branches.
> > > > > > > >
> > > > > > > > I can tweek the CI a bit and trigger an internal run. The t=
est runs
> > > > > > > > will be visible at [1] once build stage is complete and we =
enter the
> > > > > > > > test stage.
> > > > > > > >
> > > > > > > > Pushing to the regular branches - and a failing CI afterwar=
ds - means
> > > > > > > > that we already "released" or at least deployed something t=
hat is not
> > > > > > > > working. No?
> > > > > > >
> > > > > > > Released is what was tagged. I do local build tests for my br=
anches
> > > > > > > before I push, but CI is doing the rest of the qualification.=
 Then I
> > > > > > > bump the revision, add a tag, and push all that as release.
> > > > > > >
> > > > > > > Jan
> > > > > >
> > > > > > Update:
> > > > > >
> > > > > > I triggered our CI infrastructure to perform two different buil=
ds. One
> > > > > > with Debian 11 (gcc 10) and one with Debian 12 (gcc 12).
> > > > > >
> > > > > > The result of both runs is the same: We have one failing test j=
ob on
> > > > > > the Hikey board. 5.4 [2] does not show any UART output, 4.19 [3=
] is
> > > > > > fine.
> > > > >
> > > > > Do we have any early printk on? And does it only show that issue =
with
> > > > > I-pipe enabled? QEMU arm64 is fine, right?
> > > >
> > > > Nope, no early printk enabled. The qemu job is OK, so it seems boar=
d/hw
> > > > specific.
> > > >
> > > > >
> > > > > Jan
> > > > >
> > > >
> > > Let me see if I have a board here that has the same uart as the Hikey
> > > board, I'll see if I can reproduce locally.
> > >
> > > -Greg
> >
> > Quick update, still debugging the ARM64 build, the arm side looks
> > okay.  I'll release the ARM stuff by the weekend and continue to look
> > into ARM64.
>
> Thanks for the update! Our CI confirmed the same thing, arm OK, arm64
> boot failure.
>
> Still debugging means that you can reproduce? That would actually be
> perfect because I don't have the board at hand and would need to
> remote-debug it...
>
> Florian
> >
> > -Greg
>

Hi Florian,
   Can you confirm what hikey board it is.  I think the uart driver is
the arm,pl011.  I do have a board here with it, I'm trying to
reproduce tonight and over the weekend.

-Greg
