From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17889.38267.536073.99875@domain.hid>
Date: Sun, 25 Feb 2007 14:56:11 +0100
Subject: Re: [Xenomai-help] rt_timer_start()
In-Reply-To: <bc4264770702250528u1f7a4736s919eb998d064289b@domain.hid>
References: <bc4264770702250528u1f7a4736s919eb998d064289b@domain.hid>
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
 > Hi,
 > 
 > The Native API tour dictates that rt_timer_start() MUST be called in
 > all userspace applications that access the rt_timer.
 > 
 > It displays and example very similar to the example trivial_periodic.c
 > 
 > howeve trivial_periodic.c does not call the rt_timer_start() even
 > though it does have calls such as rt_timer_read.
 > 
 > and it seems to work.
 > 
 > Why is that?

My bad, I sent you the URL of an old version of the Native API tour,
this has been fixed in later releases. The correct URL is:

http://www.xenomai.org/documentation/trunk/pdf/Native-API-Tour-rev-C.pdf

-- 


					    Gilles Chanteperdrix.

