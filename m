From: Josh Karch <jkarch@FirstMode.com>
Subject: ERROR: "__ipipe_dispatch_irq" [drivers/gpio/gpio-zynq.ko] undefined!
Date: Wed, 15 Jul 2020 20:29:40 +0000
Message-ID: <MN2PR19MB396705558DC19B20A61E9DAFD57E0@MN2PR19MB3967.namprd19.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is a separate issue that goes along with the issues with gpio-xilinx. =
 The gpio-zynq driver is a stock driver with the standard I-Pipe patch, how=
ever I am receiving an error that __ipipe_dispatch_irq is undefined. Thanks=
 to Greg, I was able to confirm that core.c has this function.
However, In core.c, I noticed that EXPORT_SYMBOL_GPL was not applied to __i=
pipe_dispatch_irq.  Modifying core.c to include this function enabled the m=
odule to load, however my system still locks up on an ISR when the GPIO tri=
ggers an IRQ, so the GPIO interrupt handler is still not working on the gpi=
o-xilinx made by Xilinx.

Best,
Josh Karch
