Message-ID: <45188502.4060209@domain.hid>
Date: Mon, 25 Sep 2006 22:40:18 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Help on debugger gdb
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi, it's me again, after a long while :)

I'll present my Master thesis this Friday and I would like to comment 
about the debugger. Since I'm in hurry with a lot other issues, I do not 
have to time to test what I'm going to ask.

I've never used a debugger with Xenomai (or RTAI). I mean, not GDB. I 
used other techniques to debug, such as logging, etc. My doubt is:

Suppose I have a user-space program with 3 independent Xenomai RT-tasks. 
If I put a breakpoint in one of them, will the other two keep running? I 
guess yes, but I'm not sure and that is why I'm asking.

Another thing. I think that the scheduler will keep counting the time 
when the debugger stopped the task. So, the next call to 
rt_task_wait_period() will return -ETIMEDOUT immediately, with the 
overruns set accordly, if this was the case, right?

Thank you all again for all the support I had while researching for my 
master thesis. :) After concluding it, it will be time for starting 
looking for a job. If anyone of you knows about some company that could 
employ a brazilian to work with Linux based real-time systems, 
preferently Xenomai, please, let me know.

Best regards,

Rodrigo.


		
_______________________________________________________ 
Novidade no Yahoo! Mail: receba alertas de novas mensagens no seu celular. Registre seu aparelho agora! 
http://br.mobile.yahoo.com/mailalertas/ 
 



