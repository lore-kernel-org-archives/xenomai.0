Date: Thu, 3 Jan 2013 15:15:52 +0100
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20130103141552.GB9656@localhost.localdomain>
References: <CAGVaUoFsUJKCSOMrDuq3htrLzScpzjVP8oKs2ARp7k7o8KbRfQ@mail.gmail.com>
	<9480305C-20DF-4DBA-AC23-7E3E59EBCEEB@mah.priv.at>
	<50E1CC06.9050404@xenomai.org>
	<382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>
	<CANKLDmuU254PGkv2+ABiGitZDg1u9A5uq9Po=3gzOo8-KyANVw@mail.gmail.com>
	<20130103085312.GA8132@localhost.localdomain>
	<5C3D95AF-ADF8-4B1E-8FB6-5B9557262EC8@mah.priv.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C3D95AF-ADF8-4B1E-8FB6-5B9557262EC8@mah.priv.at>
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On Thu, Jan 03, 2013 at 10:18:15AM +0100, Michael Haberler wrote:
> 
> fine, but my requirement is a working Xenomai kernel with - in the minimum - GPIO, PRU, PWM, cape support, and I dont see that combination of Xenomai and v.3.8 around the corner anyday soon
> 
> what would you then suggest as an alternative base for getting Xenomai to run on the beaglebone with the above laundry list?

I guess that the best way forward would be:

1. Try vanilla v3.8 and see if the drivers you need are working.
2. If so, then help to update the arm ipipe patch to v3.8.

But of course, it depends on how much time and effort you are willing
to spend. Just be aware that if you develop on top of some random,
hacked up vendor kernel, then it probably will end up as a dead end,
and you efforts might be wasted.

I wouldn't necessarily say that updating ipipe is harder than chasing
and fixing TI's hacks.

HTH,
Richard

