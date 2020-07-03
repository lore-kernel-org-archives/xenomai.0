MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Fri, 3 Jul 2020 10:17:51 +0800
Message-ID: <CAAvDm6b3qYf_a+hQOaRx1RgbnzZ3v6YsD7ZP-EDS-4XyCxjq2w@mail.gmail.com>
Subject: What are the differences among these similar nanosleep functions?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

What are the differences among these similar nanosleep functions,
especially the second one and the third one:

https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/lib/cobalt/clock.c:
 line=EF=BC=9A353
COBALT_IMPL(int, nanosleep, (const struct timespec *rqtp, struct timespec
*rmtp))
{
int ret;

ret =3D __WRAP(clock_nanosleep(CLOCK_REALTIME, 0, rqtp, rmtp));
if (ret) {
errno =3D ret;
return -1;
}

return 0;
}

https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/kernel/cobalt/posix/cloc=
k.c
line:272
int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
     const struct timespec *rqt,
     struct timespec *rmt)
{
struct restart_block *restart;
struct xnthread *cur;
xnsticks_t timeout, rem;
spl_t s;

trace_cobalt_clock_nanosleep(clock_id, flags, rqt);

if (clock_id !=3D CLOCK_MONOTONIC &&
    clock_id !=3D CLOCK_MONOTONIC_RAW &&
    clock_id !=3D CLOCK_REALTIME)
return -EOPNOTSUPP;

if (rqt->tv_sec < 0)
return -EINVAL;

if ((unsigned long)rqt->tv_nsec >=3D ONE_BILLION)
return -EINVAL;

if (flags & ~TIMER_ABSTIME)
return -EINVAL;

cur =3D xnthread_current();
...
}

https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/kernel/cobalt/posix/cloc=
k.c
line:360
COBALT_SYSCALL(clock_nanosleep, primary,
       (clockid_t clock_id, int flags,
const struct timespec __user *u_rqt,
struct timespec __user *u_rmt))
{
struct timespec rqt, rmt, *rmtp =3D NULL;
int ret;

if (u_rmt)
rmtp =3D &rmt;

if (cobalt_copy_from_user(&rqt, u_rqt, sizeof(rqt)))
return -EFAULT;

ret =3D __cobalt_clock_nanosleep(clock_id, flags, &rqt, rmtp);
if (ret =3D=3D -EINTR && flags =3D=3D 0 && rmtp) {
if (cobalt_copy_to_user(u_rmt, rmtp, sizeof(*u_rmt)))
return -EFAULT;
}

return ret;
}

BTW, the patch that you required has been sent out in the last email
(refer to https://www.mail-archive.com/xenomai@xenomai.org/msg17909.html).

Thank you for your attention to this matter.
Looking forward to hearing from you.
Best Regards.
