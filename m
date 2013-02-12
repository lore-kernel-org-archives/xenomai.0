Message-ID: <511A2CA4.1000408@siemens.com>
Date: Tue, 12 Feb 2013 12:51:00 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <511A2964.4080902@hilscher.com>
In-Reply-To: <511A2964.4080902@hilscher.com>
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

On 2013-02-12 12:37, St=E9phane LOS wrote:
> Hello there,
>=20
> It seems we have managed to build an RTDM module and we can insmod it
> and it shows up in the named devices list.
>=20
> If we forget to rmmod the module, the kernel crashes when stopping or
> rebooting.

So you have a bug in your driver that requires fixing. Is the device
opened while you shutdown? What does the backtrace tell you you about
the crash? If you share your code early, we could review it already.

Jan

--=20
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

