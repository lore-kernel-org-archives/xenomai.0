Message-ID: <4B76B7F2.2050303@domain.hid>
Date: Sat, 13 Feb 2010 15:32:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid>
In-Reply-To: <4B6E8167.6010907@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Roland Stigge wrote:
> Hi,
> 
> I'm just working on the Xenomai 2.5.1 Debian package and encountered 
> non-PIC code (evil! ;-) in the shared libraries (skins libraries).

Hi Roland,

I just had a look at the Debian package, and there are a few things that
I do not like:
- the package ships with patches for 2.6.24. These I-pipe patches are
outdated and have been publicly announced as being bogus on the Xenomai
mailing lists;
- xenomai 2.5.1 seems to have introduced a conflict with sigtest, my
fault, you seem to have fixed this by prefixing all xenomai binaries
with xenomai-, there was a simple solution which would have been for us
to rename only sigtest.

This looks to me like a bad idea. You are breaking the documented user
interface.

Applications which were compiling for older versions of xenomai using
xeno-config will simply stop working with the new version, not because
of Xenomai incompatibilities, but simply because of a decision of the
maintainer of Xenomai Debian package. Not mentioning how preposterous it
looks to have things called xenomai-xeno-config.

I have already asked publicly for this, but will ask it once again:
please inform the xenomai mailing list of the debian xenomai package
bugs, and get us involved in their resolution. I do not really
understand why you are refusing to do this. As far as I know, we never
refused any patch coming from you.

If you refuse to comply to this simple request, I will have to advise
publicly people not to use the "official" debian packages, including on
the xenomai project's wiki, and in the text documentation which ships
with Xenomai. Because the debian packaging of xenomai simply do not
meets the quality standards of the Xenomai project. I do not mean that
our quality is perfect, but one of the motto of the Xenomai project is
to avoid breaking uselessly the interfaces, and you just did it.

Thanks in advance.
Regards.

-- 
					    Gilles.

