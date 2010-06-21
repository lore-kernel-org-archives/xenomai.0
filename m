Date: Tue, 22 Jun 2010 00:52:27 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100621225226.GA11004@domain.hid>
References: <4C093C93.4000907@domain.hid> <4C0CEC7E.6080408@domain.hid>
	<4C0CF99F.1090700@domain.hid> <4C19E5C8.8070802@domain.hid>
	<4C1F2AE4.6030304@domain.hid>
	<AANLkTim2aawiM9Rn-9yosiqLJFfVT6ko-uluJRPskZ7y@domain.hid>
	<4C1FAC04.8080100@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C1FAC04.8080100@domain.hid>
Subject: Re: [Xenomai-help] [comedi] NI 6251 "wrong" samples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org, comedi_list@domain.hid

Hi,

Daniele Nicolodi wrote:
> On 21/06/10 13:59, Alexis Berlemont wrote:
> >> I have tried to look at Analogy buffer handling, but the lack of any
> >> comment in the source code makes understanding how it is supposed to
> >> work a complex task.
> >>
> > Please, tell me where comments are lacking, I will fix that.
> 
> I find buffer.c and buffer.h to be under documented to be easily
> understood. For example it is not clear what the *_count members of the
> a4l_buf_t struct are for without a quite tedious inspection of the code.
> 
> >> Alexis, can you see any case where there may be a synchronization issue
> >> like the one I'm seeing in your code? Any suggestion in where to look
> >> for the bug?
> >>
> > 
> > You told you that the bug was occuring randomly and that there was no
> > pattern in the repetition of the bad samples. But are you sure that
> > the wrong samples do not occur every modulo x * 64KB ?
> 
> I convinced myself that this is not the case. For sure the error is not
> there at any ring buffer wrap around. I increased the buffer size to
> 128KB and there hasn't been any noticeable difference. Am I right
> supposing that those 64KB you are referring to are the buffer size?
> 

Yes.

> > If the bug is located in Analogy buffer handling, it should not be
> > specific to a driver. So, I will try to reproduce it with the testing
> > drivers. I will compare the mapped and unmapped acquisition results.
> > If I remember well, the "fake" driver outputs some deterministic
> > content.  If nothing comes out, I will try to use a NI device.
> 
> To detect the problem you need to feed a deterministic signal to your
> device. It looks like every now and then an old sample is returned (I
> say so because the wrong value is always in the signal range). If you
> feed a constant value you would be unable to distinguish the wrong
> sample from the good ones. If you are missing a function generator the
> DAC channels of the NI ADC board work just fine, as long as you provide
> proper low pass filters.
> 

I was just starting to define how to debug it with the testing driver
"fake" but your additional comment made me doubt: especially the fact
that I will not notice it with a constant value as the wrong acquired
sample is an "old one".

Regarding that, would you consider possible that the user application
could read the data too early? Maybe there is a synchronization issue
between the interrupt and the DMA transfer. That would explain why
unoptimized accesses (unmapped buffer and read syscalls) make the bug
vanish. 

I may have messed something up with the mite transfer counters. I will
double-check the code in this location (mite.c).

If you re-read a faulting value after a while, does it get updated ?
You might find this question silly but what strikes me is that an
unmapped acquisition gives you no wrong sample; that means that the
data are properly copied by the DMA controller into the kernel memory
buffer, the very same buffer you map in user space in the optimized mode.

> My test case is a phase-meter implementation. I'm testing the phase
> noise of the phase-meter and thus I acquire a zero mean sine wave. Every
> now and then the average of a fixed number of samples, containing an
> integer number of sine waves, is far from zero. When I detect this
> situation I dump the content of the current buffer, and in each dump
> there is always a single wrong sample.
> 
> My code is embedded into a data acquisition framework I'm developing,
> but I can provide the code, however I can take a little bit to have it
> to compile stand alone.
> 
> The bug shows usually after some minutes to half an hour of data taking
> at 10 to 50 kHz. It would be unpractical to save all that data to disk
> for inspection.
> 
> Thanks. Cheers,
> -- 
> Daniele

-- 
Alexis.

