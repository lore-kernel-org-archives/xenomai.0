MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18427.6136.345161.941487@domain.hid>
Date: Tue, 8 Apr 2008 09:00:08 +0200
In-Reply-To: <a7575bba0804072345r40957042u51c37bb3e79de4a1@domain.hid>
References: <a7575bba0804010328v43bbc606oe1d0a26f7ea12be8@domain.hid>
	<47F22E76.5020009@domain.hid>
	<a7575bba0804072345r40957042u51c37bb3e79de4a1@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] When do I need to
	add	local_irq_disable_hw/local_irq_enable_hw in root domain?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Josh Zhao <joshsystem@domain.hid>
Cc: adeos-main@gna.org, rpm@xenomai.org

Josh Zhao wrote:
 > Thanks,Philippe Gerum
 >      Well, I have another question:
 >       1.  Why I need take over the  linux syscall ,I think that it is only
 > for linux domain,so it looks no necessary to take over them?

This allows non root domain to use (part of) Linux syscall path. The
fact that Xenomai takes over Linux syscall path is what makes user-space
real-time possible.

 >       2. kernel/exit.c        ipipe_exit_notify(tsk);
 >     When a process exits, why adeos  has to take  over it ?

This allows non root domain to run per-process cleanups. Xenomai uses it
to destroy per-process objects and so gains a little comfort. You no
longer have to take care to intercept process termination and run
process cleanups, Xenomai does it automatically.

-- 


					    Gilles.

