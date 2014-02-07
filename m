Message-ID: <52F4E084.3020809@marel.com>
Date: Fri, 7 Feb 2014 13:32:52 +0000
From: Marcel van Mierlo <marcel.vanmierlo@marel.com>
MIME-Version: 1.0
References: <52F3B77F.3020405@marel.com> <52F3C5DD.8010208@xenomai.org>
 <52F3DBDB.4060805@xenomai.org> <52F49F07.9040801@xenomai.org>
In-Reply-To: <52F49F07.9040801@xenomai.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] High CPU load using q_send under pSOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On 07/02/14 08:53, Philippe Gerum wrote:
> On 02/06/2014 08:00 PM, Gilles Chanteperdrix wrote:
>> On 02/06/2014 06:26 PM, Philippe Gerum wrote:
>>>> Every 2.0s: cat /proc/xenomai/stat                      Sat Jan  1
>>>> 00:09:03 2000
>>>>
>>>> CPU  PID    MSW        CSW        PF    STAT       %CPU NAME
>>>>     0  0      0          186436     0     00500080   94.2 ROOT/0
>>>>     0  2882   16         427        0     00300380    0.0 MAIN
>>>>     0  2883   0          54128      0     00300184    1.0 
>>>> onemsscheduler
>>>>     0  2884   0          542        0     00300184    0.0 FREE
>>>>     0  2885   0          1499       0     00300184    0.0 flsh
>>>>     0  2886   0          1          0     00300182    0.0 EWRN
>>>>     0  2887   0          45158      0     00300186    0.8 EEDT
>>>>     0  2888   0          53921      0     00300184    1.4 RESP
>>>>     0  2889   1          1          0     00300380    0.0 SERV
>>>>     0  2890   0          10784      0     00300184    0.4 CMND
>>>>     0  2891   2          1370       0     00300186    0.1 SERP
>>>>     0  2896   0          53080      0     00300184    0.8 SERO
>>>>     0  2899   0          536        0     00300186    0.0 CANP
>>>>     0  2900   0          1          0     00300182    0.0 CANG
>>>>     0  2901   0          1          0     00300182    0.0 CANE
>>>>     0  2902   0          315        0     00300182    0.0 CANT
>>>>     0  2903   1          1          0     00300380    0.0 CNMN
>>>>     0  2904   236        628        0     00300184    0.0 CIOW
>>>>     0  0      0          699350     0     00000000    1.0 IRQ83:
>>>> [timer]
>>>>
>>>>
>>>> So questions are:
>>>>
>>>> - Why does the %CPU under xenomai/stat not reflect whats reported 
>>>> by top
>>>
>>> Because top reports the CPU consumed when Linux is active, which
>>> excludes Xenomai activity.
>>>
>>>> (where is the 40% going)?
>>>
>>> Good question.
>>
>> I think we have a known issue: the registers passed to Linux timer tick
>> are the ones of the last timer tick, which may very well happen to
>> always hit the same task. Could this be the cause?
>>
>
> I checked your arm-side pipeline implementation yesterday, I believe 
> the saved CPSR value does exhibit PSR_I_BIT as expected when the timer 
> preempts the Xenomai domain, so there should not be any accounting 
> issue (i.e. __ipipe_root_tick_p would prevent update_process_times() 
> to charge the last active linux task). This said, the adverse 
> side-effect which is solved by the code I just mentioned would rather 
> happen when a Xenomai task does frequent relax/harden transitions, not 
> when it runs exclusively in real-time mode.
>
>> Is the MAIN task the one which does the tm_wkafter ?
>>
>> Is the hardware timer of the beaglebone black shared with Linux (like
>> omap4) or do linux and xenomai have different timers (like omap3)?
>>
>> Could you arm the T_WARNSW bit to see if the MAIN task experiences mode
>> switches?
>>
>
> It would also be interesting to check that commenting out q_send() 
> still produces the same result.
>

- When I set top to show threads I see "CIOW" taking up the CPU.
     - This is the pSOS task which invokes q_send, as per the sample code.
     - If I understand correctly
         - xenomai/stat confirms this task is not using much CPU time in 
Xenomai domain
         - top tells me the time is being taken up in Linux domain.
         *** Why would q_send/tm_wkafter be in linux domain?

- I cannot reproduce the problem when I comment out q_send()
     *** q_send appears to trigger the high %CPU.

- MSW increases by ~5 every seconds under xenomai/stat for CIOW.
     - It is the only task with increasing MSW.
     - This happens whether or not I am printing to screen...so when I 
sit in a tight loop calling only q_send and tm_wakeafter, MSW still 
increases. I dont understand this.
     - When I comment out q_send (so only call tm_wakeafter) MSW does 
not increase and stays on zero.
     *** Why does q_send cause mode switches?

- I cant see how to set T_WARNSW using the pSOS skin.
     - I get warning that "T_FPU" redefined when including native/task.h 
and psos+/psos.h
     - If I hack the mask by using "0x00040000" explicitly I get 
SIGXCPU: CPU time limit exceeded when calling rt_task_set_mode at runtime.
     - But I think xenomai/stat gives the required information anyway, 
right?

- When the high CPU load is reported the system exhibits poor 
responsiveness in a separate interactive shell - indicating this is not 
only an accounting anomaly(?)

- rtps after one minute with high CPU load:

PID    TIME                THREAD                   CMD

0      000:41:02.977,660   ROOT/0                   -
2675   000:00:00.037,676   MAIN                     .
2679   000:00:00.654,322   onemsscheduler           .
2680   000:00:00.013,614   flsh                     .
2681   000:00:00.000,046   EWRN                     .
2682   000:00:00.248,698   EEDT                     .
2683   000:00:00.779,498   RESP                     .
2684   000:00:00.000,049   SERV                     .
2685   000:00:00.177,563   CMND                     .
2692   000:00:00.071,832   SERP                     .
2699   000:00:00.410,424   SERO                     .
2703   000:00:00.015,994   CANP                     .
2704   000:00:00.000,041   CANG                     .
2705   000:00:00.000,021   CANE                     .
2706   000:00:00.005,955   CANT                     .
2707   000:00:00.000,023   CNMN                     .
2708   000:00:00.012,894   CIOW                     .
0      000:00:15.380,873   IRQ83: [timer]           -


- rtps after one minute low CPU load:

PID    TIME                THREAD                   CMD

0      000:44:27.327,181   ROOT/0                   -
3248   000:00:00.038,278   MAIN                     .
3252   000:00:00.679,777   onemsscheduler           .
3253   000:00:00.014,136   flsh                     .
3254   000:00:00.000,048   EWRN                     .
3255   000:00:00.249,896   EEDT                     .
3256   000:00:00.822,868   RESP                     .
3257   000:00:00.000,052   SERV                     .
3258   000:00:00.183,185   CMND                     .
3265   000:00:00.072,530   SERP                     .
3272   000:00:00.423,205   SERO                     .
3276   000:00:00.024,839   CANP                     .
3277   000:00:00.000,055   CANG                     .
3278   000:00:00.000,022   CANE                     .
3279   000:00:00.010,050   CANT                     .
3280   000:00:00.000,023   CNMN                     .
3281   000:00:00.023,130   CIOW                     .
0      000:00:17.034,773   IRQ83: [timer]           -

-    CIOW and CANT are ~double...these are the sender and listener tasks 
on the q.
-    I added further tracing.
     -    with low %CPU 100 messages are sent & received every 10s as 
expected
     -    with high %CPU (no printf/fflush in CIOW) then 100 messages 
are sent and received every ~17s

*** It seems high %CPU severely impacts time taken to post messages.

I added further tracing around q_send.
/High %CPU:
q_send: 93.687ms,
tm_wkafter: 99.360ms
total: 193.055ms

Low %CPU:
/////q_send/: 0.068ms///
tm_wkafter:/ 99.665ms
total: 99.737ms
/
- Why is printf/fflush impacting time taken to invoke q_send?


I'll implement a simple test harness to try and further isolate this 
behaviour...of course any input greatly appreciated!



Marcel.




