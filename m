Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <20091104065257.A164B3F6C1@domain.hid>
Date: Tue, 3 Nov 2009 23:11:57 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <E9E5F92E-E406-4355-8E41-AE5E970F250C@usc.edu>
References: <B0122F57-107F-4E31-A663-D4DE560C08B8@domain.hid>
	<C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid>
	<20091104065257.A164B3F6C1@domain.hid>
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
Cc: xenomai@xenomai.org, Peter Pastor <pastor@domain.hid>

Hi Wolfgang,

  ok, good point. Let's replace the "math loop" with:

   for (i=1; i<=1000000000; ++i) {
     foo = foo*1.1;
     foo = foo/1.1;
     foo = pow(foo,1.0);
   }

   printf("foo=%f\n",foo);


Will this get your system to an almost stand-still?

-Stefan




On Nov 3, 2009, at 22:52, Wolfgang Denk wrote:

> Dear Stefan Schaal,
>
> In message <C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid> you wrote:
>> Sorry, I attached the wrong C-program in the previous posting ....
>> here is the corrected version:
>
> I'm not sure what exactly you are trying to test, but I think you
> should invest a little more time in your test cases.
>
>>  attached is a little C program that spawns off a task which runs a
>> heavy tiny math job. Despite my 8 processor machine, taking this one
>
> Does it? Not for me.
>
>> void
>> run_task(void *dummy)
>> {
>>   int i;
>>   double foo = 1.0;
>>
>>   for (i=1; i<=100000000; ++i)
>>     foo = foo*1.1;
>>
>>   return;
>> }
>
> On x86, this code compiles for me into this:
>
>        .text
>        .p2align 4,,15
> .globl run_task
>        .type   run_task, @function
> run_task:
>        pushl   %ebp
>        movl    %esp, %ebp
>        popl    %ebp
>        ret
>        .size   run_task, .-run_task
>        .ident  "GCC: (GNU) 4.4.1 20090725 (Red Hat 4.4.1-2)"
>        .section        .note.GNU-stack,"",@progbits
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
> -- 
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
> "Nature is very un-American.  Nature never hurries."
> - William George Jordan
>


