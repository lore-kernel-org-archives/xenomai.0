Message-ID: <490B3E58.3010206@domain.hid>
Date: Fri, 31 Oct 2008 18:20:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <857546.30206.qm@domain.hid>
	<490B32EF.8050503@domain.hid>
	<327543.30247.qm@domain.hid>
	<490B37D6.8050809@domain.hid>
	<352894.28773.qm@domain.hid>
In-Reply-To: <352894.28773.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] floating point (int 16) exception
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: xenomai@xenomai.org

Gabriele Moabiti wrote:
>> No, you do not read the sources correctly. Xenomai does handle FPU
>> exception in primary mode. You know, I implemented part of this, so, you
>> should not assume that I do not know what I am talking about.
> 
> I *REALLY* don't say you don't know what you say
> (I ask you 'cause I think you know... :)
> 
> ring 3 xenomai task:
> void xeno_task(void *cookie)
> {
>  static long loop_count=0;
>   unsigned int cw=0x360;
> 
>   /* Unmask all but not precision, the int 7 will be raised */
>   __asm__ __volatile__("fldcw %0;"::"m"(cw)); 
>   for (;;loop_count++) {
>     rt_task_wait_period(NULL);
>         rt_printf("Loop number: %ld\n", loop_count);
>     /* Let's raise an exception #16*/
>     __asm__ __volatile__(
>       "fldz;"
>       "fld1;"
>       "fdivrp %st(0),%st(1);"
>       "fwait;"
>     ); 
>   }
> }
> 
> xnarch_fault_fpu_p is related to int 7 that It manage the TS bit (fpu handling
> of save restore only if the task use fpu) and it works, it doesn't switch to secondary
> mode as you say.
> If I pass to Xenomai the exception 16 of fdivrp the task end 'cause (i thought) the
> switch to secondary mode. Sorry if i bug you but i really need a suggestion.

You mean you want to handle a division by zero without ending the
program, and without even switching to secondary mode? Then in this
case, I am afraid you are on your own.

-- 
                                                 Gilles.

