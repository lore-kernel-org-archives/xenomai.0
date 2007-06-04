Message-ID: <1180974632.46643e288fd9a@domain.hid>
Date: Mon, 04 Jun 2007 18:30:32 +0200
From: garryt <garryt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] __ipipe_mach_demux_irq issue. (solved)
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hello,

Thanks for the answer, following your advice i just looked at the previou=
s code
(not patched), and then i may have the solution.

In fact irq generated was defined as edge triggered:
set_irq_handler(irq, handle_edge_irq);

while GPIO register was only modified like this
set_irq_type(irq, IRQF_TRIGGER_LOW);

This seems to be ok (at least working...)  when used without IPIPE, but
unfortunately IPIPE was looking for the correct handler in order to defin=
e mask,
unmask, ack function for this irq... (As far as i understood)

then i have just registered the correct handler and everything is ok.

set_irq_type(irq, IRQF_TRIGGER_LOW);
set_irq_handler(irq, handle_level_irq);

Thanks.





