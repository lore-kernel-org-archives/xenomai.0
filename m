Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Jul 2006 14:39:39 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A668C0@domain.hid>
In-Reply-To: <20060731095941.3C4F5EC8@domain.hid>
From: "Landau, Bracha" <BLandau@domain.hid>
Subject: [Xenomai-help] two questions about using rtdm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org



-----Original Message-----
From: xenomai-help-bounces@domain.hid
[mailto:xenomai-help-bounces@domain.hid Behalf Of
xenomai-help-request@domain.hid
Sent: Monday, July 31, 2006 1:00 PM
To: xenomai@xenomai.org
Subject: Xenomai-help Digest, Vol 10, Issue 48


Send Xenomai-help mailing list submissions to
	xenomai@xenomai.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://mail.gna.org/listinfo/xenomai-help
or, via email, send a message with subject or body 'help' to
	xenomai-help-request@domain.hid

You can reach the person managing the list at
	xenomai-help-owner@domain.hid

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Xenomai-help digest..."


Today's Topics:

   1. Re: Beginner's question / testsuite / latency (Jan Kiszka)
   2. Re: Beginner's question / testsuite / latency (Philippe Gerum)


----------------------------------------------------------------------

Message: 1
Date: Mon, 31 Jul 2006 00:00:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
To: rpm@xenomai.org
Cc: xenomai@xenomai.org
Message-ID: <44CD2C0C.3@domain.hid>
Content-Type: text/plain; charset=3D"iso-8859-15"

Philippe Gerum wrote:
> On Sun, 2006-07-30 at 21:33 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Sat, 2006-07-29 at 16:20 +0200, Jan Kiszka wrote:
>>>>>> :|func        6   xnintr_clock_handler (__ipipe_dispatch_wired)
>>>>>> :|func        6   xnintr_irq_handler (xnintr_clock_handler)
>>>>>> :|func        7   xnpod_announce_tick (xnintr_irq_handler)
>>>>>> :|func        8+  xntimer_do_tick_aperiodic (xnpod_announce_tick)
>>>>>> :|func        9   xnthread_periodic_handler (xntimer_do_tick_aperi=
odic)
>>>>>> :|func       10   xnpod_resume_thread (xnthread_periodic_handler)
>>>>>> :|[21559]    11+  xnpod_resume_thread (xnthread_periodic_handler)
>>>>>> :|func       13+  xnthread_periodic_handler (xntimer_do_tick_aperi=
odic)
>>>> ...
>>>>
>>>>>> :|func      363+  xnthread_periodic_handler (xntimer_do_tick_aperi=
odic)
>>>> That are a lot of overruns. Haven't counted, but it should be one
>>>> xnthread_periodic_handler per missed 100 us period (20000 / 100 =3D =
200!).
>>>> [BTW, I think we should handle even this failure scenario without
>>>> looping.
Two questions regarding rtdm:

1) I would like to use the real-time system calls (bind,socket,send,recv,=
 etc) that are included in the API (i.e., rt_dev_socket, rt_dev_bind...).=

I tried to replace the calls to their rt equivalents (e.g., socket become=
s rt_dev_socket). But apparently that is not enough, because when I do a =
call to rt_dev_socket, I get an error.
Are there any examples of how to use the r/t sockets?

2) I am running on an MPC8247 with two CPM serial ports. Can I use the 16=
650A driver provided by xenomai to "impersonate" the CPM serial driver? I=
f not, can you instruct me how to do this?

Bracha
*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

