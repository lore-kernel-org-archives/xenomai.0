Message-ID: <47EAAB87.2040804@domain.hid>
Date: Wed, 26 Mar 2008 21:01:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47EA60980200000100192F1D@nwque-vm-gwia.criq.qc.ca>
	<2ff1a98a0803261150q1036103fr9c4152ea818834c1@domain.hid>
In-Reply-To: <2ff1a98a0803261150q1036103fr9c4152ea818834c1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] latency test
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Hubert Talbot <Hubert.Talbot@domain.hid>, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> On Wed, Mar 26, 2008 at 7:41 PM, Hubert Talbot <Hubert.Talbot@domain.hid> wrote:
>> Hi,
>>
>>  800 MHz x86 system.
>>
>>  How can "lat max" vary to consider we have a reliable realtime system ?
>>
>>  If results are around 40 usec, is it normal that some values are ~75 or ~175
>>  (especially when two other applications send/receive interrupts) ?
> 
> 800 MHz is rather slow, so 75 may be normal (albeit rather high), but

75 us is just simply crappy on any sane x86 hw of this class. 40 us should be
achievable.

> 175 is too much. You probably have a problem with SMIs... Also normal
> high peaks usually happen under load. SMI peaks happen even on an idle
> system.
> 
>>  Does "lat max" depend on processor frequency ?
> 
> I think it rather depends on processor class, as a rule of thumb, you
> will probably get much lower latencies on a core 2 duo than on, say, a
> pentium 2.
> 
>>  Does interrupt reception (rt_intr_wait) depend on processor frequency ?
> 
> The latency test uses the timer interrupt, you control the sampling
> period with the -p argument.
> 


-- 
Philippe.

