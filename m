Message-ID: <435FECBA.20605@domain.hid>
Date: Wed, 26 Oct 2005 22:53:14 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM & serial port
References: <435EFAB8.2050501@domain.hid> <435F2DDA.1030702@domain.hid>
	<435FB6CB.9030307@domain.hid> <435FBDB1.2010109@domain.hid>
	<435FC965.8040400@domain.hid> <435FCAA7.8090003@domain.hid>
	<435FE178.1040100@domain.hid>
In-Reply-To: <435FE178.1040100@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2B3B18C69A770367D3B7BFFE"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B3B18C69A770367D3B7BFFE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hannes Mayer wrote:
> Hi Jan!
> 
> Jan Kiszka wrote:
> [...]
> 
>> Almost: ioaddr=0x3f8
> 
> 
> Yep, tried that too before, but disabling ttyS0 with setserial did the
> trick :-)
> 
>> Ok, we need some README about xeno_16550A somewhere. Where would you
>> look for information first?
> 
> 
> API-docs -> Modules -> Real-Time Driver Model -> Device Profiles ->
> Serial Devices ?

Hmm, that part is intended to remain implementation indepent. Will have
to think about it.

>> How can I get rt_dev_ioctl to block ?
> 
> AHA! Found it! :-)
> 
> There is
>             if (!rtdm_in_rt_context())
>                 return -EPERM;
> in rt_16550_ioctl(...)
> 
> Silly me put a printf into it:
>     ret = rt_task_set_mode(0, T_PRIMARY, NULL);
>     [...]
>     printf(RTASK_PREFIX "waiting for event\n");
>     ret = rt_dev_ioctl(write_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event );
> so the whole thing was not in RT anymore.

But this one IS documented! ;)

Well, the patch containing this check is rather new. Maybe it should
better read like this:

if (!rtdm_in_rt_context())
    return -ENOSYS;

The result would be that the nucleus will try to switch the caller to RT
on return and restart the call afterwards. Then you shouldn't notice any
error. Patch in preparation...

Jan

--------------enig2B3B18C69A770367D3B7BFFE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDX+y9ncNeS9Q0k+IRAodOAJ0ZVOSTAn+7e6x5c2440JUE3WwchwCgkP1E
Wk4A/SRu4DxqRAfz8oAyriI=
=jtS7
-----END PGP SIGNATURE-----

--------------enig2B3B18C69A770367D3B7BFFE--

