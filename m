MIME-Version: 1.0
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F201D553EC@dggema523-mbx.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F201D553EC@dggema523-mbx.china.huawei.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 11 Jul 2018 10:09:18 -0400
Message-ID: <CALLqZ8RKt78JkgsrAvYgO0DKSHvdoTritA9do+PyoSkxNsMqBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [roscore issue for "Operation not permitted"]
 pthread_mutex_lock failed: operation not permitted
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: "gilles.chanteperdrix@xenomai.org" <gilles.chanteperdrix@xenomai.org>, "gernot.hillier@siemens.com" <gernot.hillier@siemens.com>, "zhangjianwei (D)" <zhangjianwei8@huawei.com>, Jan Kiszka <jan.kiszka@siemens.com>, "andreasglatz@ruggedcom.com" <andreasglatz@ruggedcom.com>, "ma30002000@yahoo.de" <ma30002000@yahoo.de>, "wolfgang.mauerer@siemens.com" <wolfgang.mauerer@siemens.com>, "kisda@hispeed.ch" <kisda@hispeed.ch>, "jorge.ramirez-ortiz@linaro.org" <jorge.ramirez-ortiz@linaro.org>, "fabrice.gasnier@cenosys.com" <fabrice.gasnier@cenosys.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Have you looked at any of the ROS frameworks that use Xenomai?  Is the
expectation that roscore runs in the secondary domain and your ros
based application runs in the primary domain?

-Greg

On Wed, Jul 11, 2018 at 10:03 AM, gengdongjiu <gengdongjiu@huawei.com> wrot=
e:
> Hi, Philippe/ Gilles/ Jan/ Alexis/others,
>
>
>
> I=E2=80=99m running ros on Xenomai, with Xenomai-3.07 and linux kernel 4.=
4.71. I
> first export CFLAGS and LDFLAGS of posix skin. And compile ros project wi=
th
> posix skin successfully.
>
> Then, I run roscore as root user, it throws a std::system_error. So I deb=
ug
> roscore with gdb. According to the gdb backtrace frame #10, it=E2=80=99s =
the 62
> lines of participant.cpp that caused the problem. Which is
> =E2=80=9Cstd::unique_lock<std::mutex> ul(_msg_lock);=E2=80=9D. As far as =
I know,
> initializing a unique_lock will call _msg_lock.lock(),and _msg_lock is a
> std::mutex, _msg_lock.lock() will call pthread_mutex_lock(). According th=
e
> to the error message =E2=80=9COperation not permitted=E2=80=9D. Pthread_m=
utex_lock() must
> return EPERM, and pthread_mutex_lock return EPRM only if the mutex is not
> process-shared and does not belong to the current process or the caller
> context is invalid.
>
>
>
> So my question is why compiling and running ros on xenomai will cause
> pthread_mutex_lock() return EPERM? Does current calling context is invali=
d ?
> And how can I solve this problem, does anybody have any insight? By the w=
ay,
> it=E2=80=99s perfect fine to compiling and running ros on linux with the =
same code.
>
>
>
> Thanks.
>
>
>
> -----------------------------------------------------------------
>
> root@ros:/home/ros/zjw/ros/install/ros_x86_64/lib# roscore
>
> terminate called after throwing an instance of 'std::system_error'
>
>   what():  Operation not permitted
>
> Aborted (core dumped)
>
>
>
>
>
> (gdb) r `which roscore`
>
> Starting program: /usr/bin/python `which roscore`
>
> [Thread debugging using libthread_db enabled]
>
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1"=
.
>
> [New Thread 0x7ffff3586700 (LWP 29315)]
>
> [New Thread 0x7ffff279b700 (LWP 29316)]
>
> [New Thread 0x7ffff1f9a700 (LWP 29317)]
>
> [New Thread 0x7ffff1799700 (LWP 29318)]
>
> [New Thread 0x7ffff0f98700 (LWP 29319)]
>
> [New Thread 0x7fffe3fff700 (LWP 29320)]
>
> [New Thread 0x7fffe37fe700 (LWP 29321)]
>
> [New Thread 0x7fffe2ffd700 (LWP 29322)]
>
> terminate called after throwing an instance of 'std::system_error'
>
>   what():  Operation not permitted
>
>
>
> Thread 9 "python" received signal SIGABRT, Aborted.
>
> [Switching to Thread 0x7fffe2ffd700 (LWP 29322)]
>
> 0x00007ffff7825428 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/unix/sysv/linux/raise.c:54
>
> 54      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
>
> (gdb) bt
>
> #0  0x00007ffff7825428 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/unix/sysv/linux/raise.c:54
>
> #1  0x00007ffff782702a in __GI_abort () at abort.c:89
>
> #2  0x00007ffff3e6884d in __gnu_cxx::__verbose_terminate_handler () at
> ../../../../src/libstdc++-v3/libsupc++/vterminate.cc:95
>
> #3  0x00007ffff3e666b6 in __cxxabiv1::__terminate (handler=3D<optimized o=
ut>)
> at ../../../../src/libstdc++-v3/libsupc++/eh_terminate.cc:47
>
> #4  0x00007ffff3e66701 in std::terminate () at
> ../../../../src/libstdc++-v3/libsupc++/eh_terminate.cc:57
>
> #5  0x00007ffff3e66919 in __cxxabiv1::__cxa_throw
> (obj=3Dobj@entry=3D0x7fffd00010d0, tinfo=3D0x7ffff414ec00 <typeinfo for
> std::system_error>, dest=3D0x7ffff3e91640
> <std::system_error::~system_error()>)
>
>     at ../../../../src/libstdc++-v3/libsupc++/eh_throw.cc:87
>
> #6  0x00007ffff3e8f7fe in std::__throw_system_error (__i=3D1) at
> ../../../../../src/libstdc++-v3/src/c++11/functexcept.cc:127
>
> #7  0x00007ffff4162451 in std::mutex::lock (this=3D0x25c7280) at
> /usr/include/c++/5/mutex:139
>
> #8  std::unique_lock<std::mutex>::lock (this=3D0x7fffe2ffc300) at
> /usr/include/c++/5/mutex:485
>
> #9  std::unique_lock<std::mutex>::unique_lock (__m=3D..., this=3D0x7fffe2=
ffc300)
> at /usr/include/c++/5/mutex:415
>
> #10 ros::Participant::read_msg[abi:cxx11]() (this=3D0x25c7200) at
> /home/ros/zjw/ros/src/ros_comm/roscpp/src/libros/discovery/participant.cp=
p:62
>
> #11 0x00007ffff4be9195 in _wrap_Participant_read_msg () from
> /home/ros/zjw/ros/install/ros_x86_64/lib/_participant.so
>
> #12 0x00000000004bc3fa in PyEval_EvalFrameEx ()
>
> #13 0x00000000004c136f in PyEval_EvalFrameEx ()
>
> #14 0x00000000004b9ab6 in PyEval_EvalCodeEx ()
>
> #15 0x00000000004d55f3 in ?? ()
>
> #16 0x00000000004a577e in PyObject_Call ()
>
> #17 0x00000000004bed3d in PyEval_EvalFrameEx ()
>
> #18 0x00000000004c136f in PyEval_EvalFrameEx ()
>
> #19 0x00000000004c136f in PyEval_EvalFrameEx ()
>
> #20 0x00000000004b9ab6 in PyEval_EvalCodeEx ()
>
> #21 0x00000000004d54b9 in ?? ()
>
> #22 0x00000000004eebee in ?? ()
>
> #23 0x00000000004a577e in PyObject_Call ()
>
> #24 0x00000000004c5e10 in PyEval_CallObjectWithKeywords ()
>
> #25 0x0000000000589172 in ?? ()
>
> #26 0x00007ffff7bc16ba in start_thread (arg=3D0x7fffe2ffd700) at
> pthread_create.c:333
>
> #27 0x00007ffff78f741d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
>
> (gdb)
>
>
>
> root@ros:/home/ros/zjw/ros/install/ros_x86_64/lib# grep -nrIT -e "_msg_lo=
ck"
> /home/ros/zjw/ros/src/ros_comm/
>
> /home/ros/zjw/ros/src/ros_comm/roscpp/include/discovery/participant.h: 14=
4
> :  std::mutex _msg_lock;
>
> /home/ros/zjw/ros/src/ros_comm/roscpp/src/libros/discovery/participant.cp=
p:
> 53:    std::lock_guard<std::mutex> lg(_msg_lock);
>
> /home/ros/zjw/ros/src/ros_comm/roscpp/src/libros/discovery/participant.cp=
p:
> 62:  std::unique_lock<std::mutex> ul(_msg_lock);
>
>

