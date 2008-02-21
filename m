Message-Id: <47BD41F502000001001927C9@domain.hid>
Date: Thu, 21 Feb 2008 09:18:45 -0500
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] Non RT PCI device driver vs interrupts
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

I have a PCI card that works good with a non realtime device driver, I can =
catch interrupts from it.

Can I expect to be able to catch interrupts with rt_intr_wait() in a rt =
task?

Or, should I have to translate all the PCI device driver into xenomai-rtdm =
way?
(http://www.xenomai.org/index.php/Weblinks#Installation_of_Xenomai_and_RTDM=
_Driver_Writing)

Thanks

Hubert


