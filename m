Message-ID: <4B02C974.8050701@domain.hid>
Date: Tue, 17 Nov 2009 17:04:04 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01D8F93D@ARVMAIL1.mra.roland-man.biz>
	<4B02ADAB.2030307@domain.hid>
In-Reply-To: <4B02ADAB.2030307@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> roderik.wildenburg@domain.hid wrote:
>> On one of our platforms (PPC 5200B Kernel 2.4, Xenomai 2.4.8,
>> PCI-bus) we face rare network stalls (once a day). In this situation
>> network communication seems to be completly dead, but obviously only
>> the receive direction is affected as receive-interrupts in
>> /proc/interrupts aren=B4t incremented while transmit interrupts are
>> incremented. Wireshark-protocoll (taken via port mirroring of the
>> switch) says that packets are sent to the target, but tcpdump on the
>> target does not show these packets (which is obvious, if
>> receive-interrupt isn=B4t operational). In the send direction only
>> arp-requests are monitored (on the target and on the switch).=20
>> Unfortunatelly this situation can=B4t be reproduced in an laboratory
>> environment

Are there any FEC related kernel messages? Maybe (likely) the problem is
caused by Ethernet packet bombardments (I suspect bursts of ARP
request). You could try to simulate such bombardments by using pktgen. I
can send you a script in case you are interested.

>> On our other platform, which is very similar (PPC 5200B Kernel 2.4,
>> Xenomai 2.4.8) but without PCI we don=B4t have this problem. Therefore
>> I am thinking whether Ipipe (in combination with PCI) could be
>> responsible for the interrupt lock?
>>
>> Does anybody have an idea/suggestion how we can track down the reason
>> for interrupt blockade? Are there some helpful /proc entries
>> (/proc/ipipe wasn=B4t very useful for me)? Unfortunatelly, as far as I
>> know, Ipipe-tacer is only available for Kernel 2.6. Am I right?
>>
>>
>> I would appreciate any suggestion very much!
>=20
> Hi,
>=20
> there used to be a bug in the Adeos patches for Linux 2.6, which made
> the kernel forget to run the softirqs sometimes. If this happens at the
> right time with an ethernet driver using the NAPI, this could result in
> a network stall with the RX interrupt no longer increasing. That is
> because with NAPI, the network driver sometimes stops the RX interrupts
> and does polling in the softirqs.

The standard FEC Ethernet driver does not use NAPI.

Wolfgang.

