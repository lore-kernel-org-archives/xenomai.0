Date: Mon, 14 Sep 2015 09:45:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150914074527.GA17701@hermes.click-hack.org>
References: <20150914062111.GE4195@hermes.click-hack.org>
 <CAPRPZsB5PCNmrrqfE4u8E23JEL=_aRhTPS=kUHtEZwpRPjhagw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPRPZsB5PCNmrrqfE4u8E23JEL=_aRhTPS=kUHtEZwpRPjhagw@mail.gmail.com>
Subject: Re: [Xenomai] SMI count polling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Sep 14, 2015 at 09:41:47AM +0200, Jeroen Van den Keybus wrote:
> Gilles,
> 
> 
> > Would it make sense to
> > poll that MSR in the I-pipe tracer for the processors which support
> > it? Or is it really not generic enough?
> 
> We have been using the SMI count in the past to trace the origin of
> unexpected delays. I'd say the support for this count would be very
> useful.
> 
> I'm thinking if it would be helpful to include this count somewhere in
> /proc/xenomai as well (including total over all CPUs) as we don't
> always have the tracer on when the SMI bites / might have bitten. On
> one occasion, an overtemp condition on the CPU of one of our
> mainboards would trigger an SMI, which happened only after several
> days.

Well, in that case you can install msr-tools:
https://01.org/msr-tools

And run:
rdmsr 0x34

Of course, this requires CONFIG_X86_MSR in the kernel configuration,
which putting the count in /proc would avoid. But still, this would
be a bit redundant.

Regards.

-- 
					    Gilles.
https://click-hack.org

