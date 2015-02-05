Message-ID: <54D37739.9020306@control.lth.se>
Date: Thu, 05 Feb 2015 14:59:21 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
References: <54D350CA.90801@control.lth.se>
 <20150205115020.GA32156@hermes.click-hack.org>
In-Reply-To: <20150205115020.GA32156@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3/next: modprobe rtpacket fails with -EINVAL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2015-02-05 12:50, Gilles Chanteperdrix wrote:
> I received a patch for this issue, I simply need to merge it. Thanks
> for the reminder.

OK, ".device_count =     1," works for me now. 

BTW: is it the expected behaviour that when rtpacket is not loaded, socket()
will default to __real_socket()?

/Anders


- -- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU03c3AAoJENZYyvaDG8NcdOIH/1KOtrLaXGVOz/UR6qCTHH4w
DXiEcVaYyZfsxWFYGlaYLJX4eEyaDyUgwwzxu9btZK20C380GJvXBujNQRo/fCzT
y/lM/4mDzuWqUpdSWhEfklVM9W90pSB1nUO2FpxTtNdVYJRGrZa5MhltobrmyZKw
WXIVU9Hs47d1WevvXRbHMM1WFHh6kMcbmjYzJ596B2zAFs1qRQjQb/QaxhlCITbq
5enzxCaqXQTC1saBCcNKhg+dLviGOqUVIHJvr5PRSp+nRgTP5QKqcXbu3p0NxSf/
mHViajS7f/muPbCFFOvAytiF/bRb5qXcnqpKybpWkSihozy7vMA7GVh+Dc3BAi4=
=5r/d
-----END PGP SIGNATURE-----

