Message-ID: <4E92B7AC.8040502@domain.hid>
Date: Mon, 10 Oct 2011 11:15:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
	<4E8F1643.1050700@domain.hid>
	<CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
	<4E8F2CFA.1070306@domain.hid>
	<CACFV95LX8U8U=UW6EicEjRYSjToSmL9-PPVf=n16GfKW9pLsPg@domain.hid>
	<4E907256.1010707@domain.hid>
	<CACFV95KWbC_ehmHqrh+E_dTfeMzvOabFSNLYe6LDvRWG-_V+6w@domain.hid>
In-Reply-To: <CACFV95KWbC_ehmHqrh+E_dTfeMzvOabFSNLYe6LDvRWG-_V+6w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai: /dev/rtheap is missing (chardev,
 major=10 minor=254) in mini2440
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Cc: xenomai@xenomai.org

On 10/10/2011 10:45 AM, Siva kumar Balasubramanian wrote:
> I am using xenomai-2.5.6.
> 
> When i tried with xenomai-2.6.0-rc1 with kernel-2.6.37.6. It gets error
> during kernel compilation
> 
> Which kernel and xenomai version is working in mini2440
> 
> I tried vanilla kernel 2.6.35.9 with mini2440_defconfig , i am getting error
> while booting
> 
>  Log file of error http://pastebin.com/L2mffkym

The only non-working version is kernel 2.6.37 (and later) with xenomai
2.5.6. Please try 2.6.0-rc4 instead of -rc1. However, I am surprised
that the kernel does not build with the 2.6.37 patch, as I build-tested
it. Could you put the compilation logs on a pastebin?

The error you have with 2.6.35.9 does not seem to be related to xenomai.

-- 
					    Gilles.

