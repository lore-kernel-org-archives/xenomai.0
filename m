From: Paul <paul_c@domain.hid>
Date: Wed, 14 Nov 2007 16:37:30 +0000
References: <4739E07B.1000608@domain.hid> <200711141056.06083.lepalom@domain.hid>
In-Reply-To: <200711141056.06083.lepalom@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711141637.30166.paul_c@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai v2.4-rc6
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Leopold Palomo-Avellaneda <lepalom@domain.hid>

On Wednesday 14 November 2007 09:56, Leopold Palomo-Avellaneda wrote:
> A Dimarts 13 Novembre 2007, Philippe Gerum va escriure:
> > Here is the sixth candidate release for the v2.4.x branch.
>
> [....]
>
> > 	[i386, x86_64 => x86]
> >
> > 	* Merge i386 and x86_64 arch-dep support as x86.
> >  	* Update Adeos/i386 support for 2.6.20, 2.6.22 and 2.6.23.
>
> [...]
>
> this has break the creation of the debian packages. I can understand that
> conceptually they are the same arch (one with 32bits and another with 64
> and more extensions) in general _all_ the distros treat them as two
> different arch. So this changes break things. I don't think that it's a
> good idea do it in a release candidate, IMHO.

I'm right in the middle of looking at the packaging scripts, so expect a patch 
within the next few days.

Giles/Philippe: Is there likely to be a 2.6.24 ipipe patch out before Xenomai 
reaches 2.4.0 ?


Regards, Paul.



