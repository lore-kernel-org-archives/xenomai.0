From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100923095230.B712AB7480C@mail3-117.sinamail.sina.com.cn>
References: <20100923095230.B712AB7480C@mail3-117.sinamail.sina.com.cn>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Sep 2010 14:33:57 +0200
Message-ID: <1285245237.1661.137.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help]
 =?utf-8?b?5Zue5aSN77yaUmU6IOWbnuWkje+8mlJlOiBIb3cg?=
 =?utf-8?q?to_add_=22t=5Frestart=22_to_pSoS_emulator?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gwysu@domain.hid
Cc: Xenomai-help <Xenomai-help@domain.hid>

On Thu, 2010-09-23 at 17:52 +0800, gwysu@domain.hid wrote:
> Thank you Philippe very much. I am working on porting our pSoS code to
> xenomai. There are many syscall "t_restart" in our code. The case is
> not like what you mentioned. Let me give a example to illustrate our
> case:
> 
> Task A create and start Task B with parameter "X", then Task B run and
> suspend when its parameter is "X". At rigth time, Task A restart Task
> B with parameter "Y", the Task will re-run with a new parameter "Y"
> and won't suspend.

I still don't see the requirement for t_restart() in your description.
Task A doing t_delete(task B), then t_create(task B) + t_start(task B,
param=X or Y) would behave exactly the same way AFAICS. Again, the only
feature that t_restart() buys you is forcibly unblocking a task from a
pending state, at the expense of branching back to its entry point. Task
B does not seem to pend on anything, it is merely suspended, and only
waits for task A for resetting it. I see no difference with
self-deletion followed by a respawn.

> 
>  
> 
> I just don't want to modify the code and want to implement the syscall
> "restart" to make the porting smoothly. 
> 
> 

t_restart() has non-trivial semantics for user-space threads. Trying to
emulate it may cost more than getting rid of it, unless you are ready to
invest some time to make your way through Xenomai's innards. YMMV.

>  
> 
> Best regards
> 
> Wenyi Gao 
> 
> 

-- 
Philippe.



