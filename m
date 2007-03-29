Message-ID: <90a126800703290413n5c7f01fbm5a7e293cb487fa1c@domain.hid>
Date: Thu, 29 Mar 2007 16:43:50 +0530
From: "Andrew Xeno" <andrew.xeno@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11478_12368500.1175166830977"
Subject: [Xenomai-core] Few questions xenomai schedule, for porting Therad,
	TCB for MIPS 4KeC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_11478_12368500.1175166830977
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello All,
This is my first mail on Xenomai, earIier I posted my messages on ADEOS
forum regarding IPIPE-1.0.5 porting on MIPS. Recently I started porting
Xenomai for the same architecture  and could do some work related to
1. Xenomai Intialization of ROOT task
2. Timer and Interrupt related code.
3. XENO_SYSCALLS.
4. Trap Handlers
The Code changes are done considering MIPS 4KeC

Now
I could define Architecture related Task control block(TCB) user task,
active task, stack elements with inthe xnarchtcb_t.

Currently I am facing problem in creating and starting the task. After
understanding code flow, i could see that
Correct me if I am wrong!!!
1. When user calls "rt_task_create", the task state is defined as,
XNDORMANT, XNRELAX, XNSHADOW.
2. When user calls "rt_task_start", since the RTTASK being XNSHADOW,
xnpod_start_thread calls xnshadow_start and inturn resume which will remove
the task from the DORMANT state, however the XNRELAX state remains. This
makes sched->Ready queue being emptty. Later when xnpod_schedule is called,
since thread is not in the Ready queue and still remains in the RELAX mode,
xnpod_schedule exits from the context of "goto signal_unlock_and_exit;"
.Therefore this makes that my body of the new task not being executed.

Also I don't even see my "xnarch_init_thread" being called to intialize
startup functions for the new task. May I know when exactly this function is
called for the first newly created task.

I don't know where I am going wrong, few hints about xnpod_schedule on First
task creation will help me in verifying and debugging of my context swicth
code written fro this Architecture.

Regards
Andrew( Subbu)

------=_Part_11478_12368500.1175166830977
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello All,<br>This is my first mail on Xenomai, earIier I posted my messages on ADEOS forum regarding IPIPE-1.0.5 porting on MIPS. Recently I started porting Xenomai for the same architecture&nbsp; and could do some work related to 
<br>1. Xenomai Intialization of ROOT task<br>2. Timer and Interrupt related code.<br>3. XENO_SYSCALLS.<br>4. Trap Handlers<br>The Code changes are done considering MIPS 4KeC<br><br>Now<br>I could define Architecture related Task control block(TCB) user task, active task, stack elements with inthe xnarchtcb_t.
<br><br>Currently I am facing problem in creating and starting the task. After understanding code flow, i could see that<br>Correct me if I am wrong!!!<br>1. When user calls &quot;rt_task_create&quot;, the task state is defined as, XNDORMANT, XNRELAX, XNSHADOW.
<br>2. When user calls &quot;rt_task_start&quot;, since the RTTASK being XNSHADOW, xnpod_start_thread calls xnshadow_start and inturn resume which will remove the task from the DORMANT state, however the XNRELAX state remains. This makes sched-&gt;Ready queue being emptty. Later when xnpod_schedule is called, since thread is not in the Ready queue and still remains in the RELAX mode, xnpod_schedule exits from the context of &quot;goto signal_unlock_and_exit;&quot; .Therefore this makes that my body of the new task not being executed.
<br><br>Also I don&#39;t even see my &quot;xnarch_init_thread&quot; being called to intialize startup functions for the new task. May I know when exactly this function is called for the first newly created task.<br><br>I don&#39;t know where I am going wrong, few hints about xnpod_schedule on First task creation will help me in verifying and debugging of my context swicth code written fro this Architecture.
<br><br>Regards<br>Andrew( Subbu)<br><br><br><br><br>

------=_Part_11478_12368500.1175166830977--

