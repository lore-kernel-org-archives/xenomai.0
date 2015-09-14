MIME-Version: 1.0
In-Reply-To: <20150914062111.GE4195@hermes.click-hack.org>
References: <20150914062111.GE4195@hermes.click-hack.org>
Date: Mon, 14 Sep 2015 09:41:47 +0200
Message-ID: <CAPRPZsB5PCNmrrqfE4u8E23JEL=_aRhTPS=kUHtEZwpRPjhagw@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] SMI count polling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Gilles,


> Would it make sense to
> poll that MSR in the I-pipe tracer for the processors which support
> it? Or is it really not generic enough?

We have been using the SMI count in the past to trace the origin of
unexpected delays. I'd say the support for this count would be very
useful.

I'm thinking if it would be helpful to include this count somewhere in
/proc/xenomai as well (including total over all CPUs) as we don't
always have the tracer on when the SMI bites / might have bitten. On
one occasion, an overtemp condition on the CPU of one of our
mainboards would trigger an SMI, which happened only after several
days.


Jeroen.

