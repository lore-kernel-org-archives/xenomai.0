Message-ID: <4E8AEB1D.2060706@domain.hid>
Date: Tue, 04 Oct 2011 13:16:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGc_wL0GYwEPJVMOBR_niJCd9bz2VWoTA7-q-MLOAR_WW2vm2g@domain.hid>
In-Reply-To: <CAGc_wL0GYwEPJVMOBR_niJCd9bz2VWoTA7-q-MLOAR_WW2vm2g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel configuration suggestions/hints
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Julien Delange <julien.delange@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 10/04/2011 10:42 AM, Julien Delange wrote:
> Dear all,
> 
> I am currently building a customized kernel to build a real-time
> application. At this time, the requirement is very basic : I have one
> periodic task in userland that acquires data from an analogy card
> (ni6071e) with a 1ms period/deadline. At that time, the task miss one
> deadline at each period, meaning that the code is executed in 2ms
> instead of 1ms (and so, the deadline expires). So, I configured my
> kernel without power management and with a timer at 1000Hz and a
> tickless system (see variables below). However I would like to know if
> there are other relevant configuration parameters that may influence
> the scheduling of xenomai tasks so that I can make sure that my
> application meets its requirements. If anyone has a feedback about
> kernel configuration in that scope, it might be really useful ! In
> addition, depending on your answer, it may be also good to report good
> practices about the kernel configuration on the wiki, what do you
> think about it ?
> 
> Thanks for any suggestion,
> 
> Kernel configuration variables:
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_PREEMPT=y
> CONFIG_HZ_1000=y
> CONFIG_HZ=1000
> CONFIG_PM is not set
> CONFIG_SFI is not set
> CONFIG_CPU_FREQ is not set
> CONFIG_CPU_IDLE is not set

I am sorry, I do not really understand what you are doing, what has
CONFIG_HZ to do with your issue?

Could you post a self-contained example allowing to reproduce the issue
you observe?

-- 
                                                                Gilles.

