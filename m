Message-ID: <4620DC4B.4040000@domain.hid>
Date: Sat, 14 Apr 2007 15:51:07 +0200
From: Jean-Luc Pamart <jlpamart@domain.hid>
MIME-Version: 1.0
References: <461FE560.8070100@domain.hid> <461FF950.7080608@domain.hid>
In-Reply-To: <461FF950.7080608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Execution error with rtdm heartbeat example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka a =E9crit :
> Jean-Luc Pamart wrote:
>  =20
>> Hello
>>
>> I  try to execute the heartbeat example (xenomai 2.3 with kernel 2.6.1=
9)
>> With the unmodified sources when the heartbeat module
>> is being unloaded (rmmod)  I obtain :
>>
>> atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying=20
>> access hardware directly. =20
>>
>> and the unloading can't be finished.
>>
>> I try to slightly change the sources. It works with no bad kernel=20
>> message and
>> complete unloaded with this modification :
>>
>> void heartbeat(void *cookie)
>> {
>>       =20
>>         while (!end) {
>>               ...
>>         }
>>     set_leds(0);
>>    =20
>> }
>> void cleanup_module(void)
>> {
>>     //  set_leds(0);
>> } =20
>>
>> My interpretation :
>> In the non modified example, We try to access directly to the keyboard
>> after the end of the rt-driver(after =20
>> rtdm_task_join_nrt(&heartbeat_task, 100);)
>> So it is a problem for the kernel.
>>    =20
>
> Hmm, the problem might be that set_leds(0) gets preempted. Could you tr=
y
>
> local_irq_disable();
> set_leds(0);
> local_irq_enable();
>
> for cleanup_module()?
>
> Yes, this demo accesses shared hardware directly, and that can confuse
> Linux or cause even worse situations. Moreover, this high-prio task als=
o
> causes fairly high latencies. So it is nothing for serious use anyway.
> But if we can improve obvious issues, there is no need to hesitate.
>
>  =20
>> Is it a good interpretation ?
>> =20
>> what is the difference between rtdm_task_join_nrt(&heartbeat_task, 100=
) and
>>  rtdm_task_destroy(&heartbeat_task) ?
>> What is the role of the polling argument (value 100) ?
>>    =20
>
> Not being too lazy to answer, but I would like to know if the doc is
> improvable: Did you read the API documentation [1]?
>
> Jan
>
> [1]http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group_=
_rtdmtask.html
>
>  =20
Hi

I don't want to use this example for a real application.
It's only for the "fun" : I' ll have to write a rtdm driver
so now, I study ...

That's was a good proposition for the heartbeat module :

void cleanup_module(void)
{
    end =3D 1;
    rtdm_task_join_nrt(&heartbeat_task, 100);=20
    local_irq_disable();     // to be added
    set_leds(0);
    local_irq_enable();     // to be added
}

1 / it run as usual very well
2/ his unloading can finish
3/ his unloading doesn't anymore cause  "Spurious ACK .."
so all is all right now !


But, this problem appears only when unloading the module.
After all, set_leds() is used by heartbeat() without any problem.
Why not in cleanup_module() ?
Sorry it's perhaps an obviousness but not for me.

I have red the rtdm_api.pdf doc which is embedded with the Xenomai source=
s.
I'd like to try "hello world examples" for a more large point of view
and some easy begining you haven't when you read the documentation :
a list of functions and a brief use - too short for the beginner i am -
Well, it's the same situation (it's my point of view, perhaps I am alone =
??)
when you try to write a letter in a unknown language :
the dictionnaries are good for spelling not for grammar (construct of
the sentence).

So for the differences between rtdm_task_join_nrt and rtdm_task_destroy,
what I understand :

1/rtdm_task_destroy(&heartbeat_task)
Stop and destroy immediately the target task.

2/rtdm_task_join_nrt(&heartbeat_task, 100);
Wait for the end of target task
It is the user to take care of the termination of the target task
If not, rtdm will never return
(the task must cooperate)

Ok but what is "polling delay" for ?
At the first look I think about a watchdog but it's not the case

Sorry for these obvious issues !

BTW, the "real-time" answers of this forum is impressive : bravo !


Jean-Luc

