MIME-Version: 1.0
Date: Fri, 12 Aug 2011 12:33:21 +0200
Message-ID: <CAKvQZ_201P0vHGH0QFyGGqmOHFugbEfcZ=-vspNJU+F9Z+1dqw@domain.hid>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd5f4aa45e7bd04aa4c714f
Subject: [Xenomai-help] depracated use case of xeno-config, how to update ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, canfestival-devel@domain.hid

--000e0cd5f4aa45e7bd04aa4c714f
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I am running a 2.5.6 xenomai version (under a 2.5.32.7 Debian squeeze 64b
linux). I used to have a can driven by CanFestival which is supported for
both linux and xenomai. I had no problem with linux and i am now trying to
use it with xenomai. The point is that the configuration of makefile uses
old xeno-config commands that shows depracated use cases like :
xeno-config  --xeno-ldflags
--xeno-ldflags is deprecated, use --skin=name --ldflags instead

Here is the old code FYI :
    RT_LIB_DIR=`$XENO_CONFIG --library-dir`\ -Wl,-rpath\ `$XENO_CONFIG
--library-dir`
    SUB_EXE_CFLAGS=$SUB_EXE_CFLAGS\ `$XENO_CONFIG --xeno-ldflags`\
-L$RT_LIB_DIR\ -lnative\ -lrtdm
    SUB_PROG_CFLAGS=$SUB_PROG_CFLAGS\ -DUSE_XENO\ `$XENO_CONFIG
--xeno-cflags`

which ended in :
SUB_EXE_CFLAGS=... -L/usr/lib -lxenomai -lpthread -L/usr/lib -Wl,-rpath
/usr/lib -lnative -lrtdm
SUB_PROG_CFLAGS= ... -DUSE_XENO -I/usr/include/xenomai -D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__
Note : I don't really know if those where correct for previous versions this
xenomai case may be nroken.

Now, as xeno-config depracated messages suggest I should not use "
$XENO_CONFIG --xeno-ldflags" but "$XENO_CONFIG --skin=native --ldflags"
without adding -lnative.
My problem is that I have both -lnative and -lrtdm so I wonder why skin is
only accepting one at a time.
Is it forbidden now to do such mixes ?
Did CanFestival code should be separated into 2 pieces one with skin=native
the other with skin=rtdm ?
Should I only add -lrtdm "brutally"


BTW, the helper message of xeno-config is not very clear, it seems it is
printed twice , one with an old message, and one with a new :
xeno-config --verbose
        --version="2.5.6"
        --cc="gcc"
        --arch="x86"
        --prefix="/usr"
        --xeno-cflags="-I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT
-Wall -pipe -D__XENO__"
        --xeno-ldflags="-L/usr/lib -lxenomai -lpthread "
        --posix-cflags=""
        --posix-ldflags="-Wl,@/usr/lib/posix.wrappers -L/usr/lib
-lpthread_rt -lxenomai -lpthread -lrt "
        --library-dir="/usr/lib"
Usage xeno-config --skin=skinname OPTIONS
Options :
    --help
    --v,--verbose
    --version
    --cc
    --arch
    --prefix
    --skin native|posix|psos|rtai|rtdm|uitron|vrtx|vxworks
    --cflags
    --ldflags
    --lib*-dir,--libdir,--user-libdir

Deprecated options:
    --xeno-cflags
    --xeno-ldflags
    --posix-cflags
    --posix-ldflags

--000e0cd5f4aa45e7bd04aa4c714f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I am running a 2.5.6 xenomai version (under a 2.5.32.7 Debia=
n squeeze 64b linux). I used to have a can driven by CanFestival which is s=
upported for both linux and xenomai. I had no problem with linux and i am n=
ow trying to use it with xenomai. The point is that the configuration of ma=
kefile uses old xeno-config commands that shows depracated use cases like :=
<br>
xeno-config=A0 --xeno-ldflags<br>--xeno-ldflags is deprecated, use --skin=
=3Dname --ldflags instead<br><br>Here is the old code FYI : <br>=A0=A0=A0 R=
T_LIB_DIR=3D`$XENO_CONFIG --library-dir`\ -Wl,-rpath\ `$XENO_CONFIG --libra=
ry-dir`<br>
=A0=A0=A0 SUB_EXE_CFLAGS=3D$SUB_EXE_CFLAGS\ `$XENO_CONFIG --xeno-ldflags`\ =
-L$RT_LIB_DIR\ -lnative\ -lrtdm<br>=A0=A0=A0 SUB_PROG_CFLAGS=3D$SUB_PROG_CF=
LAGS\ -DUSE_XENO\ `$XENO_CONFIG --xeno-cflags`<br><br>which ended in :<br>S=
UB_EXE_CFLAGS=3D... -L/usr/lib -lxenomai -lpthread -L/usr/lib -Wl,-rpath /u=
sr/lib -lnative -lrtdm<br>
SUB_PROG_CFLAGS=3D ... -DUSE_XENO -I/usr/include/xenomai -D_GNU_SOURCE -D_R=
EENTRANT -Wall -pipe -D__XENO__<br>Note : I don&#39;t really know if those =
where correct for previous versions this xenomai case may be nroken.<br><br=
>
Now, as xeno-config depracated messages suggest I should not use &quot; $XE=
NO_CONFIG --xeno-ldflags&quot; but &quot;$XENO_CONFIG --skin=3Dnative --ldf=
lags&quot; without adding -lnative.<br>My problem is that I have both -lnat=
ive and -lrtdm so I wonder why skin is only accepting one at a time.<br>
Is it forbidden now to do such mixes ?<br>Did CanFestival code should be se=
parated into 2 pieces one with skin=3Dnative the other with skin=3Drtdm ?<b=
r>Should I only add -lrtdm &quot;brutally&quot;<br><br><br>BTW, the helper =
message of xeno-config is not very clear, it seems it is printed twice , on=
e with an old message, and one with a new :<br>
xeno-config --verbose<br>=A0=A0=A0=A0=A0=A0=A0 --version=3D&quot;2.5.6&quot=
;<br>=A0=A0=A0=A0=A0=A0=A0 --cc=3D&quot;gcc&quot;<br>=A0=A0=A0=A0=A0=A0=A0 =
--arch=3D&quot;x86&quot;<br>=A0=A0=A0=A0=A0=A0=A0 --prefix=3D&quot;/usr&quo=
t;<br>=A0=A0=A0=A0=A0=A0=A0 --xeno-cflags=3D&quot;-I/usr/include/xenomai -D=
_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__&quot;<br>
=A0=A0=A0=A0=A0=A0=A0 --xeno-ldflags=3D&quot;-L/usr/lib -lxenomai -lpthread=
 &quot;<br>=A0=A0=A0=A0=A0=A0=A0 --posix-cflags=3D&quot;&quot;<br>=A0=A0=A0=
=A0=A0=A0=A0 --posix-ldflags=3D&quot;-Wl,@/usr/lib/posix.wrappers -L/usr/li=
b -lpthread_rt -lxenomai -lpthread -lrt &quot;<br>
=A0=A0=A0=A0=A0=A0=A0 --library-dir=3D&quot;/usr/lib&quot;<br>Usage xeno-co=
nfig --skin=3Dskinname OPTIONS<br>Options :<br>=A0=A0=A0 --help<br>=A0=A0=
=A0 --v,--verbose<br>=A0=A0=A0 --version<br>=A0=A0=A0 --cc<br>=A0=A0=A0 --a=
rch<br>=A0=A0=A0 --prefix<br>=A0=A0=A0 --skin native|posix|psos|rtai|rtdm|u=
itron|vrtx|vxworks<br>
=A0=A0=A0 --cflags<br>=A0=A0=A0 --ldflags<br>=A0=A0=A0 --lib*-dir,--libdir,=
--user-libdir<br><br>Deprecated options:<br>=A0=A0=A0 --xeno-cflags<br>=A0=
=A0=A0 --xeno-ldflags<br>=A0=A0=A0 --posix-cflags<br>=A0=A0=A0 --posix-ldfl=
ags<br><div style=3D"visibility: hidden; left: -5000px; position: absolute;=
 z-index: 9999; padding: 0px; margin-left: 0px; margin-top: 0px; overflow: =
hidden; word-wrap: break-word; color: black; font-size: 10px; text-align: l=
eft; line-height: 130%;" id=3D"avg_ls_inline_popup">
</div>

--000e0cd5f4aa45e7bd04aa4c714f--

