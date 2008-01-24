Message-ID: <d3f72a390801240819r34179b2av7f92a17e8d6277a@domain.hid>
Date: Thu, 24 Jan 2008 17:19:39 +0100
From: "axel axel" <softaxel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_37480_11957955.1201191579565"
Subject: [Xenomai-core] TASK SCHEDULING E PRIORITY
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_37480_11957955.1201191579565
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

you answer me this:

> Hi,
>
> i'm testing xenomai but i have a problem:
>
> i try to run 2 TASKS with the same PRIORITY that never exit out of the
cycle
> ( down there is the code of task )
> and never SLEEP

1. This will not work. Xenomai relies on Linux, so Xenomai tasks must let
Linux run from time to time.

but i see with the oscilloscope that the second task never
> execute.
>
> I set also round robin mode for the task, with rt_task_set_mode( 0,T_RRB,0
> ), and xnpod_activate_rr( LATCH ) kernel side.
>
> Which is the problem for you ?

2. If you use Xenomai in one-shot mode, round-robin is not implemented.
You have to switch Xenomai timer to periodic mode.


But if i use periodic mode ( second point ) i can do the first point or it's
the same impossibile ?

Thanks


Roberto Bielli

------=_Part_37480_11957955.1201191579565
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div style="direction: ltr;"><span class="q">Hi,<br><br>you answer me this:<br><br>&gt; Hi,<br>&gt;<br>&gt; i&#39;m testing xenomai but i have a problem:<br>&gt;<br>&gt; i try to run 2 TASKS with the same PRIORITY that never exit out of the cycle
<br>&gt; ( down there is the code of task )<br>&gt; and never SLEEP<br><br></span></div><div style="direction: ltr;"><span style="font-weight: bold;"><span style="font-weight: bold;">1. </span>This will not work. Xenomai relies on Linux, so Xenomai tasks must let
</span><br style="font-weight: bold;"><span style="font-weight: bold;">Linux run from time to time.</span><br></div><div style="direction: ltr;"><span class="q"><br>but i see with the oscilloscope that the second task never
<br>&gt; execute.<br>&gt;<br>&gt; I set also round robin mode for the task, with rt_task_set_mode( 0,T_RRB,0<br>&gt; ), and xnpod_activate_rr( LATCH ) kernel side.<br>&gt;<br>&gt; Which is the problem for you ?<br><br></span>
</div><span style="font-weight: bold;"><span style="font-weight: bold;">2. </span>If you use Xenomai in one-shot mode, round-robin is not implemented.</span><br style="font-weight: bold;"><span style="font-weight: bold;">
You have to switch Xenomai timer to periodic mode.<br><br><span style="font-weight: bold;"><br></span>But if i use periodic mode ( second point ) i can do the first point or it&#39;s the same impossibile ?<br><br><span style="font-weight: bold;">
Thanks <br><br><br><span style="font-weight: bold;">Roberto Bielli</span><br></span></span>

------=_Part_37480_11957955.1201191579565--

