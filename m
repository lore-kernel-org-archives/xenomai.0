Message-ID: <53316570.5060600@xenomai.org>
Date: Tue, 25 Mar 2014 12:16:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACKc53LDHUFyLAy5-=wW7Zy+rmB1gthujCORsY1w4zyzip1bmQ@mail.gmail.com>
 <53163439.6070608@gmail.com> <532DBBFF.9010900@xenomai.org>
 <53302093.9090503@gmail.com> <533022B7.9000405@xenomai.org>
 <533159E0.7090809@gmail.com>
In-Reply-To: <533159E0.7090809@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sensoray 626 analogy driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wojciech Domski <wojciech.domski@gmail.com>
Cc: xenomai@xenomai.org

On 03/25/2014 11:26 AM, Wojciech Domski wrote:
> W dniu 24.03.2014 13:19, Gilles Chanteperdrix pisze:
>> The solution which would be acceptable is not to have busy waits, except
>> for very short durations. But for instance transferring a byte on I2C
>> takes around 20us at 400 kHz, a 20us masking section is unacceptable.
>> rtdm_task_busy_sleep, as the name suggests is a busy wait loop, so, no,
>> it is not acceptable either.
>>
>> Use a thread or a timer to reschedule while you wait for the end of the
>> transfer, instead of busy waiting.
> Dear Gilles,
> 
> As you mentioned before the driver has few places like this:
> 
> while(!FLAG1);
> while(!FLAG2);
> 
> Would a solution of creating a separate task for this purpose be ok?
> 
> task()
> {
>      while(!FLAG1);
>      while(!FLAG2);
> }

I was rather thinking about rtdm_task_sleep() instead.

> 
> In the place of those loops a piece of code responsible for creating and 
> joining task would be put instead:
> 
> rtdm_task_init();
> rtdm_task_join_nrt();

This will not work for code currently running in interrupt handlers. An
interrupt handler can not call rtdm_task_join_nrt(). You will rather
have to wake up the thread, not reenabling the interrupt at the end of
the handler, and reenable the interrupt in the thread when the job is
done. Or alternatively, fire a timer instead of waking up a thread.


-- 
                                                                Gilles.

