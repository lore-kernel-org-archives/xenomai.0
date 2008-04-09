MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18428.55519.209593.252726@domain.hid>
Date: Wed, 9 Apr 2008 16:55:27 +0200
In-Reply-To: <747114@domain.hid>
References: <747114@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] A second Xenomai on the same PC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Vogt <A_C_V@web.de>
Cc: xenomai@xenomai.org

Andreas Vogt wrote:
 > Hello,
 > I have install Xenomai 2.4.1 with Linux Kernel 2.6.22.16 and it works fine. Now i want install a second Xenomai on my PC to test a different Configuration. So, it is possible to install a second Kernel with the same Xenomai? Or are there any problems?
 > Thanks for all your help

For the kernel, you may use the option CONFIG_LOCALVERSION, so that the
kernel modules will get installed in another directory, and will not
override your first installation.

About kernel-space/user-space mismatches, Xenomai handles an ABI
revision number. So, if you try a bad user/kernel combination, you
should get an error message when starting your applications.

But you can install two versions of Xenomai user-space support as well,
if you use the --prefix option of xenomai configure script.

-- 


					    Gilles.

