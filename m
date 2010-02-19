MIME-Version: 1.0
Date: Fri, 19 Feb 2010 16:50:49 +0800
Message-ID: <e325d111002190050m12ac3028h5775b5fa2c390070@domain.hid>
From: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] incompatible feature set
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

Dear all,

i recevied the following error while trying to execute an example
program provided by xenomai.

user@domain.hid$ ./trivial-periodic
Xenomai: incompatible feature set
(userland requires "tsc", kernel provides "sep fastsynch smp", missing="tsc").

may i know how can i config my kernel to provide this tsc flag?

Regards,
Kim Chuan.

