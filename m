Message-ID: <548F07F1.7010606@telecom-paristech.fr>
Date: Mon, 15 Dec 2014 17:10:25 +0100
From: Renaud Pacalet <renaud.pacalet@telecom-paristech.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] I-pipe patch broken for Xilinx Zynq
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
Hash: SHA256

Dear Xenomai developers,

I ran into troubles when trying to follow the instructions at
http://www.wiki.xilinx.com/Xenomai+for+Zynq: the
xenomai-2.6.3/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-1.patch
patch mentioned in the instructions is no longer the one distributed
in http://download.gna.org/xenomai/stable/xenomai-2.6.3.tar.bz2. It
has been replaced by ipipe-core-3.8.13-arm-3.patch patch which is not
compatible with the xilinx-v14.5 tag of
git://github.com/Xilinx/linux-xlnx.git. In order to patch and compile
the compile Linux kernel I had to download and apply
http://download.gna.org/adeos/patches/v3.x/arm/older/ipipe-core-3.8-arm-1.patch
instead.

Best regards,
- -- 
Télécom ParisTech - LabSoC
c/o EURECOM, Campus SophiaTech
Les Templiers, 450 route des Chappes 06410 Biot
Tel : +33 (0) 4 9300 8402
Fax : +33 (0) 4 9300 8200
Web : http://www.telecom-paristech.fr/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEAREIAAYFAlSPB+8ACgkQ6X2qPZD76M/GHwCeNxh+t/UPT4FkfzDle/apevSK
THcAn39O72JGMkJ/ZaGs8Ne3UzVQk2Mt
=6D4A
-----END PGP SIGNATURE-----

