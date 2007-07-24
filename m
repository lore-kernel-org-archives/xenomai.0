MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18086.15028.633317.487033@domain.hid>
Date: Tue, 24 Jul 2007 19:45:24 +0200
In-Reply-To: <7289437c0707240515o4dcd6679ybb233eed4e41d04f@domain.hid>
References: <7289437c0707240515o4dcd6679ybb233eed4e41d04f@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Question about RTDM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Perrine Martignoni wrote:
 > Hello,
 > 
 > I ask me some questions about the RTDM driver. For instance, to use a mutex
 > in a RTDM driver, we can use rtdm_mutex_... functions.
 > Why don't use simply rt_mutex_... functions? What's the differences ?

It is a matter of portability: if your driver is written using
exclusively rtdm_* calls, it will work with RTAI and with regular Linux
(possibly patched with the preempt rt patch). Since people usually do
not know how the project they are working for will evolve, they should
use RTDM.

-- 


					    Gilles Chanteperdrix.

