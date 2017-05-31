From: Johann Obermayr <johann.obermayr@sigmatek.at>
Date: Wed, 31 May 2017 12:25:24 +0000
Message-ID: <AM4PR0801MB15879E136514099CD7161F87F5F10@AM4PR0801MB1587.eurprd08.prod.outlook.com>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] gatekeeper & xnpod_schedule trouble
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

we use (old version) xenomai 2.6.4 with Kernel 3.10.53 on imx6.

In the gatekeeper task are the follow 2 lines
   xnlock_put_irqrestore(&nklock, s);
   xnpod_schedule();

I see, that xenomai is not scheduled while   xnlock_put_irqrestore is not f=
inished.
In the function xnlock_put_irqrestore , there are also processed the softir=
q.
Sometimes the softirq (NET_RX_SOFTIRQ) need much time (> 800 =B5s).
And while this time, xenomai is not scheduled.
But now we have activate CONFIG_IRQ_FORCED_THREADING.
And I see, that this irq-thread have linux-priority 50.
And the gatekeeper has priority MAX_RT_PRIO - 1 =3D 99.

Is this correct, that the same problem exists with CONFIG_IRQ_FORCED_THREAD=
ING, because
xnlock_put_irqrestore make a wakeup to the irq-thread, and this threads has=
 higher priority than gatekeeper,
so xnpod_schedule is called after irq-threads has finished ?

Is it a solution, to change the gatekeeper priority higher than irq-threads=
 ?
Or is there a better solution ?

Thanks for suggestion
  Johann
