Message-ID: <4F940D6C.70108@domain.hid>
Date: Sun, 22 Apr 2012 15:53:48 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <mailman.0.1334997334.18156.xenomai@xenomai.org>	<4F931496.1060607@domain.hid>	<4F93CAF4.9050105@domain.hid>
	<4F93EA6D.5050208@domain.hid> <4F93ECCF.5020108@domain.hid>
In-Reply-To: <4F93ECCF.5020108@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] linux 2.6.11
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
Cc: xenomai@xenomai.org

On 04/22/2012 01:34 PM, Gilles Chanteperdrix wrote:
> On 04/22/2012 01:24 PM, Gilles Chanteperdrix wrote:
>> On 04/22/2012 11:10 AM, Wolfgang Grandegger wrote:
>>> But all this does not explain a factor of 3 with your driver. I doubt
>>> that it's due to a move from 2.6.29 -> 2.6.32. Try using ftrace to find
>>> out what's going on (if it's already available).
>>
>> Threaded interrupts were introduced around this time. And threaded
>> interrupts DO have a significant impact on latencies.

Yes, but thread interrupts are normally not enabled/used by default. I'm
not speaking about CONFIG_PREEMPT_RT. Well, do we speak about latencies?
He just said "reading an ADC on an EP9312 ARM board has slowed by a
factor of three". I'm not even sure if it's related to Xenomai at all.
xenophile (&$#^?) , could you please be more precise.

> But I agree: tracing with ftrace or the I-pipe tracer if using xenomai
> to see where the time is spent is the way to go.

Yep.

Wolfgang.



