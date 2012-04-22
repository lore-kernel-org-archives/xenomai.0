Message-ID: <4F93ECCF.5020108@domain.hid>
Date: Sun, 22 Apr 2012 13:34:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.0.1334997334.18156.xenomai@xenomai.org>	<4F931496.1060607@domain.hid>	<4F93CAF4.9050105@domain.hid>
	<4F93EA6D.5050208@domain.hid>
In-Reply-To: <4F93EA6D.5050208@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

On 04/22/2012 01:24 PM, Gilles Chanteperdrix wrote:
> On 04/22/2012 11:10 AM, Wolfgang Grandegger wrote:
>> But all this does not explain a factor of 3 with your driver. I doubt
>> that it's due to a move from 2.6.29 -> 2.6.32. Try using ftrace to find
>> out what's going on (if it's already available).
> 
> Threaded interrupts were introduced around this time. And threaded
> interrupts DO have a significant impact on latencies.
> 
But I agree: tracing with ftrace or the I-pipe tracer if using xenomai
to see where the time is spent is the way to go.

-- 
                                                                Gilles.

