Message-ID: <50349F8D.3080102@xenomai.org>
Date: Wed, 22 Aug 2012 10:59:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtei-4S1A_AyhAifj+HxuGcVCuNRsDUeytX=21=bB9UwbQ@mail.gmail.com>
In-Reply-To: <CAKKWdtei-4S1A_AyhAifj+HxuGcVCuNRsDUeytX=21=bB9UwbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Can we have nested interrupt handling in Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: Xenomai@xenomai.org

On 08/22/2012 06:28 AM, ali hagigat wrote:
> Can we have nested interrupt handling in Xenomai? Suppose we are in
> the middle of an interrupt handler and a new interrupt comes in, CPU
> will start executing the handler of the new interrupt completely? or
> that interrupt is logged only for that domain to be serviced later?

No, we do not support nested interrupt. You should note that the Linux
kernel has stopped re-enabling hardware interrupts in the middle of the
interrupt handlers for some time now: if an interrupt handler takes a
long time to execute, then there is a bug in the interrupt handler. The
interrupt handler has to be fixed, re-enabling interrupts is a bad
workaround.

> 
> As far as I understood, when an interrupt comes, that interrupt is
> disabled and the domain pipeline is stalled and then the interrupt
> handler is called.
> When the interrupt handler returns, the domain pipeline is unstalled.
> Is that correct?

Not quite, it depends on which domain is current and which domain the
interrupt is for.

-- 
					    Gilles.

