Message-ID: <48C3F669.2020405@domain.hid>
Date: Sun, 07 Sep 2008 17:42:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <785469.16674.qm@domain.hid>
In-Reply-To: <785469.16674.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Start Xenomai User-Space Task as Service
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: yasser_kashfi@domain.hid
Cc: xenomai@xenomai.org

Yasser Kashfi wrote:
> Hi everyone,
> 
> I have a problem with xenomai user-space task. I write a very simple
> xenomai user-space task with one real-time thread, and try to start
> it as service.

What does "start as a service" mean?


> I do it properly. but when change this program with
> another xenomai user-space task with 10 real-time threads and some
> FIFO, queue, ... ; the task can not start and fail.

What do you mean it fails? What function call returns what return value?

> also this problem
> appear when system reboot and try to stop this task.

What problem? Obviously it is not the "service" which does not start,
so, what is it ?

> although when
> system is up and I run (service my-service [start/stop]) it work
> without any problem.
> 
> I glad to see your comments. Best regards.

To really help you we need more than this mail. The program which fails,
any log, any oops ?

-- 
					    Gilles.

