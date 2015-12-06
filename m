From: "Seeger, Steven D. (GSFC-444.0)[Embedded Flight Systems, Inc]"
 <steven.seeger@nasa.gov>
Date: Sun, 6 Dec 2015 18:22:48 +0000
Message-ID: <0A5CA087C7C2B54F937024C86CBC8AD503176195@NDMSMBX402.ndc.nasa.gov>
References: <6309036.vrZ57LHtHK@wirbelwind>
 <9606009.fESfxUr9Qo@wirbelwind>,<566458D1.7020308@xenomai.org>
In-Reply-To: <566458D1.7020308@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] powerpc 440 userspace latency test does nothing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

What would keep it from firing? The latency -t 1 works fine. At its core bo=
th user thread and kernel
thread use xntimers so they should all fire.
________________________________________
From: Philippe Gerum [rpm@xenomai.org]
Sent: Sunday, December 06, 2015 10:48 AM
To: Seeger, Steven D. (GSFC-444.0)[Embedded Flight Systems, Inc]; xenomai@x=
enomai.org
Subject: Re: [Xenomai] powerpc 440 userspace latency test does nothing

On 12/05/2015 07:53 PM, Steven Seeger wrote:
> More info on this.
>
> timer_gettime() on latency's timerfd returns 0 seconds and 1 nanosecond,
> indicating the timer has not expired.

This value usually indicates an expired but not yet handled timer shot;
that would match your description of an elapsed timer that did not
trigger the associated action.

--
Philippe.

