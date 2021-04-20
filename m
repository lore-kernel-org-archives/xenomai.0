From: =?UTF-8?B?6ZmI5p2+?= <chensong@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIIDMvM10geTIwMzg6IHRlc3RzdWl0ZS9zbW9rZXkveTIwMzg6IHRlc3RjYXNlIGZvciBuYW5vc2xlZXA2NA==?=
Date: Tue, 20 Apr 2021 09:07:49 +0800
Message-ID: <1044rhulxbn-1047bdhg0z8@nsmail6.0>
References: 83024fe06cff2042963185505b834d8be95bac5a.camel@siemens.com
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?Zmxvcmlhbi5iZXpkZWthLS0tIHZpYSBYZW5vbWFp?= <xenomai@xenomai.org>, 

   sorry for html message, i subscribed xenomai maillist with my personal
   mailbox, and will submit new versions by it soon.

   I also have some comments back regarding you comments, please have a
   look.

   Song



   主　题：Re: [PATCH 3/3] y2038: testsuite/smokey/y2038: testcase for
   nanosleep64
   日　期：
   发件人：florian.bezdeka--- via Xenomai
   收件人：xenomai@xenomai.orgchensong@tj.kylinos.cn


   On Wed, 2021-03-31 at 11:26 +0800, chensong wrote:
   > add test case for clock_nanosleep64 in testsuite
   >
   > Signed-off-by: chensong
   > ---
   >  testsuite/smokey/y2038/syscall-tests.c | 65
   ++++++++++++++++++++++++++++++++++
   >  1 file changed, 65 insertions(+)
   >
   > diff --git a/testsuite/smokey/y2038/syscall-tests.c
   b/testsuite/smokey/y2038/syscall-tests.c
   > index 03a3198..affbb2d 100644
   > --- a/testsuite/smokey/y2038/syscall-tests.c
   > +++ b/testsuite/smokey/y2038/syscall-tests.c
   > @@ -226,6 +226,67 @@ static int test_sc_cobalt_clock_settime64(void)
   >   return 0;
   >  }
   >
   >
   > +static inline int64_t calcdiff(struct timespec t1, struct
   xn_timespec64 t2)
   >
   > +{
   > + struct timespec r;
   > +
   > + r.tv_sec = t1.tv_sec - t2.tv_sec;
   > + r.tv_nsec = t1.tv_nsec - t2.tv_nsec;
   When looking at the function signature I would assume t2 is the bigger
   or later one. But it's flipped. But maybe this function is getting

   obsolete, see below.

   [Song] i copied it from cyclictest, it's working fine here and
   cyclictest as well, t1 is real woken up time , and t2 is expected woken
   up time,t1 is bigger.

   > + if (r.tv_nsec < 0) {
   > + r.tv_sec--;
   > + r.tv_nsec += NSEC_PER_SEC;
   > + }
   > +
   > + return (r.tv_sec * NSEC_PER_SEC + r.tv_nsec) / 1000;
   > +}
   > +
   > +static int test_sc_cobalt_clock_nanosleep64(void)
   > +{
   > + long ret;
   > + int code = __xn_syscode(sc_cobalt_clock_nanosleep64);
   > + struct xn_timespec64 next;
   > + struct timespec now;
   > + int64_t diff;
   > + int64_t threshold = 500;
   > +
   > + /* Make sure we don't crash because of NULL pointers */
   > + ret = syscall(code, NULL, NULL, NULL);
   > + if (ret == -1 && errno == ENOSYS) {
   > + smokey_note("clock_nanosleep64: skipped. (no kernel support)");
   > + return 0; // Not implemented, nothing to test, success
   > + }
   > + if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
   > + return errno;
   > +
   > + /* Providing an invalid address has to deliver EFAULT */
   > + ret = syscall(code, CLOCK_MONOTONIC, (void *)0xdeadbeefUL,
   > + (void *)0xdeadbeefUL);
   > + if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
   > + return errno;
   To be complete we should cover all possibilities here. We already cover
   that both pointers are invalid, but there might be one invalid and a

   valid one in all combinations.

   [song]will do

   > +
   > + /* Provide an valid 64bit timespec*/
   Minor: "a valid" instead of "an valid"
   > + ret = clock_gettime(CLOCK_REALTIME, &now);
   > + if (ret)
   > + return errno;
   When leaving the function here we should add a warning that we failed
   because clock_gettime did not work. Otherwise we might end up searching

   for the root cause in the nanosleep stuff.

   There is a second clock_gettime() error path below. Both should be
   handled the same way.

   [song] will do

   > + next.tv_sec  = now.tv_sec + 1;
   > + next.tv_nsec = now.tv_nsec;
   > +
   > + ret = syscall(code, CLOCK_REALTIME, TIMER_ABSTIME, &next, NULL);
   > + if (!smokey_assert(!ret))
   > + return errno;
   > +
   > + ret = clock_gettime(CLOCK_REALTIME, &now);
   > + if (ret)
   > + return errno;
   > +
   > + diff = calcdiff(now, next);
   > + if (diff > threshold)
   > + smokey_warning("clock_nanosleep64, latency is %dus\n");
   > +
   I'm not a fan of magic numbers (threshold = 500). Those numbers might
   be OK on some systems / architectures / chips but might be wrong for
   others.

   [song]threshold 500 is set by my experience and it's not as meaningful
   as cyclictest or latency, it's more aimed to verify syscall's
   validation.

   For the semaphore test I just made sure that we don't come back to
   early. Maybe someone has a better idea?
   As CLOCK_REALTIME could jump back and forward we should switch to
   CLOCK_MONOTONIC for all such tests (as well as for the clock_gettime()
   part)

   [song]: will do

   > + return 0;
   > +}
   > +
   >  static int run_y2038(struct smokey_test *t, int argc, char *const
   argv[])
   >  {
   >   int ret;
   > @@ -242,5 +303,9 @@ static int run_y2038(struct smokey_test *t, int
   argc, char *const argv[])
   >   if (ret)
   >   return ret;
   >
   > + ret = test_sc_cobalt_clock_nanosleep64();
   > + if (ret)
   > + return ret;
   > +
   >   return 0;
   >  }







   ----
