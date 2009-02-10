Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Feb 2009 16:01:56 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F7048CB@ukmail.uk.wirelessworld.airvananet.com>
In-Reply-To: <49919FD4.3040009@domain.hid>
References: <4B3F8896E1733D4787DDB0EA1C7FF91F7048AD@ukmail.uk.wirelessworld.airvananet.com>
	<49919FD4.3040009@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Mike McTernan wrote:
> > Hi,
> >
> > Does anyone have a working Adeos patch for the top of the Blackfin
> > 2008R1 non-SMP branch to get up to 2.4.6.1?  The patch supplied with
> > Xenomai doesn't cleanly apply, and after massaging would not
compile:
>=20
> see ksrc/arch/blackfin/patches/README

I wasn't holding out much hope for taking Adeos from one place, Blackfin
uClinux from another and Xenomai from here.  However, the patch at this
location does indeed patch and build against the Blackfin 2008R1:

http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-2008R1.5
-RC3-bf5xx-1.8-00.patch

Hooray!  And sorry for the obvious question.

Regards,

Mike

