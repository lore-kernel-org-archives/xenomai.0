Message-ID: <a7575bba0804170215k2999fadcn8de7a4e0bf87c64e@domain.hid>
Date: Thu, 17 Apr 2008 17:15:56 +0800
From: "Josh Zhao" <joshsystem@domain.hid>
In-Reply-To: <a7575bba0804150405iec3cc82ia823f010f034a671@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7685_28931241.1208423756931"
References: <a7575bba0804150405iec3cc82ia823f010f034a671@domain.hid>
Subject: [Xenomai-core] About Xenomai questions
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

------=_Part_7685_28931241.1208423756931
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi ,
  After reading Xenomai code, I have some questions:
  1.    usespace--> rt_task_create  -->pthread_create-->__native_task_create

      So why xenomai use pthread  to invoke __native_task_create ?

   2.   usespace-->rt_task_start(RT_TASK *task, void (*entry) (void
*cookie), void *cookie)-->
   kernel space --> __rt_task_start(struct task_struct *curr, struct pt_regs
*regs)-->
rt_task_start(task,
                 (void (*)(void *))__xn_reg_arg2(regs),
                 (void *)__xn_reg_arg3(regs));


     I can't understand that the entry paramter is address of function in
user space ,why it can be passed into kernel space by syscall?

3.   the xnthread_t struct and  pod  sechedule algorithm looks very complex,
is there any papers taking about it?

thanks very much!!!!

------=_Part_7685_28931241.1208423756931
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"><br></span>Hi ,<br>&nbsp; After reading Xenomai code, I have some questions:<br>&nbsp; 1.&nbsp; &nbsp; usespace--&gt; rt_task_create&nbsp; --&gt;pthread_create--&gt;__native_task_create <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; So why xenomai use pthread&nbsp; to invoke __native_task_create ?<br>

<br>&nbsp;&nbsp; 2.&nbsp;&nbsp; usespace--&gt;rt_task_start(RT_TASK *task, void (*entry) (void *cookie), void *cookie)--&gt;<br>&nbsp;&nbsp; kernel space --&gt; __rt_task_start(struct task_struct *curr, struct pt_regs *regs)--&gt;<br>rt_task_start(task,<br>

&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; (void (*)(void *))__xn_reg_arg2(regs),<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; (void *)__xn_reg_arg3(regs));<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp; I can&#39;t understand that the entry paramter is address of function in user space ,why it can be passed into kernel space by syscall?<br>

<br>3.&nbsp;&nbsp; the xnthread_t struct and&nbsp; pod&nbsp; sechedule algorithm looks very complex,  is there any papers taking about it?<br><br>thanks very much!!!!<br>&nbsp;&nbsp;&nbsp; <br> 

------=_Part_7685_28931241.1208423756931--

