Message-ID: <478497ED.3050809@domain.hid>
Date: Wed, 09 Jan 2008 10:46:21 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] #include <linux/uaccess.h> fails with Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hello,

recent versions of Xenomai include the header file "linux/uaccess.h" in
"xenomai/include/asm-generic/syscall.h" which does not exist under Linux
2.4. "asm/uaccess" should be used instead. Any clever idea how to fix it
(without using #ifdefs)?

Wolfgang.

