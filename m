From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15804.11694.108768.648281@domain.hid>
Date: Sun, 27 Oct 2002 19:17:18 +0100
Subject: [Adeos-main] Patch freeze + modularization
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.nongnu.org/pipermail/adeos-main/>
To: adeos-main@gna.org

Final 2.4.19-r5 and 2.5.41-r2 patches for x86 are now frozen in the
CVS.

The undergoing work aims at modularizing most of the nanokernel code
into a dynamically loadable driver. In-kernel (static) inclusion will
remain possible, depending on the configuration option selected as for
any regular Linux driver.

Regards,

Philippe.


