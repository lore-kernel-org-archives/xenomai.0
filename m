Message-Id: <47EA60980200000100192F1D@nwque-vm-gwia.criq.qc.ca>
Date: Wed, 26 Mar 2008 14:41:28 -0400
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] latency test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

800 MHz x86 system.

How can "lat max" vary to consider we have a reliable realtime system ?=20

If results are around 40 usec, is it normal that some values are ~75 or =
~175
(especially when two other applications send/receive interrupts) ?

Does "lat max" depend on processor frequency ?

Does interrupt reception (rt_intr_wait) depend on processor frequency ?

Thanks

Hubert




