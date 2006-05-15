Message-ID: <4546494d0605150250h350fa8c6me325b6d7a73a6d6f@domain.hid>
Date: Mon, 15 May 2006 17:50:49 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_25174_27937868.1147686649127"
Subject: [Xenomai-help] mutex_init() error when build
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

------=_Part_25174_27937868.1147686649127
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I am using Xenomai-2.1.0 on Blackfin uClinux. When enabling "POSIX"
interface and build the kernel, I got error message:

"make
make ARCH=3Dblackfin CROSS_COMPILE=3Dbfin-uclinux- -C linux-2.6.x  || exit =
1
make[1]: Entering directory
`/home/adam/workspace/kernel/adeos/uClinux-dist_0425/linux-2.6.x'
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      kernel/xenomai/skins/posix/syscall.o
kernel/xenomai/skins/posix/syscall.c:810: error: conflicting types for
'__mutex_init'
include/linux/mutex.h:94: error: previous declaration of '__mutex_init' was
here
kernel/xenomai/skins/posix/syscall.c:810: error: conflicting types for
'__mutex_init'
include/linux/mutex.h:94: error: previous declaration of '__mutex_init' was
here
make[5]: *** [kernel/xenomai/skins/posix/syscall.o] Error 1
make[4]: *** [kernel/xenomai/skins/posix] Error 2
make[3]: *** [kernel/xenomai/skins] Error 2
make[2]: *** [kernel/xenomai] Error 2
make[1]: *** [kernel] Error 2
"

include/linux/mutex.h:

extern void fastcall __mutex_init(struct mutex *lock, const char *name);

The function definition is different. I tried to add "static" in syscall.c:
__mutex_init(), still cannot work. Could you please help?

Thanks,
-Yi

------=_Part_25174_27937868.1147686649127
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I am using Xenomai-2.1.0 on Blackfin uClinux. When enabling &quot;POSIX&quo=
t; interface and build the kernel, I got error message:<br>
<br>
&quot;make<br>
make ARCH=3Dblackfin CROSS_COMPILE=3Dbfin-uclinux- -C linux-2.6.x&nbsp; || =
exit 1<br>
make[1]: Entering directory `/home/adam/workspace/kernel/adeos/uClinux-dist=
_0425/linux-2.6.x'<br>
&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br>
&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/compile.h<br>
&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; usr/initramfs_list<br>
&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel/xenomai/skins/posix/syscall.=
o<br>
kernel/xenomai/skins/posix/syscall.c:810: error: conflicting types for '__m=
utex_init'<br>
include/linux/mutex.h:94: error: previous declaration of '__mutex_init' was=
 here<br>
kernel/xenomai/skins/posix/syscall.c:810: error: conflicting types for '__m=
utex_init'<br>
include/linux/mutex.h:94: error: previous declaration of '__mutex_init' was=
 here<br>
make[5]: *** [kernel/xenomai/skins/posix/syscall.o] Error 1<br>
make[4]: *** [kernel/xenomai/skins/posix] Error 2<br>
make[3]: *** [kernel/xenomai/skins] Error 2<br>
make[2]: *** [kernel/xenomai] Error 2<br>
make[1]: *** [kernel] Error 2<br>
&quot;<br>
<br>
include/linux/mutex.h: <br>
<br>
extern void fastcall __mutex_init(struct mutex *lock, const char *name);<br=
>
<br>
The function definition is different. I tried to add &quot;static&quot; in
syscall.c: __mutex_init(), still cannot work. Could you please help?<br>
<br>
Thanks,<br>
-Yi<br>

------=_Part_25174_27937868.1147686649127--

