From: Paul <paul_c@domain.hid>
Date: Sat, 7 Feb 2009 15:23:39 +0000
References: <200902071351.57024.loretta@domain.hid>
In-Reply-To: <200902071351.57024.loretta@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200902071523.39102.paul_c@domain.hid>
Subject: Re: [Xenomai-help] Installing Xenomai by simply exec'ing apt-get
	install?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, loretta@domain.hid


Hi Loretta

On Saturday 07 February 2009, loretta wrote:
> I'm on sidux (i.e. Debian SID). If I look into its repo I see that Xenomai
> is available. Will apt-get installing Xenomai really install Xenomai
> (patching the kernel and all that) or will it just load it onto my
> computer?

The Xenomai packages in the Debian repository consist of four parts:

libxenomai1 - The user space skins & libraries.
libxenomai-dev - Headers and assorted sample source files.
xenomai-runtime - Various scripts for stress testing & loading of modules.
linux-patch-xenomai - Kernel patches for a number of kernels & architectures.

Installing any of the above packages will just get you the user space side of 
things, the kernel will still need patching & compiling. Typical method would 
be:

`sudo make-kpkg --initrd --added-patches xenomai --config menuconfig  
binary-arch`


Regards, Paul.




P.S. I do have some patched & precompiled kernels available - These are 
somewhat dated and probably won't work with the Sid user space packages...
 (I need get round to building a new set sometime).

