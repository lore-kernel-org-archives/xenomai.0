From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
Date: Tue, 5 Dec 2006 11:18:09 +0100
References: <E1GrHXk-00023w-Oq@domain.hid> <4575370B.5070002@domain.hid>
In-Reply-To: <4575370B.5070002@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1GrXNE-0004fl-MZ@mailer.emlix.com>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

Hi Gilles,

Gilles Chanteperdrix wrote:
> Sebastian Smolorz wrote:
> > Hi,
> >
> > here comes a preliminary version of the missing ARM-parts for the I-pipe
> > tracer. It's not yet complete, some features for the tracing of IRQs-off
> > times are missing, but will soon be added. Besides of that, the tracer
> > seems to work. ;-)
>
> That's nice.
>
> > The following traces were recorded on a S3C2440. It would be nice if
> > someone could have a look at them and determine if everything looks sane
> > so far.
>
> The patch looks ok, a few remarks however:
> - you include the full head.S in the patch whereas you most likely just
> added the empty mcount;

I diff'ed over a ipipe cvs repository where head.S does not exist. Of course, 
if I would create the patch over a ipipe'd linux kernel the empty mcount 
would be the only change in head.S

> - I see no patch of any Kconfig, did you forget them ?

As far as I remember no change in any Kconfig file was needed.

> - the arm_return_address function seem to rely on frame pointers, so
> should not the tracer option require the CONFIG_FRAME_POINTER option to
> be enabled ?

You mean the existing contents of kernel/ipipe/Kconfig.debug are not enough?

...
config IPIPE_TRACE
	bool "Latency tracing"
	depends on IPIPE_DEBUG
	select FRAME_POINTER
...

--
Sebastian

