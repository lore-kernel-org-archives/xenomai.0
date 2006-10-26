From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-help] RTDM/ALSA hybrid driver ?
Date: Thu, 26 Oct 2006 12:13:29 +0900
References: <200610251610.36530.witzel.thomas@domain.hid>
	<453FCA64.9090402@domain.hid>
In-Reply-To: <453FCA64.9090402@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610261213.29248.rlenglet@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Jan Kiszka wrote:
> Thomas Witzel wrote:
> > Hello,
> >
> > I'm now trying to create a sound driver that will start and
> > stop playback in real time. Is it better to implement a
> > driver for RTDM from scratch, or is it reasonable to just
> > add a RTDM interface for the required functionality to an
> > existing ALSA driver ? The advantage of the latter approach
> > is of course, that everything that doesn't need to be done
> > in realtime already exists through ALSA and I only would
> > have to implement the pcm triggers through RTDM. Is that
> > reasonable at all ?
>
> Yes, this can be reasonable. You will fork the driver
> effectively, but you should be able to reuse init/cleanup
> parts for this. Basically, this is how most RTnet drivers were
> developed.
>
> But how hard and how tight are your RT requirements? I'm
> asking because I know that a lot of people are using
> unmodified ALSA drivers over the PREEMPT_RT kernel for
> real-time recording, processing, and playback. Maybe this can
> already provide you what you need. But I don't know the
> internal design of ALSA, if there are any pitfalls hidden like
> dynamic buffer management.

I believe that most people wanting real-time audio use JACK 
instead of ALSA. All "serious" audio software on Linux use JACK: 
Ardour, Rosegarden, etc.
Its design allows for real-time audio, better than ALSA.
http://jackaudio.org/

I believe that you could easily port JACK to Xenomai, 
transparently for client apps, and then interface an RTDM-based 
driver to JACK.

There is already an alternative implementation of JACK 
specifically for IEEE1394 audio interfaces:
http://freebob.sourceforge.net/index.php/Main_Page
You could get inspiration from this implementation.

Regards,

-- 
Romain LENGLET

