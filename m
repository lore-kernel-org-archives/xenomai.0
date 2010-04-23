From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B9A5CDA.7080704@domain.hid>
References: <4B9A5CDA.7080704@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Apr 2010 13:04:28 +0200
Message-ID: <1272020668.9515.763.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] KVM over Xenomai and I-pipe
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

On Fri, 2010-03-12 at 16:25 +0100, Jan Kiszka wrote:
> Hi,
> 
> this is still in the state "study", but it is working fairly nicely so far:
> 
> These two patches harden latest KVM for use over I-pipe kernels and make
> Xenomai aware of the lazy host state restoring that KVM uses for
> performance reasons. The latter basically means calling the sched-out
> notifier that KVM registers with the kernel when switching from a Linux
> task to some shadow. This is safe in all recent versions of KVM and
> still gives nice KVM performance (that of KVM before 2.6.32) without
> significant impact on the RT latency (Note: if you have an old VT-x CPU,
> guest-issued wbinvd will ruin RT as it is not intercepted by the hardware!).
> 
> To test it, you need to apply the kernel patch on top of current kvm.git
> master [1], obtain kvm-kmod.git [2], run configure on it (assuming your
> host kernel is a Xenomai one, otherwise use --kerneldir) and then "make
> sync-kmod LINUX=/path/to/kvm.git". After a final make && make install,
> you will have recent kvm modules that are I-pipe aware. The Xenomai
> patch simply appies to the 2.5 tree. This has been tested with
> ipipe-2.6.32-x86-2.6-01 + [3] and Xenomai-2.5 git.
> 
> Feedback welcome, specifically if you think it's worth integrating both
> patches into upstream. The kernel bits would make sense over some
> 2.6.33-x86, but additional work will be required to account for the
> user-return notifiers introduced with that release (kvm-kmod currently
> wraps them away for older kernels).

No concern on the final goal, running a Xenomai-enabled kernel
rock-solid over KVM is a must.

The KVM code ironing from the 1st patch looks fine to me, no big deal to
maintain AFAICS. I would be only concerned by the 2nd patch,
specifically how the KVM callout is invoked from the Xenomai context
switching code:

- depending on CONFIG_PREEMPT_NOTIFIERS is much broader than required; I
guess that CONFIG_KVM would be enough.

- calling the KVM callout directly instead of going through the notifier
list would be more acceptable, so that we don't assume anything from the
non-KVM hooks (whether they exist or not), albeit we may assume that we
have complete information about which KVM callout has to be run for a
particular kernel version.

But again, rock-solid KVM+Xenomai is a much desirable feature.

> 
> Jan
> 
> [1]git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> [2]git://git.kernel.org/pub/scm/virt/kvm/kvm-kmod.git
> [3]http://git.kiszka.org/?p=ipipe-2.6.git;a=commitdiff;h=0bddff1716aba6dd5ca11627ee377a5a25fa3dae
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.



