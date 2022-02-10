From: Gunter Grau <gunter.grau@philips.com>
Subject: Issue with linux threaded level triggered interrupts 
Date: Thu, 10 Feb 2022 16:33:12 +0100
Message-Id: <20220210153313.2229625-1-gunter.grau@philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

during our development on imx6 with kernel 5.4 and Xenomai 3.1 we discovere=
d complete system stalls when using phylib with phy irqs level triggerd. Th=
is irq is connected on the imx-gpio.

Investigation showed that it seems to be an issue in the ipipe irq end func=
tion for level interrupts. Please review the patch proposal.
I am not sure if just calling unmask_irq() is ok here since this functin al=
so does some locking. The other way would be to just call additionally the =
irq_state_clr_masked(desc) in the level end function itself.

The patch applies on ipipe/master in ipipe-arm.
It looks like this is an issue in all ipipe patches, but is triggered
by the introduction of a check in unmask_irq().

Thanks in advance,
Gunter Grau




________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.

