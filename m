Date: Sun, 19 Feb 2017 01:38:13 +0000 (UTC)
From: Giulio Moro <giuliomoro@yahoo.it>
Message-ID: <1051219559.580434.1487468293843@mail.yahoo.com>
MIME-Version: 1.0
References: <1051219559.580434.1487468293843.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] pthread_rt and C++ on Xenomai 2.6
Reply-To: Giulio Moro <giuliomoro@yahoo.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

What's the deal with using the posix skin to wrap C++ mutex, locks and thre=
ads?
I am on ARMv7 (Beaglebone Black), with gcc 4.9, xeno-config on this system =
returns the following:$ /usr/xenomai/bin/xeno-config --skin=3Dposix --ldfla=
gs --cflags-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthrea=
d_rt -lxenomai -lpthread -lrt-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTR=
ANT -D__XENO__ -I/usr/xenomai/include/posix
The example code here=C2=A0http://www.cplusplus.com/reference/mutex/mutex/t=
ry_lock/
compiles and runs fine (i.e.: I get a reasonable number of increases of the=
 counter) with=C2=A0(1) g++ -pthread test.cpp -std=3Dc++14 -lpthread

but if I wrap the posix calls with(2) gcc test.cpp -std=3Dc++14 =C2=A0-I/us=
r/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -I/usr/xenomai/incl=
ude/posix -L/usr/xenomai/lib -lstdc++ -lpthread_rt -lxenomai -lpthread -lrt=
 -Wl,@/usr/xenomai/lib/posix.wrappers -pthread
then the mutex can never be acquired by any thread. Actually, I cannot lock=
 it even if I place mtx.try_lock() on the first line of main().Also, if I t=
ry to sleep at sleep just before the end of attempt_10k_increases() with "s=
td::this_thread::sleep_for", it does not sleep. Even if I increase the numb=
er of attempts, in order for the threads to stay alive for longer, I cannot=
 see the threads show up in /proc/xenomai/stat .
What I observe is that when using -Wl,@/usr/xenomai/lib/posix.wrapper:- mut=
ex::try_lock fails-=C2=A0std::this_thread::sleep_for() does not sleep- thre=
ads do not show up in /proc/xenomai/stat
So I have two questions:a) is there any way to get -Wl,@/usr/xenomai/lib/po=
six.wrappers to correctly wrap underlying calls to pthread_* functions whic=
h are hidden in libstdc++ ?b) is there any way to safely link into the same=
 executable some code that calls pthread_* which you want to wrap in the Xe=
nomai posix skin and C++ code which uses std::thread?
Thanks,Giulio
