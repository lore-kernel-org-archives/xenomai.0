MIME-Version: 1.0
Date: Thu, 12 Jul 2018 13:03:51 +0200
From: =?UTF-8?Q?Mariusz_Janiak?= <mariuszjaniak@wp.pl>
Message-ID: <508cf45f9e7b42e09d87ab11b5e889b0@grupawp.pl>
In-Reply-To: <<ceac8f91-8d86-62af-79e1-571ccbd36427@huawei.com>>
References: <0184ea26b2509940aa629ae1405dd7f201d553ec@dggema523-mbx.china.huawei.com>
 <callqz8rkt78jkgsravygo0dkshvdotrita9do+pyoskxnsmqbg@mail.gmail.com>
 <ceac8f91-8d86-62af-79e1-571ccbd36427@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] =?utf-8?q?Odp=3A_Re=3A__=5Broscore_issue_for_=22Operati?=
	=?utf-8?q?on_not_permitted=22=5D_pthread=5Fmutex=5Flock_failed=3A_?=
	=?utf-8?q?operation_not_permitted?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: =?UTF-8?Q?xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Sorry, the previous mail looks unreadable.=C2=A0 Once again   Please consid=
er OROCOS for RT part instead of ROS. Eventually ROS2.   ROS haven&#39;t be=
en designed as a real-time framework, especially in communication domain (r=
os topics + TCP + XML RPC).   Best,  Mariusz  
                
              
               
                 
                  Dnia 12 lipca 2018 10:55 gengdongjiu &lt;gengdongjiu@huaw=
ei.com&gt; napisa=C5=82(a):
                 
                 
                   Hi Greg, 
  =C2=A0Thanks for the answer, 
  
 On 2018/7/11 22:09, Greg Gallagher wrote: 
 
 Have you looked at any of the ROS frameworks that use Xenomai? =C2=A0Is th=
e 
 expectation that roscore runs in the secondary domain and your ros 
 based application runs in the primary domain? 
 
  
 Yes, we have looked at the the ROS frameworks that use Xenomai. do you hav=
e any suggestion? we are not very familiar with the ROS. 
 In our test, we used the ROS pub and sub to do communication. From our tes=
t, if roscore runs in the secondary (normal linux)domain, it will not have =
such issue. 
 should the roscore run in the =C2=A0secondary domain or the primary domain=
? I do not know which domain it should run into. thanks a lot. 
  
 
  
 -Greg 
  
 On Wed, Jul 11, 2018 at 10:03 AM, gengdongjiu &lt;gengdongjiu@huawei.com&g=
t; wrote: 
 
 Hi, Philippe/ Gilles/ Jan/ Alexis/others, 
  
  
  
 I=E2=80=99m running ros on Xenomai, with Xenomai-3.07 and linux kernel 4.4=
.71. I 
 first export CFLAGS and LDFLAGS of posix skin. And compile ros project wit=
h 
 posix skin successfully. 
  
 Then, I run roscore as root user, it throws a std::system_error. So I debu=
g 
 roscore with gdb. According to the gdb backtrace frame #10, it=E2=80=99s t=
he 62 
 lines of participant.cpp that caused the problem. Which is 
 =E2=80=9Cstd::unique_lock&lt;std::mutex ul(_msg_lock);=E2=80=9D. As far as=
 I know, 
 initializing a unique_lock will call _msg_lock.lock(),and _msg_lock is a 
 std::mutex, _msg_lock.lock() will call pthread_mutex_lock(). According the=
 
 to the error message =E2=80=9COperation not permitted=E2=80=9D. Pthread_mu=
tex_lock() must 
 return EPERM, and pthread_mutex_lock return EPRM only if the mutex is not 
 process-shared and does not belong to the current process or the caller 
 context is invalid. 
  
  
  
 So my question is why compiling and running ros on xenomai will cause 
 pthread_mutex_lock() return EPERM? Does current calling context is invalid=
 ? 
 And how can I solve this problem, does anybody have any insight? By the wa=
y, 
 it=E2=80=99s perfect fine to compiling and running ros on linux with the s=
ame code. 
  
  
  
 Thanks. 
  
  
  
 ------------------------------ 
  
 root@ros:/home/ros/zjw/ros/ins roscore 
  
 terminate called after throwing an instance of &#39;std::system_error&#39;=
 
  
  =C2=A0what(): =C2=A0Operation not permitted 
  
 Aborted (core dumped) 
  
  
  
  
  
 (gdb) r `which roscore` 
  
 Starting program: /usr/bin/python `which roscore` 
  
 [Thread debugging using libthread_db enabled] 
  
 Using host libthread_db library &#34;/lib/x86_64-linux-gnu/libthre 
  
 [New Thread 0x7ffff3586700 (LWP 29315)] 
  
 [New Thread 0x7ffff279b700 (LWP 29316)] 
  
 [New Thread 0x7ffff1f9a700 (LWP 29317)] 
  
 [New Thread 0x7ffff1799700 (LWP 29318)] 
  
 [New Thread 0x7ffff0f98700 (LWP 29319)] 
  
 [New Thread 0x7fffe3fff700 (LWP 29320)] 
  
 [New Thread 0x7fffe37fe700 (LWP 29321)] 
  
 [New Thread 0x7fffe2ffd700 (LWP 29322)] 
  
 terminate called after throwing an instance of &#39;std::system_error&#39;=
 
  
  =C2=A0what(): =C2=A0Operation not permitted 
  
  
  
 Thread 9 &#34;python&#34; received signal SIGABRT, Aborted. 
  
 [Switching to Thread 0x7fffe2ffd700 (LWP 29322)] 
  
 0x00007ffff7825428 in __GI_raise (sig=3Dsig@entry=3D6) at 
 ../sysdeps/unix/sysv/linux/rai 
  
 54 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0../sysdeps/unix/sysv No such file or dire=
ctory. 
  
 (gdb) bt 
  
 #0 =C2=A00x00007ffff7825428 in __GI_raise (sig=3Dsig@entry=3D6) at 
 ../sysdeps/unix/sysv/linux/rai 
  
 #1 =C2=A00x00007ffff782702a in __GI_abort () at abort.c:89 
  
 #2 =C2=A00x00007ffff3e6884d in __gnu_cxx::__verbose_terminate () at 
 ../../../../src/libstdc++-v3/l 
  
 #3 =C2=A00x00007ffff3e666b6 in __cxxabiv1::__terminate (handler=3D&lt;opti=
mized out&gt;) 
 at ../../../../src/libstdc++-v3/l 
  
 #4 =C2=A00x00007ffff3e66701 in std::terminate () at 
 ../../../../src/libstdc++-v3/l 
  
 #5 =C2=A00x00007ffff3e66919 in __cxxabiv1::__cxa_throw 
 (obj=3Dobj@entry=3D0x7fffd00010d0, tinfo=3D0x7ffff414ec00 &lt;typeinfo for=
 
 std::system_error&gt;, dest=3D0x7ffff3e91640 
 &lt;std::system_error::~system_er 
  
  =C2=A0=C2=A0=C2=A0at ../../../../src/libstdc++-v3/l 
  
 #6 =C2=A00x00007ffff3e8f7fe in std::__throw_system_error (__i=3D1) at 
 ../../../../../src/libstdc++-v 
  
 #7 =C2=A00x00007ffff4162451 in std::mutex::lock (this=3D0x25c7280) at 
 /usr/include/c++/5/mutex:139 
  
 #8 =C2=A0std::unique_lock&lt;std::mutex&gt; (this=3D0x7fffe2ffc300) at 
 /usr/include/c++/5/mutex:485 
  
 #9 =C2=A0std::unique_lock&lt;std::mutex&gt; (__m=3D..., this=3D0x7fffe2ffc=
300) 
 at /usr/include/c++/5/mutex:415 
  
 #10 ros::Participant::read_msg[abi (this=3D0x25c7200) at 
 /home/ros/zjw/ros/src/ros_comm 
  
 #11 0x00007ffff4be9195 in _wrap_Participant_read_msg () from 
 /home/ros/zjw/ros/install/ros_ 
  
 #12 0x00000000004bc3fa in PyEval_EvalFrameEx () 
  
 #13 0x00000000004c136f in PyEval_EvalFrameEx () 
  
 #14 0x00000000004b9ab6 in PyEval_EvalCodeEx () 
  
 #15 0x00000000004d55f3 in ?? () 
  
 #16 0x00000000004a577e in PyObject_Call () 
  
 #17 0x00000000004bed3d in PyEval_EvalFrameEx () 
  
 #18 0x00000000004c136f in PyEval_EvalFrameEx () 
  
 #19 0x00000000004c136f in PyEval_EvalFrameEx () 
  
 #20 0x00000000004b9ab6 in PyEval_EvalCodeEx () 
  
 #21 0x00000000004d54b9 in ?? () 
  
 #22 0x00000000004eebee in ?? () 
  
 #23 0x00000000004a577e in PyObject_Call () 
  
 #24 0x00000000004c5e10 in PyEval_CallObjectWithKeywords () 
  
 #25 0x0000000000589172 in ?? () 
  
 #26 0x00007ffff7bc16ba in start_thread (arg=3D0x7fffe2ffd700) at 
 pthread_create.c:333 
  
 #27 0x00007ffff78f741d in clone () at 
 ../sysdeps/unix/sysv/linux/x86 
  
 (gdb) 
  
  
  
 root@ros:/home/ros/zjw/ros/ins grep -nrIT -e &#34;_msg_lock&#34; 
 /home/ros/zjw/ros/src/ros_comm 
  
 /home/ros/zjw/ros/src/ros_comm 144 
 : =C2=A0std::mutex _msg_lock; 
  
 /home/ros/zjw/ros/src/ros_comm 
 53: =C2=A0=C2=A0=C2=A0std::lock_guard&lt;std::mut lg(_msg_lock); 
  
 /home/ros/zjw/ros/src/ros_comm 
 62: =C2=A0std::unique_lock&lt;std::mutex&gt; ul(_msg_lock); 
  
  
 
  
 . 
  
 
  
  
 ______________________________ 
 Xenomai mailing list 
  Xenomai@xenomai.org 
 xenomai.org xenomai.org=0D
