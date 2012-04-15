Message-ID: <4F8B4B4E.7000202@domain.hid>
Date: Mon, 16 Apr 2012 00:27:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkC0xXveRSBe-YR1OV_2ZF7qZ-xPzWLjKa5b2PP5MaufLg@domain.hid>
In-Reply-To: <CAOiXNkC0xXveRSBe-YR1OV_2ZF7qZ-xPzWLjKa5b2PP5MaufLg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM or native Xenomai API
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrey Nechypurenko <andreynech@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 04/15/2012 11:24 PM, Andrey Nechypurenko wrote:
> Hi Folks,
> 
> In our hobby robotics project [1] we start using Xenomai for RT tasks.
> The first application was PWM generation with GPIO to control servo
> motors [2] (the next would be dealing with interrupts from wheel
> encoders). We have made it from the user space and result was not as
> good as we would like it to be so I decide to write kernel module to
> reduce the jitter. And here comes the question whether to use RTDM or
> just plain Xenomai API?
> 
> I was never using RTDM in the past. Based on what I have read, the
> main intent of the RTDM is to make driver code portable across
> different RT solutions for Linux. I understand it and it makes sense.
> However, looking around and asking myself what are these different
> solutions, I just can name Xenomai and preempt_rt patch. AFAIK, all
> the rest are either dead (or almost dead) or not relevant for hobby
> open-source development. So my question is what are the practical
> advantages of using RTDM instead of Xenomai API? I would be very glad
> to hear the opinion of experienced Linux RT developers about it.

RTDM is the API of choice for developing drivers for real-time
applications using xenomai. We aim at the same separation as you have
with Linux: driver code in kernel-space (using RTDM in the case of
Xenomai), application code resides in user-space, using any other skin,
though what probably makes sense to a new project is to use the native
or posix skin. Both skins have bindings to access RTDM drivers.

So, in particular, it means that writing driver code (meaning code which
interacts with hardware) in user-space is not what we would recommend.
And handling interrupts in user-space is even less recommended.

Also note that in the case of omap3, gptimers may be used to generate
PWM without software assistance. And that the gpio kernel functions are
safe to be used in real-time context.

-- 
                                                                Gilles.

