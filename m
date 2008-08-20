Message-ID: <48ABE84B.7070803@domain.hid>
Date: Wed, 20 Aug 2008 11:47:55 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E56431F57@domain.hid>
	<48AAF55E.9000206@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56431FCD@oab1mx1.oneaccess.intra>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E56431FCD@oab1mx1.oneaccess.intra>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Filip Van Rillaer wrote:
> Hello,
> 
> My current test-setup is as follows:
> 1) user-program reads test-samples from a file in non-RT and does a blocking write to the Xenomai-pipe
> 2) a RT-program that implements a V34 modem is listening to the Xenomai-pipe and will send the data over a telephone line.
> ---> so it is the intention that at startup the Xenomai-pipe buffer gets filled up and from than in stationary state the data should stream at the speed of the V34 modem connection.
> 
> The RT-side is using rt_pipe_monitor to be warned when new data from the non-RT write arrives (so no polling).  The RT-side will 'remember' that data from the non-RT side are available and (sometimes a lot) later when enough data have been sent over the telephone line, read new data from the Xenomai pipe.
> 
> Any idea how I can get around this problem?
>

Well, yes. /Me fixing my mess.

> Concerning O_SYNC I get the fatal error message:
>  Xenomai: fatal: inserting element twice, holder=00b19cfc, qslot=00b1ab84 at kernel/xenomai/nucleus/pipe.c:96

Oh dear...

>   CPU  PID    PRI      TIMEOUT  STAT      NAME
>  >  0  0       -1      0        00400080  ROOT
>     0  112     99      999616310 00300186  RTTask
> I think that this happens around the same time that I get the -ENOMEM when I am not using the O_SYNC flag.
> 

Ok, once again, I need to reproduce this first. More later,

> Best regards,
> Filip
>  
> 
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org] 
> Sent: 19 August 2008 18:31
> To: Filip Van Rillaer
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
> 
> Filip Van Rillaer wrote:
>> Hello,
>>  
>> I am opening the uClinux side of a Xenomai pipe like (so in blocking mode):
>> FdPipe = open(PipeName, O_RDWR);
>> After some writes to FdPipe I get the returnvalue -ENOMEM.
>> I can understand that the internal buffer gets full as my application 
>> is writing data faster than the Xenomai side is consuming, but I don't 
>> expect to see a returnvalue -ENOMEM : the calling writing-thread 
>> should block, isn't it?  Please comment.
>>
> 
> RT is assumed to consume asap and will preempt the non-RT write() caller immediately upon data receipt, unless the RT code uses some kind of timed polling, which is considered useless and inefficient, since you can ask a RT thread to wait for incoming data in a blocking way.
> 
>> (When adding the O_SYNC flag things get even worse)
>>  
> 
> That is the point that would actually need fixing: what happens with O_SYNC, what is worsening exactly?
> 
>> Why is the code for xnpipe_write saying:
>> if (!mh)
>>   /* Cannot sleep. */   <--- ???????????????????
>>   return -ENOMEM;
>>  
>> I am using svn version 4105.
>>  
>> Best regards,
>> Filip
>>
>>
>> ----------------------------------------------------------------------
>> --
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
> 
> 
> --
> Philippe.
> 


-- 
Philippe.

