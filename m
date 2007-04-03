From: Peter Soetens <peter.soetens@domain.hid>
Date: Tue, 3 Apr 2007 11:34:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704031134.33726.peter.soetens@domain.hid>
Subject: [Xenomai-help] v2.2.6 prepare-kernel.sh broken for 2.4 kernels
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

It seems some files are missing in this (not announced ?) release, which make 
the prepare-kernel.sh script fail in the following fcn:

patch_help() {
    if which perl > /dev/null; then
        hfile=$linux_tree/Documentation/Configure.help
        if ! grep -iq CONFIG_XENO $hfile; then
            kfiles=$xenomai_root/scripts/Kconfig.frag
            for d in ksrc/nucleus ksrc/skins ksrc/arch/$xenomai_arch \
                ksrc/drivers sim; do

  -> 'sim' is not found

                kfiles="$kfiles `find $xenomai_root/$d -name Kconfig`"
            done
            perl $xenomai_root/scripts/help_from_kconfig.pl $kfiles >> $hfile

  -> help_from_kconfig.pl is not found.

            if test x$verbose = x1; then
                echo 'Configuration help added.'
            fi
        fi
    fi
}

It seems (afaikt) to be related to this patch:
<https://mail.gna.org/public/xenomai-core/2006-11/msg00037.html>

Which did not patch the Makefile.am file to include the script in the 
EXTRA_DIST var. The 'sim' dir seems to be a Xenomai 2.0.x slip-in.

Peter

-- 
Peter Soetens -- FMTC -- <http://www.fmtc.be>

