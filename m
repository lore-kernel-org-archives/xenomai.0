Message-ID: <544A584F.5070708@xenomai.org>
Date: Fri, 24 Oct 2014 09:46:55 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <D06C2B92.195DA%shartmann@cnt.canon.com>
 <20141022051722.GB29673@sisyphus.hd.free.fr>
 <D06CFB35.19680%shartmann@cnt.canon.com> <5447CF8D.30309@xenomai.org>
In-Reply-To: <5447CF8D.30309@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] [Analogy] - new feature:  software calibration NI-M
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

All,

I have just delivered a software calibration feature for the NI M family of
acquisition cards

	"pci-6220", "pci-6221", "pci-6221_37pin", "pci-6224", "pci-6225",
	"pci-6229", "pci-6250", "pci-6251", "pci-6254", "pci-6259", "pcie-6259",
	"pci-6280", "pci-6281", "pxi-6281", "pci-6284", "pci-6289"

Usage of the calibration tool requires:

1. to use the analogy_calibrate utility to generate a calibration file for your board.
	$ analogy_calibrate --device /dev/analogy0 --output /path/calib.bin
	
2. use the library functions to parse and apply the calibration file to samples (read
from hardware) or values (to be written to hardware)

An example on usage is in the utility function "insn_read" now accepting a
calibration file as input.

This feature will be available for xenomai-3 only and there are no plans to backport
it to xenomai-2.

For the time being you can find the relevant commits in the tree/branch below
http://git.xenomai.org/xenomai-jro.git/log/?h=for-xeno3


jro


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUSlhLAAoJECDcy2IJkagRlGoH/1p2STVGfToNKKzBFlFJ19PH
1LzfEFDlsJ+QvKmeOXXz8h24KoNTiIfwx9nvXeYc8569/UwxJqqypBrVR3uXPb4f
eqNb0SRtQJVRjabnKbl//6KbDmlQmHhkJHzYejoJM1HIRnfu3UF45TgAWQUJOxN4
ebU/sWOE0mABhWL3CBw+fOeudmKOWEKtWO+J5fjIkUD2iz0GL6PsXMbdeAT19dVJ
naLOXgAQVhJpA26aYh1My0utnHfY05FgPKtvf0VSZMK622R2SB9lxKoaukESBWGF
E9Nt2r4LYdbPVH3qQpa2GM9f7EgZ/cepaRLzls/Sdid67b3l0M/nz+XJzdDUhY8=
=+uHT
-----END PGP SIGNATURE-----

