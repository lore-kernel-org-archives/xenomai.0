Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 1 Feb 2008 15:46:57 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB02AAE515@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D37686A@slcmail.slc.mew.int>
References: <51CAD0CE1504444DBE77CBBE51A0135D37686A@slcmail.slc.mew.int>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] 125 us periodic timer high interrupt cpu usage
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>, xenomai@xenomai.org

Well,

8000 interrupts/second costs you something.

Daniel Schnell


________________________________

From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] =
On Behalf Of Steven Seeger
Sent: 1. febr=FAar 2008 15:23
To: xenomai@xenomai.org
Subject: [Xenomai-help] 125 us periodic timer high interrupt cpu usage



I notice about 8% cpu usage if I call rt_timer_set_mode(125000); and =
load up a couple of tasks which do nothing but block on conditional =
variables. (The tasks are using 0%.) I didn't have this issue (as far as =
I know) with RTAI, and I didn't have this issue when using aperiodic =
timing mode. What I need is to have all my tasks locked to some =
timebase, and was told in a previous discussion that this was the way to =
go.

=20

Is there any reason it should use so much CPU time?

=20

Thanks,

Steven

=20


