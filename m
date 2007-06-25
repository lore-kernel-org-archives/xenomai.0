Message-ID: <467F72C1.5050306@domain.hid>
Date: Mon, 25 Jun 2007 09:46:09 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Getting the current RT-state of a task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

I am building an OS-abstraction layer for our application, and for this 
I would like to know the RT-status of a task.
Using the rt_task_set_mode function it is possible to switch between RT 
and non-RT (using T_PRIMARY). But I would like to know what the state is 
of the current task. I did not find a function to retrieve the RT-state 
of a task; is a function available that will return the status of a task?

For the moment I am using the code shown below. Does this code work:

    rt_task_set_mode(0,0, &var);
    if(var&T_PRIMARY)
    {   /* Primary mode */
        ....
    }
    else
    {   /* Secondary mode */
        ....
    }

I would like to use this for a printf-implementation, where the text is 
printed if the task is non-RT or send to a logging task is the task is 
RT. I would like to call this code from Xenomai tasks, but also from 
plain Linux tasks. Is this possible?

Kind regards,
    Johan Borkhuis


