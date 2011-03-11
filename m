Message-ID: <4D79F1B5.5000906@domain.hid>
Date: Fri, 11 Mar 2011 10:56:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D79DD32.4050307@domain.hid> <4D79E28B.3090004@domain.hid>
	<4D79F0ED.6080101@domain.hid>
In-Reply-To: <4D79F0ED.6080101@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_delete trouble
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
> Am 11.03.2011 09:51, schrieb Gilles Chanteperdrix:
>> Johann Obermayr wrote:
>>> void task_waiter_do(void *data)
>>> {
>>>       rt_printf("task_waiter_do started\n");
>>>       while(task_waiter_flag == 0)
>>>           ; // rt_task_sleep( DELAYMS(1) );
>>>       rt_printf("task_waiter_do finished\n");
>>> }
>> What happens if you uncomment the rt_task_sleep here ?
> we have some shared code from another RT OS.
> And in this code there are some while(hw_state) ;  loops.

I just ask you to uncomment this line and run the test to see if it
changes anything. We are in the process of trying and understanding the
issue here... not fixing anything yet.

But from a general point of vieuw, code with unbounded busy waits with
Xenomai will not fly for other reasons.

-- 
					    Gilles.

