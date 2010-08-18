From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
In-Reply-To: <4C6BD403.4030902@domain.hid>
References: <1282047938.5255.89.camel@domain.hid>
	<4C6B146D.9010004@domain.hid>
	<1282126974.5255.262.camel@domain.hid>
	<4C6BBD62.3050907@domain.hid>
	<1282131617.5255.286.camel@domain.hid>
	<4C6BCB51.4010805@domain.hid>
	<1282133876.5255.296.camel@domain.hid>
	<4C6BD403.4030902@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 18 Aug 2010 14:55:47 +0200
Message-Id: <1282136147.5255.306.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2010-08-18 at 14:37 +0200, Gilles Chanteperdrix wrote:
> Krzysztof Błaszkowski wrote:
> >>> rather i use native clean x86 environment (on e.g. x86_64)
> >> I do this all the time, and never had any problem.
> > 
> > i had lots with header files mainly.
> 
> Well, the glibc and Xenomai header files are the same on 64 bits and 32
> bits machines... of course, if you are talking about other libs...


;) i don't mean Xenomai and degree of crosscompilation complexity
depends on what you try to compile.
i remember a few years ago it was not so funny.

> 
> > and i am happy with my way.
> > 
> >> Also, why not running 64 bits code on your atom? There are some x86_32
> >> only atoms? What about SMP?
> > 
> > for some other constraints i will not mention i use 32 bits now.
> > 
> > this is single core cpu so no point to use smp for e.g. 8 cpus (nor
> > bigsmp)
> 
> Well, my atom has hyper-threading, so, SMP can be used, Linux sees two
> threads. I suspect yours has hyper-threading too, since Linux mentions
> that it sees an ACPI SMP table, but usually, hyper-threading needs to be
> enabled at BIOS level.
> 

yes, it has "ht". disabled now. i thought that i don't want to try to
solve superposition of various corner cases and stuck on solving this.

otoh, i could create such case. did i ?

(btw, rtai 3.7 works)


-- 
Krzysztof Blaszkowski


