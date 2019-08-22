From: "DIAO, Hanson" <hanson.diao@siemens.com>
Subject: A potential  Xenomai Mutex issue
Date: Thu, 22 Aug 2019 18:42:33 +0000
Message-ID: <DM6PR07MB596162CF3DD4EB4071336D26E7A50@DM6PR07MB5961.namprd07.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,



I hope you are doing well. Currently I was working on a critical deadlock i=
ssue with Xenomail Library(version 2.6.4). I found that for the Xenomai loc=
k count is not reliable after we called rt_mutex_release. I print the follo=
wing message to you. I hope some developer can help me fix this issue. I kn=
ow that this version is EOL, but we still use this old version. Thank you s=
o much.



Issue 1:

Before Mutex Lock Mutext addr =3D 0xb7c059e8,count =3D 0, owner =3D 0     T=
his message show the status before rt_mutex_acquire.

After Mutex Lock Mutext addr =3D 0xb7c059e8,count =3D 1, owner =3D 2bd   Th=
is message show the status after calling rt_mutex_acquire.     Everything i=
s right for the rt_mutex_acquire in this scenario.



Before Mutex unLock Mutext addr =3D 0xb7c059e8,count =3D 1, owner =3D 2bd  =
 This message show the status before rt_mutex_release.

After Mutex unLock Mutext addr =3D 0xb7c059e8,count =3D 1, owner =3D 0     =
     This message show the status after rt_mutex_release. It seems that the=
 lock count is not correct after call rt_mutex_release.



Issue 2:

When our task is call recursive lock. The mutex lock count should more than=
 1, but the lock count is still 1.



For the issue 1, I guess that there are something wrong in the release func=
tion. I highlighted the code. I am not sure if it is the root cause.



int rt_mutex_release(RT_MUTEX *mutex)

{

#ifdef CONFIG_XENO_FASTSYNCH

        unsigned long status;

        xnhandle_t cur;



        cur =3D xeno_get_current();

        if (cur =3D=3D XN_NO_HANDLE)

                return -EPERM;



        status =3D xeno_get_current_mode();

        if (unlikely(status & XNOTHER))

                /* See rt_mutex_acquire_inner() */

                goto do_syscall;



        if (unlikely(xnsynch_fast_owner_check(mutex->fastlock, cur) !=3D 0)=
)

                return -EPERM;



        if (mutex->lockcnt > 1) {

                mutex->lockcnt--;

                return 0;

        }



        if (likely(xnsynch_fast_release(mutex->fastlock, cur)))

        {

                return 0;

        }

do_syscall:

#endif /* CONFIG_XENO_FASTSYNCH */



        return XENOMAI_SKINCALL1(__native_muxid, __native_mutex_release, mu=
tex);

}







For the Mutex lock function, I am so confused with the following comments w=
hich I highlighted as below. I am not sure if it supports the recursive loc=
k.

static int rt_mutex_acquire_inner(RT_MUTEX *mutex, RTIME timeout, xntmode_t=
 mode)

{

        int err;

#ifdef CONFIG_XENO_FASTSYNCH

        unsigned long status;

        xnhandle_t cur;



        cur =3D xeno_get_current();

        if (cur =3D=3D XN_NO_HANDLE)

                return -EPERM;



        /*

         * We track resource ownership for non real-time shadows in

         * order to handle the auto-relax feature, so we must always

         * obtain them via a syscall.

         */

        status =3D xeno_get_current_mode();

        if (unlikely(status & XNOTHER))

                goto do_syscall;



        if (likely(!(status & XNRELAX))) {

                err =3D xnsynch_fast_acquire(mutex->fastlock, cur);

                if (likely(!err)) {

                        mutex->lockcnt =3D 1;

                        return 0;

                }



                if (err =3D=3D -EBUSY) {

                        if (mutex->lockcnt =3D=3D UINT_MAX)

                                return -EAGAIN;



                        mutex->lockcnt++;

                        return 0;

                }



                if (timeout =3D=3D TM_NONBLOCK && mode =3D=3D XN_RELATIVE)

                        return -EWOULDBLOCK;

        } else if (xnsynch_fast_owner_check(mutex->fastlock, cur) =3D=3D 0)=
 {

                /*

                 * The application is buggy as it jumped to secondary mode

                 * while holding the mutex. Nevertheless, we have to keep t=
he

                 * mutex state consistent.

                 *

                 * We make no efforts to migrate or warn here. There is

                 * XENO_DEBUG(SYNCH_RELAX) to catch such bugs.

                 */

                if (mutex->lockcnt =3D=3D UINT_MAX)

                        return -EAGAIN;



                mutex->lockcnt++;

                return 0;

        }

do_syscall:

#endif /* CONFIG_XENO_FASTSYNCH */



        err =3D XENOMAI_SKINCALL3(__native_muxid,

                                __native_mutex_acquire, mutex, mode, &timeo=
ut);



#ifdef CONFIG_XENO_FASTSYNCH

        if (!err)

                mutex->lockcnt =3D 1;

#endif /* CONFIG_XENO_FASTSYNCH */



        return err;

}





