Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Mar 2007 12:20:26 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F4805EC5C@trillian.at.omicron.at>
From: "Richard Cochran" <richard.cochran@domain.hid>
Subject: [Adeos-main] Porting to Intel IXP425
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

I am porting to the IXP425 using adeos-ipipe-2.6.19-arm-1.6-04.patch.

Apart from the code itself, I guess that there is nothing written
about what the bits in mach-xxx must do. If I am wrong, please point
me in the right direction.

Looking at __ipipe_mach_irq_mux_p and __ipipe_mach_demux_irq:

The 'mux_p' seems to identify one of the IRQs, and this IRQ is special
in some way. The 'mux' here stands for 'multiplex', I guess. But what
exactly is the meaning of this macro?

The purpose of 'demux_irq' appears to be to check the interrupt
controller for all pending interrupts, and feed them back to the ipipe
via '__ipipe_handle_irq'. Is that right?

Thanks,
Richard


************************************************************************
***
Richard Cochran (Mr), Software Development
OMICRON electronics GmbH, Oberes Ried 1, A-6833 Klaus / Austria
Tel.: +43 5523 507 425, Fax.: +43 5523 507 7425
http://www.omicron.at/         mailto:richard.cochran@domain.hid
************************************************************************
***


