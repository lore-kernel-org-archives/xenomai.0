Message-ID: <43DF6587.2070207@domain.hid>
Date: Tue, 31 Jan 2006 14:26:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Event flag anomaly
References: <FDBBB5CC70676540B3EF7CFE83FD94E00430B4@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E00430B4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> 
> Hi,
> 
> I've some problems to understand how the event flag semantic is defined.
> 
> In the example below, I just defined a RT_EVENT task which waits on event mask 1.
> (Simply bit 1 has to be set). 
> When I do a rt_event_signal(&meteoEvents, 1) from another task, the blocking task
> is logically waked up. Fine. On the next iteration, the event bit set is remaining
> unchanged and the rt_event_wait() doesn't wait anymore since the event is activated.
> (please consider the rt_event_clear as commented lines as it is). Well, it seems
> OK. BUT, on the third iteration, the rt_event_wait() is blocking! Actually, the bit
> set has been cleared in the meanwhile.
> 
> Looking at the rt_event_wait() code in native/event.c, it effectively turns out that
> the bit set is cleared according to the mask, if and only if the task doesn't need to wait.
> 
> Please could you explain me what's the rationale behind this strange behaviour? I would propose that the bits
> remain unchanged until a clear().  (I probably missed something in my reasoning).

You are right. Auto-clearing the satisfied event bits is spurious here. Fixed, thanks.

> 
> Here is the example:
> ---------------------------
> 
> void meteoDataAcquisition(void *cookie) {
> 
> unsigned long receivedMask;
> 
>   while(1) {
> 
>     rt_event_wait(&meteoEvents, 1, &receivedMask, EV_ANY, TM_INFINITE);
>     //rt_event_clear(&meteoEvents, 1, &receivedMask);
>     
>     
>     printk("#Task activated\n");
>    
>   }
>   
> }
> -------------------------------
> 
> And a piece of code from event.c
> 
> ....
>  if (((mode & EV_ANY) && (mask & event->value) != 0) ||
>         (!(mode & EV_ANY) && ((mask & event->value) == mask)))
>         {
>         *mask_r = (event->value & mask);
>         event->value &= ~mask;        --> this is not done after the thread has been waked up.
>         goto unlock_and_exit;
>         }
> .....
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

