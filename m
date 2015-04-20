MIME-Version: 1.0
In-Reply-To: <CAKk99t1NdbeEWeB9hTztoZyDS7XDFzHeDRjMypfURLVkLqENkA@mail.gmail.com>
References: <553232db.8404460a.6101.538c@mx.google.com>
 <CAKk99t1NdbeEWeB9hTztoZyDS7XDFzHeDRjMypfURLVkLqENkA@mail.gmail.com>
Date: Mon, 20 Apr 2015 19:23:35 +0800
Message-ID: <CABqyFP-2R-r_OWHs7zgLLKEUjBfL1amuOteAEKNKBVye-E6Xmg@mail.gmail.com>
From: Ruika You <crazylinuxcnc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Error: could not insert module kernel-task.ko:
 Unknown symbol in module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Helder Daniel,

Thanks for your guide, I solve this issue.

MODULES        =3Dhello
PWD          :=3D $(shell if [ "$$PWD" !=3D "" ]; then echo $$PWD; else pwd=
; fi)
KSRC         ?=3D /lib/modules/$(shell uname -r)/build
obj-m         +=3D ${patsubst %, %.o, $(MODULES)}

#comment this line change to your proposal
#EXTRA_CFLAGS    =3D -I$(KSRC)/include/xenomai -D_GNU_SOURCE -D_REENTRANT
-D__XENO__

EXTRA_CFLAGS:=3D$(shell /usr/xenomai/bin/xeno-config --skin native --cflags=
)
all:
    make -C $(KSRC) M=3D$(PWD) modules
clean::
    $(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.markers
modules.order
    $(RM) -R .tmp*

make -C /lib/modules/3.14.0/build M=3D/home/edm/test/hello modules
make[1]: Entering directory `/home/edm/linuxcnc/linux-kernel'
  CC [M]  /home/edm/test/hello/hello.o
In file included from /home/edm/test/hello/hello.c:4:0:
/usr/xenomai/include/native/task.h: In function =E2=80=98rt_task_spawn=E2=
=80=99:
/usr/xenomai/include/native/task.h:319:5: warning: =E2=80=98rt_task_create=
=E2=80=99 is
deprecated (declared at /usr/xenomai/include/native/task.h:252)
[-Wdeprecated-declarations]
/home/edm/test/hello/hello.c: In function =E2=80=98init_module=E2=80=99:
/home/edm/test/hello/hello.c:24:1: warning: =E2=80=98rt_task_create=E2=80=
=99 is deprecated
(declared at /usr/xenomai/include/native/task.h:252)
[-Wdeprecated-declarations]
  Building modules, stage 2.
  MODPOST 1 modules
  CC      /home/edm/test/hello/hello.mod.o
  LD [M]  /home/edm/test/hello/hello.ko
make[1]: Leaving directory `/home/edm/linuxcnc/linux-kernel'

By the way, I am wondering are there warning OK?

-chengxi
