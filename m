From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=7M-cqps4b--i6Kud3o6-awuntk2Zpwj7JHZ8a@domain.hid>
References: <AANLkTi=7M-cqps4b--i6Kud3o6-awuntk2Zpwj7JHZ8a@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 Jan 2011 11:32:13 +0100
Message-ID: <1296469933.2214.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Is xenomai OK for early boot purpose ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gryma biloy <gryma.biloy@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2011-01-31 at 09:55 +0100, gryma biloy wrote:
> Hello,
> 
> On a project running Linux on a beagle board, I'd like to add the
> following capabilities to my platform :
>   - real time processes with periodic tasks (10ms, 100ms & 200 ms) and
> a low jitter (< 50 us)

Kernel space apps then, likely. Userland apps (the recommended way)
probably have a larger worst-case jitter on this hardware, albeit still
below 100 us. Gilles?

>   - early boot operations (i.e. being able to perform some tasks asap
> after a power on reset)
> 
> I've searched for solutions over the net and Xenomai seems to be a
> possible candidate to fulfill
> these constraints. Can you please share your knowledge to confirm that
> Xenomai would make
> the job (especially on the early boot side) ?
> 

I don't see how Xenomai could directly help in any way for the early
boot goal. If you question is about whether Xenomai initializes fast
enough, and early enough during the linux boot process for kicking rt
applications as soon as possible, then the answer is yes, that should
do.

> Also, I don't have a clear understanding of Xenomai availability
> during the Linux kernel startup.
> If a statically link Xenomai to the kernel, when would it be operational ?
> 

When built statically into the kernel, Xenomai initializes along with
the linux drivers. So once this init stage is passed, Xenomai is up and
running, ready to run applications.

> Thanks a lot for your help,
> 
> --
> Gryma
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



