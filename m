Message-ID: <52A1C10B.4010101@xenomai.org>
Date: Fri, 06 Dec 2013 13:20:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52A184EC.40407@axelsw.it>
In-Reply-To: <52A184EC.40407@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_set_priority hangs/loops sometimes on boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Bielli <roberto.bielli@axelsw.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/06/2013 09:03 AM, Roberto Bielli wrote:
> Hi,
> 
> sometimes i have a strange behaviour on boot. The kernel hangs. I saw 
> with an hardware debugger the backtrace when i was in that situation and 
> i saw this:
> 
> probe_irq_off | devm_free_irq
> probe_irq_on
> probe_irq_on
> register_handler_proc
> timecounter_read
> timer_list_show
> posix_cpu_timer_set
> stk5_esdhci_init
> load_module
> exit_irq_thread
> __setup_str_setup_slub_nomerge
> __setup_str_setup_slub_nomerge
> probe_irq_on
> probe_irq_on
> register_handler_proc
> __xnpod_schedule
> xnpipe_recv
> rt_task_set_priority

This backtrace does not seem to really make sense. Or maybe it is not a
backtrace?

> 
> The system is in loop/hangs in rt_task_set_priority.
> 
> My system has xenomai 2.5.6 on freescale imx25 arm.
> 
> Any ideas ?

Do you have the same issue with xenomai 2.6.3 ?


-- 
                                                                Gilles.

