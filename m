Message-ID: <476D63B1.7010302@domain.hid>
Date: Sat, 22 Dec 2007 20:21:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-help] [ALERT] Severe I-pipe bug fixed for the kernel 2.4
	series
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


A severe issue causing interrupts to be randomly locked out when running
in secondary mode has just been fixed in the I-pipe patches for the
2.4/ppc and 2.4/i386 kernels. People depending on those patches should
really consider upgrading to these ones:

http://download.gna.org/adeos/patches/v2.4/ppc/adeos-ipipe-2.4.25-ppc-DENX-1.2-02.patch
http://download.gna.org/adeos/patches/v2.4/i386/adeos-ipipe-2.4.34-i386-1.3-04.patch

This bug does NOT affect any I-pipe patch against the kernel 2.6 series.

-- 
Philippe.

