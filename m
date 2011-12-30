Message-ID: <4EFCFF53.7040508@domain.hid>
Date: Fri, 30 Dec 2011 01:01:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C3860BCA25804175ABD53E2F2B1A942A@TerryHP>
In-Reply-To: <C3860BCA25804175ABD53E2F2B1A942A@TerryHP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mode switches??
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 12/29/2011 10:43 PM, Terry Fryar wrote:
> Using 2.6.0, I am have trouble understanding the results of the
> rt_task_info() call?
>  
> Have a very simple kernel module that fires off an ISR routine and a xenomai
> task.  The IRQ is not firing for these tests, so it's not doing anything.
> Here's the xenomai rt task created using rt_create_task():
>  
> void irqdrv_task(void *args)
> {
>     while (!irqdrv_terminated)
>      {
>           rt_task_sleep(10000000);
>      }
> }
>  
> So, in the driver "exit" code, right before I delete this task I do a
> rt_task_info() and I see no context switches and very little exec time for
> this task.  However, it's showing 1,000,000 mode switches in just 5 or 10
> seconds of exec time??
>  
> The info.modeswitches is the number of times the task switches between
> primary and secondary mode, yes??  Why in the world are there so many for a
> small task doing nothing but call a xenomai function, and in a kernel driver
> to boot!!
>  
> Am I missing something here....shouldn't mode switches be zero???  I'm not
> calling any linux kernel functions...it shouldn't have switched ever??

mode switches do not exist for kernel-space tasks. So, reading the
modeswitch member of the task info structure for a kernel space task
does not really make sense. Which is why probably nobody else noticed
(that, and the fact that the native API in kernel-space is not very much
in use, these days).

-- 
                                                                Gilles.

