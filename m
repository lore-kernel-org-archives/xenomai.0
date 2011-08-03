Message-ID: <4E394A78.7040408@domain.hid>
Date: Wed, 03 Aug 2011 15:17:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <509DA52866E38F47878413CF102D751FD4207794F0@domain.hid>	<1312370844.2135.10.camel@domain.hid>
	<509DA52866E38F47878413CF102D751FD4207794F2@domain.hid>
In-Reply-To: <509DA52866E38F47878413CF102D751FD4207794F2@domain.hid>
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

On 08/03/2011 02:44 PM, Sambasiva Rao Manchili wrote:
> Hi Philppe,
> Failed and return with error code is  <Unknown error 4294967295> and continues. I do not know the granularity of time  here, if it is returning immediately or not.
> We have about 15 tasks spawned in this whole system. Done very very minimal changes to our VxWorks code to run on Linux over Xenomai version 2.5.6.   Board does not crash.
> CPU Platform is Intel x86 Arch 32 Bit.

semTake does not return error code directly, it returns ERROR (which is
-1, or 4294967295 if you cast to unsigned), and the real error is in the
errno variable.

-- 
					    Gilles.

