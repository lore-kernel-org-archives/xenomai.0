From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <509DA52866E38F47878413CF102D751FD4207794F0@domain.hid>
References: <509DA52866E38F47878413CF102D751FD4207794F0@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 03 Aug 2011 13:27:24 +0200
Message-ID: <1312370844.2135.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai VxWorks Skin--->semTake
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Cc: Antonio Gambin <antonio.gambin@domain.hid>, "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

On Wed, 2011-08-03 at 12:15 +0200, Sambasiva Rao Manchili wrote:
> Hallo ,
> Most of  code containing semTake with (WAIT_FOREVER ) ported from
> VxWorks to Linux using Xenomai is working, but only the following
> semTake is always failing.

Your description is a bit terse. Failing how? Hangs, returns
immediately? Crashes your board? If not, any error code reported by the
skin?

And rehashing a previous question which was not answered IIRC: what
CPU/platform are you running on, beside "linux 2.6.37" which does not
help enough? What Xenomai version?

Please make sure to send any relevant information that may help
reproducing the issue, this tends to convince people to actually have a
look at it.

>  
> For Example:-
> semTake( restab_access_smp, 1200).
>  
> Semaphore created successfully and exists.
> Any reason and any hint?
>  
> Semaphore created without ERROR as follows.
> if ((restab_access_smp = semMCreate (SEM_Q_PRIORITY | SEM_DELETE_SAFE
>            | SEM_INVERSION_SAFE)) == NULL)
> {
>    ERROR
> }
>  
> Thanks,
> Samba.
>  
>  
> Sambasiva Rao Manchili
> Software Development Engineer 
> ________________________________
>  
> NEXUS TELECOM AG 
> Network and Service Investigation
> 
> Feldbachstrasse 80
> 8634 Hombrechtikon
> Switzerland
> 
> Direct/mobile: +41 78 750 6808
> Main: +41 44 355 6611
> Email: sambasiva.manchili@domain.hid
> Website: www.nexustelecom.com
> 
>  
>  
> 
> 
> ______________________________________________________________________
> This email and any attachment may contain confidential information
> which is intended for use only by the addressee(s) named above. If you
> received this email by mistake, please notify the sender immediately,
> and delete the email from your system. You are prohibited from
> copying, disseminating or otherwise using the email or any attachment.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



