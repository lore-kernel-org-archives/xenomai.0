From: Marcel Van Mierlo <Marcel.VanMierlo@marel.com>
Date: Wed, 8 Jun 2016 09:11:00 +0000
Message-ID: <AM4PR05MB1747728DA27DE760AD5DF39E915E0@AM4PR05MB1747.eurprd05.prod.outlook.com>
References: <AM4PR05MB17479649FDCD91F251E66DB991740@AM4PR05MB1747.eurprd05.prod.outlook.com>
 <37e28fa0-0e14-6b84-dc43-e0f64c16c226@xenomai.org>
 <AM4PR05MB17470B585705C4680E3DF0EC915C0@AM4PR05MB1747.eurprd05.prod.outlook.com>,
 <de32dcc4-3237-3686-779d-3cdf280eba2d@xenomai.org>
In-Reply-To: <de32dcc4-3237-3686-779d-3cdf280eba2d@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] what limits number of pSOS tasks using t_create?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe,

I'm just creating the tasks, not starting them. I am using googletest as a =
unit-test framework.

I see this during a single invocation of the test application. When I run t=
he test again (on same running instance of Xenomai), the results are repeat=
ed. So seems related to resource usage of application instance only, and no=
t global resources.

Regression tests, below. I ran them longer and notice that the maximum numb=
er of tasks I can create tends to increase between tests after being hit th=
e first time...

MaxThreadsLimit_Pre and MaxThreadsLimit_Post are identical and create what =
should be a safe number of threads (750). MaxThreads tries to create 5000 t=
hreads and fails.
MaxThreadsLimit_Pre always succeeds. MaxThreads and MaxThreads_Post always =
fail - see test results, below.

Issue could be with memory management with googletest...but seems unlikely =
(as far as I can tell it isn't spawning threads).

If I monitor /proc/xenomai/heap, I see free "system heap" get pretty low du=
ring MasThreadsLimit_Pre, but interestingly it seems to generally stay high=
er for the other two tests...free shared and private heap stay healthy. As =
if some other internal resource is not getting returned to a free pool.

Here is the unit-test code. The test framework state is reset between invoc=
ation of each TEST instance, but they all run in the same application insta=
nce.

 11 #define MAXTHREAD_ITERATIONS  20
 12 #define NUM_THREADS_LIMIT     750
 13 #define NUM_THREADS           5000
 14
 15 TEST(Threads, MaxThreadsLimit_Pre) {
 16   int i;
 17
 18   for (i =3D 0; i < MAXTHREAD_ITERATIONS; i++)
 19   {
 20     EXPECT_EQ (MaxThreads(NUM_THREADS_LIMIT), NUM_THREADS_LIMIT);
 21   }
 22 }
 23
 24 TEST(Threads, MaxThreads) {
 25   int i;
 26
 27   for (i =3D 0; i < MAXTHREAD_ITERATIONS; i++)
 28   {
 29     EXPECT_EQ (MaxThreads(NUM_THREADS), NUM_THREADS);
 30   }
 31 }
 32
 33 TEST(Threads, MaxThreadsLimit_Post) {
 34   int i;
 35
 36   for (i =3D 0; i < MAXTHREAD_ITERATIONS; i++)
 37   {
 38     EXPECT_EQ (MaxThreads(NUM_THREADS_LIMIT), NUM_THREADS_LIMIT);
 39   }
 40 }

 11 #define MAX_TIDS (10000)
 12
 13 ULONG tids [MAX_TIDS];
 14 int MaxThreads(int limit)
 15 {
 16   int result  =3D 0;
 17   int i       =3D 0;
 18   int j       =3D 0;
 19   int dc      =3D 0; //delete count
 20
 21   if ((limit > 0) && (limit < MAX_TIDS))
 22   {
 23     bzero (tids, sizeof(tids));
 24
 25     for (i =3D 0; i < limit; i++)
 26     {
 27       result =3D t_create("MAX_THREAD_TEST", 200, 0x1000, 0x1000, T_LOC=
AL, &tids[i]);
 28
 29       if (result !=3D 0)
 30         break;
 31     }
 32
 33     //cleardown allocated tasks
 34     for (j =3D 0; j < i; j++)
 35     {
 36       if (tids[j])
 37       {
 38         if (t_delete (tids[j]) =3D=3D 0x00)
 39           dc++;
 40       }
 41     }
 42   }
 43
 44   return dc;
 45 }
 9 [----------] 3 tests from Threads
 10 [ RUN      ] Threads.MaxThreadsLimit_Pre
 11 [       OK ] Threads.MaxThreadsLimit_Pre (15521 ms)

 12 [ RUN      ] Threads.MaxThreads
 13       Expected: MaxThreads(5000) Which is: 847
 14 To be equal to: 5000
 15       Expected: MaxThreads(5000) Which is: 336
 16 To be equal to: 5000
 17       Expected: MaxThreads(5000) Which is: 338
 18 To be equal to: 5000
 19       Expected: MaxThreads(5000) Which is: 549
 20 To be equal to: 5000
 21       Expected: MaxThreads(5000) Which is: 560
 22 To be equal to: 5000
 23       Expected: MaxThreads(5000) Which is: 563
 24 To be equal to: 5000
 25       Expected: MaxThreads(5000) Which is: 571
 26 To be equal to: 5000
 27       Expected: MaxThreads(5000) Which is: 571
 28 To be equal to: 5000
 29       Expected: MaxThreads(5000) Which is: 573
 30 To be equal to: 5000
 31       Expected: MaxThreads(5000) Which is: 586
 32 To be equal to: 5000
 33       Expected: MaxThreads(5000) Which is: 588
 34 To be equal to: 5000
 35       Expected: MaxThreads(5000) Which is: 596
 36 To be equal to: 5000
 37       Expected: MaxThreads(5000) Which is: 619
 38 To be equal to: 5000
 39       Expected: MaxThreads(5000) Which is: 630
 40 To be equal to: 5000
 41       Expected: MaxThreads(5000) Which is: 634
 42 To be equal to: 5000
 43       Expected: MaxThreads(5000) Which is: 645
 44 To be equal to: 5000
 45       Expected: MaxThreads(5000) Which is: 647
 46 To be equal to: 5000
 47       Expected: MaxThreads(5000) Which is: 653
 48 To be equal to: 5000
 49       Expected: MaxThreads(5000) Which is: 663
 50 To be equal to: 5000
 51       Expected: MaxThreads(5000) Which is: 666
 52 To be equal to: 5000
 53 [  FAILED  ] Threads.MaxThreads (10090 ms)

 54 [ RUN      ] Threads.MaxThreadsLimit_Post
 55       Expected: MaxThreads(750) Which is: 675
 56 To be equal to: 750
 57       Expected: MaxThreads(750) Which is: 679
 58 To be equal to: 750
 59       Expected: MaxThreads(750) Which is: 672
 60 To be equal to: 750
 61       Expected: MaxThreads(750) Which is: 674
 62 To be equal to: 750
 63       Expected: MaxThreads(750) Which is: 678
 64 To be equal to: 750
 65       Expected: MaxThreads(750) Which is: 674
 66 To be equal to: 750
 67       Expected: MaxThreads(750) Which is: 676
 68 To be equal to: 750
 69       Expected: MaxThreads(750) Which is: 679
 70 To be equal to: 750
 71       Expected: MaxThreads(750) Which is: 672
 72 To be equal to: 750
 73       Expected: MaxThreads(750) Which is: 674
 74 To be equal to: 750
 75       Expected: MaxThreads(750) Which is: 678
 76 To be equal to: 750
 77       Expected: MaxThreads(750) Which is: 674
 78 To be equal to: 750
 79       Expected: MaxThreads(750) Which is: 676
 80 To be equal to: 750
 81       Expected: MaxThreads(750) Which is: 678
 82 To be equal to: 750
 83       Expected: MaxThreads(750) Which is: 677
 84 To be equal to: 750
 85       Expected: MaxThreads(750) Which is: 676
 86 To be equal to: 750
 87       Expected: MaxThreads(750) Which is: 676
 88 To be equal to: 750
 89       Expected: MaxThreads(750) Which is: 676
 90 To be equal to: 750
 91       Expected: MaxThreads(750) Which is: 676
 92 To be equal to: 750
 93       Expected: MaxThreads(750) Which is: 676
 94 To be equal to: 750
 95 [  FAILED  ] Threads.MaxThreadsLimit_Post (11411 ms)
 96 [----------] 3 tests from Threads (37023 ms total)

root@WPL:/var/wpl# ./wpl.bin --dump-config
based on Xenomai/cobalt v3.0 -- #5f6b32f (2015-10-31 20:57:40 +0100)
CONFIG_MMU=3D1
CONFIG_XENO_BUILD_ARGS=3D" 'CFLAGS=3D-march=3Darmv7-a' 'CFLAGS=3D-mfpu=3Dne=
on' 'CFLAGS=3D-fomit-frame-pointer' 'LDFLAGS=3D-march=3Darmv7-a' '--with-co=
re=3Dcobalt' '--build=3Di686-pc-linux-gnu' '--host=3Darm-linux-gnueabihf' '=
-enable-lores-clock' '-enable-debug=3Dsymbols' 'build_alias=3Di686-pc-linux=
-gnu' 'host_alias=3Darm-linux-gnueabihf'"
CONFIG_XENO_BUILD_STRING=3D"i686-pc-linux-gnu"
CONFIG_XENO_COBALT=3D1
CONFIG_XENO_COMPILER=3D"gcc version 4.7.3 20121106 (prerelease) (crosstool-=
NG linaro-1.13.1-4.7-2012.11-20121123 - Linaro GCC 2012.11) "
CONFIG_XENO_DEFAULT_PERIOD=3D1000000
CONFIG_XENO_FORTIFY=3D1
CONFIG_XENO_HOST_STRING=3D"arm-unknown-linux-gnueabihf"
CONFIG_XENO_PREFIX=3D"/usr/xenomai"
CONFIG_XENO_RAW_CLOCK_ENABLED=3D1
CONFIG_XENO_REVISION_LEVEL=3D0
CONFIG_XENO_SANITY=3D1
CONFIG_XENO_TLSF=3D1
CONFIG_XENO_TLS_MODEL=3D"initial-exec"
CONFIG_XENO_UAPI_LEVEL=3D14
CONFIG_XENO_VERSION_MAJOR=3D3
CONFIG_XENO_VERSION_MINOR=3D0
CONFIG_XENO_VERSION_NAME=3D"Exact Zero"
CONFIG_XENO_VERSION_STRING=3D"3.0"
CONFIG_XENO_X86_VSYSCALL=3D1
---
CONFIG_SMP is OFF
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_LORES_CLOCK_DISABLED is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_PSHARED is OFF
CONFIG_XENO_REGISTRY is OFF
CONFIG_XENO_REGISTRY_ROOT is OFF
CONFIG_XENO_VALGRIND_API is OFF
CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
---
PTHREAD_STACK_DEFAULT=3D65536
________________________________________
From: Philippe Gerum <rpm@xenomai.org>
Sent: 07 June 2016 16:03:24
To: Marcel Van Mierlo; xenomai@xenomai.org
Subject: Re: [Xenomai] what limits number of pSOS tasks using t_create?

Hi,

On 06/06/2016 10:14 AM, Marcel Van Mierlo wrote:
>
> Hi Philippe, yes that worked.
>
> I made a regression test on the maximum number of psos threads I could cr=
eate. I found that once I start seeing ERR_NOTCB returned from t_create the=
 maximum number of tasks I can create then drops, even after deleting all p=
revious tasks - as if available memory for tasks becomes less after limit i=
s hit.
>
> For example, after tuning all four parameters below (including CONFIG_XEN=
O_OPT_REGISTRY_NRSLOTS) I am able to reliably create 500 tasks under test c=
onditions - if I push it to 600, say, and see ERR_NOTCB, then after deletin=
g all tasks I can only create a maximum of around 300 tasks.
>
> This is fine for me - I know I will never need more than 150 tasks, but s=
eems something worth noting.
>

I cannot reproduce that one yet. A few questions:

- are you starting the tasks or only creating them before calling
t_delete() on the tid?

- do you observe this behavior when respawning the test program after
each creation+deletion sequence, or within a single execution of the
test program running multiple sequences?

- can you paste the output of ./your_program --dump-config?

Thanks,

--
Philippe.

