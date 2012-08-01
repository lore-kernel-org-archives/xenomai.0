Message-ID: <5018D02E.9010003@xenomai.org>
Date: Wed, 01 Aug 2012 08:43:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtcVT9s9FfTf5fHd=z=Cg9iBS4NCbd+aqD-53iXbHUjqOA@mail.gmail.com>
In-Reply-To: <CAKKWdtcVT9s9FfTf5fHd=z=Cg9iBS4NCbd+aqD-53iXbHUjqOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: scheduling2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: Xenomai@xenomai.org

On 08/01/2012 08:28 AM, ali hagigat wrote:

> If I have only one logical CPU and there is a real time Xenomai task
> (SCHED_RR or SCHED_FIFO) and the task is infinite , never leaves the
> Xenomai domain and never blocks. Does it mean that Linux, its
> scheduler and the Linux interrupt handling routines will never be
> executed?


In the context of xenomai, this is a bug, a real-time task should never
do that. Thus, if you have CONFIG_XENO_OPT_WATCHDOG enabled, the task
gets killed, you can find where the problem is, and resume working on
more interesting issues.

-- 
                                                                Gilles.

