Message-ID: <48A57135.4020905@domain.hid>
Date: Fri, 15 Aug 2008 14:06:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48A4ECEB.4060206@domain.hid>
In-Reply-To: <48A4ECEB.4060206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai install problem?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Shumway <sshumway@domain.hid>
Cc: xenomai@xenomai.org

Steve Shumway wrote:
> gcc -O2 -Wall -DMODULE -D__KERNEL__ -DLINUX -I/usr/src/linux/include 
> -I/usr/src/linux/include/xenomai/compat -I/usr/xenomai/include   -c -o 
> irqcontrol_driver.o irqcontrol_driver.c

So, the compiler looks for headers in /usr/src/linux.

> tar -xvzpf linux-2.6.25 tar -C /usr/src

And you installed the kernel sources in /usr/src/linux-2.6.25

And by the way, are you trying to compile a module with gcc by hand ?
If, yes, then it is normal that you get problems. The official way to
compile modules with the 2.6 kernel is to use the way described in
/usr/src/linux-2.6.25/Documentation/kbuild/modules.txt

-- 
					    Gilles.

