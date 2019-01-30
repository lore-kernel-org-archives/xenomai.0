From: Lowell Gilbert <kludge@be-well.ilk.org>
Subject: Re: crash on accessing =?iso-8859-1?Q?=2Fproc=2Fxenomai=2Fsched?=
 =?iso-8859-1?Q?=2F=C2?=
References: <44k1infa1k.fsf@be-well.ilk.org>
 <e888a48e-9576-6353-25c1-361ae66a70e6@siemens.com>
Date: Wed, 30 Jan 2019 14:34:43 -0500
In-Reply-To: <e888a48e-9576-6353-25c1-361ae66a70e6@siemens.com> (Jan Kiszka's
 message of "Wed, 30 Jan 2019 10:37:39 +0100")
Message-ID: <44va262b3g.fsf@be-well.ilk.org>
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
Cc: xenomai@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 29.01.19 22:06, Lowell Gilbert via Xenomai wrote:
>> I was trying to update to 3.0.8, and looking at stat or acct in the
>> sched branch of the proc tree gives me an instant kernel crash, usually
>> with a null pointer access from a bogus code address, although the
>> locations aren't always the same. This is without even having my kernel
>> module or application loaded.
>>
>> The system is a dual-core Cortex-A9.
>
> Does this patch happen to help?
>
> https://gitlab.denx.de/Xenomai/xenomai/commit/02500efff060c293a74fa4c914c19b8e1504b9a3

No. I didn't expect it to: I only hook interrupts with rtdm_irq_request() 

> Otherwise: Is your I-pipe patch from upstream or self-developed. I
> suspect the latter as your kernel claims to be LTSI-based.

I'm just using the  ipipe-core-4.14.71-arm-4.patch, with a couple of
very minor changes related to handling ARM errata. I compared the
original source tree to the official linux-4.14.71 release, and the
differences were minor. I can't seem to reproduce that now, though, so I
applied the official patch against the official linux-4.14.71 tree, and
still see the same panics. I'm going to try that again to make sure I'm
not crazy.

Be well.

