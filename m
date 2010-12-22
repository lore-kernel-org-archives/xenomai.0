Date: Wed, 22 Dec 2010 13:38:27 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1012221306370.10955@domain.hid>
Message-ID: <alpine.DEB.1.10.1012221336260.10955@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012221306370.10955@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
Reply-To: Kolja Waschk <xenoka09@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai GNA <xenomai@xenomai.org>

> Further investigation showed that (wrapped) pthread_cond_wait actually
> returns EPERM instead of waiting, but only when running with gdb(?)

I verified that all used mutexes and condition variables have been created
successfully and the ctx->mutex was just locked successfully by the thread
calling pthread_cond_wait. For some reason, GDB doesn't let me step further
into pthread_cond_wait so I cannot determine a good reason for EPERM.

Kolja



