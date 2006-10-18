Message-ID: <453622A6.2000105@domain.hid>
Date: Wed, 18 Oct 2006 14:48:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
References: <1161099585.5024.48.camel@domain.hid>	<1161157955.5093.3.camel@domain.hid>	<4536038A.4000002@domain.hid>
	<1161174276.5093.22.camel@domain.hid> <45361F0C.1010007@domain.hid>
In-Reply-To: <45361F0C.1010007@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
>>The RTTST_RTIOC_INTERM_BENCH_RES request is received by
>>rt_tmbench_ioctl_nrt and rt_tmbench_ioctl_rt. Is this normal on arm?
>>(on my x86 this happens only at the beginning of a test-run)
> 
> 
> Remove your instrumentation printfs from the user space part. They
> always switch the task to secondary mode in order to dump the messages.

Another reason why latency may switch to secondary mode is the hardware 
FPU emulation. In order to avoid that, if your toolchain is compiling
for hardware floats by default, you should pass CFLAGS=-msoft-float to 
configure.

-- 
                                                  Gilles Chanteperdrix

