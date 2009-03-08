Message-ID: <49B3CAFF.6090406@domain.hid>
Date: Sun, 08 Mar 2009 14:41:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49B3A126.6000602@domain.hid>
In-Reply-To: <49B3A126.6000602@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Watchdog / immediate Linux signal delivery
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

Jan Kiszka wrote:
> Linux (e.g. via xnpod_suspend_thread(<cpu-hog>). Unfortunately, there is
> no way to force a shadow thread into secondary mode to handle pending
> Linux signals unless that thread issues a syscall once in a while. And
> that raises the question if we shouldn't improve this as well while we
> are on it.
> 
> Granted, non-broken Xenomai user space threads always issue frequent
> syscalls, otherwise the system would starve (and the watchdog would come
> around). On the other hand, delaying signals till syscall prologues is
> different from plain Linux behaviour...
> 
> Comments, ideas?

We discussed the issue of having a way to force threads to relax with
Philippe, and we both had patches to make this work. However, the issue
we recently had with the emulated iret on x86 makes me think that we can
not relax at any point in time, the code surrounding the relax has to be
made to allow a relax to occur.

-- 
					    Gilles.

