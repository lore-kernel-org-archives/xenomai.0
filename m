Message-ID: <45ED3A0F.6090203@domain.hid>
Date: Tue, 06 Mar 2007 10:53:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN problem continued
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>	<E1HOUrr-0000FF-0J@mailer.emlix.com>
	<bc4264770703060129i6e74086lc2cf09b413e7c4a9@domain.hid>
In-Reply-To: <bc4264770703060129i6e74086lc2cf09b413e7c4a9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> It takes 2 hours to rebuild the kernel and all the modules.

Note that linux 2.6 is not like linux 2.4, you do not have to run make
clean before running make. So rebuilding after having modified one
option take just a few seconds. If you want to decrease the total kernel
build time, make a configuration where you disable everything that you
do not need. Yes, the configuration will take you some time, but you
will then save time at every compilation.

-- 
                                                 Gilles Chanteperdrix

