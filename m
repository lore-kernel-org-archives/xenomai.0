Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9C190
	for <xenomai@lists.linux.dev>; Thu, 16 Mar 2023 22:33:03 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230316205236e9511a402da2f758b0
        for <xenomai@lists.linux.dev>;
        Thu, 16 Mar 2023 21:52:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dPRjlVkbQp6NMqFh2GFOp37YYL781DZkIhDRU7w7K60=;
 b=VRd4IBSC7PXd7s3NhnJcPOymyB1yHE9itF1KELUDQ1zCnkNQp564NHPE2zL56lrie/E37K
 8MaIAljwaYvdw8a32TkmXjgV38nv4GsstsU2sCrsTsB/cizWVaBrk5S0sGQbemdYCuoJhkcR
 NxRCO5vVT0QtO9415Xfj8ZgH4E26g=;
Message-ID: <51a2aa74da3274aca7959b422349975fd75040b7.camel@siemens.com>
Subject: Re: arm/arm-64 ipipe release
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Thu, 16 Mar 2023 21:52:35 +0100
In-Reply-To: <CALLqZ8SSVzhLH4augLVFR59is6atMhWHdbX9Fq+d82txN8u6NA@mail.gmail.com>
References: 
	<CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
	 <252602b1508b13bc480f6c971e13b02ae7702071.camel@siemens.com>
	 <CALLqZ8SiSB8e1VJcCv06H7Gc=zwiLf=6kBisB73yCT6VhRRRug@mail.gmail.com>
	 <CALLqZ8Sk2OejX_aZRSiMqdDunY-5nG_Gr5Guf032HhS41ewD=Q@mail.gmail.com>
	 <9a49e98f-2de6-168d-51b2-22c68c2d8084@siemens.com>
	 <CALLqZ8TA_yUvrSMvqbrLOD1_+pqE+SVxZ5-=FwgrPX+k5KgOpQ@mail.gmail.com>
	 <954672f9-5367-603c-1721-1047a4e18283@siemens.com>
	 <88c4c9d231886bc3df0ede57a66353b19c4eabf2.camel@siemens.com>
	 <327eb2af-b4b9-b78e-4456-32f61ce7b03d@siemens.com>
	 <fb67c17c9b2c67b3a8b1b67dad9df4c77391ea14.camel@siemens.com>
	 <8a97726e-46a4-422c-07b0-086dbf36c249@siemens.com>
	 <48dcb04adfc2efc2936c554747660cb0c504fa7b.camel@siemens.com>
	 <CALLqZ8Rq-TZZ3vHfU-JPgrGVrYZaC5Jgx5vBUWVeScpiMt2K7g@mail.gmail.com>
	 <CALLqZ8SSVzhLH4augLVFR59is6atMhWHdbX9Fq+d82txN8u6NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Thu, 2023-03-16 at 16:11 -0400, Greg Gallagher wrote:
> On Mon, Mar 6, 2023 at 12:18=E2=80=AFAM Greg Gallagher <greg@embeddedgreg=
.com> wrote:
> >=20
> > On Fri, Mar 3, 2023 at 12:50=E2=80=AFPM Florian Bezdeka
> > <florian.bezdeka@siemens.com> wrote:
> > >=20
> > > On Wed, 2023-03-01 at 13:08 +0100, Jan Kiszka wrote:
> > > > On 01.03.23 12:19, Florian Bezdeka wrote:
> > > > > On Tue, 2023-02-28 at 09:12 +0100, Jan Kiszka wrote:
> > > > > > On 28.02.23 08:49, Florian Bezdeka wrote:
> > > > > > > On Tue, 2023-02-28 at 06:48 +0100, Jan Kiszka wrote:
> > > > > > > > On 28.02.23 06:18, Greg Gallagher wrote:
> > > > > > > > > On Mon, Feb 20, 2023 at 1:42 AM Jan Kiszka <jan.kiszka@si=
emens.com> wrote:
> > > > > > > > > >=20
> > > > > > > > > > On 20.02.23 06:27, Greg Gallagher wrote:
> > > > > > > > > > > On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <greg=
@embeddedgreg.com> wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
> > > > > > > > > > > > <florian.bezdeka@siemens.com> wrote:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Hi Greg!
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher=
 wrote:
> > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > >    I'm almost ready to release the next arm and=
 arm64 ipipe patch. I'm
> > > > > > > > > > > > > > working on stable release 231 since it contains=
 the patch that
> > > > > > > > > > > > > > hopefully fixes the UART irq issue seen in CI. =
 If there's a problem
> > > > > > > > > > > > > > with using 231 let me know.  Finishing my local=
 test this week.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Thanks for letting us know. If there is a chance =
that you publish a
> > > > > > > > > > > > > public available -rc somewhere, it would be possi=
ble to tweak our CI a
> > > > > > > > > > > > > bit and trigger a full test run in our lab.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > That should help us to identify any leftovers upf=
ront.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Best regards,
> > > > > > > > > > > > > Florian
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Thanks
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Greg
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > I'll get -rc releases out this weekend.  I'll post =
back once they are
> > > > > > > > > > > > done and the -rc tags are pushed up.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Thanks
> > > > > > > > > > > >=20
> > > > > > > > > > > > Greg
> > > > > > > > > > >=20
> > > > > > > > > > > Hi Florian,
> > > > > > > > > > >    I have the rc releases ready to go.  I'm going to =
push them up to
> > > > > > > > > > > the ipipe tree with the kernel update (5.4.231).  Doe=
s the CI system
> > > > > > > > > > > pull the current ipipe release based on the tag?  Wou=
ld pushing up the
> > > > > > > > > > > new point release (5.4.231) break the current CI?
> > > > > > > > > >=20
> > > > > > > > > > We are pulling from the head of ipipe/4.19.y-cip and ip=
ipe/5.4.y for
> > > > > > > > > > ipipe-arm[64], see [1]. It just takes manual triggers s=
o far as there
> > > > > > > > > > are no ci files in our kernel trees (unlike the xenomai=
 repo itself).
> > > > > > > > > >=20
> > > > > > > > > > Jan
> > > > > > > > > >=20
> > > > > > > > > > [1]
> > > > > > > > > > https://source.denx.de/Xenomai/xenomai-images/-/blob/ma=
ster/recipes-kernel/linux/linux-xenomai_latest.bb
> > > > > > > > > >=20
> > > > > > > > > > --
> > > > > > > > > > Siemens AG, Technology
> > > > > > > > > > Competence Center Embedded Linux
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > I put the beta releases here:
> > > > > > > > >=20
> > > > > > > > > https://github.com/ggallagher31/ipipe-arm
> > > > > > > > > https://github.com/ggallagher31/ipipe-arm64
> > > > > > > > >=20
> > > > > > > > > Branch names are the same as gitlab, once CI tests out th=
e branches
> > > > > > > > > where are the results located? I'll look to see what debu=
gging is
> > > > > > > > > needed.
> > > > > > > >=20
> > > > > > > > Anything speaking against pushing to the regular branches d=
irectly? No
> > > > > > > > need to tag/bump revision yet, you can do that after CI pas=
sed. That's
> > > > > > > > how I maintain the other repos/branches.
> > > > > > >=20
> > > > > > > I can tweek the CI a bit and trigger an internal run. The tes=
t runs
> > > > > > > will be visible at [1] once build stage is complete and we en=
ter the
> > > > > > > test stage.
> > > > > > >=20
> > > > > > > Pushing to the regular branches - and a failing CI afterwards=
 - means
> > > > > > > that we already "released" or at least deployed something tha=
t is not
> > > > > > > working. No?
> > > > > >=20
> > > > > > Released is what was tagged. I do local build tests for my bran=
ches
> > > > > > before I push, but CI is doing the rest of the qualification. T=
hen I
> > > > > > bump the revision, add a tag, and push all that as release.
> > > > > >=20
> > > > > > Jan
> > > > >=20
> > > > > Update:
> > > > >=20
> > > > > I triggered our CI infrastructure to perform two different builds=
. One
> > > > > with Debian 11 (gcc 10) and one with Debian 12 (gcc 12).
> > > > >=20
> > > > > The result of both runs is the same: We have one failing test job=
 on
> > > > > the Hikey board. 5.4 [2] does not show any UART output, 4.19 [3] =
is
> > > > > fine.
> > > >=20
> > > > Do we have any early printk on? And does it only show that issue wi=
th
> > > > I-pipe enabled? QEMU arm64 is fine, right?
> > >=20
> > > Nope, no early printk enabled. The qemu job is OK, so it seems board/=
hw
> > > specific.
> > >=20
> > > >=20
> > > > Jan
> > > >=20
> > >=20
> > Let me see if I have a board here that has the same uart as the Hikey
> > board, I'll see if I can reproduce locally.
> >=20
> > -Greg
>=20
> Quick update, still debugging the ARM64 build, the arm side looks
> okay.  I'll release the ARM stuff by the weekend and continue to look
> into ARM64.

Thanks for the update! Our CI confirmed the same thing, arm OK, arm64
boot failure.

Still debugging means that you can reproduce? That would actually be
perfect because I don't have the board at hand and would need to
remote-debug it...

Florian
>=20
> -Greg

