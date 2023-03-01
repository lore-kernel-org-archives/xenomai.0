Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F91116
	for <xenomai@lists.linux.dev>; Wed,  1 Mar 2023 11:19:45 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230301111934b21b95f5752723c120
        for <xenomai@lists.linux.dev>;
        Wed, 01 Mar 2023 12:19:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Ck1ZvD+0vTWevFVEMvIypGSZbADibVugPxj8cntaB3o=;
 b=KeR4GjDBfzMDlOSM6V0ZdEj3956KcFlJtx9un5FeQ+prfvZZI+fUaY+EE5bXIHUKSw04Oq
 Pve7BDcKoSDxoqGNql7zFsSKmTeKgrJyrvU1gZxj0lMJYP5YOC7Zpb7LoZ5zYHC3Pi8QVCjZ
 0BmTycpWzcqgEHXd5Cz0T6zY+1iTM=;
Message-ID: <fb67c17c9b2c67b3a8b1b67dad9df4c77391ea14.camel@siemens.com>
Subject: Re: arm/arm-64 ipipe release
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher
 <greg@embeddedgreg.com>
Cc: xenomai@lists.linux.dev
Date: Wed, 01 Mar 2023 12:19:33 +0100
In-Reply-To: <327eb2af-b4b9-b78e-4456-32f61ce7b03d@siemens.com>
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

On Tue, 2023-02-28 at 09:12 +0100, Jan Kiszka wrote:
> On 28.02.23 08:49, Florian Bezdeka wrote:
> > On Tue, 2023-02-28 at 06:48 +0100, Jan Kiszka wrote:
> > > On 28.02.23 06:18, Greg Gallagher wrote:
> > > > On Mon, Feb 20, 2023 at 1:42 AM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
> > > > >=20
> > > > > On 20.02.23 06:27, Greg Gallagher wrote:
> > > > > > On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <greg@embeddedg=
reg.com> wrote:
> > > > > > >=20
> > > > > > > On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
> > > > > > > <florian.bezdeka@siemens.com> wrote:
> > > > > > > >=20
> > > > > > > > Hi Greg!
> > > > > > > >=20
> > > > > > > > On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher wrote:
> > > > > > > > > Hi,
> > > > > > > > >    I'm almost ready to release the next arm and arm64 ipi=
pe patch. I'm
> > > > > > > > > working on stable release 231 since it contains the patch=
 that
> > > > > > > > > hopefully fixes the UART irq issue seen in CI.  If there'=
s a problem
> > > > > > > > > with using 231 let me know.  Finishing my local test this=
 week.
> > > > > > > >=20
> > > > > > > > Thanks for letting us know. If there is a chance that you p=
ublish a
> > > > > > > > public available -rc somewhere, it would be possible to twe=
ak our CI a
> > > > > > > > bit and trigger a full test run in our lab.
> > > > > > > >=20
> > > > > > > > That should help us to identify any leftovers upfront.
> > > > > > > >=20
> > > > > > > > Best regards,
> > > > > > > > Florian
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Thanks
> > > > > > > > >=20
> > > > > > > > > Greg
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > >=20
> > > > > > > I'll get -rc releases out this weekend.  I'll post back once =
they are
> > > > > > > done and the -rc tags are pushed up.
> > > > > > >=20
> > > > > > > Thanks
> > > > > > >=20
> > > > > > > Greg
> > > > > >=20
> > > > > > Hi Florian,
> > > > > >    I have the rc releases ready to go.  I'm going to push them =
up to
> > > > > > the ipipe tree with the kernel update (5.4.231).  Does the CI s=
ystem
> > > > > > pull the current ipipe release based on the tag?  Would pushing=
 up the
> > > > > > new point release (5.4.231) break the current CI?
> > > > >=20
> > > > > We are pulling from the head of ipipe/4.19.y-cip and ipipe/5.4.y =
for
> > > > > ipipe-arm[64], see [1]. It just takes manual triggers so far as t=
here
> > > > > are no ci files in our kernel trees (unlike the xenomai repo itse=
lf).
> > > > >=20
> > > > > Jan
> > > > >=20
> > > > > [1]
> > > > > https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recip=
es-kernel/linux/linux-xenomai_latest.bb
> > > > >=20
> > > > > --
> > > > > Siemens AG, Technology
> > > > > Competence Center Embedded Linux
> > > > >=20
> > > >=20
> > > > I put the beta releases here:
> > > >=20
> > > > https://github.com/ggallagher31/ipipe-arm
> > > > https://github.com/ggallagher31/ipipe-arm64
> > > >=20
> > > > Branch names are the same as gitlab, once CI tests out the branches
> > > > where are the results located? I'll look to see what debugging is
> > > > needed.
> > >=20
> > > Anything speaking against pushing to the regular branches directly? N=
o
> > > need to tag/bump revision yet, you can do that after CI passed. That'=
s
> > > how I maintain the other repos/branches.
> >=20
> > I can tweek the CI a bit and trigger an internal run. The test runs
> > will be visible at [1] once build stage is complete and we enter the
> > test stage.
> >=20
> > Pushing to the regular branches - and a failing CI afterwards - means
> > that we already "released" or at least deployed something that is not
> > working. No?
>=20
> Released is what was tagged. I do local build tests for my branches
> before I push, but CI is doing the rest of the qualification. Then I
> bump the revision, add a tag, and push all that as release.
>=20
> Jan

Update:

I triggered our CI infrastructure to perform two different builds. One
with Debian 11 (gcc 10) and one with Debian 12 (gcc 12).

The result of both runs is the same: We have one failing test job on
the Hikey board. 5.4 [2] does not show any UART output, 4.19 [3] is
fine.=20

Greg, do you have such a board at hand?

Best regards,
Florian

[2] https://lava.xenomai.org/scheduler/job/8381
[3] https://lava.xenomai.org/scheduler/job/8376

>=20
> >=20
> > I will let you know when the test results are visible.
> >=20
> > [1] https://lava.xenomai.org/scheduler/alljobs
> >=20
> > Best regards,
> > Florian
> >=20
> > >=20
> > > Jan
> > >=20
> >=20
>=20

