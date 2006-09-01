From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17656.30980.846435.69720@domain.hid>
Date: Fri, 1 Sep 2006 20:16:36 +0200
Subject: Re: [Xenomai-help] Kernel panic with Xenomai SMP kernel
In-Reply-To: <44F84C23.9070105@domain.hid>
References: <44F6E774.2000701@domain.hid> <44F72F35.4070109@domain.hid>
	<44F75C54.90608@domain.hid>
	<17655.28122.163232.842311@domain.hid>
	<44F84C23.9070105@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

Jeff Webb wrote:
 > I still get a very similar kernel panic with this build.  Do you see any other suspicious options in my .config that could cause problems with SMP on my processor?

I see nothing obvious. I tried compiling a kernel with the same .config
as yours, except for the disk controller, and it seems to run fine. So,
an option that you enabled probably need some hardware that I have not.
Maybe you should try disabling:

CONFIG_HPET_TIMER
CONFIG_X86_PM_TIMER

-- 


					    Gilles Chanteperdrix.

