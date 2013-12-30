Message-ID: <52C1EFD6.2080404@zultron.com>
Date: Mon, 30 Dec 2013 16:12:38 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <52BF6547.5050204@zultron.com> <52BFF400.8040406@xenomai.org>
In-Reply-To: <52BFF400.8040406@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel oops:  x86 arch, Xenomai 2.6.3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 12/29/2013 04:05 AM, Gilles Chanteperdrix wrote:
> On 12/29/2013 12:56 AM, John Morris wrote:
>> Updated RPMS, Xenomai 2.6.3 and Linux 3.8.13, crash on most tested
>> platforms (Fedora 18/19 & EL6 32-bit, but strangely not EL6 64-bit).  In
>> some cases the crash occurs during boot.  In the pasted example [1] (EL6
>> 32-bit), the crash occurred after starting a Xenomai application (LinuxCNC).
>>
>> Xenomai package [9] updates:
>> - Update Xenomai from 2.6.2.1 to 2.6.3
>> - _FORTIFY_SOURCE=2 flag re-enabled
>>   (see prev. discussion [2,3]; Gilles indicated this has been fixed)
>> - --enable-dlopen-skins removed ("WARNING: unrecognized option")
>> - devel package follows Debian:  use prepare-kernel.sh instead of
>>   prepare-patch.sh
>>
>> Kernel package [4] updates:
>> - (Package was rebased on top of elrepo.org packages)
>> - Update Linux from 3.5.7 to 3.8.13
>> - Base .config from Fedora ~3.8.13 kernel
>>   - added a few missing answers [5,6]
>> - Xenomai .config 'overrides' unchanged [7,8]

Hi Gilles,

I neglected to mention the above kernels are all running in KVM, not on
bare metal.

> just tried your .config, I can not reproduce your crash. LOCKDEP
> complains about hardirqs being on in the timer interrupt, but once
> LOCKDEP is disabled (which involves disabling several options), the
> system runs fine. Someone would have to check to see if it is a false
> positive (i.e. LOCKDEP using the hardware interrupt mask instead of the
> I-pipe virtualized interrupt mask), or if it is a real bug. It is highly
> suspicious since the bug in slub.c since to be triggered by a similar
> condition (irqs being on in a place where they should not).

Disabling DEBUG_KERNEL was all that was needed in the Fedora .config to
disable LOCKDEP.  Is that different from what you expected?

> In the mean time, could you try and enable the I-pipe tracer with the
> "freeze on panic" option, increase the number of backtrace points, and
> try and trigger the bug again?

Here's a trace on Fedora 19 32-bit:

http://pastebin.ca/2520565

>> [7] https://github.com/zultron/kernel-rt-rpm/blob/master/config-xenomai-i686
> 
> Just had a look at that, you can now remove:
> - the SMI related stuff as SMI are now configured at run-time
> - the gpio-pch stuff, as the missing EXPORT_SYMBOL has been added
> 
> The problem with CONFIG_CPUMASK_OFFSTACK can probably be fixed (we
> simply have to use set_cpus_allowed_ptr instead of set_cpus_allowed),
> though I do not know if enabling CONFIG_MAXSMP with Xenomai makes any
> sense anyway.

Thanks for the review.  SMI and GPIO_PCH removed here:

https://github.com/zultron/kernel-rt-rpm/commit/ae08d8a651496134dc415fe7b0bcb6519ff148f3

>> Although nobody but me runs Xenomai on Red Hat, these .configs and
>> packaging scripts will be the basis for updating the Debian packages;
>> therefore, solving these issues is more valuable than it seems.  ;)  >
> Thanks!
> 
> The problem probably has nothing to do with Red Hat. By the way, a patch
> integrating the Red Hat "rules" to Xenomai would be welcome. This would
> allow users to build Red Hat packages from Xenomai sources from the
> repository.

Gladly.  I'll send a patch once the 'xenomai' service systemd scripts
for Fedora are integrated.

	John

