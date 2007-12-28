Message-ID: <47751992.9030302@domain.hid>
Date: Fri, 28 Dec 2007 16:43:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <477505A5.6070900@domain.hid>
In-Reply-To: <477505A5.6070900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] fastcall and asmlinkage in x86
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Hi Philippe,
> 
> most of the code in arch/x86/ipipe_*.c can be pushed into some
> ipipe-common.c, reducing the patch size by 10-20k and improving code
> maintainability.
>
> But one thing is currently blocking a copy&paste move: a lot of
> functions that are declared fastcall on 32 bit are asmlinkage on 64 bit.

2.4/x86 legacy that survived.

> As both asmlinkage and fastcall are meaningless on 64 bit, can we safely
> switch to fastcall?

Yes.

 Or even better, could we drop that redundant
> declarations totally, given that everything is fastcall on 32 bit anyway
> (unless its marked asmlinkage)?
> 

I see -mregparm=3 unconditionally set in arch/x86/Makefile_32, so this
should work. Looking at some assembly call sites (exception
handling/diversion) tends to confirm this; AFAIR we should not have any
regparm(0) code anywhere. Well, if we still do have some, you will be
the first to know...

-- 
Philippe.

