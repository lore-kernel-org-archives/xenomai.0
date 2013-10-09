Message-ID: <3b559e148cf71d636e41b420b7476428.squirrel@127.0.0.1>
In-Reply-To: <CAKKWdtfW+p1twc63Z1t3AXQscNtCGMO0j0NUc9uqq4gXaCgfoA@mail.gmail.com>
References: <CAKKWdtfW+p1twc63Z1t3AXQscNtCGMO0j0NUc9uqq4gXaCgfoA@mail.gmail.com>
Date: Wed, 9 Oct 2013 12:51:42 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Watchdog timer does not function correctly
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org


ali hagigat wrote:
> I have installed xenomai-2.6.2.1 for linux-3.5.7 under Fedora 13 correctly
> and the Xenomai tests like,  "latency",  seem to work properly. I have
> written a application and have made it execute in the primary xenomai mode
> by rt_task_shadow and the timer mode is set in one shot=aperiodic.
> I have put the following instruction at the end of my C code:
>
> while(1);
>
> and I have only one real time application in user space. Watchdog timer
> facility has been enabled inside the kernel. but it does not kill the
> runaway process after 4 seconds!! that task continues to run. For the
> first
> 3 minutes when i use "PS axu" , it shows that CPU has been use over 70%.
> But the number will rise gradually so that it becomes 88%, even 100% and
> then suddenly, the system freezes and the screen is not updated and
> keyboard and other things seem not functioning.
>
> That was the first problem.

Please post the full code of the test application. The only reason I could
see for such a behaviour would be if the signal SIGXCPU is ignored, masked,
or its handler does not stop the program.

>
> Another problem is that before executing that real-time application, when
> i
> execute the regular Linux tasks like i run "make -j 16" for compiling the
> Linux kernel, system becomes not responsive much, for some minutes the
> keystrokes of the keyboard are not taken  till "make" finishes.
> What is the reason for that?
>
> That was the second problem.

I do not understand how this problem is related to Xenomai.

-- 
                                              Gilles


