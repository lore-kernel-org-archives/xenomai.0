MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18401.32535.925176.896273@domain.hid>
Date: Wed, 19 Mar 2008 22:01:11 +0100
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

Yes, it may be possible if the ABI revision did not change between the
two versions (for instance if you want to install Xenomai 2.4.2
kernel-space support with Xenomai 2.4.1 user-space support). Otherwise,
you can install Xenomai with a different prefix (using the --prefix
option of Xenomai configure script), this will allow you to have two
versions of Xenomai user-space support installed.

-- 


					    Gilles.

