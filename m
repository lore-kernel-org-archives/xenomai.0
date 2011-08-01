MIME-Version: 1.0
Date: Mon, 1 Aug 2011 16:01:48 +0200
Message-ID: <CAL+uwv-PHPr3xTXrgYP4LtkaTX7rcoL-nsoHvxEAUQgTTzah7A@mail.gmail.com>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=20cf307f35e485a89504a9721229
Subject: [Xenomai-help] regarding the compilingerror
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--20cf307f35e485a89504a9721229
Content-Type: text/plain; charset=ISO-8859-1

Dear Xenomai Team,

below is the command iam running to compile userspace program test.c. But it
giving me the error as given below . Can anyone let me know the reason for
highlighted error ,

test06:/home/balijepalli/omap4/xnm# arm-none-linux-gnueabi-gcc -o test
test.c "DESTDIR=/home/balijepalli/omap4/root/usr/xenomai/bin/xeno-config
--skin=native --cflags --ldflags" -lrtdk




a*rm-none-linux-gnueabi-gcc:
DESTDIR=/home/balijepalli/omap4/root/usr/xenomai/bin/xeno-config --skin=
native --cflags --ldflags: No such file or directory*
test.c:1:8: error: expected '=', ',', ';', 'asm' or '__attribute__' before
'<' token
In file included from test.c:2:0:
/home/balijepalli/omap4/arm-2010.09/bin/../arm-none-linux-gnueabi/libc/usr/include/signal.h:41:24:
error: expected '=', ',', ';', 'asm' or '__attribute__' before
'sig_atomic_t'
test.c:6:25: fatal error: native/task.h: No such file or directory
compilation terminated.


-- 

Suresh balijepalli
Rosenehim,Baveria.

--20cf307f35e485a89504a9721229
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Xenomai Team,<div><br></div><div>below is the command=
 iam running to compile userspace program test.c. But it giving me the erro=
r as given below . Can anyone let me know the reason for highlighted error =
,=A0<br>
<div><br></div><div><div>test06:/home/balijepalli/omap4/xnm# arm-none-linux=
-gnueabi-gcc -o test test.c &quot;DESTDIR=3D/home/balijepalli/omap4/root/us=
r/xenomai/bin/xeno-config --skin=3Dnative --cflags --ldflags&quot; -lrtdk</=
div>
<div><br></div><div><br></div><div><br></div><div><br></div><div>a<b>rm-non=
e-linux-gnueabi-gcc: DESTDIR=3D/home/balijepalli/omap4/root/usr/xenomai/bin=
/xeno-config --skin=3D native --cflags --ldflags: No such file or directory=
</b></div>
<div>test.c:1:8: error: expected &#39;=3D&#39;, &#39;,&#39;, &#39;;&#39;, &=
#39;asm&#39; or &#39;__attribute__&#39; before &#39;&lt;&#39; token</div><d=
iv>In file included from test.c:2:0:</div><div>/home/balijepalli/omap4/arm-=
2010.09/bin/../arm-none-linux-gnueabi/libc/usr/include/signal.h:41:24: erro=
r: expected &#39;=3D&#39;, &#39;,&#39;, &#39;;&#39;, &#39;asm&#39; or &#39;=
__attribute__&#39; before &#39;sig_atomic_t&#39;</div>
<div>test.c:6:25: fatal error: native/task.h: No such file or directory</di=
v><div>compilation terminated.</div><div><br></div><br>-- <br><br>Suresh ba=
lijepalli<br>Rosenehim,Baveria.<br>
</div></div></div>

--20cf307f35e485a89504a9721229--

