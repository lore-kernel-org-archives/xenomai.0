MIME-Version: 1.0
Date: Thu, 12 Jul 2018 13:50:59 +0200
From: =?UTF-8?Q?Mariusz_Janiak?= <mariuszjaniak@wp.pl>
Message-ID: <8efff54403d94924b00371c82bf031f2@grupawp.pl>
In-Reply-To: <<B9CEC894-836E-4F1B-9892-0DB1EF8637D7>>
References: <0184ea26b2509940aa629ae1405dd7f201d553ec@dggema523-mbx.china.huawei.com>
 <callqz8rkt78jkgsravygo0dkshvdotrita9do+pyoskxnsmqbg@mail.gmail.com>
 <ceac8f91-8d86-62af-79e1-571ccbd36427@huawei.com>,
 <af575344c0ab4d50b1ff22e15636e30f@grupawp.pl>,
 104e91ed-f625-46ae-b301-204ec1438d3a <B9CEC894-836E-4F1B-9892-0DB1EF8637D7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai]
	=?utf-8?q?Odp=3A_Re=3A__=5Broscore_issue_for_=22Operati?=
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
To: =?UTF-8?Q?Greg_Gallagher?= <greg@embeddedgreg.com>, gengdongjiu <gengdongjiu@huawei.com>
Cc: =?UTF-8?Q?zhangjianwei_=28D=29?= <zhangjianwei8@huawei.com>, =?UTF-8?Q?xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Hi,   In my opinion,=C2=A0 if we are already considering such an option,  r=
oscore in primary is not needed. Probably you use nodelets so, in this case=
 you communicate within one process, between threads. The communication wit=
h external world wan&#39;t be real-time so roscore can be run in secondary.=
 It is needed only during establishing connections, after that the communic=
ation is direct between nodes.    Best,  Mariusz  
                
              
               
                 
                  Dnia 12 lipca 2018 13:41 gengdongjiu &lt;gengdongjiu@huaw=
ei.com&gt; napisa=C5=82(a):
                 
                 
                   


 
 
 cc jianwei 
 
 
 =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A gengdongjiu 
 =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A Mariusz Janiak,Greg Gallagher, 
 =E6=8A=84=E2=80=83=E9=80=81=EF=BC=9A xenomai@xenomai.org, 
 =E6=97=B6=E9=97=B4=EF=BC=9A 2018-07-12 19:39:17 
 =E4=B8=BB=E2=80=83=E9=A2=98=EF=BC=9A RE: Odp: Re: [Xenomai] [roscore issue=
 for &#34;Operation not permitted&#34;] pthread_mutex_lock failed: operatio=
n not permitted 
  
 
 
 
 thanks for the suggestion.  
we have modified the ROS1 to make it realtime according to ROS2, but for so=
me reasons, we keep the roscore master node, so can you give some advice ho=
w to deploy the roscore ? should we deployed the roscore to primary domain =
or secondary domain? Now deploying
 it to primary domain has this bug, thanks.  
  
  
 
 
 
 =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Mariusz Janiak 
 =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A Greg Gallagher,gengdongjiu, 
 =E6=8A=84=E2=80=83=E9=80=81=EF=BC=9A xenomai@xenomai.org, 
 =E6=97=B6=E9=97=B4=EF=BC=9A 2018-07-12 18:52:06 
 =E4=B8=BB=E2=80=83=E9=A2=98=EF=BC=9A Odp: Re: [Xenomai] [roscore issue for=
 &#34;Operation not permitted&#34;] pthread_mutex_lock failed: operation no=
t permitted 
  
 
 
 
  
 
 
 Dnia 12 lipca 2018 10:55 gengdongjiu &lt;gengdongjiu@huawei.com&gt; napisa=
=C5=82(a):  
 
 
 
 Hi Greg,  
 
 =C2=A0Thanks for the answer,  
 
  
 
 On 2018/7/11 22:09, Greg Gallagher wrote:  
 
 
 Have you looked at any of the ROS frameworks that use Xenomai? =C2=A0Is th=
e  
 
 expectation that roscore runs in the secondary domain and your ros  
 
 based application runs in the primary domain?  
 
 
  
 
 Yes, we have looked at the the ROS frameworks that use Xenomai. do you hav=
e any suggestion?  
 
 
 
 
  
 
 Please consider OROCOS for RT part instead of ROS. Eventually ROS2.  
 
  
 
  
 
 
 
 
 we are not very familiar with the ROS.  
 
 In our test, we used the ROS pub and sub to do communication. From our tes=
t, if roscore runs in the secondary (normal linux)domain, it will not have =
such issue.  
 
 should the roscore run in the =C2=A0secondary domain or the primary domain=
? I do not know which domain it should run into. thanks a lot.  
 
 
 
 
  
 
 ROS haven&#39;t been designed as a real-time framework, especially in comm=
unication domain (ros topics + TCP + XML RPC).
  
 
  
 
 Best,  
 
 Mariusz  
 
  
 
 
 
 
 
  
 
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
 
 return EPERM, and pthread_mutex_lock return EPRM only if the mutex is not =
 
 
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
