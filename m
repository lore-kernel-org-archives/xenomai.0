Message-ID: <4DAEBB48.2070700@domain.hid>
Date: Wed, 20 Apr 2011 12:54:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <COL104-W8B4D8E6C75C99ECA28042E9930@domain.hid>,
	<4DAE99F2.7030002@domain.hid>
	<COL104-W334D71DB0C86070AC9F939E9930@domain.hid>
In-Reply-To: <COL104-W334D71DB0C86070AC9F939E9930@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] [Xenomai-core] xenomai and framebuffer-ipu on
	target iMx35
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVmb3J0?= <francois.beaufort@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Fran=C3=A7ois Beaufort wrote:
> I can't show you  /proc/interrupts when ipu and I-pipe are enabled
> because the system doesn't start in this case.

Ok. I failed to get that from your first mail. I do not know either if
you are using a vanilla kernel, or a patched one?

If a patched one, then you have to verify that generic_handle_irq is
replaced with ipipe_handle_chained_irq for multiplexed GPIO irqs.

Note that I CCd the Xenomai-help mailing list, next private mail will
receive no answer.

--=20
                                                                Gilles.


