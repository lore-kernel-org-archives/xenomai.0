Message-ID: <4C2DFEDF.3030606@domain.hid>
Date: Fri, 02 Jul 2010 16:59:43 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
	<4C2DEF35.3000605@domain.hid>
In-Reply-To: <4C2DEF35.3000605@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 0/7] Host realtime clock support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Mauerer wrote:
>> (This is the Xenomai part of the mechanism, please see the ipipe
>>  mailing list for the patches that provide the required basis 
>>  infrastructure)
>>
>> This patch series extends Xenomai with a new clock, CLOCK_HOST_REALTIME.
>> It allows for sharing NTP-corrected real time timestamps between
>> Linux/ipipe and Xenomai. The data are also available in userspace and can
>> be read without switching to kernel mode. Notice, however, that the new
>> clock only enables to read to time, but cannot serve as a full time basis.
>> Some changes to the ipipe layer are required as basis.
>>
>> In contrast to the initial approach, we don't use a transactional mechanism
>> to copy the information over from Linux, but use classical synchronisation.
>> The code can be compiled in conditionally for both, ipipe and Xenomai. When
>> disabled by architectures that don't support apt clock sources, there is
>> no runtime-overhead associated with the feature.
>>
>> Some points that may require further discussion:
>>
>> - POSIX only specifies a few clock_ids, and these have already been
>>   extended by the Linux kernel. We use the maximum id (16) for the new
>>   clock, but it might also make sense to use 7 (CLOCK_MONOTONIC_COARSE+1)
>>   or 4 (CLOCK_THREAD_CPUTIME_ID+1).
>>
>> - The current implementation deals with x86_64's TSC. Support for other
>>   architectures can be added. Additionally, the user has to make sure that
>>   the TSC clock source remains active once selected.  To implement 
>>   deactivation (e.g., when the Linux clock source is changed), more 
>>   ipipe hooks would be required, though.
>>
>>   There are two alternatives including other architectures:
>>
>>   * We can create a new clocksource that abstracts the per-architecture
>>     differences, and use this clocksource as basis for
>>     Xenomai. Essentially, this means mapping all desired
>>     non-x86-Clocksources to the interface offered in this patch.
>>     This requires more changes in the ipipe layer than variant B, namely,
>>   * We can create a union in struct xnvdso of all arch-specific clock
>>     datasets and introduce feature flags like XNVDSO_FEAT_HOSTRT_X86,
>>     XNVDSO_FEAT_HOSTRT_WHATEVER. The reader-side code then needs to
>>     match the data provided, which requires more changes on the
>>     Xenomai side.
> 
> The dataset is the same on all architectures, since we provide the same
> "clocksource abstraction" on the 5 architectures we support: a TSC
> emulation. So, a simple approach is simply cut-and-paste the x86
> update_vsyscall code for other architectures, another approach is to put
> this code in a wrapper which we call on all architectures.

this disables the possibility of using non-TSC time sources that
can also be accessed from userland. That's certainly not a requirement
for us, I'd just like to mention it.

We also need to ensure that the host has not switched away from TSC
because in this case, the NTP correction values delivered from Linux
are for a different clocksource than the one used by Xenomai.
So we need to detect a switch from TSC to non-TSC, which can only be
done in arch-specific code -- I don't see a generic way to know which
clocksources are based on the TSC and which one are not.
> 
> This update_vsyscall code would call ipipe_dispatch_event to pass the
> data to Xenomai.
> 
okay. That seems to have dropped from my radar, as I don't recall having
any issues with this requirement.

Regards, Wolfgang

