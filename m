Message-ID: <51ECE12A.4070700@xenomai.org>
Date: Mon, 22 Jul 2013 09:37:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1374143094.1082.YahooMailNeo@web172202.mail.ir2.yahoo.com>
	<51E900B7.9070604@xenomai.org>
	<1374227358.60075.YahooMailNeo@web172203.mail.ir2.yahoo.com>
	<51E9106C.3000909@xenomai.org>
	<1374231441.29790.YahooMailNeo@web172205.mail.ir2.yahoo.com>
In-Reply-To: <1374231441.29790.YahooMailNeo@web172205.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __xn_sys_current_info failed: Operation not permitted
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Franz Engel <franz_lambert_engel@yahoo.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/19/2013 12:57 PM, Franz Engel wrote:
>
>
>     ------------------------------------------------------------------------
>     *Von:* Philippe Gerum <rpm@xenomai.org>
>     *An:* Franz Engel <franz_lambert_engel@yahoo.de>
>     *CC:* "xenomai@xenomai.org" <xenomai@xenomai.org>
>     *Gesendet:* 12:09 Freitag, 19.Juli 2013
>     *Betreff:* Re: [Xenomai] __xn_sys_current_info failed: Operation not
>     permitted
>
>     On 07/19/2013 11:49 AM, Franz Engel wrote:
>      > Philippe wrote:
>      >>> Franz Engel wrote:
>      >>> Hi,
>      >> >
>      >>> I get this error when I run a programm:
>      >>> __xn_sys_current_info failed: Operation not permitted
>      >> >
>      >>> I know that the error comes from the assert_nrt_inner(void)
>     function inside the assert_context.c file. But I have no idea what
>     is the reason. The Operation not permitted is the return value from
>     XENOMAI_SYSCALL1(__xn_sys_current_info, &info);. But I found no
>     documentation about this function.
>      >
>      >
>      >>This is reminiscent of a symptom observed for a bug fixed in the
>     -forge
>      >>tree, a while ago:
>      >>http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=014898add6a697e1a0d69f9e20b910ade74f1940
>      >
>      >>Do you happen to call fork() in your  application?
>      >
>      > Yes. I do? What I can do to solve the problem. Should I try to modify
>      > the xenomai files as discrept in the git-link?
>      >
>
>     I'm unsure, although this would be possible to backport portions of the
>     logic, the implementation has now diverged significantly between the
>     2.x
>     and 3.x code bases.
>
>     Could you try the patch below? It's untested, but should work around
>     the
>     root issue in your case:
>
>     diff --git a/include/nucleus/compiler.h b/include/nucleus/compiler.h
>     index 30f32c7..da4ea03 100644
>     --- a/include/nucleus/compiler.h
>     +++ b/include/nucleus/compiler.h
>     @@ -37,9 +37,11 @@
>
>        #ifdef __IN_XENO__
>        #if __GNUC__ == 4 && __GNUC_MINOR__ == 6
>     -#define __constructor__ __attribute__((constructor, noclone))
>     +#define __constructor__ __attribute__((constructor(200), noclone))
>     +#define __late_constructor__ __attribute__((constructor, noclone))
>        #else /* Gcc not 4.6 */
>     -#define __constructor__ __attribute__((constructor))
>     +#define __constructor__ __attribute__((constructor(200)))
>     +#define __late_constructor__ __attribute__((constructor))
>        #endif /* Gcc not 4.6 */
>        #endif /* In xenomai */
>
>     diff --git a/src/skins/common/rt_print.c b/src/skins/common/rt_print.c
>     index dfa8b33..e056cd6 100644
>     --- a/src/skins/common/rt_print.c
>     +++ b/src/skins/common/rt_print.c
>     @@ -738,7 +738,7 @@ static void forked_child_init(void)
>                spawn_printer_thread();
>     }
>
>     -static __constructor__ void __rt_print_init(void)
>     +static __late_constructor__ void __rt_print_init(void)
>        {
>            const char *value_str;
>            unsigned long long period;
>
>     --
>     Philippe.
>
>     I tried the patch. But I think it is not the correct version of
>     xenomai. In my compiler.h there is no line "#define __constructor__
>     __attribute__((constructor, noclone))". I use Xenomai 2.6.2.1.
>

With 2.6.2.1, you need the patch below applied, before applying the 
suggested work around:
6e89cb2287378a7dcbba987949d0168460dabbe7

Bottom line is that all library constructor routines shall be tagged 
with the __constructor__ qualifier, except rt_print_init which should be 
__late_constructor__ instead. Otherwise the change makes no sense.

-- 
Philippe.

