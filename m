MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18489.29452.834191.596609@domain.hid>
Date: Sun, 25 May 2008 16:09:16 +0200
In-Reply-To: <4838AC7A.7030609@domain.hid>
References: <4838AC7A.7030609@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] rt_intr_wait takes 10ms
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Tomas Kalibera wrote:
 > 
 > Hi,
 > 
 > I've measured interrupt latencies using irqbench and extended it a bit 
 > to measure also latencies of a user space task that uses "rt_intr_wait", 
 > as opposed to the specialized ioctl call used presently by the benchmark.
 > 
 > I found out that when the call to rt_intr_wait does not block (there is 
 > already an interrupt pending), the latency is nice, i.e. 20us. However, 
 > when rt_intr_wait blocks, the latency is 10ms (the whole quantum).
 > 
 > I thought that once the interrupt arrives and the kernel space header 
 > signals the interrupt, the Xenomai scheduler should be invoked and 
 > should preempt any presently running thread and immediately wake up the 
 > thread blocked in rt_intr_wait. Is this correct ?
 > 
 > The thread blocked in rt_intr_wait had maximum priority (99) and was in 
 > primary mode.
 > 
 > Interestingly, when I run the original version of the irqbench 
 > benchmark, even the user space version (-t 0, default) that waits for 
 > the interrupt using the specialized ioctl call, had nice latencies about 
 > 20us. Any ideas why the rt_intr_wait does not behave equally well ?

Did you check the interrupts count returned by rt_intr_wait ? What else
do you do in the loop calling rt_intr_wait ? Do not you use special
features such as I_NO_AUTOENA ?

-- 


					    Gilles.

