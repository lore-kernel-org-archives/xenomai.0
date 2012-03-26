MIME-Version: 1.0
Date: Mon, 26 Mar 2012 20:11:22 +0200
Message-ID: <CA+fRa6eqDGrM+ftg2Su_+zGtLsvrnFnCm-HQ5C5HaTQ76y7aCg@domain.hid>
From: Daniele <danielegottfried@domain.hid>
Content-Type: multipart/alternative; boundary=001636c92676415efe04bc294deb
Subject: [Xenomai-help] error with rt_pipe
Reply-To: daniele.gottfried@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001636c92676415efe04bc294deb
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi
I have these errors when I'm trying to make an example of pipe

cc -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -Wall
-Werror-implicit-function-declaration -pipe -D__XENO__  test_pipe.c
-lnative -L/usr/lib -lxenomai -lpthread -lrt  -lrtdm -lpthread -Xlinker
-rpath /usr/lib  -o test_pipe
test_pipe.c: In function =82'task_body=82':
test_pipe.c:33: error: 'RT_PIPE_MSG' undeclared (first use in this function=
)
test_pipe.c:33: error: (Each undeclared identifier is reported only once
test_pipe.c:33: error: for each function it appears in.)
test_pipe.c:33: error: 'msgout' undeclared (first use in this function)
test_pipe.c:33: error: 'msgin' undeclared (first use in this function)
test_pipe.c:33: warning: left-hand operand of comma expression has no effec=
t
test_pipe.c:42: error: implicit declaration of function 'rt_pipe_alloc'
test_pipe.c:44: error: implicit declaration of function =82'fail'
test_pipe.c:46: error: implicit declaration of function 'RT_PIPE_MSGPTR'
test_pipe.c:47: error: implicit declaration of function 'rt_pipe_send'
test_pipe.c:50: error: implicit declaration of function 'rt_pipe_receive'
test_pipe.c:52: error: 'n' undeclared (first use in this function)
test_pipe.c:53: error: continue statement not within a loop
test_pipe.c:58: error: continue statement not within a loop
test_pipe.c:62: error: implicit declaration of function 'P_MSGPTR'
test_pipe.c:62: error: implicit declaration of function 'P_MSGSIZE'
test_pipe.c:64: error: implicit declaration of function 'rt_pipe_free'

thanks

Daniele

--001636c92676415efe04bc294deb
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi=A0<div>I have these errors when I&#39;m trying to make an example of pip=
e=A0</div><div><br></div><div><div>cc -I/usr/include/xenomai -D_GNU_SOURCE =
-D_REENTRANT -Wall -Werror-implicit-function-declaration -pipe -D__XENO__ =
=A0test_pipe.c -lnative -L/usr/lib -lxenomai -lpthread -lrt =A0-lrtdm -lpth=
read -Xlinker -rpath /usr/lib =A0-o test_pipe</div>
<div>test_pipe.c: In function =82&#39;task_body=82&#39;:</div><div>test_pip=
e.c:33: error: &#39;RT_PIPE_MSG&#39; undeclared (first use in this function=
)</div><div>test_pipe.c:33: error: (Each undeclared identifier is reported =
only once</div>
<div>test_pipe.c:33: error: for each function it appears in.)</div><div>tes=
t_pipe.c:33: error: &#39;msgout&#39; undeclared (first use in this function=
)</div><div>test_pipe.c:33: error: &#39;msgin&#39; undeclared (first use in=
 this function)</div>
<div>test_pipe.c:33: warning: left-hand operand of comma expression has no =
effect</div><div>test_pipe.c:42: error: implicit declaration of function &#=
39;rt_pipe_alloc&#39;</div><div>test_pipe.c:44: error: implicit declaration=
 of function =82&#39;fail&#39;</div>
<div>test_pipe.c:46: error: implicit declaration of function &#39;RT_PIPE_M=
SGPTR&#39;</div><div>test_pipe.c:47: error: implicit declaration of functio=
n &#39;rt_pipe_send&#39;</div><div>test_pipe.c:50: error: implicit declarat=
ion of function &#39;rt_pipe_receive&#39;</div>
<div>test_pipe.c:52: error: &#39;n&#39; undeclared (first use in this funct=
ion)</div><div>test_pipe.c:53: error: continue statement not within a loop<=
/div><div>test_pipe.c:58: error: continue statement not within a loop</div>
<div>test_pipe.c:62: error: implicit declaration of function &#39;P_MSGPTR&=
#39;</div><div>test_pipe.c:62: error: implicit declaration of function &#39=
;P_MSGSIZE&#39;</div><div>test_pipe.c:64: error: implicit declaration of fu=
nction &#39;rt_pipe_free&#39;</div>
</div><div><br></div><div>thanks</div><div><br></div><div>Daniele</div><div=
><br></div>

--001636c92676415efe04bc294deb--

