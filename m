From: "Grau, Gunter" <gunter.grau@philips.com>
Subject: Can't compile userspace application with compiler switch -std=c++11
 and Xenomai 3.2
Date: Thu, 5 May 2022 14:56:49 +0000
Message-ID: <AM7P122MB022978CBCF4698031D9E1F33F2C29@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


Hi,

We are trying to port our application to Xenomai 3.2.
The source is c++ and we use in some parts C++11 elements. Therefore the co=
mpile switch is set to -std=3Dc++11.
When now compiling with this option we see following output when using Xeno=
mai 3.2:

In file included from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD-5=
.4-Kernel-88/sdk-iv-monitor/target-sysroot/usr/xenomai/include/cobalt/semap=
hore.h:24,
                 from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD-5=
.4-Kernel-88/sdk-iv-monitor/target-sysroot/usr/xenomai/include/cobalt/sys/c=
obalt.h:25,
                 from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD-5=
.4-Kernel-88/sdk-iv-monitor/target-sysroot/usr/xenomai/include/copperplate/=
clockobj.h:113,
                 from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD-5=
.4-Kernel-88/sdk-iv-monitor/target-sysroot/usr/xenomai/include/alchemy/time=
r.h:22,
                 from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD-5=
.4-Kernel-88/sdk-iv-monitor/target-sysroot/usr/xenomai/include/alchemy/heap=
.h:22,
                 from ../PROG/Test.cpp:39:
/target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h: In function '=
void __try_read_start(const urw_t*, urwstate_t*)':
/target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:57:19: error: =
expected primary-expression before 'volatile'
 #define READ_ONCE ACCESS_ONCE
                   ^~~~~~~~~~~
/target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:64:10: note: i=
n expansion of macro 'READ_ONCE'
  token =3D READ_ONCE(urw->sequence);
          ^~~~~~~~~
/target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:57:19: error: =
expected ')' before 'volatile'
 #define READ_ONCE ACCESS_ONCE
                   ^~~~~~~~~~~
/target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:64:10: note: i=
n expansion of macro 'READ_ONCE'
  token =3D READ_ONCE(urw->sequence);
          ^~~~~~~~~

This worked with Xenomai 3.1.
It looks like the issue is related to the usage of "typeof" in the ACCESS_O=
NCE macro. This seems not to be allowed if you use -std option:
https://gcc.gnu.org/onlinedocs/gcc/Alternate-Keywords.html#Alternate-Keywor=
ds
I have now a workaround by defining a macro prior the inclusion of "heap.h"=
:
#define typeof __typeof__
But I am not happy with this. Is there a way to do this better? Is -std now=
 not allowed with Xenomai?

Thanks,
Gunter Grau


________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.

