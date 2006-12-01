Subject: Re: [Xenomai-core] libnative versioning
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45704CAB.5060502@domain.hid>
References: <45704CAB.5060502@domain.hid>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 17:56:43 +0100
Message-Id: <1164992204.4952.109.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2006-12-01 at 16:39 +0100, Jan Kiszka wrote:
> Hi,
> 
> we just had some fun here with incompatible native libraries. A program
> was built against some 2.2 release and was then started on a target with
> 2.3 libs installed. The result: undefined symbol rt_mutex_lock. The
> reason: this function was renamed to rt_mutex_acquire in trunk to
> resolve a naming conflict in recent kernels.
> 
> So we now have incompatible libraries and should either increment some
> version number of libnative or export the necessary aliases for
> lock/unlock. What is preferred?

The Xenomai ABI has been kept compatible between versions, so we want to
provide the proper aliases for user-space; the conflict is kernel-space
only, and there is no reason to ask user-space apps to conform to some
obscure change that took place within the vanilla kernel API. Actually,
I already wrappers in include/native/mutex.h, but unfortunately as
macros, so dynamic binding could not work. I'm fixing this. Thanks.

> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



