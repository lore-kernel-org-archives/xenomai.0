Message-ID: <4D8C6FED.7070408@domain.hid>
Date: Fri, 25 Mar 2011 11:35:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D89BF75.1060500@domain.hid>
In-Reply-To: <4D89BF75.1060500@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] task switching logging
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: johann.obermayr@domain.hid
Cc: xenomai@xenomai.org

Johann Obermayr wrote:
> Hello,
> 
> we use follow function to report task switching.
>      rt_task_add_hook(T_HOOK_SWITCH, (void(*)(void*))taskSwitchXenomai);
>      sched_info_install_switch_hook(taskSwitchLinux);
> 
> we does not get a hook callback for switch from gatekeeper to primary 
> domain.
> 
> we have a shadow task running in primary. on some function it switch 
> back to secondary.
> if we switch back the task with rt_task_set_mode(0,T_PRIMARY).
> we only see the switching to gatekeeper and not the switch to primary ?
> 
> Any solution ?
> 
> Xenomai 2.5.6, linux kernel 2.6.32.15. gcc 4.3.3

I am not sure I understand what you mean. Normally, with rt_task_hook,
the hook is called for all switches between Xenomai scheduler tasks.
So, when switching from secondary mode to primary mode, there should be
only one hook call: for the switch from "root thread", that is Linux, to
the real-time task itself. Are you sure this is not this call that you
are seeing?

-- 
					    Gilles.

