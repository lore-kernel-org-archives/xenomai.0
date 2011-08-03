Message-ID: <4E395528.5090409@domain.hid>
Date: Wed, 03 Aug 2011 16:03:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <509DA52866E38F47878413CF102D751FD4207794F0@domain.hid>	<1312370844.2135.10.camel@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F2@domain.hid>
	<4E394A78.7040408@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F8@domain.hid>
In-Reply-To: <509DA52866E38F47878413CF102D751FD4207794F8@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

On 08/03/2011 03:31 PM, Sambasiva Rao Manchili wrote:
> Hi Gilles,
> I had seen the code  in src\skins\vxworks\semLib.c it returns ERROR which is -1.
> 
> The value that I sent earlier is the value that I got out of the following statement.
> serrLog( serrErr,
>              "resu_getonline_1_svc: semTake for restab_access_smp failed!!<%s>",
>               strerror(errnoGet()));
> 
> Is it right ?

You want printErrno instead of strerror.

> 
> 
> Now again I tried with
>  serrLog( serrErr,
>              "resu_getonline_1_svc: semTake for restab_access_smp failed!!<%s> <%d>",
>               strerror(errnoGet()), errno);
> 
> Here I get value 1 for errno.

1 is EPERM. Is the thread issuing the call a thread created by Xenomai?

-- 
					    Gilles.

