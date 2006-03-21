Message-ID: <4420391B.7000309@domain.hid>
Date: Tue, 21 Mar 2006 18:34:19 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up - SOLVED
References: 00603201434.15258@domain.hid>
	<200603201434.15258@domain.hid>	<441ED657.1080405@domain.hid>
	<200603201901.3123@domain.hid>	<441F3476.1080003@domain.hid>
	<200603211503.22918@domain.hid> <442018FE.3020906@domain.hid>
	<442029CF.8030709@domain.hid> <44203051.4080400@domain.hid>
In-Reply-To: <44203051.4080400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Petr Cervenka wrote:
>>>
>>>
>>>>The problem was in my calling "RT" task. I forgot to switch the new
>>>>created task to PRIMARY MODE, because I didn't know it's neccessary.
>>>
>>>
>>>As Philippe said, it isn't usually required - with exceptions. Let me
>>>first sketch the standard situation: You registered a read_rt handler
>>>with your device, but no read_nrt. If your application now calls
>>>rt_dev_read (or just read() for the POSIX skin) from the "wrong"
>>>context, RTDM will detect the missing _nrt handler and trigger an
>>>automatic switch to primary mode (and vice versa). So, no need for
>>>manual switching in the standard case.
>>>
>>>But if you had registered handlers for both contexts, RTDM will always
>>>invoke the one for your current mode.
>>
>>I wonder if marking the call as "conforming" instead of leaving it to
>>the current domain would make such handling more intuitive? RT threads
>>would automatically switch to primary before always going to the _rt
>>routine, while plain Linux tasks would just go to the _nrt one. Am I
>>off-base wrt RTDM's logic here?
> 
> 
> Its the difference between a RT thread issuing some service request
> during its init phase (where it may not need hard guarantees, rather
> wants to save short RT resources) and from inside its critical loop
> (where no mode switch is desired). The second case would be ok with
> "default-to-RT", but the first one would require to move the job into a
> plain linux thread in order to address the _nrt variant of the invoked
> service.
> 
> A concrete example: RTnet can create sockets with strict RT guarantees.
> In case the socket creation is invoked from primary mode, the required
> buffers for the socket are taken from a limited, user-tuned global pool.
> But the standard, far more convenient case is that socket creation does
> not have to happen in RT. In this case we can allocate the buffers from
> Linux. This may lead to swapping or may even fail if the system is
> generally low on memory. But that's non-RT. An RT task can now select
> the allocation strategy by setting its execution mode either to primary
> or secondary.
> 
> Selecting the strategy via function arguments may appear as a better
> way, but this cannot easily be done where conformance to existing APIs
> (like POSIX) is desired.

I'm worried by the fact that mode switching needs to be exposed to the 
application layer in this case. Actually, it has always been seen as an 
internal request, but never as part of the recommended API, because one 
might just do utterly wrong things with this syscall (useless eager 
switch when none is due etc). My worst nightmare waking me up in cold 
sweat is seeing Xenomai-based applications litterally stuffed with 
rt_task_set_mode(...T_PRIMARY...) calls, breaking the lazy switch scheme 
without any upside, but additional latencies. Actually, a lot of work 
has been done to make those mode switches as transparent/invisible as 
possible. My fear is that people having problems with their application 
would start adding mode switches everywhere "just in case", without 
really understanding the logic behind it. Gah...! cold sweat again...

The other issue which bothers me is that applications would need to know 
the actual implementation of the syscall to pick the right mode, i.e. 
whether rtdm_socket wants to get memory from the Linux pool, or from a 
predefined local pool, and so on. Sounds ok for a low-level library 
which must know about RTDM's internals, but might be error-prone for 
writing regular apps.

-- 

Philippe.

