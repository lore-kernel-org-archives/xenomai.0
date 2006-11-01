From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-help] RTDM/ALSA hybrid driver ?
Date: Wed, 1 Nov 2006 15:58:16 +0900
References: <200610251610.36530.witzel.thomas@domain.hid>
	<200610261213.29248.rlenglet@domain.hid>
	<200611010018.34412.witzel.thomas@domain.hid>
In-Reply-To: <200611010018.34412.witzel.thomas@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611011558.17164.rlenglet@domain.hid>
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

Thomas Witzel wrote:
> On Wednesday 25 October 2006 23:13, Romain Lenglet wrote:
> > I believe that most people wanting real-time audio use JACK
> > instead of ALSA. All "serious" audio software on Linux use
> > JACK: Ardour, Rosegarden, etc.
> > Its design allows for real-time audio, better than ALSA.
> > http://jackaudio.org/
> >
> > I believe that you could easily port JACK to Xenomai,
> > transparently for client apps, and then interface an
> > RTDM-based driver to JACK.
> >
> > There is already an alternative implementation of JACK
> > specifically for IEEE1394 audio interfaces:
> > http://freebob.sourceforge.net/index.php/Main_Page
> > You could get inspiration from this implementation.
>
> Maybe I understand this wrong, but it seems to me that Jack
> itself does not provide lowlevel drivers for the hardware, but
> in most cases sits on top of ALSA.

JACK has several backends, including ALSA. But the Freebob 
backend does implement its own drivers, in userspace, using the 
libraw1394, etc.

Since you wanted to develop/port your own device driver anyway, I 
just suggested to use JACK as an interface with your 
applications, instead of the ALSA interface. I believe that the 
JACK API/interface is better suited for realtime applications.
So why not develop your own new JACK hard-realtime backend with 
your RTDM driver?

> Also most applications seem 
> to use Jack to control other professional devices via MIDI or
> 1394.

No. JACK has been designed to pass/route audio data in realtime 
and with low latency between applications, and to/from drivers. 
It can also route MIDI data, but that is not its main purpose.

Freebob is an implementation of a JACK backend that provides 
drivers for IEEE1394 audio interfaces, without using ALSA 
drivers.

-- 
Romain LENGLET

