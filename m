Message-ID: <44859D3F.50800@domain.hid>
Date: Tue, 06 Jun 2006 15:20:31 +0000
From: "s.a." <sancelot@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai: binding failed: Operation not permitted.
References: 446C264A.7040206@domain.hid>	<200605181426.8240@domain.hid>	<446C6C1C.2010902@domain.hid>	<200605190943.31667@domain.hid>
	<446D7DE6.10402@domain.hid>
In-Reply-To: <446D7DE6.10402@domain.hid>
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

Okay, but in this case, why do we need  root permissions for programs
accessing that "only" access shared memory area (heaps)????

Best Regards
Steph


Jan Kiszka wrote

>Petr Cervenka wrote:
>  
>
>>Hi,
>>When I try to run realtime application under lesser than root rights, I get this strange error:
>>Xenomai: binding failed: Operation not permitted.
>>
>>Error showed after kernel update 2.6.15.6 -> 2.6.16.16 and xenomai update 2.1.1 -> daily snapshot (2006/05/18)
>>Changing of the rights of the /dev/rt* dousn't help.
>>
>>Any suggestions?
>>
>>    
>>
>
>That's intended. Real-time means real power, so all skin syscalls now
>require root privileges (more precisely CAP_SYS_NICE). This can be
>switched off, but standard syscalls like mlockall may still demand root
>power (mlock'ing is at least size-limited for normal users on recent
>kernels). And with current real-time APIs, it makes no sense anyway to
>restrict the real-time user's permission by turning his account into a
>non-root one.
>
>Jan
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


