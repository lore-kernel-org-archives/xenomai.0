Message-ID: <4D110810.1090504@domain.hid>
Date: Tue, 21 Dec 2010 21:03:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
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
To: xenoka09@domain.hid
Cc: Xenomai GNA <xenomai@xenomai.org>

Kolja Waschk wrote:
> Hi,
> 
> thanks for the quick response regarding the irritating warning.
> 
> My next problem appears while debugging an application on a Blackfin target
> with gdbserver + gdb. Debugging hangs when the first rt_task_create is reached.
> 
> Starting in my application:
> 
> 153     int prio = T_HIPRIO/2;
> 154     int r = rt_task_create(&thread, thread_name.c_str(), 128*1024, prio, T_FPU|T_JOINABLE);

Is there any trace on the serial console?


-- 
                                                                Gilles.

