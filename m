From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17598.7383.550897.877061@domain.hid>
Date: Wed, 19 Jul 2006 13:51:51 +0200
Subject: Re: [Xenomai-help] kernel oops using mq_open after fork
In-Reply-To: <02AA386EB831044F8537A696BA785C78A66846@domain.hid>
References: <200607111736.k6BHaCme029123@domain.hid>
	<02AA386EB831044F8537A696BA785C78A66846@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org

Landau, Bracha wrote:
 > I'm using xenomai 2.2 rc3 on a MPC8247, on linux 2.6.14.
 >  
 > I have a problem using mq_open. Please see the attached code.
 > If I fork before the mq_open the kernel, I get a kernel oops.
 > 
 > Why this behaviour?

The child process has not "bound" the interface, so, it has no
per-process data. If this is the cause of the oops, the solution is to
add a pthread_atfork call in xeno_user_skin_init in order for the
process children to also call xeno_user_skin_init.

-- 


					    Gilles Chanteperdrix.

