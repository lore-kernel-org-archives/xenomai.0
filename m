Subject: Re: [Xenomai-core] Suggestions for the vxWorks skins
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200610202221.49664.niklaus.giger@domain.hid>
References: <200610202221.49664.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 00:00:49 +0200
Message-Id: <1161381649.4988.141.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2006-10-20 at 22:21 +0200, Niklaus Giger wrote:
> Hi
> 
> As I am trying to debug startup failures of a thirs party C++-library, I 
> stumbled about the fact that the /proc/xenomai/registry/ only listed 
> semaphores and not tasks.
> 

Actually, the lack of task information under the registry tree is
historically due to the existence of /proc/xenomai/{sched,stat}. This
said, I agree that this would also make sense to provide task-related
entries into the registry, since some task attributes one would want to
know about are skin-specific, and could not be exported as part of the
generic information available from the sched/stat entries.

> My co-workers would appreciate to have some equivalents to vxWorks "i" 
> or "semShow" routines, as they come often very handy to debug problems, I was 
> thinking about how to improve the situation.
> 
> One approach could be:
> a) Instead of calling semShow for each semaphore 
> do "cat /proc/xenomai/registry/semaphores/*". The information therein is 
> already useful. The attached patch only modifies the output to include the 
> name of the semaphore. In the future it would be nice to show also the owner 
> of a mutex. 
> 
> b) The "i" procedure of vxworks could be replaced 
> by "cat /proc/xenomai/registry/tasks/*". 

Likely /proc/xenomai/registry/vxworks/tasks/*.

> 
> With the attached patch I just show the name of the task. 
> 
> If nobody opposes I would like to extend the interface to provide at least the 
> same information as under vxWorks (entrypoint, priority, status, program 
> counter, errno, delay).
> 

I would definitely merge that. Xenomai is very much about helping
traditional RTOS users to move smoothly to Linux, so this feature would
likely be desirable.

> Would it be difficult/desirable to include the amount of free stack space?

Not difficult, but the problem I'd see, is that an application usually
crashes before one manage to ask for this information to be displayed.
IOW, you would be already toast before the information gives you any
value.

> Would it be difficult/desirable to include the name of the vxworks semaphores 
> a vx task is holding? Together with point a) one could easyly detect lock 
> ups.

Mm, depends on the overhead tracking them safely.

> 
> Best regards
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



