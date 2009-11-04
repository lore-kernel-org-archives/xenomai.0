Message-ID: <4AF12B70.3020004@domain.hid>
Date: Tue, 03 Nov 2009 23:21:20 -0800
From: Jonas Buchli <jonas@domain.hid>
MIME-Version: 1.0
References: <B0122F57-107F-4E31-A663-D4DE560C08B8@domain.hid>	<C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid>
	<20091104065257.A164B3F6C1@domain.hid>
In-Reply-To: <20091104065257.A164B3F6C1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] bring down the system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: Peter Pastor <pastor@domain.hid>, xenomai@xenomai.org

wolfgang,

did you compile with exactly our compile statement or with additional 
flags (i.e. optimization)?

compiling with our statement, just throwing in the -S flag, i am getting 
a very getting different assembly code - while has been a while i have 
been reading assembly, it seems our loop is not getting optimized away.

anyway, the point here is not about if this is a meaningful program or 
not, but we are getting system lock ups and this one is a minimal 
program that does reproduce the problem for us.

best
jonas

Wolfgang Denk wrote:
> Dear Stefan Schaal,
> 
> In message <C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid> you wrote:
>> Sorry, I attached the wrong C-program in the previous posting ....  
>> here is the corrected version:
> 
> I'm not sure what exactly you are trying to test, but I think you
> should invest a little more time in your test cases.
> 
>>   attached is a little C program that spawns off a task which runs a  
>> heavy tiny math job. Despite my 8 processor machine, taking this one  
> 
> Does it? Not for me.
> 
>> void
>> run_task(void *dummy)
>> {
>>    int i;
>>    double foo = 1.0;
>>
>>    for (i=1; i<=100000000; ++i)
>>      foo = foo*1.1;
>>
>>    return;
>> }
> 
> On x86, this code compiles for me into this:
> 
>         .text
>         .p2align 4,,15
> .globl run_task
>         .type   run_task, @function
> run_task:
>         pushl   %ebp
>         movl    %esp, %ebp
>         popl    %ebp
>         ret
>         .size   run_task, .-run_task
>         .ident  "GCC: (GNU) 4.4.1 20090725 (Red Hat 4.4.1-2)"
>         .section        .note.GNU-stack,"",@progbits
> 
> Similar on ARM and Power.
> 
> As you can see, the compiler completely optimizes away your "tiny math
> job". So what should be loading your CPU?
> 
> Best regards,
> 
> Wolfgang Denk
> 

-- 
--------------------------------------------------------------
Jonas Buchli, Dr.sc., MSc EE
Computational Learning and Motor Control Lab
University of Southern California
http://www-clmc.usc.edu/
+1 (213) 740 67 17
--------------------------------------------------------------

