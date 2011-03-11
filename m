Message-ID: <4D79E608.4050909@domain.hid>
Date: Fri, 11 Mar 2011 10:06:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D79DD32.4050307@domain.hid> <4D79E28B.3090004@domain.hid>
	<4D79E43D.2040807@domain.hid>
In-Reply-To: <4D79E43D.2040807@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> On 2011-03-11 09:51, Gilles Chanteperdrix wrote:
>> Johann Obermayr wrote:
>>> void task_waiter_do(void *data)
>>> {
>>>      rt_printf("task_waiter_do started\n");
>>>      while(task_waiter_flag == 0)
>>>          ; // rt_task_sleep( DELAYMS(1) );
>>>      rt_printf("task_waiter_do finished\n");
>>> }
>> What happens if you uncomment the rt_task_sleep here ?
>>
> 
> Given how often users make this mistake, should we enable the watchdog
> by default?

>From my point of view, however strange this example is, it should work
with root thread priority coupling enabled.
-- 
					    Gilles.

