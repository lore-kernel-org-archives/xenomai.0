From: Paul <paul_c@domain.hid>
Date: Thu, 18 Oct 2007 21:16:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710182116.25461.paul_c@domain.hid>
Subject: [Adeos-main] 2.6.23 x86_64 broken for SMP ?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


Attempting to compile on x86_64 with SMP enabled, getting quite a few failures 
cetered around ipipe_declare_cpuid being undeclared in 
arch/x86_64/kernel/ipipe.c. Should we be including ipipe_compat.h or 
following the lead set in arch/i386/kernel/ipipe.c ?


Regards, Paul.

