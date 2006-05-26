From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17527.11954.591272.313230@domain.hid>
Date: Fri, 26 May 2006 18:37:06 +0200
Subject: Re: [Xenomai-help] Re: Error Compiling posix skin
In-Reply-To: <44755E01.3000801@domain.hid>
References: <44755E01.3000801@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nicola Pace <nicola@domain.hid>
Cc: xenomai@xenomai.org

Nicola Pace wrote:
 > >Nicola Pace wrote:
 > 
 > I am trying to compile xenomai.2.2-rc1, but compiling the posix skin I 
 > get the error :
 > 
 > /usr/src/xenomai-2.2-rc1/include/posix/time.h:103: parse error before 
 > 'clock_id'
 > 
 > Some Suggestions ?
 >   
 > 
 > >Your libc is likely a bit old and does not define clockid_t, what
 > >version of glibc are you using ? Could you try the attached patch ?
 > >Maybe other definitions than clockid_t are missing, timer_t for
 > >example.
 > 
 > 
 > Your patch fixes 'clockid' error but, of course, there are other missing definitions:
 > 
 > struct sigevent
 > struct itimerspec
 > CLOCK_REALTIME
 > .
 > .
 > .
 > 
 > The GLIBC version is 2.1.3

Could you run "make -k" and send the full logs to me? I have no machine
at hand with such an old libc.

-- 


					    Gilles Chanteperdrix.

