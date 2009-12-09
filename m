Message-ID: <4B1FA80F.3070405@domain.hid>
Date: Wed, 09 Dec 2009 14:37:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <c024fefc0912040111s78a97159vde8d7391b5702acf@domain.hid>	
	<4B194E6F.7090806@domain.hid>
	<c024fefc0912082017i59c0c688pbfe8178ba0201f6a@domain.hid>
In-Reply-To: <c024fefc0912082017i59c0c688pbfe8178ba0201f6a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with Xenomai Install
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrian Boeing <aboeing@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Adrian Boeing wrote:
> I have created a new install with Ubuntu 9.04, kernel 2.6.28-10
> 
> When I run trivial-periodic the computer resets.
> 
> This is how I created the kernel:
> apt-get build-dep linux-image-$(uname -r)
> apt-get source linux-image-$(uname -r)
> download xenomai&adeos
> scripts/prepare-kernel.sh
> cp /boot/config-$(uname -r) .
> make menuconfig      {I had to drop the #CPU's to 2}
> make
> sudo make modules_install install
> make bzImage
> sudo make-kpkg --initrd kernel_image modules
> dpkg -i PACKAGENAME
> 
> cd xenomai
> ./configure
> make
> sudo make install
> cd /etc/ld.so.conf.d/
> cp libc.conf xenomai.conf
> cd examples native
> make
> sudo ./trivial peridoic <--- crashes computer (causes a reset)

Please enable all xenomai and ipipe debugs, disable any kernel option
which could cause debugs in case of panic (such as panic=x). And try and
send us the kernel logs when the bug happens by redirecting the kernel
console on a serial port.

-- 
                                          Gilles


