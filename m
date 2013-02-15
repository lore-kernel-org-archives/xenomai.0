Message-ID: <511E4C3B.2020407@siemens.com>
Date: Fri, 15 Feb 2013 15:54:51 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <511A2964.4080902@hilscher.com> <511A2CA4.1000408@siemens.com>
	<511B9E94.2030108@hilscher.com> <511CE85D.6070704@hilscher.com>
	<511CFC47.5000709@hilscher.com>
In-Reply-To: <511CFC47.5000709@hilscher.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?ISO-8859-1?Q?St=E9phane_LOS?= <slos@hilscher.com>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-02-14 16:01, St=E9phane LOS wrote:
> Hi,
>=20
> Please find attached the newest version that seems better to us.

Some remarks on the code first:
 - Consider reformatting your code according to kernel style, it will
   improve readability (no long lines, e.g.).
 - rtdm_malloc is for the rare case that you allocate memory over RT
   context. But probe is still Linux.
 - If you register/free the IRQ handler on open/close, you must also
   enable/disable the IRQ sources in the hardware in those functions.
 - On removal, unregister the RTDM device first. That will synchronize
   with remaining open instances.
 - Minor: Avoid __devinit/exit, they were removed from recent kernels.

So, what is the bug again? How does the oops message look like? When
will the device start generating IRQs, and do they arrive while rebooting=
?

Jan

--=20
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

