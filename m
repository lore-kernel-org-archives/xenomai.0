Message-ID: <46246CBB.8050304@domain.hid>
Date: Tue, 17 Apr 2007 08:44:11 +0200
From: Jean-Luc Pamart <jlpamart@domain.hid>
MIME-Version: 1.0
References: <461FE560.8070100@domain.hid> <461FF950.7080608@domain.hid>
	<4620DC4B.4040000@domain.hid> <46222091.1010903@domain.hid>
In-Reply-To: <46222091.1010903@domain.hid>
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
>> Jan Kiszka a =E9crit :
>>    =20
>>> Jean-Luc Pamart wrote:
>>> =20
>>>      =20
>>>> Hello
>>>>
>>>> I  try to execute the heartbeat example (xenomai 2.3 with kernel 2.6=
.19)
>>>> With the unmodified sources when the heartbeat module
>>>> is being unloaded (rmmod)  I obtain :
>>>>
>>>> atkbd.c: Spurious ACK on isa0060/serio0. Some program might be tryin=
g
>>>> access hardware directly.=20
>>>> and the unloading can't be finished.
>>>>
>>>> I try to slightly change the sources. It works with no bad kernel
>>>> message and
>>>> complete unloaded with this modification :
>>>>
>>>> void heartbeat(void *cookie)
>>>> {
>>>>                while (!end) {
>>>>               ...
>>>>         }
>>>>     set_leds(0);
>>>>     }
>>>> void cleanup_module(void)
>>>> {
>>>>     //  set_leds(0);
>>>> }=20
>>>> My interpretation :
>>>> In the non modified example, We try to access directly to the keyboa=
rd
>>>> after the end of the rt-driver(after=20
>>>> rtdm_task_join_nrt(&heartbeat_task, 100);)
>>>> So it is a problem for the kernel.
>>>>    =20
>>>>        =20
>>> Hmm, the problem might be that set_leds(0) gets preempted. Could you =
try
>>>
>>> local_irq_disable();
>>> set_leds(0);
>>> local_irq_enable();
>>>
>>> for cleanup_module()?
>>>
>>> Yes, this demo accesses shared hardware directly, and that can confus=
e
>>> Linux or cause even worse situations. Moreover, this high-prio task a=
lso
>>> causes fairly high latencies. So it is nothing for serious use anyway=
.
>>> But if we can improve obvious issues, there is no need to hesitate.
>>>
>>> =20
>>>      =20
>>>> Is it a good interpretation ?
>>>> =20
>>>> what is the difference between rtdm_task_join_nrt(&heartbeat_task,
>>>> 100) and
>>>>  rtdm_task_destroy(&heartbeat_task) ?
>>>> What is the role of the polling argument (value 100) ?
>>>>    =20
>>>>        =20
>>> Not being too lazy to answer, but I would like to know if the doc is
>>> improvable: Did you read the API documentation [1]?
>>>
>>> Jan
>>>
>>> [1]http://www.xenomai.org/documentation/branches/v2.3.x/html/api/grou=
p__rtdmtask.html
>>>
>>>
>>>  =20
>>>      =20
>> Hi
>>
>> I don't want to use this example for a real application.
>> It's only for the "fun" : I' ll have to write a rtdm driver
>> so now, I study ...
>>
>> That's was a good proposition for the heartbeat module :
>>
>> void cleanup_module(void)
>> {
>>    end =3D 1;
>>    rtdm_task_join_nrt(&heartbeat_task, 100);    local_irq_disable();  =
 =20
>> // to be added
>>    set_leds(0);
>>    local_irq_enable();     // to be added
>> }
>>
>> 1 / it run as usual very well
>> 2/ his unloading can finish
>> 3/ his unloading doesn't anymore cause  "Spurious ACK .."
>> so all is all right now !
>>
>>    =20
>
> OK, good know. That experiment was just to check the theory, I will
> actually commit your first proposal as fix (call set_leds before leavin=
g
> heartbeat()). It's shorter.
>
>  =20
>> But, this problem appears only when unloading the module.
>> After all, set_leds() is used by heartbeat() without any problem.
>> Why not in cleanup_module() ?
>> Sorry it's perhaps an obviousness but not for me.
>>    =20
>
> The difference between the RTDM task function heartbeat() and
> cleanup_module() is the execution context: the former it RT, thus canno=
t
> be preempted by any Linux activity, the latter is a Linux task that is
> preemptible by Linux interrupts or other Linux tasks, including other
> keyboard-using code.
>
> Actually, all this is only true for single-processor systems. SMP will
> cause troubles due to the unsynchronised HW access of Linux vs.
> hearbeat. Anyway, this remains an imperfect demo.
>
>  =20
>> I have red the rtdm_api.pdf doc which is embedded with the Xenomai sou=
rces.
>> I'd like to try "hello world examples" for a more large point of view
>> and some easy begining you haven't when you read the documentation :
>> a list of functions and a brief use - too short for the beginner i am =
-
>> Well, it's the same situation (it's my point of view, perhaps I am alo=
ne
>> ??)
>> when you try to write a letter in a unknown language :
>> the dictionnaries are good for spelling not for grammar (construct of
>> the sentence).
>>    =20
>
> Yep, I understand and agree. Still, writing appropriate introductions
> for all this, either as text or in form of thoroughly worked out
> examples, takes quite some effort (means: time).
>
> Therefore, the best would be if some former beginners help us by fillin=
g
> gaps in the existing documentation and/or examples repository. Fixing
> remaining glitches in their contribution is not a big problem (see e.g.
> how the RTnet docs started on xenomai.org). The point is that we would
> then already know where to invest required effort effectively.=20
I work for a school project "systeme de vision artificielle pour=20
pr=E9tailleuse" : a tractor which cut the vine of Champagne
(the famous drink ...)
The embedded application will analyse the movies in real time and lead=20
the cutting part of this machine (with a CAN-BUS).
I have to write a driver which interface a PCI board (connected to a=20
little camera) and ask
Rodrigo Rosenfeld Rosas for a squeletton of his driver.
So, I think I have now a beginning ...
In the future, if the project is finished, I can send the whole driver=20
to the xenomai-forum
with, (if you find that interresting) some explanations (from a beginner=20
point of view)

> Keep in
> mind: individual project contributors don't scale infinitely, thus the
> team size need to.
>
>  =20
Do you mean that there isnt enought contributors or the team whant to be=20
bigger ?


>> So for the differences between rtdm_task_join_nrt and rtdm_task_destro=
y,
>> what I understand :
>>
>> 1/rtdm_task_destroy(&heartbeat_task)
>> Stop and destroy immediately the target task.
>>
>> 2/rtdm_task_join_nrt(&heartbeat_task, 100);
>> Wait for the end of target task
>> It is the user to take care of the termination of the target task
>> If not, rtdm will never return
>> (the task must cooperate)
>>
>> Ok but what is "polling delay" for ?
>> At the first look I think about a watchdog but it's not the case
>>
>> Sorry for these obvious issues !
>>    =20
>
> No need to apologise, specifically as that "polling delay" is in fact
> badly documented. rtdm_task_join_nrt() may wait on the termination by
> periodically checking (polling) the RT task state. So the delay defines
> this period. Will fix.
>
>  =20
Ok it's clear now :
some of the fonctions are in rt context and the others not and especially
the interface with insmod, rmmod etc. obviously in user mode.


>> BTW, the "real-time" answers of this forum is impressive : bravo !
>>
>>    =20
>
> I think this is mandatory for real-time projects, isn't it? ;)
>  =20
yes !

> Jan
>
>  =20





