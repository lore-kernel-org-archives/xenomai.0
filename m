MIME-Version: 1.0
Date: Tue, 14 Jun 2011 14:09:31 +1000
Message-ID: <BANLkTi=4KnpNyzx73XqHErLT9_5bQWHnHg@domain.hid>
From: AKS <aungkyas@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Adeos-main] xenomai-runtime package for Ubuntu (can we get 2.6.38
 hard real time kernel with it?)
Reply-To: aungkyas@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>

Hi

Good day everyone. I have questions about "xenomai-runtime" package
that can be installed in Ubuntu using "apt-get install". xenomai-runtime
relies on libxenomai1. It is recommended to have "linux-patch-xenomai"
too. I can understand why it needs libxenomai1 library but I cannot figure
out how it can patch the Linux kernel to be real time. I assume it is still
needed to patch "adeos I-pipe" into the kernel to make it real time. The
package information states that the "linux-patch-xenomai" package is just
an adeos I-pipe patch, but the Linux source has to be virgin source code
from mainstream kernel.
https://launchpad.net/ubuntu/natty/+package/xenomai-runtime

First will that patch is for new kernel compilation? I think the question I
have is already asked. I guess I am repeating Robinson's question below.

https://mail.gna.org/public/xenomai-help/2010-08/msg00309.html

I assume that package uses Xenomai 2.5.5.2-1. Since it is Ubuntu Natty,
its Kernel is 2.6.35+ or can even be 2.6.38 (but from this forum, I learned
that the latest adeos I-pipe linux kernel patch was 2.6.35. So which is the
latest and greatest xenomai. Am I right?

My other question is that can I compile a 2.6.38 kernel, drivers and rootfile
system with Ubuntu Natty, since that patch and xenomai-runtime do not
limit the kernel number. Can it be possible to build an Ubuntu with 2.6.38
real time kernel based on Xenomai. I will be glad if anyone can kindly share
or point me to documentation for xenomai-runtime. Thanks!

