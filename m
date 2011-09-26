Date: Mon, 26 Sep 2011 09:02:26 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-Id: <20110926090226.9C75AD68@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Frequency downscaling of new intel CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


Hello.

I recently tried newer computer and I suprusingly realized that it is big=
ger load than the old one with our xenomai application.
The problem is in the frequency downscaling of the processor when the loa=
d in under 100%.
Of course I have disabled CPU_FREQ, ACPI_PROCESSOR and INTEL_IDLE as sugg=
ested.
Later I tried also to disable CPU_IDLE, 7300_IDLE (intel chipset idle mem=
ory) and all power efficiency settings in the BIOS, but without success.
The experienced behaviour is following:
when the process is waiting for an event, the processor lowers its freque=
ncy and when the event happens it tries to restore (slowly) its nominal f=
requency.

Do you have any advice or tip what to try, because I'm really desperate?

Best regards

Petr Cervenka

configuration:
Xeon E3-1220 (Sandy Bridge)
linux-2.6.38.8
xenomai-2.5.6

