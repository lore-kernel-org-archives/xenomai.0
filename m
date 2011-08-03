From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <509DA52866E38F47878413CF102D751FD4207794F8@domain.hid>
References: <509DA52866E38F47878413CF102D751FD4207794F0@domain.hid>
	<1312370844.2135.10.camel@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F2@domain.hid>
	<4E394A78.7040408@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F8@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 03 Aug 2011 15:53:08 +0200
Message-ID: <1312379588.2135.12.camel@domain.hid>
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

On Wed, 2011-08-03 at 15:31 +0200, Sambasiva Rao Manchili wrote:
> Hi Gilles,
> I had seen the code  in src\skins\vxworks\semLib.c it returns ERROR which is -1.
> 
> The value that I sent earlier is the value that I got out of the following statement.
> serrLog( serrErr,
>              "resu_getonline_1_svc: semTake for restab_access_smp failed!!<%s>",
>               strerror(errnoGet()));
> 
> Is it right ?
> 
> 
> Now again I tried with
>  serrLog( serrErr,
>              "resu_getonline_1_svc: semTake for restab_access_smp failed!!<%s> <%d>",
>               strerror(errnoGet()), errno);
> 
> Here I get value 1 for errno.

You are trying to grab the mutex from a non-Xenomai thread context. This
is invalid.

> 
> Samba.
> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Wednesday, 03. August, 2011 15:18
> To: Sambasiva Rao Manchili
> Cc: Philippe Gerum; Antonio Gambin; Xenomai-help@domain.hid
> Subject: Re: [Xenomai-help] Xenomai VxWorks Skin--->semTake
> 
> On 08/03/2011 02:44 PM, Sambasiva Rao Manchili wrote:
> > Hi Philppe,
> > Failed and return with error code is  <Unknown error 4294967295> and continues. I do not know the granularity of time  here, if it is returning immediately or not.
> > We have about 15 tasks spawned in this whole system. Done very very minimal changes to our VxWorks code to run on Linux over Xenomai version 2.5.6.   Board does not crash.
> > CPU Platform is Intel x86 Arch 32 Bit.
> 
> semTake does not return error code directly, it returns ERROR (which is -1, or 4294967295 if you cast to unsigned), and the real error is in the errno variable.
> 
> --
>                                             Gilles.
> 
> 
> This email and any attachment may contain confidential information which is intended for use only by the addressee(s) named above. If you received this email by mistake, please notify the sender immediately, and delete the email from your system. You are prohibited from copying, disseminating or otherwise using the email or any attachment.
> 

-- 
Philippe.



