From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17527.3943.859759.669932@domain.hid>
Date: Fri, 26 May 2006 16:23:35 +0200
Subject: Re: [Xenomai-help] VxWorks side-by-side with POSIX
In-Reply-To: <44763D2B.30007@domain.hid>
References: <44763D2B.30007@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nathaniel Villaume <villaume@domain.hid>
Cc: xenomai@xenomai.org

Nathaniel Villaume wrote:
 > Hello all,
 > 
 > Pardon my ignorance, and please tolerate my sloth, but is it possible 
 > (and easy) to run skins side-by-side and have them communicate through 
 > IPCs? So I'd like to run a process that uses VxWorks calls, and then 
 > another one that uses POSIX, and yet have them communicate via one or 
 > two semaphores and shared memory.

Most services (including shared memory and semaphores) of the POSIX skin
may be used by threads created by other skins. The exceptions to this
rule are the services related to signals and cancellation. In case of
doubt, you may have a look at POSIX skin documentation; it should
document explicitely which services are restricted to which contexts.


-- 


					    Gilles Chanteperdrix.

