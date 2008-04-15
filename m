Message-ID: <a7575bba0804150405iec3cc82ia823f010f034a671@domain.hid>
Date: Tue, 15 Apr 2008 19:05:48 +0800
From: "Josh Zhao" <joshsystem@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2214_1098938.1208257548900"
Subject: [Adeos-main] About Xenomai questions
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

------=_Part_2214_1098938.1208257548900
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

------=_Part_2214_1098938.1208257548900
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi ,<br>&nbsp; After reading Xenomai code, I have some questions:<br>&nbsp; 1.&nbsp; &nbsp; usespace--&gt; rt_task_create&nbsp; --&gt;pthread_create--&gt;__native_task_create <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; So why xenomai use pthread&nbsp; to invoke __native_task_create ?<br>
<br>&nbsp;&nbsp; 2.&nbsp;&nbsp; usespace--&gt;rt_task_start(RT_TASK *task, void (*entry) (void *cookie), void *cookie)--&gt;<br>&nbsp;&nbsp; kernel space --&gt; __rt_task_start(struct task_struct *curr, struct pt_regs *regs)--&gt;<br>rt_task_start(task,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; (void (*)(void *))__xn_reg_arg2(regs),<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; (void *)__xn_reg_arg3(regs));<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp; I can&#39;t understand that the entry paramter is address of function in user space ,why it can be passed into kernel space by syscall?<br>
<br>3.&nbsp;&nbsp; the xnthread_t struct and&nbsp; pod&nbsp; sechedule algorithm looks very complex,  is there any papers taking about it?<br><br>thanks very much!!!!<br>&nbsp;&nbsp;&nbsp; <br> 

------=_Part_2214_1098938.1208257548900--

