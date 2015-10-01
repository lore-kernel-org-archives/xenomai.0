Date: Thu, 1 Oct 2015 13:03:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151001110344.GH31137@hermes.click-hack.org>
References: <CANWkrRN9Tyk7bzjdE1NOPA_otGf=Lyspo_CFb33SRgfN8++gYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANWkrRN9Tyk7bzjdE1NOPA_otGf=Lyspo_CFb33SRgfN8++gYQ@mail.gmail.com>
Subject: Re: [Xenomai] RTnet rtcfg thread creation issue (Xenomai 3.x)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Jul 21, 2015 at 08:58:59AM +0200, Michael Smith wrote:
> Hi I require RTNet for a project I am working on.
> Because of the previously reported rtcfg issue one of my RTNet nodes
> does net run start up correctly as the master.
> So I have spent some time in order to trace the issue in the code to find a
> solution, and have come up with a question and possible corrections on
> the existing code.
> 
> I have used Xenomai-3.0 rc5 as my code base.
> The symptoms on my system is that when running the RTNet script and
> setting up the system as
> a master the whole system locks up completely. I have traced this to
> the line in the RTNet script
> where the master is setup -> $RTCFG rteth0 server
> Then it traced the lockup to
> kernel/drivers/net/stack/rtcfg/rtcfg_event.c:151
> This is in function rtcfg_main_state_off() where the rtdm_task_init()
> is called. This thread creation
> call completely locks up the system.
> 
> I checked all the parameters in the call, and one parameter that was
> incorrect was the pointer to function  void rtcfg_timer(int ifindex)
> in kernel/drivers/net/stack/rtcfg/rtcfg_timer.c:35.
> According to the declaration of rtdm_task_init() its parameter
> task_proc is of type rtdm_task_proc_t which is declared as typedef
> void(* rtdm_task_proc_t) (void *arg). So I assume the correct function
> declaration in rtcfg_timer.c should rather be void rtcfg_timer(void *arg).
> 
> Changing this in the code didn't correct the problem. But then I had a
> look in the documentation and it specifies that rtdm_task_init()
> should be called in secondary mode only. I have placed a
> rtdm_in_rt_context() call before the rtdm_task_init() call and it
> reports that the context that the
> thread is running in just before calling the rtdm_task_init() is primary mode.
> My question is would this cause a lockup if you are trying to call
> rtdm_task_init() in primary mode?
> All the other parameters to the function seems fine, and I see no
> memory pointer or other issues that will cause this behavior.

Thanks for your report, rtdm_task_init called from primary mode was
indeed the problem. You can try a fixed version in xenomai-gch.git
branch for-forge.


-- 
					    Gilles.
https://click-hack.org

