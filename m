Message-ID: <4DF723D2.5080200@domain.hid>
Date: Tue, 14 Jun 2011 15:03:14 +0600
From: Alexey Galakhov <agalakhov@domain.hid>
MIME-Version: 1.0
References: <BANLkTi=4KnpNyzx73XqHErLT9_5bQWHnHg@domain.hid>
In-Reply-To: <BANLkTi=4KnpNyzx73XqHErLT9_5bQWHnHg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] xenomai-runtime package for Ubuntu (can we get
 2.6.38 hard real time kernel with it?)
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi!

On 06/14/2011 10:09 AM, AKS wrote:
> Hi
> 
> Good day everyone. I have questions about "xenomai-runtime" package
> that can be installed in Ubuntu using "apt-get install". xenomai-runtime
> relies on libxenomai1. It is recommended to have "linux-patch-xenomai"
> too. I can understand why it needs libxenomai1 library but I cannot figure
> out how it can patch the Linux kernel to be real time. I assume it is still
> needed to patch "adeos I-pipe" into the kernel to make it real time. The
> package information states that the "linux-patch-xenomai" package is just
> an adeos I-pipe patch, but the Linux source has to be virgin source code
> from mainstream kernel.
> https://launchpad.net/ubuntu/natty/+package/xenomai-runtime

You have to install one of Ubuntu "linux-source-*" packages. It should
be of the version supported by Xenomai/I-pipe. 2.6.35.9 or 2.6.37 should
be Ok.

After that, install "linux-patch-xenomai" and follow instructions from
its README.Debian. Usually you both apply the patch and recompile the
kernel using make-kpkg utility (install "kernel-package").

Some Ubuntu/Debian versions are broken so that there is no matching
linux-source in the repository at all. If so, use vanilla kernel with
vanilla xenomai patch. Run make-kpkg to build the kernel. You still may
use "xenomai-runtime" from the repository.

> My other question is that can I compile a 2.6.38 kernel, drivers and rootfile
> system with Ubuntu Natty, since that patch and xenomai-runtime do not
> limit the kernel number. Can it be possible to build an Ubuntu with 2.6.38
> real time kernel based on Xenomai. I will be glad if anyone can kindly share
> or point me to documentation for xenomai-runtime. Thanks!

Maybe. You have to have an ipipe patch for this kernel version. If you
don't have one. you may use git version of ipipe and patch the kernel by
hand. It is much more complex but doable.

--
Alex


