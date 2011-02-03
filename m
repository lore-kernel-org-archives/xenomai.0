Message-ID: <4D4A957B.6050907@domain.hid>
Date: Thu, 03 Feb 2011 12:46:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTikSnhe5fnSLQm7eSOh9R7YA2cJ=m78n+S3kpW9K@mail.gmail.com>
	<4D4A84ED.7030604@domain.hid> <4D4A8BD8.1060900@domain.hid>
	<4D4A9052.2090508@domain.hid> <4D4A9118.2070602@domain.hid>
In-Reply-To: <4D4A9118.2070602@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT OS Selection advice for parallel processing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-02-03 12:27, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> On 2011-02-03 12:04, Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> [ And, personally, I don't trust the NVIDIA driver a lot. But that might
>>>> be influenced by the fact that latest versions lock up my notebook
>>>> regularly after resume and that I filed another obvious locking issue of
>>>> the compilable driver stub around mmap_sem without any response from the
>>>> vendor. ]
>>> Some colleague of mine is using the NVIDIA driver (through the opengl
>>> mapping, not CUDA/VDPAU, whatever) on high-end NVIDIA boards in a non RT
>>> situation. he definitely observed some huge latencies not due to
>>> scheduling issues, when uploading textures to the GPU. We are talking
>>> tens of milliseconds here.
>>
>> Ugh, tens of milliseconds is heavy, more than I would expect from
>> wbinvd. OTOH, uploading textures may involve mapping the RAM that
>> contains them for the GPU. To exclude that as source, he could try
>> instrumenting CACHE_FLUSH() (in nv-linux.h).
> 
> No, it really looks like a bug in the blob. Of course the 40ms is a spot
> from time to time, usually, the upload is really fast.

Unless it's a stall on the PCI bus, the blob should leaves some traces
in ftrace.

Anyway, the key message is the same: you don't know for sure what the
blob is doing.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

