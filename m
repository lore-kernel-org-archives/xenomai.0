Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <51DAC4DF.8030908@xenomai.org>
Date: Mon, 8 Jul 2013 16:03:22 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <751B86D8-E3C2-4DFD-8455-FBBCDD2CCF78@mah.priv.at>
References: <CE260BFE-CB8F-45DC-A46D-8CFE585069EC@mah.priv.at>
	<51DAC0A9.1010709@xenomai.org>
	<E46787D6-E990-4573-A1D4-124253BD8DEA@mah.priv.at>
	<51DAC4DF.8030908@xenomai.org>
Subject: Re: [Xenomai] q on rt_task_self() and mode switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


Am 08.07.2013 um 15:55 schrieb Philippe Gerum <rpm@xenomai.org>:

>>> Certainly, but which context does the code above run? On top of some =
ioctl()?
>>=20
>> from the RT thread, which is started by a kernel module
>>=20
>=20
> I still don't see how rt_task_self() could ever return a NULL pointer =
in this case. What does xnpod_current_thread()->name give you in the =
same context?

sorry, pls disregard, my fault - trivial #define missing. rt_task_self() =
works fine as advertised in kernel too.

- Michael


>=20
> --=20
> Philippe.


