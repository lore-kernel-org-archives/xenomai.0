Message-ID: <54858FCC.7080600@control.lth.se>
Date: Mon, 08 Dec 2014 12:47:24 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] xenomai-3/next is out of sync with regards to
	automake/autoconf...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

...which leads to rtnet utils not being properly built. I think
the following is needed:

autoconf
automake
git add configure utils/Makefile.in utils/net/Makefile.in
git commit


/Anders
- -- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUhY/KAAoJENZYyvaDG8Nc+z8H/351Q2joGXsGiREV6giprokC
xhFpFIDl0lMtsha5PQpTf6AnY1Bau++HnuiWObiIFPd134IriNSCaT/g0NG//76U
oUQUAG24XGTW5pGvXkczM/rnlrD7Pd6QYpbTU9sjubCp/Bs3UXVNHxZEQl6auYDs
/MY5h+NS1FY4IA8Zc/GIa4jprUQ+4Dm4UAgAvvxTH7cA3y+PC6YheCSUYXk74FDo
6H7cfbnW/cago1DPvLPFDJkFofigjTP0cnmSHR3gFDoRleTZaXHck3D1bRSmTr01
SknuhOg5UiniHxN0pzugXI8qc1wGCCTgT6CWmei+ClLWkktX9KseYpw9kjrkDHI=
=PFzc
-----END PGP SIGNATURE-----

