Message-ID: <4D4AABF4.6030804@domain.hid>
Date: Thu, 03 Feb 2011 14:21:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikSnhe5fnSLQm7eSOh9R7YA2cJ=m78n+S3kpW9K@mail.gmail.com>
	<4D4A84ED.7030604@domain.hid> <4D4A8BD8.1060900@domain.hid>
	<4D4A9052.2090508@domain.hid> <4D4A9118.2070602@domain.hid>
	<4D4A957B.6050907@domain.hid> <4D4A9654.80402@domain.hid>
	<4D4AA479.2020808@domain.hid>
In-Reply-To: <4D4AA479.2020808@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> On 2011-02-03 12:49, Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> On 2011-02-03 12:27, Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> On 2011-02-03 12:04, Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> [ And, personally, I don't trust the NVIDIA driver a lot. But that might
>>>>>>> be influenced by the fact that latest versions lock up my notebook
>>>>>>> regularly after resume and that I filed another obvious locking issue of
>>>>>>> the compilable driver stub around mmap_sem without any response from the
>>>>>>> vendor. ]
>>>>>> Some colleague of mine is using the NVIDIA driver (through the opengl
>>>>>> mapping, not CUDA/VDPAU, whatever) on high-end NVIDIA boards in a non RT
>>>>>> situation. he definitely observed some huge latencies not due to
>>>>>> scheduling issues, when uploading textures to the GPU. We are talking
>>>>>> tens of milliseconds here.
>>>>> Ugh, tens of milliseconds is heavy, more than I would expect from
>>>>> wbinvd. OTOH, uploading textures may involve mapping the RAM that
>>>>> contains them for the GPU. To exclude that as source, he could try
>>>>> instrumenting CACHE_FLUSH() (in nv-linux.h).
>>>> No, it really looks like a bug in the blob. Of course the 40ms is a spot
>>>> from time to time, usually, the upload is really fast.
>>> Unless it's a stall on the PCI bus, the blob should leaves some traces
>>> in ftrace.
>> I am talking about the kernel-space blob. ftrance does just show that
>> the ioctl has been submitted.
> 
> Function tracing takes you at least into the blob wrapper, both for
> requests issued to the blob and for its callbacks to access Linux
> services. It looks like NVIDIA as concentrating both arch and kernel
> specific abstractions there, not in the blob (but that's just an
> impression).

Sorry, I misunderstood ftrace, I thought strace. No, we did not try ftrace.

-- 
					    Gilles.

