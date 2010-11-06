MIME-Version: 1.0
Date: Fri, 5 Nov 2010 19:26:29 -0700
Message-ID: <AANLkTimpz6=DWjrKLRoG6O5XGotgQX6FTZR+U2b54awU@mail.gmail.com>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0016361e7fe45c33220494591ea3
Subject: [Xenomai-help] detect mode switches to primary mode
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

--0016361e7fe45c33220494591ea3
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

I am running several boarder line threads that are running in primary mode
only when accessing some shared memory, otherwise I want them to run in
secondary mode. I have used rt_task_set_mode to warn me upon switches to
secondary modes, however, my question is, is there a similar way to detect
mode switches to primary mode ?

I have figured out a workaround using pthread_set_mode_np to force the
thread to run in secondary mode (after shared memory access) and right
before I force it back to primary mode do a printf and see whether I get a
warning of switching into secondary mode (if so, then I know that the thread
was running in primary mode, if not, then the thread was running in
secondary mode.)

Again, my question is, is there an elegant way to detect mode switches from
secondary mode to primary mode ?

THANKS,
 peter

--0016361e7fe45c33220494591ea3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,<br><br>I am running several boarder line threads that are running=
 in primary mode only when accessing some shared memory, otherwise I want t=
hem to run in secondary mode. I have used rt_task_set_mode to warn me upon =
switches to secondary modes, however, my question is, is there a similar wa=
y to detect mode switches to primary mode ?<br>
<br>I have figured out a workaround using pthread_set_mode_np to force the =
thread to run in secondary mode (after shared memory access) and right befo=
re I force it back to primary mode do a printf and see whether I get a warn=
ing of switching into secondary mode (if so, then I know that the thread wa=
s running in primary mode, if not, then the thread was running in secondary=
 mode.)<br>
<br>Again, my question is, is there an elegant way to detect mode switches =
from secondary mode to primary mode ?<br><br>THANKS,<br>=A0peter<br>

--0016361e7fe45c33220494591ea3--

