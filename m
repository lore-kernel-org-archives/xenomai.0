From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] Xenomai vs. RTLinux
Date: Thu, 9 Mar 2006 13:31:00 -0300
References: <006f01c64312$a28ab730$a10a10ac@domain.hid>
	<44104044.20606@domain.hid>
	<17424.17324.137254.586833@domain.hid>
In-Reply-To: <17424.17324.137254.586833@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603091331.00589.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Em Quinta 09 Mar=3DE7o 2006 12:03, Gilles Chanteperdrix escreveu:

>Rodrigo Rosenfeld Rosas wrote:
> > Christopher Stone escreveu:
> > > ...
> > > Vendor specific API's are like drugs, once you get hooked on them, it
> > > is difficult to incur the cost of kicking the habit. With Xenomai you
> > > can use any of a number of skins, but, would be wise to consider the
> > > POSIX skin. By using the industry standard POSIX API your code remains
> > > portable and more future proof.
> >
> > Actually it depends. At the moment, as far as I know, RTDM drivers are
> > not able to communicate to POSIX written programs in every way, like it
> > does with programs written using the native API.
>
>Actually there is a major change around 2.1-rc3: most services of the
>POSIX skins may be used by threads created by other skins. The exceptions =
=3D
to
>this rule are services which involves the "POSIX skin specific" part of
>Xenomai POSIX skin threads, namely only services involving signals and
>cancellation.
>
>Also note that in user-space, the RTDM and POSIX skins are fully integrate=
=3D
d.

Thanks for that information. I wasn't aware of that.

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


