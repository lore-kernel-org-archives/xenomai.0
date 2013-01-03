Message-ID: <50E5E7D9.7020605@xenomai.org>
Date: Thu, 03 Jan 2013 21:19:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGVaUoFsUJKCSOMrDuq3htrLzScpzjVP8oKs2ARp7k7o8KbRfQ@mail.gmail.com>	<9480305C-20DF-4DBA-AC23-7E3E59EBCEEB@mah.priv.at>	<50E1CC06.9050404@xenomai.org>	<382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>	<CANKLDmuU254PGkv2+ABiGitZDg1u9A5uq9Po=3gzOo8-KyANVw@mail.gmail.com>	<20130103085312.GA8132@localhost.localdomain>	<5C3D95AF-ADF8-4B1E-8FB6-5B9557262EC8@mah.priv.at>
	<20130103141552.GB9656@localhost.localdomain>
In-Reply-To: <20130103141552.GB9656@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Cochran <richardcochran@gmail.com>
Cc: xenomai@xenomai.org

On 01/03/2013 03:15 PM, Richard Cochran wrote:

> On Thu, Jan 03, 2013 at 10:18:15AM +0100, Michael Haberler wrote:
>>
>> fine, but my requirement is a working Xenomai kernel with - in the minimum - GPIO, PRU, PWM, cape support, and I dont see that combination of Xenomai and v.3.8 around the corner anyday soon
>>
>> what would you then suggest as an alternative base for getting Xenomai to run on the beaglebone with the above laundry list?
> 
> I guess that the best way forward would be:
> 
> 1. Try vanilla v3.8 and see if the drivers you need are working.
> 2. If so, then help to update the arm ipipe patch to v3.8.
> 
> But of course, it depends on how much time and effort you are willing
> to spend. Just be aware that if you develop on top of some random,
> hacked up vendor kernel, then it probably will end up as a dead end,
> and you efforts might be wasted.
> 
> I wouldn't necessarily say that updating ipipe is harder than chasing
> and fixing TI's hacks.


The advantage of TI's trees is that:
- they are available way before any code equivalent to the one they
contain is available in mainline, some drivers may never make it to
mainline anyway;
- their SDKs are based on it.

Of course some of the code they contain is not really acceptable in
mainline, but at least it is there and takes less time to debug than it
would if starting from scratch.

The fact that they remain with one kernel release is only an issue on
the long term, but since on the long term, you have chances to use the
next TI product, which will mean a newer kernel, maybe you will never
care about trying and updating the kernel for the old TI product.

Just trying to give a different opinion from Richard.

-- 
                                                                Gilles.

