Message-ID: <46C1EE69.3020301@domain.hid>
Date: Tue, 14 Aug 2007 20:03:21 +0200
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid> <46C04384.4030805@domain.hid>
	<46C05180.5090302@domain.hid> <46C05690.2010108@domain.hid>
	<46C063E0.1010809@domain.hid> <46C07005.8000504@domain.hid>
	<46C1B498.8060600@domain.hid>
	<Pine.LNX.4.64.0708141629570.18303@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0708141629570.18303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input framebuilding failed.
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>, rtnet-users <rtnet-users@domain.hid>

Hi,

> How many threads do you have sending process data, and what are there
> priorities? (/proc/xenomai/sched IIRC)
I have 3 rt tasks running. Only one sends and receives process data. The 
priorities are:
rt_task1 99
rt_task2 75
rt_task3 1

Period times are
1ms
3ms
indefinite(holds a blocking rt_can recv call to catch any incoming CAN 
messages)


> 
>> EC_Telegram::index_check() : index not the same,
>> low_level_input() :  framebuilding failed.
>>
>> Or something pretty closely to that effect.
>>
>> Despite EML warning that the frame could not be built, the inputs (which
>> rely on the framebuilding being succesful pretty stringently) seem to
>> function perfectly. It seems as though EML is emitting a false warning.
> 
> What do you mean with "inputs functioning perfectly"?

The digital inputs are packed into the frame as are the digital outputs 
and analog output process data. The outputs function as they should but 
the warning complains mainly about the retrieving part of the ethercat 
cycle. Hence my comment that the digital inputs also function as they 
should that is to say the data arrives correctly and uncorrupted. AFAI 
understand from ETG the index is not changed by the ESC's so I would 
expect the check always return true. But even if it does not what does 
that mean? Can it mean that EML is losing some frames that have been 
transmitted? I.e. the index is incremented with every transmit and the 
message with the same index is expected on the next read but instead it 
is only getting one later? If so, what could cause this?

>> I have now killed the warning from EML with the following hack:
>>
>> In EC_Telegram::check_index() I have effectively killed the check by
>> snubbing the holler and always returning true. Now the application no
>> longer emits warnings and everything functions well (or so it seems). I
>> have a sawtooth analog output on a scope which triggers well.
> 
> Should I have read s/input/output/g in the above?
No, output. The output is incremented up in task 1 and reset to -10V 
when it reaches 10V. The steps take place at exactly 1ms with impressive 
accuracy and consistency. This saw tooth wave is so stable that my scope 
has no problem locking onto it and it remains stationary (allowing me to 
admire the accurate 1ms steps :) ). Now and then if I try hard the wave 
flimmers i.e. the triggering is lost) which I think indicates that the 
1ms task did not increment the analog output on time. Whatever happens 
to cause this (rtcan ?, we know that it displays some latency breaking 
behaviour when the buffer is full. But there is no evidence that there 
is any buffer overflow at present anymore) might make an ethernet frame 
go lost Ah!, a delayed read **** which causes the index shift and 
consequently the irritating messages.

**** It occurs to me to ask whether there is an incomming buffer for 
ethercat frames that is maybe read out in such a manner (e.g. FIFO) that 
if a message can get "buried" and once a slip has occurred the index 
shift stays resident. ?? If anyone would care to enlighten me on how 
this part of EML works and whether this hypothesis is a possibility or 
not I would be much obliged.


>> I have also made the index that is supposedly not the same visible. For
>> the EML chaps: index and m_idx and the output seems to be something like
>> this
>>
>> index    m_idx
>> 0    1
>> 0    0
>> 1    2
>> 2    3
>> 2    3
>> 3    4
>> 4    5
>> :    :
>> :    :
>> 253    254
>> 0    2
>>
>> or something to that effect. Can anyone comment on this?
> 
> Is the above the index in the output captured with wireshark or
> something else?
No EML and switches are no friends of each other when the frame gets 
long I suspect. EML bombs out when I introduce a switch. I would be much 
obliged to anyone who would tell me how to set up any timeout delay 
measurement in EML.
What I did was simply put a printf line into EML to output index and 
m_idx to screen. So unfortunately this does not tell us where the shift 
is acquired.


Thanks. I'll give below a try.

Roland.

> 
> AFAIS from the code shouldn't be affected by latency of the PD
> thread.  You might uncomment the following log statements to get more
> info too (I wonder why they are commented out anyway, Tom?)
> 
> static bool ec_rtdm_txandrx(struct EtherCAT_Frame * frame, struct
> netif * netif) {
>         int tries = 0;
>         while (tries < MAX_TRIES_TX) {
>                 pthread_mutex_lock (&txandrx_mut);
>                 if (low_level_output(frame,netif)){
>                         if (low_level_input(frame,netif)){
>                                 pthread_mutex_unlock(&txandrx_mut);
>                                 return true;
>                         }
>                         else{
>                                 //log(EC_LOG_ERROR,
>                 "low_level_txandrx: receiving
>                 failed\n");
>                                 pthread_mutex_unlock(&txandrx_mut);
>                         }
>                 }
>                 else{
>                         //log(EC_LOG_ERROR, "low_level_txandrx:
>             sending failed\n");
>                         pthread_mutex_unlock(&txandrx_mut);
>                 }
>                 tries++;
>         }
>         log(EC_LOG_FATAL, "low_level_txandrx: failed: MAX_TRIES_TX:
>     Giving up\n");
>         return false;
> 
> Klaas
> 
> 

