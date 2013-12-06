Message-ID: <52A194FB.9050304@xenomai.org>
Date: Fri, 06 Dec 2013 10:12:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <52A184EC.40407@axelsw.it>
In-Reply-To: <52A184EC.40407@axelsw.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Roberto Bielli <roberto.bielli@axelsw.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

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
>
> The system is in loop/hangs in rt_task_set_priority.
>
> My system has xenomai 2.5.6 on freescale imx25 arm.
>
> Any ideas ?
>

If changing the priority of a thread makes that thread preempt the 
caller of rt_task_set_priority(), before entering a tight loop 
indefinitely, you would see this behavior. Enabling 
CONFIG_XENO_OPT_WATCHDOG would likely detect such a case.

Typical bug: not properly handling return codes of Xenomai syscalls in 
real-time work loops, such as -EINVAL, -EIDRM, -EINTR or -ETIMEDOUT, 
causing the underlying thread to iterate indefinitely on the failing 
syscall.

-- 
Philippe.

