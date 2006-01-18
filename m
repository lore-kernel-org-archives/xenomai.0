Message-ID: <47338.83.179.137.211.1137593134.squirrel@domain.hid>
Date: Wed, 18 Jan 2006 15:05:34 +0100 (CET)
From: "Germain Olivier" <germain.olivier@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-core] Initialization of a nucleus pod
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello

I am trying to understand how a pod is initialized.

I think it start with xncore_attach() from core.c, then with xnpod_init from
pod.c
But here (in xnpod_init) there is something not clear about the root thread
creation.

It use xnthread_init(&sched->rootcb, ...), but I don't see where
&sched->rootcb is initialized

Maybe I don't understand how it works, so the pod don't have his own code
to run, but this thread will be in fact replaced by the task to run.

I hope my question is clear enough

Thank

Germain

