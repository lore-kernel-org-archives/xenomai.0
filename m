Message-ID: <4575370B.5070002@domain.hid>
Date: Tue, 05 Dec 2006 10:08:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
References: <E1GrHXk-00023w-Oq@domain.hid>
In-Reply-To: <E1GrHXk-00023w-Oq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: adeos-main@gna.org

Sebastian Smolorz wrote:
> Hi,
> 
> here comes a preliminary version of the missing ARM-parts for the I-pipe 
> tracer. It's not yet complete, some features for the tracing of IRQs-off 
> times are missing, but will soon be added. Besides of that, the tracer seems 
> to work. ;-)

That's nice.

> 
> The following traces were recorded on a S3C2440. It would be nice if someone 
> could have a look at them and determine if everything looks sane so far.

The patch looks ok, a few remarks however:
- you include the full head.S in the patch whereas you most likely just
added the empty mcount;
- I see no patch of any Kconfig, did you forget them ?
- the arm_return_address function seem to rely on frame pointers, so
should not the tracer option require the CONFIG_FRAME_POINTER option to
be enabled ?

-- 
                                                 Gilles Chanteperdrix

