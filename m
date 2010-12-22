Message-ID: <4D127B17.2080305@domain.hid>
Date: Wed, 22 Dec 2010 23:26:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>	<4D110810.1090504@domain.hid>	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012221306370.10955@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1012221306370.10955@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kolja Waschk <xenoka09@domain.hid>
Cc: Xenomai GNA <xenomai@xenomai.org>

Kolja Waschk wrote:
>>> Xenomai: watchdog triggered -- signaling runaway thread 'pfda'
> 
> The loop causing this is
> 
> 3870 while (ctx->sq_head == ctx->sq_tail && ctx->stop_flag == 0) {
> 3871   pthread_cond_wait(&ctx->sq_full, &ctx->mutex);
> 3872 }
> 
> Further investigation showed that (wrapped) pthread_cond_wait actually returns
> EPERM instead of waiting, but only when running with gdb(?)

This looks like an old bug. What version of Xenomai are you using?

-- 
                                                                Gilles.

