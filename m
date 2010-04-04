Date: Sun, 4 Apr 2010 15:43:28 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100404134328.GB2582@domain.hid>
References: <4BB111C0.9050502@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BB111C0.9050502@domain.hid>
Subject: Re: [Xenomai-core] Analogy: A4L_CHAN_AREF_* and AREF_* and other
	macros
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi,

Daniele Nicolodi wrote:
> Hello Alexis,
> 
> I have noticed that in Analogy headers there are two sets of macros to
> define channels references, one with prefix A4L_CHAN_AREF_ and the other
> with prefix AREF_. I think keeping both is confusing and dangerous,
> because similar symbols are defined with different numerical values!
> 
> The later form is the one used in comedi API and drivers, but i think it
> is better to prefix all exported symbols and constants with a namespace
> like string. I would be for keeping only the former form.
> 
> If you agree, I can provide a patch for you to review.
> 

Argh, I missed it. I agree, of course. Unfortunately, the AREF_*
symbols are used in the NI driver. The other drivers used the constants
A4L_CHAN_AREF_*. 

The presence of both constants is an inconsistency. I did not
doublecheck my port of the NI driver. The use of AREF_* symbols in the
NI driver could be considered as a misuse of the API (in the driver I
mean).

However, for the people who already use this driver, they will not
understand why their applications will not work anymore. I am afraid
the deprecated solution could not be skipped.

> Similarly, I would rename TRIG_ constants to something like A4L_TRIG_,
> and while at it I think TRIG_WAKE_EOS should become A4L_CMD_WAKE_EOS, as
> it is a command flag and not a trigger source.
> 
> Similarly, it would be nice also to rename other macros defined in
> command.h, adding at least a common A4L_ prefix. While at it I think
> that, maybe after a rename to make their purpose more clear, CR_* macros
> should be exposed to user space too.
> 

I agree with all your ideas. However, for me, the whole "command" API
is a problem because of its lack of consistency with the instruction
API and because of the fact commands are not really compatible with
many subdevices (ex. DIO). So, for me, instead of inducing a little
API breakage in commands, it would be nicer to work on a new API
(coherent with instructions). The new API and the command API will
live in parallel until the next major release. Thus, no API breakage.

> If you think API breakage should be avoided, even in a so early stage of
> development and diffusion, we can keep the old definitions for a while,
> issuing deprecation warning (in this case those symbols would have to be
> exposed as constant variables where to apply the __deprecated__ gcc
> attribute).
> 
> Let me know what you think about this proposal.
> 
> Cheers,
> -- 
> Daniele
> 

-- 
Alexis.

