From: "Charlton, John" <john.charlton@domain.hid>
Date: Thu, 25 Feb 2010 16:12:44 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CF7FB0793253794F9F45991443E5FE2006483DE98Cus194mx002tyc_"
MIME-Version: 1.0
Subject: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_CF7FB0793253794F9F45991443E5FE2006483DE98Cus194mx002tyc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have a xenomai application that runs without problems with xenomai-2.4.6.=
1/linux-2.6.27.7. When run under xenomai-2.5.1/linux-2.6.32.7 it fails with=
 the warning: Xenomai: process memory not locked (missing mlockall?).  I ve=
rified that mlockall() is being called before any xenomai calls are made as=
 follows with out error:

  // lock process in memory for xenomai
  int err =3D mlockall(MCL_CURRENT | MCL_FUTURE);
  if (err)
  {
    fprintf(stderr, "TimerInit: mlockall failed to lock process into memory=
: %d\n", err);
    exit(1);
  }
  fprintf(stdout, "TimerInit: Locked process memory\n");

The relevant message in dmesg output is:
Xenomai: watchdog triggered -- signaling runaway thread 'timerloop-2166'

This occurs when creating a native xenomai task (created by CanFestival lib=
rary) with the following code with no errors:

void StartTimerLoop(TimerCallback_t _init_callback)
{
  int ret =3D 0;
  stop_timer =3D 0;
  init_callback =3D _init_callback;

  char taskname[32];
  snprintf(taskname, sizeof(taskname), "timerloop-%d", getpid());

  printf("Starting timerloop task %s\n", taskname);
  /* create timerloop_task */
  ret =3D rt_task_create(&timerloop_task, taskname, 0, 50, T_JOINABLE);
  if (ret) {
    printf("Failed to create timerloop_task, code %d\n",errno);
    return;
  }

  /* start timerloop_task */
  ret =3D rt_task_start(&timerloop_task,&timerloop_task_proc,NULL);
  if (ret) {
    printf("Failed to start timerloop_task, code %u\n",errno);
    goto error;
  }

  return;

error:
  cleanup_all();
}

Debug output is displayed from the timerloop_task indicating that the task =
starts, but the mlockall warning is displayed before those outputs and the =
application already begins to shut down.

xeno-test runs without errors.  The trivial_periodic application also compi=
les and runs without error


--John



--_000_CF7FB0793253794F9F45991443E5FE2006483DE98Cus194mx002tyc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>I have a xenomai application that runs without problems with xenomai-2=
.4.6.1/linux-2.6.27.7. When run under xenomai-2.5.1/linux-2.6.32.7 it fails=
 with the warning: Xenomai: process memory not locked (missing mlockall?).&=
nbsp; I verified that mlockall() is being
called before any xenomai calls are made as follows with out error:</div>
<div>&nbsp;</div>
<div>&nbsp; // lock process in memory for xenomai</div>
<div>&nbsp; int err =3D mlockall(MCL_CURRENT | MCL_FUTURE);</div>
<div>&nbsp; if (err)</div>
<div>&nbsp; {</div>
<div>&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;TimerInit: mlockall failed to=
 lock process into memory: %d\n&quot;, err);</div>
<div>&nbsp;&nbsp;&nbsp; exit(1);</div>
<div>&nbsp; }</div>
<div>&nbsp; fprintf(stdout, &quot;TimerInit: Locked process memory\n&quot;)=
;</div>
<div>&nbsp;</div>
<div>The relevant message in dmesg output is:</div>
<div>Xenomai: watchdog triggered -- signaling runaway thread 'timerloop-216=
6'</div>
<div>&nbsp;</div>
<div>This occurs when creating a native xenomai task (created by CanFestiva=
l library) with the following code with no errors:</div>
<div>&nbsp;</div>
<div>void StartTimerLoop(TimerCallback_t _init_callback)</div>
<div>{</div>
<div>&nbsp; int ret =3D 0;</div>
<div>&nbsp; stop_timer =3D 0;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp; init_callback =3D _init_callback;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp; char taskname[32];</div>
<div>&nbsp; snprintf(taskname, sizeof(taskname), &quot;timerloop-%d&quot;, =
getpid());</div>
<div>&nbsp;</div>
<div>&nbsp; printf(&quot;Starting timerloop task %s\n&quot;, taskname);</di=
v>
<div>&nbsp; /* create timerloop_task */</div>
<div>&nbsp; ret =3D rt_task_create(&amp;timerloop_task, taskname, 0, 50, T_=
JOINABLE);</div>
<div>&nbsp; if (ret) {</div>
<div>&nbsp;&nbsp;&nbsp; printf(&quot;Failed to create timerloop_task, code =
%d\n&quot;,errno);</div>
<div>&nbsp;&nbsp;&nbsp; return;</div>
<div>&nbsp; }</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp; /* start timerloop_task */</div>
<div>&nbsp; ret =3D rt_task_start(&amp;timerloop_task,&amp;timerloop_task_p=
roc,NULL);</div>
<div>&nbsp; if (ret) {</div>
<div>&nbsp;&nbsp;&nbsp; printf(&quot;Failed to start timerloop_task, code %=
u\n&quot;,errno);</div>
<div>&nbsp;&nbsp;&nbsp; goto error;</div>
<div>&nbsp; }</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp; return;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div>error:</div>
<div>&nbsp; cleanup_all();</div>
<div>}</div>
<div>&nbsp;</div>
<div>Debug output is displayed from the timerloop_task indicating that the =
task starts, but the mlockall warning is displayed before those outputs and=
 the application already begins to shut down.</div>
<div>&nbsp;</div>
<div>xeno-test runs without errors.&nbsp; The trivial_periodic application =
also compiles and runs without error</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>--John</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_CF7FB0793253794F9F45991443E5FE2006483DE98Cus194mx002tyc_--

