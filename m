Message-ID: <2ff1a98a0803261150q1036103fr9c4152ea818834c1@domain.hid>
Date: Wed, 26 Mar 2008 19:50:26 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47EA60980200000100192F1D@nwque-vm-gwia.criq.qc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47EA60980200000100192F1D@nwque-vm-gwia.criq.qc.ca>
Subject: Re: [Xenomai-help] latency test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hubert Talbot <Hubert.Talbot@domain.hid>
Cc: xenomai@xenomai.org

On Wed, Mar 26, 2008 at 7:41 PM, Hubert Talbot <Hubert.Talbot@domain.hid> wrote:
> Hi,
>
>  800 MHz x86 system.
>
>  How can "lat max" vary to consider we have a reliable realtime system ?
>
>  If results are around 40 usec, is it normal that some values are ~75 or ~175
>  (especially when two other applications send/receive interrupts) ?

800 MHz is rather slow, so 75 may be normal (albeit rather high), but
175 is too much. You probably have a problem with SMIs... Also normal
high peaks usually happen under load. SMI peaks happen even on an idle
system.

>
>  Does "lat max" depend on processor frequency ?

I think it rather depends on processor class, as a rule of thumb, you
will probably get much lower latencies on a core 2 duo than on, say, a
pentium 2.

>
>  Does interrupt reception (rt_intr_wait) depend on processor frequency ?

The latency test uses the timer interrupt, you control the sampling
period with the -p argument.

-- 
 Gilles

