Message-ID: <4B02ADAB.2030307@domain.hid>
Date: Tue, 17 Nov 2009 15:05:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01D8F93D@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01D8F93D@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] network stall
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
> On one of our platforms (PPC 5200B Kernel 2.4, Xenomai 2.4.8,
> PCI-bus) we face rare network stalls (once a day). In this situation
> network communication seems to be completly dead, but obviously only
> the receive direction is affected as receive-interrupts in
> /proc/interrupts aren=B4t incremented while transmit interrupts are
> incremented. Wireshark-protocoll (taken via port mirroring of the
> switch) says that packets are sent to the target, but tcpdump on the
> target does not show these packets (which is obvious, if
> receive-interrupt isn=B4t operational). In the send direction only
> arp-requests are monitored (on the target and on the switch).=20
> Unfortunatelly this situation can=B4t be reproduced in an laboratory
> environment
>=20
> On our other platform, which is very similar (PPC 5200B Kernel 2.4,
> Xenomai 2.4.8) but without PCI we don=B4t have this problem. Therefore
> I am thinking whether Ipipe (in combination with PCI) could be
> responsible for the interrupt lock?
>=20
> Does anybody have an idea/suggestion how we can track down the reason
> for interrupt blockade? Are there some helpful /proc entries
> (/proc/ipipe wasn=B4t very useful for me)? Unfortunatelly, as far as I
> know, Ipipe-tacer is only available for Kernel 2.6. Am I right?
>=20
>=20
> I would appreciate any suggestion very much!

Hi,

there used to be a bug in the Adeos patches for Linux 2.6, which made
the kernel forget to run the softirqs sometimes. If this happens at the
right time with an ethernet driver using the NAPI, this could result in
a network stall with the RX interrupt no longer increasing. That is
because with NAPI, the network driver sometimes stops the RX interrupts
and does polling in the softirqs.

Well, that is just an hypothesis, it could be something different (such
as the I-pipe suddenly loosing interrupts from one source). But to
investigate, you should try and find whether when this happens, the
interrupt generation is disabled at ethernet card level, at interrupt
controller level, or not disabled at all. This would in narrowing down
the issue.

Regards.

--=20
                                          Gilles


