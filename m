Message-ID: <4472D4E8.3090005@domain.hid>
Date: Tue, 23 May 2006 11:24:56 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Almost running - kernel BUG in add_preempt_count
	at	kernel/sched.c:2819!
References: <447231CC.9080708@domain.hid>
	<4472BA8D.9090408@domain.hid>
In-Reply-To: <4472BA8D.9090408@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, wallace@domain.hid, Jim.Rosenow@domain.hid, jan.kiszka@domain.hid

Philippe Gerum wrote:
> Gary Wallace wrote:
> 
>>   I've attached first the config file used without the motorola
>> patches, and then the config file used with a motorola patched
>> kernel.
>>
> 
> Both config builds perfectly here. Please send me privately the output 
> of a full build for the motorola patched kernel (make V=1). TIA,
> 

Ok, don't bother. You did not build a uImage like I did. I do have this 
issue with the default Makefile target too.

-- 

Philippe.

