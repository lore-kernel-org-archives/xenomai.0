From: Thomas Witzel <witzel.thomas@domain.hid>
Subject: Re: [Xenomai-help] RTDM/ALSA hybrid driver ?
References: <200610251610.36530.witzel.thomas@domain.hid>
	<200610251640.22737.witzel.thomas@domain.hid>
	<453FEE9F.9080209@domain.hid>
In-Reply-To: <453FEE9F.9080209@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Date: Tue, 31 Oct 2006 21:45:41 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200610312145.42032.witzel.thomas@domain.hid>
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
To: xenomai@xenomai.org

On Wednesday 25 October 2006 19:09, you wrote:
> > Fairly hard. I'm controlling a physics experiment with this (being short
> > the money for a function generator that will do exactly what I need).
> > This is going to be a nasty hack (given the time constraints to get this
> > accomplished).
>
> What order or dimension do those time constraints have? I.e. how long
> will the piece of output pattern be you can write ahead-of-time into the
> hardware?
Oh I was talking about the time constraints to get this implemented. I spent 
some more time on building the hardware interface between sound card output 
and experiment and I'm now back at the software.
The time constraint is that I'd like to playback a sound sample within 500us 
(or better if possible) of a trigger. The sample is short enough to fit in 
one period/buffer of the sound driver, so no "reloading" of the buffer is 
required.
> Well, understanding how the hardware and the original driver work will
> likely be unavoidable ;). Furthermore, be warned about interferences by
> other PCI users. Shutting them down or switching off DMA where feasible
> may be required.
I have a forked driver now, which actually still plays sound over the ALSA 
interface. I think the key routine to modify is snd_pcm_trigger, which 
basically starts,pauses,resumes or stops playback. The problem is that the 
routine is called from the layer above (somewhere in ALSA) already within a 
spin_lock, so I can't really wait directly in this routine. 
My idea would be that it would be best if the trigger routine for the START 
command would just activate a realtime thread that waits for the external 
event and then does what the trigger start would have done. 
> Jan

