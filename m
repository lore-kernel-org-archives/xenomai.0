Date: Fri, 12 Oct 2012 11:21:15 +0200
From: "Petr Cervenka" <grugh@centrum.cz>
References: <20121011170958.40C8E372@centrum.cz>,
	<50771645.6020705@xenomai.org>,
	<20121012091140.E3CB5F90@centrum.cz> <5077D1D8.1070505@xenomai.org>
In-Reply-To: <5077D1D8.1070505@xenomai.org>
MIME-Version: 1.0
Message-Id: <20121012112115.C2F442F8@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Shared interrupts
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

>>>>
>>>> My primary questions: Is there a possibility to have the rtdm driver
>>>> compatible with both cases?
>>>

So I assume, it is not possible.

>
>Yes, I was talking about the rt devices only case. For the rt/nrt mixup,
>see the FAQ.
>

I have some suggestion on improvement in future version:=20
Allowing to setup for interrupt, that when no rt device handles the inter=
rupt it could be passed to the linux.
More specifically:
Similar flag to XN_ISR_PROPAGATE, but pass interrupt to linux only when i=
t was not handled by any rt device at all.

Example:
Imagine system with 2 shared PCI slots (and no other). The user can use t=
hose slots for any combination of rt and nrt devices. This combination (o=
r IRQ sharing) is not known in advance.

Petr

