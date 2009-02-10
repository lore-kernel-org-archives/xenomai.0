Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Feb 2009 16:36:36 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F7048EA@ukmail.uk.wirelessworld.airvananet.com>
In-Reply-To: <4991A49C.2000503@domain.hid>
References: <4B3F8896E1733D4787DDB0EA1C7FF91F7048AD@ukmail.uk.wirelessworld.airvananet.com>
	<4991A49C.2000503@domain.hid>
From: "Mike McTernan" <mmcternan@domain.hid>
Subject: Re: [Xenomai-help] 2.4.6.1 blackfin patches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Mike McTernan wrote:
> > Hi,
> >
> > Does anyone have a working Adeos patch for the top of the Blackfin
> 2008R1 non-SMP branch to get up to 2.4.6.1?  The patch supplied with
> Xenomai doesn't cleanly apply, and after massaging would not compile:
> >
>=20
> adeos-ipipe-2008R1.5-RC3-bf5xx-1.8-00 applies cleanly against the
official
> 2008R1.5-RC3 uClinux distribution. Until recently, I was only tracking
> official release milestones.

Yes, I can confirm that.  It's good for the top of the 2008R1 branch
too.

> Since Adeos is now part of the official uClinux distro for the
blackfin,
> I'm now tracking their development head instead; you can now find
> adeos-ipipe-2.6.28-blackfin.git-1.9-00 which applies to the
> blackfin.uclinux.org
> GIT tree at
git://sources.blackfin.uclinux.org/git/readonly-mirrors/linux-
> kernel.git

That's excellent, although all the work I do is on the 2008R1 branch of
Bfin uClinux as that's well tested and stable.

Mike

