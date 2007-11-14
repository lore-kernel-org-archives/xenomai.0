From: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Date: Wed, 14 Nov 2007 10:56:05 +0100
References: <4739E07B.1000608@domain.hid>
In-Reply-To: <4739E07B.1000608@domain.hid>
MIME-Version: 1.0
Message-Id: <200711141056.06083.lepalom@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Subject: Re: [Xenomai-help] Xenomai v2.4-rc6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, rpm@xenomai.org

A Dimarts 13 Novembre 2007, Philippe Gerum va escriure:
> Here is the sixth candidate release for the v2.4.x branch.
[....]
>
> 	[i386, x86_64 => x86]
>
> 	* Merge i386 and x86_64 arch-dep support as x86.
>  	* Update Adeos/i386 support for 2.6.20, 2.6.22 and 2.6.23.

[...]

this has break the creation of the debian packages. I can understand that 
conceptually they are the same arch (one with 32bits and another with 64 and 
more extensions) in general _all_ the distros treat them as two different 
arch. So this changes break things. I don't think that it's a good idea do it 
in a release candidate, IMHO.

Regards,

Leo

