From: =?UTF-8?B?6ZmI5p2+?= <chensong@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIIDEvM10geTIwMzg6IGNvYmFsdC9wb3NpeC9jbG9jazogQWRkaW5nIGNsb2NrX25hbm9zbGVlcDY0?=
Date: Tue, 20 Apr 2021 09:10:59 +0800
Message-ID: <13mfhgf7syn-13mgre8musg@nsmail6.0>
References: 2f45ab8f4ff11d99831476aee549e49e14c04aa0.camel@siemens.com
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




   主　题：Re: [PATCH 1/3] y2038: cobalt/posix/clock: Adding clock_nanosleep64

   日　期：
   发件人：florian.bezdeka--- via Xenomai
   收件人：rpm@xenomai.orgxenomai@xenomai.orgchensong@tj.kylinos.cn


   On Wed, 2021-03-31 at 11:26 +0800, chensong wrote:
   > Add a syscall specific for clock_nanosleep with 64bit
   > time_t.
   >
   > Signed-off-by: chensong
   > ---
   >  include/cobalt/uapi/syscall.h   |  1 +
   >  kernel/cobalt/posix/clock.c     | 23 +++++++++++++++++++++++
   >  kernel/cobalt/posix/clock.h     |  5 +++++
   >  kernel/cobalt/posix/syscall32.c | 23 +++++++++++++++++++++++
   >  kernel/cobalt/posix/syscall32.h |  6 ++++++
   >  5 files changed, 58 insertions(+)
   >
   > diff --git a/include/cobalt/uapi/syscall.h
   b/include/cobalt/uapi/syscall.h
   > index 438af30..acb8260 100644
   > --- a/include/cobalt/uapi/syscall.h
   > +++ b/include/cobalt/uapi/syscall.h
   > @@ -125,6 +125,7 @@
   >  #define sc_cobalt_sem_timedwait64 102
   >  #define sc_cobalt_clock_gettime64 103
   >  #define sc_cobalt_clock_settime64 104
   > +#define sc_cobalt_clock_nanosleep64 105
   >
   >
   >  #define __NR_COBALT_SYSCALLS 128 /* Power of 2 */
   >
   > diff --git a/kernel/cobalt/posix/clock.c
   b/kernel/cobalt/posix/clock.c
   > index f0f9fb4..5be89ad 100644
   > --- a/kernel/cobalt/posix/clock.c
   > +++ b/kernel/cobalt/posix/clock.c
   > @@ -338,6 +338,29 @@ COBALT_SYSCALL(clock_nanosleep, primary,
   >   return ret;
   >  }
   >
   > +COBALT_SYSCALL(clock_nanosleep64, primary,
   > +       (clockid_t clock_id, int flags,
   > + const struct __kernel_timespec __user *u_rqt,
   > + struct __kernel_timespec __user *u_rmt))
   > +{
   > + struct timespec64 rqt, rmt, *rmtp = NULL;
   > + int ret;
   > +
   > + if (u_rmt)
   > + rmtp = &rmt;
   > +
   > + if (cobalt_get_timespec64(&rqt, u_rqt))
   > + return -EFAULT;
   > +
   > + ret = __cobalt_clock_nanosleep(clock_id, flags, &rqt, rmtp);
   > + if (ret == -EINTR && flags == 0 && rmtp) {
   > + if (cobalt_put_timespec64(rmtp, u_rmt))
   > + return -EFAULT;
   > + }
   > +
   > + return ret;
   > +}
   The compat syscall looks exactly the same. So I would vote for moving
   the code into a separate function (maybe called
   __cobalt_clock_nanosleep64) which holds the code above and calling it

   from both syscall handlers (this one + the compat one below).

   [song]thanks, it also applies to clock_settime64 and clock_gettime64, i
   will submit a new version regarding this case.
   > +
   >  int cobalt_clock_register(struct xnclock *clock, const cpumask_t
   *affinity,
   >    clockid_t *clk_id)
   >  {
   > diff --git a/kernel/cobalt/posix/clock.h
   b/kernel/cobalt/posix/clock.h
   > index fa07c56..f248578 100644
   > --- a/kernel/cobalt/posix/clock.h
   > +++ b/kernel/cobalt/posix/clock.h
   > @@ -134,6 +134,11 @@ COBALT_SYSCALL_DECL(clock_nanosleep,
   >       const struct __user_old_timespec __user *u_rqt,
   >       struct __user_old_timespec __user *u_rmt));
   >  +COBALT_SYSCALL_DECL(clock_nanosleep64,
   > +    (clockid_t clock_id, int flags,
   > +     const struct __kernel_timespec __user *u_rqt,
   > +     struct __kernel_timespec __user *u_rmt));
   > +
   >  int cobalt_clock_register(struct xnclock *clock,
   >    const cpumask_t *affinity,
   >    clockid_t *clk_id);
   > diff --git a/kernel/cobalt/posix/syscall32.c
   b/kernel/cobalt/posix/syscall32.c
   > index 1a1b830..eb83c57 100644
   > --- a/kernel/cobalt/posix/syscall32.c
   > +++ b/kernel/cobalt/posix/syscall32.c
   > @@ -250,6 +250,29 @@ COBALT_SYSCALL32emu(clock_nanosleep,
   nonrestartable,
   >   return ret;
   >  }
   >
   > +COBALT_SYSCALL32emu(clock_nanosleep64, nonrestartable,
   > +    (clockid_t clock_id, int flags,
   > +     const struct __kernel_timespec __user *u_rqt,
   > +     struct __kernel_timespec __user *u_rmt))
   > +{
   > + struct timespec64 rqt, rmt, *rmtp = NULL;
   > + int ret;
   > +
   > + if (u_rmt)
   > + rmtp = &rmt;
   > +
   > + ret = cobalt_get_timespec64(&rqt, u_rqt);
   > + if (ret)
   > + return ret;
   > +
   > + ret = __cobalt_clock_nanosleep(clock_id, flags, &rqt, rmtp);
   > + if (ret == -EINTR && flags == 0 && rmtp)
   > + ret = cobalt_put_timespec64(rmtp, u_rmt);
   > +
   > + return ret;
   > +}
   > +
   > +
   >  COBALT_SYSCALL32emu(mutex_timedlock, primary,
   >      (struct cobalt_mutex_shadow __user *u_mx,
   >       const struct old_timespec32 __user *u_ts))
   > diff --git a/kernel/cobalt/posix/syscall32.h
   b/kernel/cobalt/posix/syscall32.h
   > index 9095ebd..6c20da1 100644
   > --- a/kernel/cobalt/posix/syscall32.h
   > +++ b/kernel/cobalt/posix/syscall32.h
   > @@ -80,6 +80,12 @@ COBALT_SYSCALL32emu_DECL(clock_nanosleep,
   >    const struct old_timespec32 __user *u_rqt,
   >    struct old_timespec32 __user *u_rmt));
   > +COBALT_SYSCALL32emu_DECL(clock_nanosleep64,
   > + (clockid_t clock_id, int flags,
   > +  const struct __kernel_timespec __user *u_rqt,
   > +  struct __kernel_timespec __user *u_rmt));
   > +
   > +
   >  COBALT_SYSCALL32emu_DECL(mutex_timedlock,
   >   (struct cobalt_mutex_shadow __user *u_mx,
   >    const struct old_timespec32 __user *u_ts));







   ----
