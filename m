From: lux-integ <lux-integ@domain.hid>
Date: Sat, 20 Feb 2010 01:27:28 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201002200127.28962.lux-integ@domain.hid>
Subject: [Xenomai-help] CONFIG_XENOMAI enabled makes unbootable x86_64 setup
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

Greetings 

my test rig has an amd64CPU-based machine with Linux (clfs pure 64bit).  I am 
learning to use xenomai. For the patch downloadable from  
http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.32.7-x86-2.6-00.patch

I found the kernel would not boot   with  CONFIG_XENOMAI  enabled.  The 
relevent part of the  downloaded  config file is:-

# Real-time sub-system
#
# CONFIG_XENOMAI is not set
CONFIG_XENO_GENERIC_STACKPOOL=y
CONFIG_XENO_FASTSYNCH=y
CONFIG_FREEZER=y

Could someone elaborate on when and where CONFIG_XENOMAI  is enabled?

thanks in advance
lux-integ

