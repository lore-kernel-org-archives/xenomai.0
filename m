From: "Reitinger, Peter" <preitinger@carl-valentin.de>
Date: Tue, 12 Aug 2014 09:14:23 +0000
Message-ID: <49d17c437c8f4a26b2f7539403af05c4@CVEX13.valentin-carl.de>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] (slave) SPI driver for Am3354...?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Xenomai people,

as we like to avoid to re-invent the wheel when possible, I'd like to ask y=
ou if there is a mature spi driver as rtdm driver which enables usage of Mc=
SPI in slave mode and combined with dma. (A big preloaded byte array shall =
be clocked to the master in an FPGA in eventually varying clock speed reque=
sted by it up to maximal speed of 48MHz.)
Or do you think it is a better idea to use the standard Linux SPI protocol =
driver with RT-Preempt patch?
I've seen there is the project https://github.com/nradulovic/xdrv-spi/. Can=
 anybody recommend it?

Kind regards,
Peter Reitinger
