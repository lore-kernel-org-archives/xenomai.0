Message-ID: <43C01D76.3090808@domain.hid>
Date: Sat, 07 Jan 2006 20:58:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] Building Linux kernel in Xenomai tree.
References: <17343.42595.626357.181448@domain.hid>	<17344.665.154004.811426@domain.hid>	<43C00A97.4020404@domain.hid>
	<17344.5951.309397.423794@domain.hid>
In-Reply-To: <17344.5951.309397.423794@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB10F9F4F22D82F1177B49866"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB10F9F4F22D82F1177B49866
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > > The previous patch was also incorrect when trying to cross-compile the
>  > > Linux kernel or building it for ppc. The attached patch fixes these
>  > > issues.
>  > > 
>  > 
>  > Regarding your general idea, I'm just trying to imagine the new build
>  > process: you prepare and build the kernel + the userspace stuff again in
>  > one step?. But you still have to configure both parts separately.
>  > 
>  > The question for me is now if this simplifies the situation expecially
>  > for beginners. So far, the separation was clearly visible, now it /may/
>  > become blurred (but I'm not a beginner...).
>  > 
>  > Can you provide a rough comparision of the workflows? Sorry, but I'm too
>  > lazy, I mean busy to give it a try.
> 
> configure --enable-linux-build
> make xconfig
> make install
> 

I'm starting to like this!

> If you already have a .config file, the "make xconfig" step becomes
> optional.
> 
> Note that the --enable-linux-build flag is optional too.
> 
> The simplification is mainly for developping xenomai itself, not for its
> users. Because with the current scheme, after some modifications, you
> have to recompile and reinstall both the kernel-space modules and
> user-space libraries.
> 
> If you let configure select the proper adeos patch, you are warned when
> the adeos patch changed in the source directory (after an svn update,
> for example), and just have to type: 
> rm linux/.xenomai-prepared (Ok, this step is a bit awkward, we may find
>                             something better)
> make install
> 
> And a new kernel will be built and installed, using the new adeos patch
> and the same .config.
> 

Hmm, what about this: Instead of leaving some (probably empty)
xenomai-prepared in the kernel tree, better create an xenomai-uninstall
script in the same place. It a) can serve as an indication for a
prepared kernel and b) can be used to upgrade that tree by first running
it and then applying the usual steps on the kernel again.

I often forget to save my old adeos patch before updating the xenomai
tree, thus I will then have to download the old patch again,
reverse-apply it, and can finally run the prepare script for the update.
Automating this would be REALLY, REALLY GREAT!

Jan

--------------enigB10F9F4F22D82F1177B49866
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwB12niDOoMHTA+kRAooHAJ42QGySpnFXTMeFn4hnt2t0i7+eGwCdE/AR
V7os4euKYjWh4/4Iv3iL0yA=
=VkmH
-----END PGP SIGNATURE-----

--------------enigB10F9F4F22D82F1177B49866--

