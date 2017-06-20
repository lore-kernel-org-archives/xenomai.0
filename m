From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Tue, 20 Jun 2017 15:03:33 +0000
Message-ID: <DB6PR0701MB245610FA99A3776FA22E64AFB5C50@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB24567D7382C2C3C1C6BBB0A3B5C60@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <20170620143009.GB18556@csclub.uwaterloo.ca>
In-Reply-To: <20170620143009.GB18556@csclub.uwaterloo.ca>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Gpio: IRQ handler is called ~4ms after state change
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Len,

> Turns out that in that case smartidle was enabled and the gpio bank
>  would go into sleep mode and it took 4ms to wake up before the irq would
> show up.  Turning off the smartidle on the gpio bank so that it never
> could go to sleep solved the problem.  Maybe this TI chip has a similar
> feature.

I do not think it is the case in my test: the GPIO banks are on (the pins g=
et exported before the module is loaded), and I would not expect it to go t=
o sleep in the few ms between interrupts in my test.

Giulio=

