Subject: Re: having problems with daemonizing
References: <44ftq4zcr9.fsf@be-well.ilk.org> <5CC38412.8030107@freyder.net>
 <e0ff187c-8247-e7ed-0ee4-b9a195a393b6@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5b7e96a4-043d-484b-f05b-a96e1697bcf6@xenomai.org>
Date: Fri, 3 May 2019 13:12:26 +0200
MIME-Version: 1.0
In-Reply-To: <e0ff187c-8247-e7ed-0ee4-b9a195a393b6@xenomai.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Freyder <steve@freyder.net>, xenomai@xenomai.org

On 4/28/19 5:26 PM, Philippe Gerum via Xenomai wrote:
> On 4/27/19 12:20 AM, Steve Freyder wrote:
>> On 4/26/2019 4:18 PM, Lowell Gilbert via Xenomai wrote:
>>> Hi.
>>>
>>> I have an application working successfully with Xenomai 3.0.8 on a 4.14
>>> kernel. I use Yocto to build the system; when I tried to move to a newer
>>> version of Yocto, my application hung on trying to become a daemon. This
>>> is happening with the daemon() call (which is what I've used up to now)
>>> and with fork().
>>>
>>> I built a test application so that I could confirm that this problem
>>> only occurs when I link (and wrap) with Xenomai. However, Xenomai
>>> doesn't seem to do anything significant with fork, so I'm puzzled about
>>> why this might be happening. I am not using libdaemon.
>>>
>>> Here are the changes that I thought might be significant:
>>> | newer (nonworking setup)  | older (working) |
>>> | gcc-cross-arm-8.2.0       |           7.3.0 |
>>> | glibc-2.28                |            2.26 |
>>> | glib-2.0-1_2.58.0         |     1_2.52.3-r0 |
>>> | binutils-cross-arm-2.31.1 |          2.29.1 |
>>> | coreutils-8.30            |            8.27 |
>>>
>>> Does anything jump out as a candidate for causing problems with a fork()
>>> call? Is there anything else I should be considering?
>>>
>>> Thanks.
>>>
>>> Be well.
>>>
>> I can tell you that I have a hang issue due to fork() in a Xenomai
>> program if, after the fork(), I don't do an exec().=A0 I believe
>> the hang is related to registry access, and the fact that the
>> Unix domain socket connecting to sysregd that is inherited by
>> the forked process (which has FD_CLOEXEC set) hasn't yet gotten
>> closed (no exec() yet so no action on FD_CLOEXEC flags yet).
>>
>> If you are running into the same problem, and you don't require
>> registry access, you should see the problem go away if you throw
>> the --no-registry switch on the command line that invokes your
>> program.=A0 That's not a real fix, but it's perhaps a way to know
>> if you're seeing a related problem.
>>
>> In my case, the way I see the "hang" is via an attempt to list
>> the contents of /run/xenomai using find:
>>
>> root:~ # find /run/xenomai
>>
>> If I run a program XX that uses the registry, that does a fork() call
>> and then does not exec(), and while that program is running, I
>> execute the above find command, it will hang part way through the
>> listing.=A0 If I kill program XX, the listing continues (un-hangs).
>>
>> If I run a program that uses the registry, that does a fork() and
>> then an exec(), no such hang occurs during the find command.
>>
>> Phillipe made the change to fix this originally by adding SOCK_CLOEXEC
>> to the socket() call in sysreg.c, and it did fix it but I realized
>> much later it fixes it only if you actually call exec(), which in my
>> code I always do, but more recently one of our developers had some
>> code that didn't exec(), which was the first time I saw this hang.
>>
>> Phillipe, I had it on my list to ask you about this but it hasn't
>> bitten me lately and I forgot until I saw this msg about fork().
>>
>> I think deamonizing in its canonical form of: fork(), let the forked
>> process take over, and then exit() in the parent, is problematic when
>> you have a wrapped main() where the wrappers already initialized the
>> sysreg mechanism but the process that was done for is now gone, and
>> the fork()'ed process has no idea it has a sysreg socket in hand.
>>
>> Perhaps the better answer when daemonizing is to use --no-init and then
>> have the forked() process do manual xenomai_init() call?
>>
>=20
> I don't know yet, I'll follow up on this.
>=20

Could you try the patch below? Ideally, we should have this in 3.0.9 if thi=
s improves the situation.

Thanks,

diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index abd990692..02a99c569 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -184,20 +184,26 @@ static void low_init(void)
 	cobalt_ticks_init(f->clock_freq);
 }
=20
+static int cobalt_init_2(void);
+
 static void cobalt_fork_handler(void)
 {
 	cobalt_unmap_umm();
 	cobalt_clear_tsd();
 	cobalt_print_init_atfork();
-	if (cobalt_init())
+	if (cobalt_init_2())
 		exit(EXIT_FAILURE);
 }
=20
-static void __cobalt_init(void)
+static inline void commit_stack_memory(void)
 {
-	struct sigaction sa;
+	char stk[PTHREAD_STACK_MIN / 2];
+	cobalt_commit_memory(stk);
+}
=20
-	low_init();
+static void cobalt_init_1(void)
+{
+	struct sigaction sa;
=20
 	sa.sa_sigaction =3D cobalt_sigdebug_handler;
 	sigemptyset(&sa.sa_mask);
@@ -228,20 +234,9 @@ static void __cobalt_init(void)
 			    " sizeof(cobalt_sem_shadow): %Zd!",
 			    sizeof(sem_t),
 			    sizeof(struct cobalt_sem_shadow));
-
-	cobalt_mutex_init();
-	cobalt_sched_init();
-	cobalt_thread_init();
-	cobalt_print_init();
 }
=20
-static inline void commit_stack_memory(void)
-{
-	char stk[PTHREAD_STACK_MIN / 2];
-	cobalt_commit_memory(stk);
-}
-
-int cobalt_init(void)
+static int cobalt_init_2(void)
 {
 	pthread_t ptid =3D pthread_self();
 	struct sched_param parm;
@@ -249,7 +244,12 @@ int cobalt_init(void)
=20
 	commit_stack_memory();	/* We only need this for the main thread */
 	cobalt_default_condattr_init();
-	__cobalt_init();
+
+	low_init();
+	cobalt_mutex_init();
+	cobalt_sched_init();
+	cobalt_thread_init();
+	cobalt_print_init();
=20
 	if (__cobalt_control_bind)
 		return 0;
@@ -288,12 +288,19 @@ int cobalt_init(void)
 	return 0;
 }
=20
+int cobalt_init(void)
+{
+	cobalt_init_1();
+
+	return cobalt_init_2();
+}
+
 static int get_int_arg(const char *name, const char *arg,
 		       int *valp, int min)
 {
 	int value, ret;
 	char *p;
-=09
+
 	errno =3D 0;
 	value =3D (int)strtol(arg, &p, 10);
 	if (errno || *p || value < min) {


--=20
Philippe.

