Message-ID: <4DBD4DA6.2070101@domain.hid>
Date: Sun, 01 May 2011 14:10:14 +0200
From: Uwe Fechner <u.fechner@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Building Xenomai for Ubuntu 10.10 32 bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

 Hello,

I am trying to compile Xenomai for Ubuntu 10.10 32 bit for
a Dell Latitude E6400 Laptop.

First I tried to follow the following explanations:
http://www.xenomai.org/index.php/Building_Debian_packages

I had the following problems:
- the Xenomai version, that comes with Ubuntu 10.10 is
  very old, so I tried to compile my own packages
- using git didn't work, because I needed a user name and
  password, that I don't have (the following command failed:)
  git clone git://xenomai.org/xenomai-2.5.git
- then I tried to compile packages from a tar.bz2 archive
  I was able to compile the packages, but they did not work
 I suppose, that I have some wrong .config options.

I then tried to compile a Linux kernel in the way, that is
suggested for Ubuntu, using this tutorial:

https://wiki.ubuntu.com/KernelTeam/GitKernelBuild

After some iterations, this worked.

Now my questions:
I would like to use kernel 2.6.38 or 2.6.39-RC5 with
xenomai 2.5.6.

1) Is this a good choice, or is an older kernel or an older
   version of Xenomai more likely to work?

2) Do I need to run scripts/prepare-kernel.sh, or not?
   This is mentioned at:
   http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL
   but not mentioned at:
   http://www.xenomai.org/index.php/Building_Debian_packages

Best regards:

Uwe Fechner, TU Delft

