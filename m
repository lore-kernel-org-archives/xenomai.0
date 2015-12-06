References: <6309036.vrZ57LHtHK@wirbelwind> <9606009.fESfxUr9Qo@wirbelwind>
 <566458D1.7020308@xenomai.org>
 <0A5CA087C7C2B54F937024C86CBC8AD503176195@NDMSMBX402.ndc.nasa.gov>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56647E7F.3090009@xenomai.org>
Date: Sun, 6 Dec 2015 19:29:19 +0100
MIME-Version: 1.0
In-Reply-To: <0A5CA087C7C2B54F937024C86CBC8AD503176195@NDMSMBX402.ndc.nasa.gov>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] powerpc 440 userspace latency test does nothing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Seeger, Steven D. (GSFC-444.0)[Embedded Flight Systems, Inc]" <steven.seeger@nasa.gov>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/06/2015 07:22 PM, Seeger, Steven D. (GSFC-444.0)[Embedded Flight
Systems, Inc] wrote:
> What would keep it from firing? The latency -t 1 works fine. At its core both user thread and kernel
> thread use xntimers so they should all fire.

It does fire kernel-wise, but the system seems to be confused enough
that the userland task does not switch in. Not that I'm 100% sure that
the IC issue will fix this, but that bug is serious enough to wreck the
interrupt state of the whole kernel, so this may be related, and such
consequence has already been observed in similar cases (e.g. lockups,
unexpected hangs).

> ________________________________________
> From: Philippe Gerum [rpm@xenomai.org]
> Sent: Sunday, December 06, 2015 10:48 AM
> To: Seeger, Steven D. (GSFC-444.0)[Embedded Flight Systems, Inc]; xenomai@xenomai.org
> Subject: Re: [Xenomai] powerpc 440 userspace latency test does nothing
> 
> On 12/05/2015 07:53 PM, Steven Seeger wrote:
>> More info on this.
>>
>> timer_gettime() on latency's timerfd returns 0 seconds and 1 nanosecond,
>> indicating the timer has not expired.
> 
> This value usually indicates an expired but not yet handled timer shot;
> that would match your description of an elapsed timer that did not
> trigger the associated action.
> 
> --
> Philippe.
> 


-- 
Philippe.

