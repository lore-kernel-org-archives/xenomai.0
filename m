MIME-Version: 1.0
References: <AM0PR07MB5572FDFC8BB9278EC530F1DCB5590@AM0PR07MB5572.eurprd07.prod.outlook.com>
 <91222f7d-c3c3-848d-f304-e97c4ff4f9d6@xenomai.org>
In-Reply-To: <91222f7d-c3c3-848d-f304-e97c4ff4f9d6@xenomai.org>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 22 Apr 2019 10:49:44 -0400
Message-ID: <CALLqZ8RXX=zLZ5Dn2paJ4ZGgxaf+H7EYtErX3CrOZofJWQJiXg@mail.gmail.com>
Subject: Re: irqchip tps65217 is not pipeline-safe!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Giulio Moro <g.moro@qmul.ac.uk>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Fri, Mar 29, 2019 at 6:37 AM Philippe Gerum via Xenomai
<xenomai@xenomai.org> wrote:
>
> On 3/28/19 8:51 PM, Giulio Moro via Xenomai wrote:
> > Hi there,
> > booting a 4.14.94-ti kernel with Cobalt 3.0.8 from the "stable/v3.0.x" =
branch, on an am3358 (PocketBeagle) I get a warning during boot "irqchip tp=
s65217 is not pipeline-safe!". The tps65217 is the power-management IC for =
the board. What does this message mean exactly? Is it something to be conce=
rned about? The board has behaved fine when running Xenomai tasks, in spite=
 of this issue.
>
> Nevertheless, this is unreliable. This warning is issued because the
> irqchip code handling the tps65217 mfd which is enabled on your platform
> was not tagged as supporting IRQ pipelining (IRQCHIP_PIPELINE_SAFE not
> present in the flags). At the very least, this means that nobody cared
> checking for this.
>
> This matter is documented in Documentation/ipipe.rst.
>
> --
> Philippe.
>

Hi,
  I have a fix for this in my private ipipe tree, finishing testing
tonight. Phillipe are those trees open to the public or should I send
a patch to the list?

Giulio, II should have a fix for the gpio issue in the next week or so
if my work commitments stay sane.

-Greg

