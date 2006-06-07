Message-ID: <448696E8.10405@domain.hid>
Date: Wed, 07 Jun 2006 09:05:44 +0000
From: "s.a." <sancelot@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai: binding failed: Operation not permitted.
References: 446C264A.7040206@domain.hid>	<200605181426.8240@domain.hid>	<446C6C1C.2010902@domain.hid>	<200605190943.31667@domain.hid>	<446D7DE6.10402@domain.hid>
	<44859D3F.50800@domain.hid> <44858228.40508@domain.hid>
In-Reply-To: <44858228.40508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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


Hi,

In my mind , one or more rt process manages everything critical, need
root access for resources reasons , other processes are things like gui
to interact with realtime world, including  X11 applications (I know , I
will hurt some people, but this is the truth : X11 !) .....


Best Regards
Steph
  


Jan Kiszka wrote:

>s.a. wrote:
>  
>
>>Hi,
>>
>>Okay, but in this case, why do we need  root permissions for programs
>>accessing that "only" access shared memory area (heaps)????
>>    
>>
>
>For simplicity reasons: we did not sort out at this stage which service
>might be harmless and which not (or less), we only added access control
>to all Xenomai syscalls. Again, you can switch the whole checking off
>during compile time, but this, of course, opens the door completely.
>Given your system is adequately secured against illicit logins, this can
>be a pragmatic solution.
>
>Ok, we might derive access control to the heap from the permissions a
>process has on /dev/rtheap. But is this an urging need to have security
>for all Xenomai services but heaps? Opening heaps would make access
>control more complicated without a clear security model behind it. But
>I'm always open to concrete user requirements!
>
>Jan
>
>  
>
>>Best Regards
>>Steph
>>
>>
>>Jan Kiszka wrote
>>
>>    
>>
>>>Petr Cervenka wrote:
>>> 
>>>
>>>      
>>>
>>>>Hi,
>>>>When I try to run realtime application under lesser than root rights, I get this strange error:
>>>>Xenomai: binding failed: Operation not permitted.
>>>>
>>>>Error showed after kernel update 2.6.15.6 -> 2.6.16.16 and xenomai update 2.1.1 -> daily snapshot (2006/05/18)
>>>>Changing of the rights of the /dev/rt* dousn't help.
>>>>
>>>>Any suggestions?
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>That's intended. Real-time means real power, so all skin syscalls now
>>>require root privileges (more precisely CAP_SYS_NICE). This can be
>>>switched off, but standard syscalls like mlockall may still demand root
>>>power (mlock'ing is at least size-limited for normal users on recent
>>>kernels). And with current real-time APIs, it makes no sense anyway to
>>>restrict the real-time user's permission by turning his account into a
>>>non-root one.
>>>
>>>Jan
>>>
>>> 
>>>
>>>------------------------------------------------------------------------
>>>
>>>_______________________________________________
>>>Xenomai-help mailing list
>>>Xenomai-help@domain.hid
>>>https://mail.gna.org/listinfo/xenomai-help
>>> 
>>>
>>>      
>>>
>
>
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Xenomai-help mailing list
>Xenomai-help@domain.hid
>https://mail.gna.org/listinfo/xenomai-help
>  
>


