Message-ID: <4AC6667E.10704@domain.hid>
Date: Fri, 02 Oct 2009 22:45:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AC61F57.2010404@domain.hid> <4AC62804.7090903@domain.hid>
	<4AC62B41.3050404@domain.hid> <4AC65172.8060900@domain.hid>
	<4AC65CEB.7080107@domain.hid> <4AC65F5A.7040307@domain.hid>
	<4AC65FFC.5040902@domain.hid> <4AC66211.3030204@domain.hid>
In-Reply-To: <4AC66211.3030204@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RTDM fd support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Then please summarize again what you want change from the user's POV (fd
> range and arbitration, I guess, but also their scope?)

Basically, when going from user-space to kernel-space, instead of a
simple translation, currently done with an addition in user-space for
most services, in kernel-space for select, there is a hash lookup, done
in kernel-space.

 and what impact
> that will have on the library and kernel ABIs.

The impact on the ABI is that we no longer do the translation using
addition/substraction. If we broke all at once in version 2.5.x, we
could not run a 2.5.x-1 user-space support that does the
addition/substraction, with a 2.5.x kernel-space support which has the
unified file descriptors abstraction.

 What would be part of
> step 1, what of step 2 later in 2.5.x?

Step 1 is adding the fdtable, use it in the rtdm and posix skin before
returning a fd to user-space, and when getting an fd from user-space.
Remove the translation by addition/substraction in the rtdm part of
libpthread_rt.

Step 2 is replacing the rtdm and posix registries with an unified fd
support based on the fdtable, the real kernel-space file descriptors (I
mean, the one which really belong to a kernel-space app) would be
implemented using a global fdtable. Duplicate the fdtable at fork, etc...

-- 
					    Gilles.

