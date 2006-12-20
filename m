Message-ID: <4588F8D0.5060605@domain.hid>
Date: Wed, 20 Dec 2006 09:48:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] prepare kernel fails
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F92C7@domain.hid>
	<200612192054.54573.niklaus.giger@domain.hid>
	<45884DC5.2030701@domain.hid>
	<200612192202.58982.niklaus.giger@domain.hid>
In-Reply-To: <200612192202.58982.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Niklaus Giger wrote:
> Am Dienstag, 19. Dezember 2006 21:38 schrieb Jan Kiszka:
>>I rather think c) is desired: checkout from svn, make dist, untar that
>>archive and continue to work with *those* sources.
> 
> This solution is also easily integretable into the actual Buildbot. I suppose 
> do it would be sufficient to add it only to the daily "full" builds. But I 
> would need to know how the release is exactly generated. E.g. after a 
> checkout to clean directory there is no Makefile and therefore "make dist" 
> fails miserably. Could somebody please tell me the exact steps?

You need to create a build tree by running the configure script, then
run make dist (or preferably "make distcheck") in this build tree.

-- 
                                                 Gilles Chanteperdrix

