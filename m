From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <509DA52866E38F47878413CF102D751FED236D782F@poseidon.nexus-ag.com>
References: <509DA52866E38F47878413CF102D751FED236D782F@poseidon.nexus-ag.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Sep 2011 22:29:30 +0200
Message-ID: <1314908970.18201.30.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] taskDelete(tid) on VxWorks Skin ?
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
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

On Thu, 2011-09-01 at 12:23 +0200, Sambasiva Rao Manchili wrote:
> Hallo,
> During cleanup routines we call taskDelete(tid)   but for some reasons
> we see that taskDelete is not working as expected though status
> returned by taskDelete call is 0(OK) and
> further leads to crash as the task still exists(not deleted as assumed
> to be deleted with taskDelete) and trying to do something....which is
> not valid any more.
> We use options as 0 while creating task.
>  
> Also tried taskDeleteForce, but did not help.   Any hints please.
>  
> To my knowledge,  Xenomai does not support any Hooks adding and
> deleing calls of Vxworks, we did not use them either.

It does, but can be registered for kernel space callees only.

>  
> But I got some info from  the following URL.
> <http://www.xenomai.org/documentation/trunk/html/api/group__pod.html#gd2b761fb70cad30339f092edb4a89587>
>  
>  
> Thank you,
> samba.
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



