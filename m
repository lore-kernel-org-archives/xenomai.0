From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18009.31376.575649.430423@domain.hid>
Date: Sun, 27 May 2007 14:33:20 +0200
In-Reply-To: <528bc2040705261025j34f0fbe1na0e89962ec45c6f@domain.hid>
References: <528bc2040705261025j34f0fbe1na0e89962ec45c6f@domain.hid>
Subject: Re: [Xenomai-help] Creating real time thread using posix skins
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: manoj kumar <manojkpanghal@domain.hid>
Cc: xenomai@xenomai.org

manoj kumar wrote:
 > Hi,
 > 
 > Can we create real time thread using posix skins ony (i.e. no other
 > skins call should be used for that )in xenomai.
 > 
 > if yes, then how?

Use pthread_create with scheduling policy set to SCHED_FIFO and a
priority between 1 and 99.

If you want to create non real-time thread, use __real_pthread_create.

For low priority real-time thread that will need to interact with
real-time threads but will spend most of their time in secondary mode,
use pthread_create with the SCHED_OTHER scheduling policy and priority
of 0.

-- 


					    Gilles Chanteperdrix.

