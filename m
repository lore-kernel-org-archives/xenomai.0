Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Mar 2005 10:24:00 -0600
Message-ID: <0D21CBD1298D2C4790E2F2B86D96EC1938028C@amr-ex5.ds.amrdec.army.mil>
From: "Reynolds, Terry \(Contractor-SIMTECH\)" <terry.reynolds2@domain.hid>
Subject: [Adeos-main] ppc64 port questions
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos <adeos-main@gna.org>

Hi All,
=20
I apologize for the long posting, but wanted to give sufficient detail =
for folks to see what's going on.
=20
I have made a good bit of progress on the ppc64 port.  I'm trying to get =
the RTAI example test latency to work. =20
Things fail in a way that looks like I've missed a function somewhere.   =
I've added quite a few printk statements
in trying to track down the problem.
=20
What I'm seeing is:
=20
Root domain registered.
Pipeline started.
=20
Start latency test:
=20
RTAI[hal] domain registered:
   switch from root to RTAI[hal].
   calls suspend.
   switches back to root.
=20
Domain IShield registered.
   root switches to IShield
  IShield suspends & switches back to root.
=20
RTAI[nucleus] RTAI/fusion v0.6.9 started
  all initialization routines seem to run OK.
 __fusion_skin_init processes all the way through and exits without =
error.
=20
THEN
=20
In Root:
   sched.c's need_resched: calls -
   adeos_schedule_tail, which calls __adeos_handle_event with  =
ADEOS_SCHEDULE_TAIL
=20
   __adeos_handle_event does a switch_to RTAI[hal] domain.
   it resumes in suspend_domain, from which it returns to =
rthal_domain_entry.
   At that point it is in a loop constantly calling suspend_domain.
   So, RTAI[hal] instantly suspends again, switching back to root.=20
   Root ends up back in need_resced, and this process repeats several =
hundred times,
   until the latency test gives up and exits with a "failed to create =
display task, code -38"
=20
IShield is unregistered.
RTAI/fusion stops.
RTAI is unregistered.
RTAI[hal] is unloaded.
=20
At least things seem to exit gracefully!
=20
So, my questions are:
=20
  Did any of that description look totally wrong? =20
=20
   What is suppose to cause RTAI[hal] to break out of the suspend_domain =
loop,
  and process the event being passed in from root via the schedule_tail? =
=20
  Should it be suspended at a different place?
=20
I'm not sure if this is an Adeos or an RTAI problem at this point.
=20
=20
TIA!
=20
Terry.
=20
=20
=20

