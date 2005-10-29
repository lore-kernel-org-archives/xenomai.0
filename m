Message-ID: <4362CD78.6020304@domain.hid>
Date: Sat, 29 Oct 2005 03:16:40 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] serial driver fixes/improvements
References: <4360B46C.5030104@domain.hid> <4362A764.6070004@domain.hid>
In-Reply-To: <4362A764.6070004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6135F0E0A243F8BEE80318E4"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6135F0E0A243F8BEE80318E4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hannes Mayer wrote:
> Hi Jan et al.!
> 
> Jan Kiszka wrote:
> [...]
> 
>> +modprobe xeno_16550A ioaddr=<io1>[,<io2>...] irq=<irq1>[,<irq2>...]
>> +                     [tx_fifo=<len1>[,<len2>...]] [start_index=<index>]
>> +
>> +Arguments:
>> +    ioaddr<N>   - I/O address of device <N> (e.g. 0x3f8 for ttyS0)
>> +    irq<N>      - interrupt number of device <N> (e.g. 4 for ttyS0)
>> +    tx_fifo<N>  - Transmitter FIFO size in bytes of device <N>,
>> default is 16
>> +    start_index - First device instance number to be used, default is 0
> 
> 
> If I may throw in my 2 eurocents:
> I think the Arguments-section is a bit misleading.
> One doesn't specify ioaddr1, ioaddr2 etc. on the command line, as suggested
> by ioaddr<N>, but ioaddr=[1.dev],[2.dev]...
> Same for irq and tx_fifo.
> 
> What about this:
> 
> Arguments:
>     ioaddr      - I/O addresses of devices (e.g. 0x3f8 for ttyS0),
> separated by comma
>     irq         - interrupt numbers of devices (e.g. 4 for ttyS0),
> separated by comma
>     tx_fifo     - Transmitter FIFO sizes in bytes of devices, default is
> 16, separated by comma
>     start_index - First device instance number to be used, default is 0
> => rtser0
> 
> Just trying to make it as clear as possible :-)
> 

Indeed, my version is misleading, your version makes more sense. Just
the parameter for ttyS0 are not necessarily the one you listed, only
typically. Will post a patch.

Jan

--------------enig6135F0E0A243F8BEE80318E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDYs1/ncNeS9Q0k+IRAsarAJ9gzZCe7IfGQ1VhdNd9wF7HZTSGiQCgptoR
ZjNV55fAyGwsmKIIDYTluD4=
=tIlz
-----END PGP SIGNATURE-----

--------------enig6135F0E0A243F8BEE80318E4--

