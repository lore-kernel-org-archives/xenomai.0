From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17663.64870.945605.117981@domain.hid>
Date: Thu, 7 Sep 2006 13:07:18 +0200
Subject: Re: [Xenomai-help] Porting / API Questions
In-Reply-To: <44FF3C26.10501@domain.hid>
References: <44FF3C26.10501@domain.hid>
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
 > Is it okay to use the POSIX API for threads and timing, and the rtai API for FIFOs?  It seems like this is working, but I want to make sure that there are no hidden problems.

There should be no problem mixing the POSIX API with other
interfaces. If a POSIX service absolutely requires a POSIX skin thread,
it will return an error of EPERM when called from an invalid
context. Now, if you want to exchange messages "the POSIX way", you can
use POSIX message queues.

-- 


					    Gilles Chanteperdrix.

