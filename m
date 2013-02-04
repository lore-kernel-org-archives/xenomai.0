Message-ID: <51101A62.2090904@siemens.com>
Date: Mon, 04 Feb 2013 21:30:26 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <510FFDE0.4080703@icid.cu> <510FFE7C.1090601@xenomai.org>
	<51100A6B.90701@icid.cu> <5110122C.2090807@xenomai.org>
In-Reply-To: <5110122C.2090807@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] about switchtest ...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, raespi <raespi@icid.cu>
Cc: xenomai@xenomai.org

On 2013-02-04 20:55, Gilles Chanteperdrix wrote:
> On 02/04/2013 08:22 PM, raespi wrote:
> 
>>  Ok, I downloaded the 2.6.2.1 stable version now.  Everything compiles
>> without problems ... Still I get the same error when running *xeno-latency*:
>>
>> switchtest: Unable to open switchtest device.
>> (modprobe xeno_switchtest ?)
>>
>> Any ideas .. ?
> 
> 
> No, we do not have enough details. What toolchain do you use? What
> arguments do you pass to configure? Did you recompile the kernel too?

I remember stumbling over this issue recently as well, on x86. Hmm, I
think it was not a missing device but failing
RTTST_RTIOC_SWTEST_SET_TASKS_COUNT due to too few resources of the
nucleus - but that was on 16 or even 32 CPU box.

Anyway, my point is that the failure might be in that IOCTL. Instrument
the code to find out.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

