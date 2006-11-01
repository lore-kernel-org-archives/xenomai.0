From: Thomas Witzel <witzel.thomas@domain.hid>
Subject: Re: [Xenomai-help] RTDM/ALSA hybrid driver ?
Date: Wed, 1 Nov 2006 00:18:34 -0500
References: <200610251610.36530.witzel.thomas@domain.hid>
	<453FCA64.9090402@domain.hid>
	<200610261213.29248.rlenglet@domain.hid>
In-Reply-To: <200610261213.29248.rlenglet@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611010018.34412.witzel.thomas@domain.hid>
Reply-To: witzel.thomas@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Wednesday 25 October 2006 23:13, Romain Lenglet wrote:
> I believe that most people wanting real-time audio use JACK
> instead of ALSA. All "serious" audio software on Linux use JACK:
> Ardour, Rosegarden, etc.
> Its design allows for real-time audio, better than ALSA.
> http://jackaudio.org/
>
> I believe that you could easily port JACK to Xenomai,
> transparently for client apps, and then interface an RTDM-based
> driver to JACK.
>
> There is already an alternative implementation of JACK
> specifically for IEEE1394 audio interfaces:
> http://freebob.sourceforge.net/index.php/Main_Page
> You could get inspiration from this implementation.

Maybe I understand this wrong, but it seems to me that Jack itself does not 
provide lowlevel drivers for the hardware, but in most cases sits on top of 
ALSA. Also most applications seem to use Jack to control other professional 
devices via MIDI or 1394.

Thomas

