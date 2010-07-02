Message-ID: <4C2DEF35.3000605@domain.hid>
Date: Fri, 02 Jul 2010 15:52:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
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
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Mauerer wrote:
> (This is the Xenomai part of the mechanism, please see the ipipe
>  mailing list for the patches that provide the required basis 
>  infrastructure)
> 
> This patch series extends Xenomai with a new clock, CLOCK_HOST_REALTIME.
> It allows for sharing NTP-corrected real time timestamps between
> Linux/ipipe and Xenomai. The data are also available in userspace and can
> be read without switching to kernel mode. Notice, however, that the new
> clock only enables to read to time, but cannot serve as a full time basis.
> Some changes to the ipipe layer are required as basis.
> 
> In contrast to the initial approach, we don't use a transactional mechanism
> to copy the information over from Linux, but use classical synchronisation.
> The code can be compiled in conditionally for both, ipipe and Xenomai. When
> disabled by architectures that don't support apt clock sources, there is
> no runtime-overhead associated with the feature.
> 
> Some points that may require further discussion:
> 
> - POSIX only specifies a few clock_ids, and these have already been
>   extended by the Linux kernel. We use the maximum id (16) for the new
>   clock, but it might also make sense to use 7 (CLOCK_MONOTONIC_COARSE+1)
>   or 4 (CLOCK_THREAD_CPUTIME_ID+1).
> 
> - The current implementation deals with x86_64's TSC. Support for other
>   architectures can be added. Additionally, the user has to make sure that
>   the TSC clock source remains active once selected.  To implement 
>   deactivation (e.g., when the Linux clock source is changed), more 
>   ipipe hooks would be required, though.
> 
>   There are two alternatives including other architectures:
> 
>   * We can create a new clocksource that abstracts the per-architecture
>     differences, and use this clocksource as basis for
>     Xenomai. Essentially, this means mapping all desired
>     non-x86-Clocksources to the interface offered in this patch.
>     This requires more changes in the ipipe layer than variant B, namely,
>   * We can create a union in struct xnvdso of all arch-specific clock
>     datasets and introduce feature flags like XNVDSO_FEAT_HOSTRT_X86,
>     XNVDSO_FEAT_HOSTRT_WHATEVER. The reader-side code then needs to
>     match the data provided, which requires more changes on the
>     Xenomai side.

The dataset is the same on all architectures, since we provide the same
"clocksource abstraction" on the 5 architectures we support: a TSC
emulation. So, a simple approach is simply cut-and-paste the x86
update_vsyscall code for other architectures, another approach is to put
this code in a wrapper which we call on all architectures.

This update_vsyscall code would call ipipe_dispatch_event to pass the
data to Xenomai.

-- 
					    Gilles.

