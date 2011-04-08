Message-ID: <4D9EAC97.4090307@domain.hid>
Date: Fri, 08 Apr 2011 08:35:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110407170855.GA22659@domain.hid>
	<4D9E0354.4010600@domain.hid>
In-Reply-To: <4D9E0354.4010600@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Adeos-main] ARM IXP: ipipe regression from
 2.6.31 to .33 and .35
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> Richard Cochran wrote:
>> I have been trying to bring my IXP425 based system up to date, and I
>> have found an apparent regression. Everything worked fine with ipipe
>> 2.6.30 and Xenomai 2.4. With 2.6.31 an ipipe kernel still boots, but
>> starting with 2.6.33 the trouble begins (see below).
>>
>> I see that Gilles refactored the TSC emulation starting with
>> 2.6.33. I wonder whether this could be the cause?
> 
> What this modification does is that:
> - there is only one clocksource, which is now xenomai tsc, with a very
> high rating;
> - the tsc read code is written in assembly, and copied in the vectors
> page, the one at 0xffff0000.
> 
> I think the ixp is a 32 bits free-running counter with match register,
> wich is a configuration I tested. So, I would tend to think that the
> issue is rather in the clock_events implementation.

Just to explain a little further about this modification. The reasons
for this refactoring are:
- the TSC emulation code is factored, so that when porting to a new
port, we avoid copy-pasting the TSC emulation;
- it is written in assembly, because even for such a simple thing, I was
unable to get gcc to generate optimal code without useless register moves;
- it is ready for multi-SOCs kernels (all the TSC emulations are
compiled-in, the one chosen is copied to the vectors page when the
ipipe_tsc_register function is called). This is the direction ARM linux
is going, if you followed the ARM wrestling on the linux-arm-kernel
mailing list.
- the Linux clocksource code also uses this TSC, this keeps it in cache,
and gets us ready for hostrt (actually, hostrt is already there on ARM,
what is missing is just the equivalent of the code that was sent to the
ARM mailing list for x86_32).
- and most of all, this implementation is in the vector page, so is
available to user-space applications. This means that Xenomai user-space
support can be compiled without any knowledge of the actual TSC
involved. IOW, it means that Xenomai user-space support compiled with
--enable-arm-mach=generic (which is going to be the default) can use TSC
emulation..

-- 
                                                                Gilles.

