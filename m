Message-Id: <550B08C50200005500018E8F@iwesmail-ks.iwes.fraunhofer.de>
Date: Thu, 19 Mar 2015 17:35:01 +0100
From: <jonas.platte@iwes.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai] rtnet with xenomai 3.0 in userspace?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

after finding out that I have to use the rtdm_* functions which are part =
of
the cobalt kernel headers (I used rt_dev_* before as that's what is used =
in
the "RTnet Programming" tutorial on xenomai.org), I am still having
trouble creating a small rtnet example application.

I've found this page: [1] that implies that RTDM can generally be used in
both kernel and user space (see "Detailed Description"), but even when =
only
including <rtdm/rtdm.h> in a C or C++ program, I get a lot of error =
messages.
I stopped adding new -I directives to the compiler command line when these
errors stopped coming from missing include files only. These are the =
include
directories I accumulated trying to compile my test case:

-I/lib/modules/3.14.28/source/include
-I/lib/modules/3.14.28/source/include/uapi
-I/lib/modules/3.14.28/source/arch/x86/include
-I/lib/modules/3.14.28/source/include/xenomai

It doesn't seem right to me that I'd have to manually include things like =
the
uapi directory, or the include directory for x86 asm, but the only thing =
that I
found that seems to automate these things is `xeno-config --kcflags`, and =
I
am unsure whether the output of that command is even correct as the paths
I get from it are relative, not absolute:

-Iarch/$(SRCARCH)/xenomai/include -Iinclude/xenomai

Is RTDM (and thus rtnet) usage completely reserved to kernel space or am I
doing something wrong? In the former case, where could I get info on how =
to
write kernel modules generally / with RTDM?

Thanks,
Jonas

[1] http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtd=
m__user__api.html


