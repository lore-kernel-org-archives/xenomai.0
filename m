MIME-Version: 1.0
Date: Fri, 18 Jun 2010 19:22:15 +0530
Message-ID: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>
From: Nero Fernandez <grimlynch@domain.hid>
Content-Type: multipart/mixed; boundary=00163646bb6c3b5c5b04894e435e
Subject: [Xenomai-core] problem in pthread_mutex_lock/unlock
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--00163646bb6c3b5c5b04894e435e
Content-Type: multipart/alternative; boundary=00163646bb6c3b5c5504894e435c

--00163646bb6c3b5c5504894e435c
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Please find an archive attached, containing :
 - a program for testing context-switch-latency using posix-APIs
   for native linux kernel and xenomai-posix-skin (userspace).
 - Makefile to build it using xenomai

In brief, the attempt is to spawn a bunch of pthreads, which share pairs
of read-write pthread-mutexes in a circular fashion, as shown below, and
measure the time taken for to complete a (rel_mtx_0 - acq_mtx_n) by
pthread_0
( - threads try to acquire read mutexes and release write_mutexes)

        pthread_0:write_mtx      =   pthread_1:read_mtx
        pthread_1:write_mtx      =   pthread_2:read_mtx
        ......
        pthread_(n-1):write_mtx  =   pthread_1:write_mtx
        pthread_n:write_mtx      =   pthread_0:read_mtx

The program runs fine on native linux userspace (ARM, x86) , but the
in the xenomai-space, threads lock up at trying to acquire their respective
read_mutexes.

A similar attempt using message-queues runs fine.

Am running a version between 2.5.2 and 2.5.3.
Will try to check with 2.5.3 as well.

Following is my current xeno-config
# ./xeno-config
xeno-config --verbose
        --version="2.5.2"
        --cc="arm-linux-gcc"
        --arch="arm"
        --prefix="/opt/xeno_utils"
        --xeno-cflags="-I/opt/xeno_utils/include -D_GNU_SOURCE -D_REENTRANT
-Wall -pipe -D__XENO__"
        --xeno-ldflags="-L/opt/xeno_utils/lib -lxenomai -lpthread "
        --posix-cflags=""
        --posix-ldflags="-Wl,--wrap,pthread_create
-Wl,--wrap,pthread_setschedparam -Wl,--wrap,"

--00163646bb6c3b5c5504894e435c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font size=3D"2"><span style=3D"font-family: courier new,monospace;">Hi,</s=
pan><br style=3D"font-family: courier new,monospace;"><br style=3D"font-fam=
ily: courier new,monospace;"><span style=3D"font-family: courier new,monosp=
ace;">Please find an archive attached, containing :<br>
=A0- a program for </span><span style=3D"font-family: courier new,monospace=
;">testing context-switch-latency using posix-APIs <br><span style=3D"font-=
family: courier new,monospace;">=A0=A0 for native linux kernel </span>and x=
enomai-posix-skin (userspace).</span><br style=3D"font-family: courier new,=
monospace;">
<span style=3D"font-family: courier new,monospace;">=A0- Makefile to build =
it using xenomai</span><br style=3D"font-family: courier new,monospace;"><b=
r style=3D"font-family: courier new,monospace;"><span style=3D"font-family:=
 courier new,monospace;">In brief, the attempt is to spawn a bunch of pthre=
ads, which share pairs</span><br style=3D"font-family: courier new,monospac=
e;">
<span style=3D"font-family: courier new,monospace;">of read-write pthread-m=
utexes in a circular fashion, as shown below, and</span><br style=3D"font-f=
amily: courier new,monospace;"><span style=3D"font-family: courier new,mono=
space;">measure the time taken for to complete a (rel_mtx_0 - acq_mtx_n)</s=
pan> <span style=3D"font-family: courier new,monospace;">by pthread_0</span=
><span style=3D"font-family: courier new,monospace;"><br>
( - threads try to acquire read mutexes and release write_mutexes)</span><b=
r style=3D"font-family: courier new,monospace;"><br style=3D"font-family: c=
ourier new,monospace;"><span style=3D"font-family: courier new,monospace;">=
=A0=A0=A0=A0=A0=A0=A0 pthread_0:write_mtx =A0 =A0=A0 =3D=A0=A0 pthread_1:re=
ad_mtx</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0 p=
thread_1:write_mtx=A0 =A0 =A0 =3D=A0=A0 pthread_2:read_mtx</span><br style=
=3D"font-family: courier new,monospace;"><span style=3D"font-family: courie=
r new,monospace;">=A0=A0=A0=A0=A0=A0=A0 ......</span><br style=3D"font-fami=
ly: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0 p=
thread_(n-1):write_mtx=A0 =3D=A0=A0 pthread_1:write_mtx</span><br style=3D"=
font-family: courier new,monospace;"><span style=3D"font-family: courier ne=
w,monospace;">

=A0=A0=A0=A0=A0=A0=A0 pthread_n:write_mtx=A0=A0=A0=A0=A0 =3D =A0 pthread_0:=
read_mtx</span><br style=3D"font-family: courier new,monospace;"><br style=
=3D"font-family: courier new,monospace;"><span style=3D"font-family: courie=
r new,monospace;">The program runs fine on native linux userspace (ARM, x86=
) , but the </span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">in the xenomai-space, t=
hreads lock up at trying to acquire their respective <br>read_mutexes.<br><=
br></span><span style=3D"font-family: courier new,monospace;">A similar att=
empt using message-queues runs fine</span>.<br>
<font face=3D"courier new,monospace"><br>Am running a version between 2.5.2=
 and 2.5.3.<br>Will try to check with 2.5.3 as well.<br><br>Following is my=
 current xeno-config<br># ./xeno-config <br>xeno-config --verbose<br>=A0=A0=
=A0=A0=A0=A0=A0 --version=3D&quot;2.5.2&quot;<br>
=A0=A0=A0=A0=A0=A0=A0 --cc=3D&quot;arm-linux-gcc&quot;<br>=A0=A0=A0=A0=A0=
=A0=A0 --arch=3D&quot;arm&quot;<br>=A0=A0=A0=A0=A0=A0=A0 --prefix=3D&quot;/=
opt/xeno_utils&quot;<br>=A0=A0=A0=A0=A0=A0=A0 --xeno-cflags=3D&quot;-I/opt/=
xeno_utils/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__&quot;<=
br>
=A0=A0=A0=A0=A0=A0=A0 --xeno-ldflags=3D&quot;-L/opt/xeno_utils/lib -lxenoma=
i -lpthread &quot;<br>=A0=A0=A0=A0=A0=A0=A0 --posix-cflags=3D&quot;&quot;<b=
r>=A0=A0=A0=A0=A0=A0=A0 --posix-ldflags=3D&quot;-Wl,--wrap,pthread_create -=
Wl,--wrap,pthread_setschedparam -Wl,--wrap,&quot;<br>
<br style=3D"font-family: courier new,monospace;"></font></font>

--00163646bb6c3b5c5504894e435c--

--00163646bb6c3b5c5b04894e435e
Content-Type: application/x-gzip; name="context_switch_latency.tgz"
Content-Disposition: attachment; filename="context_switch_latency.tgz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gal2q7hj0

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
8AAA
--00163646bb6c3b5c5b04894e435e--

