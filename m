From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17359.35617.906625.920464@domain.hid>
Date: Thu, 19 Jan 2006 13:50:41 +0100
Subject: Re: [Xenomai-core] Initialization of a nucleus pod
In-Reply-To: <47338.83.179.137.211.1137593134.squirrel@domain.hid>
References: <47338.83.179.137.211.1137593134.squirrel@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Germain Olivier <germain.olivier@domain.hid>
Cc: xenomai@xenomai.org

Germain Olivier wrote:
 > Hello
 > 
 > I am trying to understand how a pod is initialized.
 > 
 > I think it start with xncore_attach() from core.c, then with xnpod_init from
 > pod.c
 > But here (in xnpod_init) there is something not clear about the root thread
 > creation.
 > 
 > It use xnthread_init(&sched->rootcb, ...), but I don't see where
 > &sched->rootcb is initialized

xnthread_init does part of the initialization. The low level part of
rootcb (its xnarchtcb_t member) is initialized twice, first by the call
to xnarch_init_tcb in xnthread_init, and then overriden by
xnarch_init_root_tcb in xnpod_init.

For any other thread than root, the thread would be given a stack and
entry point by the call to xnarch_init_thread in xnpod_start_thread. But
the root thread is Xenomai idle task, a placeholder for whatever task
Linux is currenty running. At the time where xnpod_init is called, the
root thread is the current context, so already has a stack and is
already running.

-- 


					    Gilles Chanteperdrix.

