Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2009 16:38:43 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD3878D@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and Libpcap
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>, xenomai@xenomai.org

Hej!

Benjamin Biegel wrote:
> I have a question regarding the use of Libpcap together with Xenomai.=20
> The Libpcap library provides the ability to capture Ethernet frames
with=20
> my NIC in promiscuous mode + time stamp the received frames on
Ethernet=20
> level (through the clock of the NIC).
>=20
> My question is this: How do i set up an Xenomai real-time environment=20
> that makes the time-stamping very accurate. How do I have influence on

> when pcap is scheduled? How do I make sure pcap is not preempted by
the OS?

You have to know that the Linux network stack and libpcap on behalf of
your process won't be able to run under hard real-time even with
Xenomai.

What you're looking for is RTnet: http://www.rtnet.org
So far, performance for high speed networking is rather poor IMHO,
esp. regarding the API. Please follow this proposal[1] (sorry for=20
formatting), and feel free to revive the thread and the discussion.

[1]
http://thread.gmane.org/gmane.linux.real-time.rtnet.devel/262/focus=3D263=


Best Regards
--=20
Stephane

