References: <55694df3-85a8-cca8-1801-d55a4e7f0e53@siemens.com>
 <87ft7os284.fsf@xenomai.org>
 <9c76bfeb-f114-0c29-f048-fb51679ad0de@siemens.com>
 <87k0wzdk3h.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Useless dovetail hacks
In-reply-to: <87k0wzdk3h.fsf@xenomai.org>
Date: Sun, 20 Sep 2020 18:52:31 +0200
Message-ID: <87pn6gcrw0.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Pirou, Florent" <florent.pirou@intel.com>, "Hu, Mingliang" <mingliang.hu@intel.com>, "Wang, Rick Y" <rick.y.wang@intel.com>, xenomai@xenomai.org, evl@evlproject.org


Philippe Gerum <rpm@xenomai.org> writes:
>
> SPI, DMA, and GPIOs are a no brainer for this and are already available
> in such form, serial and network need more analysis because their
> execution contexts are either more clumsy/complex. I also got the PCM
> portion of the Alsa stack enabled with a complete I/O path over the
> real-time context, from the user (ioctl) request to send/recv frames to
> some i2s device, via DMA transactions controlled by the PCM core. As
> weird as it may seem, it is actually not that intrusive, and works quite
> well, including at insane acquisition rates for feeding an audio
> pipeline. There is still some work ahead to fix rough edges, but the
> fundamentals look sane.
>

I pushed more code to illustrate what I have been talking about. The
eight topmost patches of the following branch implement a dual-kernel
aware variant of the Alsa PCM core:

https://git.evlproject.org/linux-evl.git/log/?h=wip/audio

This is a quick forward port (compile-tested only so far) to v5.8 of the
original working implementation based on v5.4. A very limited set of
i.MX audio hardware (sai, wm8904) was enabled for demo purpose so far.

To exploit this in some app, one would need to issue the ioctl request
(SNDRV_PCM_IOCTL_PREPARE_OOB), telling the real-time capable PCM core to
switch a capture/playback (sub)stream to out-of-band mode
(i.e. interrupts, DMA and scheduling controlled end-to-end by the
real-time core, EVL in this case). I plan to hack this into tinyalsa,
which should be just fine for running simply audio pipelines, calling
pcm_readi()/pcm_writei() basically.

-- 
Philippe.

