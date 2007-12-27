Message-ID: <477374E2.3020403@domain.hid>
Date: Thu, 27 Dec 2007 10:48:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <477275E0.7080001@domain.hid> <4772D19C.4030506@domain.hid>
	<4772EF89.4040101@domain.hid>
In-Reply-To: <4772EF89.4040101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH 3/3] i386: Cleanup root IRQ trampolines
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Simplifies xirq trampoline and applies the xirq refactorings to
>>> virq_handler too.
>>>
>> --- linux-2.6.23.12-xeno.orig/include/asm-i386/ipipe.h
>> +++ linux-2.6.23.12-xeno/include/asm-i386/ipipe.h
>> @@ -141,11 +141,7 @@ __ipipe_call_root_xirq_handler(unsigned
>>  		"pushl %%ds\n\t"
>>  		"pushl %%eax\n\t"
>>  		"pushl %%ebp\n\t"
>> -		"pushl %%edi\n\t"
>> -		"pushl %%esi\n\t"
>> -		"pushl %%edx\n\t"
>> -		"pushl %%ecx\n\t"
>> -		"pushl %%ebx\n\t"
>> +		"subl  $5*4,%%esp	# rest can remain unsaved\n\t"
>>
>> This won't work. We actually want to save our regs, so that they are
>> restored when going back to xirq_end through the iret path. If we don't
>> save them, the registers will remain terminally clobbered.
> 
> General purpose registers aren't stable across functions calls. But it
> is a valid question what the compiler assumes due to the function
> inlining here. So declaring those five clobbered should be safe enough -
> but if you prefer to add a few extra cycles for safety, keep it as
> explicit as it was :->.
> 

Declaring clobbers would duplicate what entry.S already does when
restoring args from the interrupt frame.

-- 
Philippe.

