From: "jpdublon" <jpdublon@domain.hid>
Date: Wed, 30 Jan 2008 16:25:43 +0100
Message-ID: <OPEMLLGLICPDOMGAPGNBIEBACAAA.jpdublon@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] shared interrupt again and again
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


Hello,

When I disable and shut down (in cleanup_module) an IRQ shared (with ata!)
in linux domain ,
it seems to also shut down (or disable?) the linux IRQ.

Is there a special way to unregister shared IRQs?

Thank you

JP DUBLON


