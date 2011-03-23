Message-ID: <4D89BF75.1060500@domain.hid>
Date: Wed, 23 Mar 2011 10:37:57 +0100
From: Johann Obermayr <johann.obermayr@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] task switching logging
Reply-To: johann.obermayr@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

we use follow function to report task switching.
     rt_task_add_hook(T_HOOK_SWITCH, (void(*)(void*))taskSwitchXenomai);
     sched_info_install_switch_hook(taskSwitchLinux);

we does not get a hook callback for switch from gatekeeper to primary 
domain.

we have a shadow task running in primary. on some function it switch 
back to secondary.
if we switch back the task with rt_task_set_mode(0,T_PRIMARY).
we only see the switching to gatekeeper and not the switch to primary ?

Any solution ?

Xenomai 2.5.6, linux kernel 2.6.32.15. gcc 4.3.3


   Jimmy


