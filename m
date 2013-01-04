Date: Fri, 4 Jan 2013 11:04:36 +0100
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20130104100435.GA2309@netboy.at.omicron.at>
References: <9480305C-20DF-4DBA-AC23-7E3E59EBCEEB@mah.priv.at>
	<50E1CC06.9050404@xenomai.org>
	<382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>
	<CANKLDmuU254PGkv2+ABiGitZDg1u9A5uq9Po=3gzOo8-KyANVw@mail.gmail.com>
	<20130103085312.GA8132@localhost.localdomain>
	<5C3D95AF-ADF8-4B1E-8FB6-5B9557262EC8@mah.priv.at>
	<20130103141552.GB9656@localhost.localdomain>
	<50E5E7D9.7020605@xenomai.org>
	<20130104085019.GA13416@localhost.localdomain>
	<50E6A5CF.7040501@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50E6A5CF.7040501@xenomai.org>
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Jan 04, 2013 at 10:50:07AM +0100, Gilles Chanteperdrix wrote:
> 
> Well, at some point you can still decide to abandon the vendor driver
> and start from scratch.

Well, yes, you will probably only do this when you have to.

And then you will cry a tear for your wasted efforts :,(

> Thanks to the stable kernel releases, a kernel still gets updates for
> security fixes. 

But not for TI's out of tree bugs.

> A product I have worked on around three years ago used
> the 2.6.32 kernel from the "arago" tree, this looks old, but on the
> other hand, the debian stable distribution default kernel running on the
> xenomai.org server is also based on the 2.6.32 kernel.

But does debian have as many custom patches as TI? I would guess not.

> I agree with that too, and I would like to help mainline the support for
> the TI processors I am using at work, but the fact is that at work, I do
> not really have time to do it, because the drivers for the TI processor
> I am working with (the TI processors for video encoding, ex-DaVinci
> family) represent big masses of code, and getting code into mainline
> means many iterations, especially for someone who does not do it often,
> and at home, well, most of the time I devote to free-software
> contributions is devoted to the xenomai project. Maybe I was discouraged
> by the attempt of contributing the FCSE patch too.

FCSE is a special, esoteric case I think. New drivers are not so hard
to get merged, but you are right about the iterations.

> The effort should come from TI, because if the support for new
> processors directly lands into mainline, we will no longer have to
> choose between the vendor kernel and the mainline kernel. I guess that
> is the point of having created Linaro.

Yep, but TI is only willing to spend so much effort. It is frustrating
to watch how they and other vendors go about their Linux support.

Thanks,
Richard

