Message-ID: <4FCF58AF.5040106@xenomai.org>
Date: Wed, 06 Jun 2012 15:18:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfz7+pRjjbE6Ev4zJNZpa45axMePyVar+3MyRyMvcp8aA@mail.gmail.com>	<4FCF1517.3010904@xenomai.org>	<CAKKWdtfRyuhDzmvCC-WM66+=ncs+ocbdUuop2TRNThsj6ZAy6g@mail.gmail.com>	<4FCF1ED5.5000403@xenomai.org>	<CAKKWdtd6p2-xHH1FdjVzbX-raNtDkvMemALrQBJMgoTb1dScnw@mail.gmail.com>	<4FCF2751.5070700@xenomai.org>
	<4FCF4D05.3070502@xenomai.org>
In-Reply-To: <4FCF4D05.3070502@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-2.6.0 instrumentation commands not executing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai@xenomai.org

On 06/06/2012 02:28 PM, Philippe Gerum wrote:
> On 06/06/2012 11:48 AM, Philippe Gerum wrote:
>> On 06/06/2012 11:18 AM, ali hagigat wrote:
>>> Much appreciate for the reply, Mr. Gerum. Here is the result of ldd 
>>> command:
>>>
>>
>> http://www.xenomai.org/pipermail/xenomai-help/2011-12/msg00012.html
> 
> Alternatively, this patch may work as well (not tested, but this
> looks like a former issue we had with aggressive optimizers):
> 
> diff --git a/src/skins/posix/init.c b/src/skins/posix/init.c
> index 7a338a0..9c7849e 100644
> --- a/src/skins/posix/init.c
> +++ b/src/skins/posix/init.c
> @@ -43,6 +43,7 @@ void pse51_clock_init(int);
>  static __attribute__ ((constructor))
>  void __init_posix_interface(void)
>  {
> +	volatile pthread_t tid = pthread_self();
>  #ifndef CONFIG_XENO_LIBS_DLOPEN
>  	struct sched_param parm;
>  	int policy;
> @@ -80,14 +81,14 @@ void __init_posix_interface(void)
>  
>  	/* Don't use auto-shadowing if we are likely invoked from dlopen. */
>  #ifndef CONFIG_XENO_LIBS_DLOPEN
> -	err = __real_pthread_getschedparam(pthread_self(), &policy, &parm);
> +	err = __real_pthread_getschedparam(tid, &policy, &parm);
>  	if (err) {
>  		fprintf(stderr, "Xenomai Posix skin init: "
>  			"pthread_getschedparam: %s\n", strerror(err));
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	err = __wrap_pthread_setschedparam(pthread_self(), policy, &parm);
> +	err = __wrap_pthread_setschedparam(tid, policy, &parm);
>  	if (err) {
>  		fprintf(stderr, "Xenomai Posix skin init: "
>  			"pthread_setschedparam: %s\n", strerror(err));

There should not be any issue here, as the pthread_self() is passed as
an argument to the called functions, the syscall is not inlined directly.

-- 
					    Gilles.

