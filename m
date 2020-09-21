Subject: Re: Useless dovetail hacks
References: <55694df3-85a8-cca8-1801-d55a4e7f0e53@siemens.com>
 <87ft7os284.fsf@xenomai.org>
 <9c76bfeb-f114-0c29-f048-fb51679ad0de@siemens.com>
 <87k0wzdk3h.fsf@xenomai.org> <87pn6gcrw0.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <181a2c6b-0aa7-b189-237e-c8b8b3b39e9e@siemens.com>
Date: Mon, 21 Sep 2020 08:15:24 +0200
MIME-Version: 1.0
In-Reply-To: <87pn6gcrw0.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Pirou, Florent" <florent.pirou@intel.com>, "Hu, Mingliang" <mingliang.hu@intel.com>, "Wang, Rick Y" <rick.y.wang@intel.com>, xenomai@xenomai.org, evl@evlproject.org

On 20.09.20 18:52, Philippe Gerum wrote:
> 
> Philippe Gerum <rpm@xenomai.org> writes:
>>
>> SPI, DMA, and GPIOs are a no brainer for this and are already available
>> in such form, serial and network need more analysis because their
>> execution contexts are either more clumsy/complex. I also got the PCM
>> portion of the Alsa stack enabled with a complete I/O path over the
>> real-time context, from the user (ioctl) request to send/recv frames to
>> some i2s device, via DMA transactions controlled by the PCM core. As
>> weird as it may seem, it is actually not that intrusive, and works quite
>> well, including at insane acquisition rates for feeding an audio
>> pipeline. There is still some work ahead to fix rough edges, but the
>> fundamentals look sane.
>>
> 
> I pushed more code to illustrate what I have been talking about. The
> eight topmost patches of the following branch implement a dual-kernel
> aware variant of the Alsa PCM core:
> 
> https://git.evlproject.org/linux-evl.git/log/?h=wip/audio
> 
> This is a quick forward port (compile-tested only so far) to v5.8 of the
> original working implementation based on v5.4. A very limited set of
> i.MX audio hardware (sai, wm8904) was enabled for demo purpose so far.
> 
> To exploit this in some app, one would need to issue the ioctl request
> (SNDRV_PCM_IOCTL_PREPARE_OOB), telling the real-time capable PCM core to
> switch a capture/playback (sub)stream to out-of-band mode
> (i.e. interrupts, DMA and scheduling controlled end-to-end by the
> real-time core, EVL in this case). I plan to hack this into tinyalsa,
> which should be just fine for running simply audio pipelines, calling
> pcm_readi()/pcm_writei() basically.
> 

That problem was never about straightforward lock conversion. It was 
always about architectural conversions. That may only change with the 
mainline drivers if PREEMPT-RT triggers more rework and more RT friendly 
architectures.

And, again, I do not want tones of driver conversions complicate the 
porting to new kernel versions. That is what will happen if spreading 
this pattern significantly. I.e., you will also need maintainers and 
deprecation policies for these enabling driver patches as they will 
quickly bitrot, just differently.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

