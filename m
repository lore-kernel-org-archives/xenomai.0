Message-ID: <48DB7A90.8070201@domain.hid>
Date: Thu, 25 Sep 2008 13:48:32 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200809222210.07837.niklaus.giger@domain.hid>
In-Reply-To: <200809222210.07837.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] vxworks: Adding tests for lstLib
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Niklaus Giger <niklaus.giger@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
> While testing I found that the behaviour of lstLib is not mimicked
> correctly by Xenomai-Solo.
> 
> I wrote a simple testsuite which passed all assertions on my
> vxWorks 6.6 system. It compiles under xxWorks and xenomai-solo.
> 
> I do not object, if you remove the conditional __SOLO__. Personally I 
> appreciate if I am able to run my testsuits without manual changes under 
> xenomai-solo and vxworks.
> 
> At the moment they fail miserably under xenomai-solo.
>

Fixed, thanks. However, I did not keep the __SOLO__ conditionals in your
example, since you could achieve portability using purely local means.
Suggestion: you could move the VXWorks code into a fake traceobj.h for VxWorks,
for instance, and symlink include/vxworks -> include/. to fix the include paths.

> It does not test splitting/merging lists.
> 
> Signed-off-by: Niklaus Giger <niklaus.giger@domain.hid>
> ---
>  vxworks/testsuite/Makefile |    2 +-
>  vxworks/testsuite/lst-1.c  |  190 
> ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 191 insertions(+), 1 deletions(-)
>  create mode 100644 vxworks/testsuite/lst-1.c
> 
> diff --git a/vxworks/testsuite/Makefile b/vxworks/testsuite/Makefile
> index 4967151..d1ce203 100644
> --- a/vxworks/testsuite/Makefile
> +++ b/vxworks/testsuite/Makefile
> @@ -5,7 +5,7 @@ ifeq ($(prefix),)
>  $(error Please add <xenomai-install-path>/bin to your PATH variable)
>  endif
>  
> -TESTS := task-1 task-2 msgQ-1 msgQ-2 msgQ-3 wd-1 sem-1 sem-2 sem-3 sem-4
> +TESTS := task-1 task-2 msgQ-1 msgQ-2 msgQ-3 wd-1 sem-1 sem-2 sem-3 sem-4 
> lst-1
>  
>  CFLAGS := $(shell $(XENO_CONFIG) --cflags) -g
>  LDFLAGS := -lvxworks $(shell $(XENO_CONFIG) --ldflags)
> diff --git a/vxworks/testsuite/lst-1.c b/vxworks/testsuite/lst-1.c
> new file mode 100644
> index 0000000..2b19511
> --- /dev/null
> +++ b/vxworks/testsuite/lst-1.c
> @@ -0,0 +1,190 @@
> +#ifdef __SOLO__
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <xenomai/traceobj.h>
> +#include <vxworks/errnoLib.h>
> +#include <vxworks/taskLib.h>
> +#include <vxworks/lstLib.h>
> +
> +static struct traceobj trobj;
> +
> +static int tseq[] = {
> +	10, 11, 12, 13, 20,
> +	1, 14, 15, 2, 3, 4,
> +	5, 6, 7, 8, 16, 17, 18,
> +	9, 21, 19
> +};
> +#else
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <errnoLib.h>
> +#include <taskLib.h>
> +#include <semLib.h>
> +
> +#define traceobj_init(a, b, c)
> +#define traceobj_enter(trobj)
> +#define traceobj_exit(trobj)
> +#define traceobj_join(trobj)
> +
> +static int nrPassed;
> +
> +#define traceobj_assert(obj, cond) \
> +  if (cond)   nrPassed ++; \
> +  else printf("assert failed at %s line %d\n", __FUNCTION__, __LINE__);\
> +
> +#define traceobj_mark(a, b)
> +#define traceobj_verify(a, b, c)
> +#endif
> +
> +void rootTask(long a0, long a1, long a2, long a3, long a4,
> +	      long a5, long a6, long a7, long a8, long a9)
> +{
> +	int ret;
> +
> +	traceobj_enter(&trobj);
> +
> +	traceobj_mark(&trobj, 1);
> +
> +    LIST list;
> +    NODE  first, second, third, fourth;
> +    traceobj_assert(&trobj, 0 == lstNth (0, 1));
> +/*
> +    traceobj_assert(&trobj, 0 == lstFirst(0));
> +    traceobj_assert(&trobj, 0 == lstLast(0));
> + */
> +    lstInit(&list);
> +    traceobj_assert(&trobj, 0 == lstCount(&list));
> +    traceobj_assert(&trobj, 0 == lstFirst(&list));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 0));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 1));
> +
> +    lstAdd(&list, &first);
> +    traceobj_assert(&trobj, 1 == lstCount(&list));
> +    traceobj_assert(&trobj, &first == lstFirst(&list));
> +    traceobj_assert(&trobj, &first == lstLast(&list));
> +    traceobj_assert(&trobj, 0 == lstPrevious (&first));
> +    traceobj_assert(&trobj, 0 == lstNext     (&first));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 0));
> +    traceobj_assert(&trobj, &first == lstNth (&list, 1));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 2));
> +
> +    lstAdd(&list, &second);
> +    traceobj_assert(&trobj, 2 == lstCount(&list));
> +    traceobj_assert(&trobj, &first == lstFirst(&list));
> +    traceobj_assert(&trobj, &second == lstLast(&list));
> +    traceobj_assert(&trobj, 0 == lstPrevious (&first)); // breaks here under 
> xenomai-solo
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 0));
> +    traceobj_assert(&trobj, &first  == lstNth (&list, 1));
> +    traceobj_assert(&trobj, &second == lstNth (&list, 2));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 3));
> +
> +    lstAdd(&list, &third);
> +    traceobj_assert(&trobj, 3 == lstCount(&list));
> +    traceobj_assert(&trobj, 0 == lstPrevious (&first));
> +    traceobj_assert(&trobj, &third == lstLast(&list));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 0));
> +    traceobj_assert(&trobj, &first  == lstNth (&list, 1));
> +    traceobj_assert(&trobj, &second == lstNth (&list, 2));
> +    traceobj_assert(&trobj, &third  == lstNth (&list, 3));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 4));
> +
> +    lstAdd(&list, &fourth);
> +    traceobj_assert(&trobj, 4 == lstCount(&list));
> +    traceobj_assert(&trobj, 0 == lstPrevious (&first));
> +    traceobj_assert(&trobj, &fourth == lstLast(&list));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 0));
> +    traceobj_assert(&trobj, &first  == lstNth (&list, 1));
> +    traceobj_assert(&trobj, &second == lstNth (&list, 2));
> +    traceobj_assert(&trobj, &third  == lstNth (&list, 3));
> +    traceobj_assert(&trobj, &fourth == lstNth (&list, 4));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 5));
> +
> +    lstDelete(&list, &third);
> +    traceobj_assert(&trobj, 3 == lstCount(&list));
> +    traceobj_assert(&trobj, 0 == lstPrevious (&first));
> +    traceobj_assert(&trobj, &fourth == lstLast(&list));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 0));
> +    traceobj_assert(&trobj, &first  == lstNth (&list, 1));
> +    traceobj_assert(&trobj, &second == lstNth (&list, 2));
> +    traceobj_assert(&trobj, &fourth == lstNth (&list, 3));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 4));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 5));
> +
> +    lstInsert(&list, &second, &third);
> +    traceobj_assert(&trobj, 4 == lstCount(&list));
> +    traceobj_assert(&trobj, 0 == lstPrevious (&first));
> +    traceobj_assert(&trobj, &fourth == lstLast(&list));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 0));
> +    traceobj_assert(&trobj, &first  == lstNth (&list, 1));
> +    traceobj_assert(&trobj, &second == lstNth (&list, 2));
> +    traceobj_assert(&trobj, &third  == lstNth (&list, 3));
> +    traceobj_assert(&trobj, &fourth == lstNth (&list, 4));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 5));
> +
> +    traceobj_assert(&trobj, &fourth == lstNStep(&second, 2));
> +    traceobj_assert(&trobj, 4 == lstCount(&list));
> +    traceobj_assert(&trobj, 0 == lstPrevious (&first));
> +    traceobj_assert(&trobj, &fourth == lstLast(&list));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 0));
> +    traceobj_assert(&trobj, &first  == lstNth (&list, 1));
> +    traceobj_assert(&trobj, &second == lstNth (&list, 2));
> +    traceobj_assert(&trobj, &third  == lstNth (&list, 3));
> +    traceobj_assert(&trobj, &fourth == lstNth (&list, 4));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 5));
> +
> +    traceobj_assert(&trobj, 1 == lstFind(&list, &first ));
> +    traceobj_assert(&trobj, 2 == lstFind(&list, &second));
> +    traceobj_assert(&trobj, 3 == lstFind(&list, &third ));
> +    traceobj_assert(&trobj, 4 == lstFind(&list, &fourth));
> +    traceobj_assert(&trobj, 4 == lstCount(&list));
> +    traceobj_assert(&trobj, 0 == lstPrevious (&first));
> +    traceobj_assert(&trobj, &fourth == lstLast(&list));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 0));
> +    traceobj_assert(&trobj, &first  == lstNth (&list, 1));
> +    traceobj_assert(&trobj, &second == lstNth (&list, 2));
> +    traceobj_assert(&trobj, &third  == lstNth (&list, 3));
> +    traceobj_assert(&trobj, &fourth == lstNth (&list, 4));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 5));
> +
> +    traceobj_assert(&trobj, &first == lstGet(&list));
> +    traceobj_assert(&trobj, 3 == lstCount(&list));
> +    traceobj_assert(&trobj, 0 == lstPrevious (&first));
> +    traceobj_assert(&trobj, 0 == lstPrevious (&second));
> +    traceobj_assert(&trobj, &fourth == lstLast(&list));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 0));
> +    traceobj_assert(&trobj, &second == lstNth (&list, 1));
> +    traceobj_assert(&trobj, &third  == lstNth (&list, 2));
> +    traceobj_assert(&trobj, &fourth == lstNth (&list, 3));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 4));
> +    traceobj_assert(&trobj, 0 == lstNth (&list, 5));
> +
> +
> +
> +#ifndef __SOLO__
> +    printf("\npeerTask done passed %d \n", nrPassed);
> +#endif
> +	traceobj_assert(&trobj, ret == OK);
> +
> +	traceobj_exit(&trobj);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int ret = OK;
> +
> +	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
> +
> +#ifdef __SOLO__
> +	ret = kernelInit(rootTask, argc, argv);
> +#endif
> +	traceobj_assert(&trobj, ret == OK);
> +
> +	traceobj_mark(&trobj, 20);
> +
> +	traceobj_join(&trobj);
> +
> +	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
> +
> +	exit(0);
> +}


-- 
Philippe.

