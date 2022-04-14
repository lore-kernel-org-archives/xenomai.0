Message-ID: <54b7b6a9-de04-54e9-b8dc-c8053a64b060@siemens.com>
Date: Thu, 14 Apr 2022 13:12:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] testsuite: Hook up alchemytests
Content-Language: en-US
References: <20220408080401.22235-1-richard@nod.at>
 <20220408080401.22235-3-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220408080401.22235-3-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 08.04.22 10:03, Richard Weinberger via Xenomai wrote:
> Build them using Xenomai's build system.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  configure.ac                       |   1 +
>  testsuite/Makefile.am              |   6 +-
>  testsuite/alchemytests/Makefile.am | 148 +++++++++++++++++++++++++++++
>  3 files changed, 153 insertions(+), 2 deletions(-)
>  create mode 100644 testsuite/alchemytests/Makefile.am
> 

With only up to here applied:

make[2]: Entering directory 'xenomai/build/testsuite/alchemytests'
make[2]: *** No rule to make target 'alchemytest_driver.c', needed by
'alchemytest_driver.o'.  Stop.

> diff --git a/configure.ac b/configure.ac
> index 019453793..8fd86e5a1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1046,6 +1046,7 @@ AC_CONFIG_FILES([ \
>  	testsuite/smokey/can/Makefile
>  	testsuite/clocktest/Makefile \
>  	testsuite/xeno-test/Makefile \
> +	testsuite/alchemytests/Makefile \
>  	utils/Makefile \
>  	utils/hdb/Makefile \
>  	utils/can/Makefile \
> diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
> index 4932f6d33..e027485fb 100644
> --- a/testsuite/Makefile.am
> +++ b/testsuite/Makefile.am
> @@ -7,7 +7,8 @@ SUBDIRS += 		\
>  	gpiotest	\
>  	spitest		\
>  	switchtest	\
> -	xeno-test
> +	xeno-test	\
> +	alchemytests
>  endif
>  
>  DIST_SUBDIRS =		\
> @@ -18,4 +19,5 @@ DIST_SUBDIRS =		\
>  	smokey		\
>  	spitest		\
>  	switchtest	\
> -	xeno-test
> +	xeno-test	\
> +	alchemytests
> diff --git a/testsuite/alchemytests/Makefile.am b/testsuite/alchemytests/Makefile.am
> new file mode 100644
> index 000000000..35df0d49c
> --- /dev/null
> +++ b/testsuite/alchemytests/Makefile.am
> @@ -0,0 +1,148 @@
> +testdir = @XENO_TEST_DIR@
> +
> +CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
> +
> +test_PROGRAMS = alchemytest_driver \
> +		alarm1		   \
> +		buffer1		   \
> +		event1		   \
> +		heap1		   \
> +		heap2		   \
> +		mq1		   \
> +		mq2		   \
> +		mq3		   \
> +		mutex1		   \
> +		pipe1		   \
> +		sem1		   \
> +		sem2		   \
> +		task1		   \
> +		task2		   \
> +		task3		   \
> +		task4		   \
> +		task5		   \
> +		task6		   \
> +		task7		   \
> +		task8		   \
> +		task9		   \
> +		task10
> +
> +alchemycppflags = 				\
> +	$(XENO_USER_CFLAGS)		\
> +	-I$(top_srcdir)/include
> +
> +alchemyldadd = 					\
> +	../../lib/alchemy/libalchemy@CORE@.la		\
> +	../../lib/copperplate/libcopperplate@CORE@.la	\
> +	@XENO_CORE_LDADD@ 			\
> +	@XENO_USER_LDADD@			\
> +	-lpthread -lrt -lm
> +
> +alarm1_SOURCES = alarm-1.c
> +alarm1_CPPFLAGS = $(alchemycppflags)
> +alarm1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alarm1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +event1_SOURCES = event-1.c
> +event1_CPPFLAGS = $(alchemycppflags)
> +event1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +event1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +heap1_SOURCES = heap-1.c
> +heap1_CPPFLAGS = $(alchemycppflags)
> +heap1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +heap1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +heap2_SOURCES = heap-2.c
> +heap2_CPPFLAGS = $(alchemycppflags)
> +heap2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +heap2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +buffer1_SOURCES = buffer-1.c
> +buffer1_CPPFLAGS = $(alchemycppflags)
> +buffer1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +buffer1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +mutex1_SOURCES = mutex-1.c
> +mutex1_CPPFLAGS = $(alchemycppflags)
> +mutex1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +mutex1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +pipe1_SOURCES = pipe-1.c
> +pipe1_CPPFLAGS = $(alchemycppflags)
> +pipe1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +pipe1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +mq1_SOURCES = mq-1.c
> +mq1_CPPFLAGS = $(alchemycppflags)
> +mq1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +mq1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +mq2_SOURCES = mq-2.c
> +mq2_CPPFLAGS = $(alchemycppflags)
> +mq2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +mq2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +mq3_SOURCES = mq-3.c
> +mq3_CPPFLAGS = $(alchemycppflags)
> +mq3_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +mq3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +sem1_SOURCES = sem-1.c
> +sem1_CPPFLAGS = $(alchemycppflags)
> +sem1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +sem2_SOURCES = sem-2.c
> +sem2_CPPFLAGS = $(alchemycppflags)
> +sem2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +task1_SOURCES = task-1.c
> +task1_CPPFLAGS = $(alchemycppflags)
> +task1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +task2_SOURCES = task-2.c
> +task2_CPPFLAGS = $(alchemycppflags)
> +task2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +task3_SOURCES = task-3.c
> +task3_CPPFLAGS = $(alchemycppflags)
> +task3_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +task3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +task4_SOURCES = task-4.c
> +task4_CPPFLAGS = $(alchemycppflags)
> +task4_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +task4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +task5_SOURCES = task-5.c
> +task5_CPPFLAGS = $(alchemycppflags)
> +task5_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +task5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +task6_SOURCES = task-6.c
> +task6_CPPFLAGS = $(alchemycppflags)
> +task6_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +task6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +task7_SOURCES = task-7.c
> +task7_CPPFLAGS = $(alchemycppflags)
> +task7_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +task7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +task8_SOURCES = task-8.c
> +task8_CPPFLAGS = $(alchemycppflags)
> +task8_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +task8_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +task9_SOURCES = task-9.c
> +task9_CPPFLAGS = $(alchemycppflags)
> +task9_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +task9_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> +task10_SOURCES = task-10.c
> +task10_CPPFLAGS = $(alchemycppflags)
> +task10_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@

Lots of repetitions. Can we use at least some macro for them, or can't
we assign CPPFLAGS, LDADD and LDFLAGS globally (in this file)?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

