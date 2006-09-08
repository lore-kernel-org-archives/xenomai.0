From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17665.20154.66738.399910@domain.hid>
Date: Fri, 8 Sep 2006 13:06:34 +0200
Subject: Re: [Xenomai-help] Porting / API Questions
In-Reply-To: <45007982.2000503@domain.hid>
References: <44FF3C26.10501@domain.hid> <44FFF5FF.2000106@domain.hid>
	<45007982.2000503@domain.hid>
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
Cc: Xenomai help <xenomai@xenomai.org>

Jeff Webb wrote:
 > Jan Kiszka wrote:
 > >> In this simulation, we use the rtlinux POSIX-like API for threads,
 > >> timing, and writing-to / reading-from real-time FIFOs.  It looks like
 > >> the xeno_posix API will allow me to port the thread and timing code with
 > >> very few (if any) changes.  There does not appear to be a kernel-space
 > >> version of read and write for use on xenomai pipes.  Am I missing
 > >> something?
 > > 
 > > For what side, RT or non-RT? Or what service (function name) is missing
 > > precisely?
 > 
 > RT-Linux has a mostly POSIX interface to rt-fifos.  You must create/delete them using the non-standard rtf_create/rtf_destroy, but after that, you can open, close, read, and write them using a file descriptor.  I was wondering if this mapping exists for the real-time Xenomai POSIX API.  I am specifically asking about kernel-space right now, but I would also like to know if this sort of thing is supported from user-space real-time as well.

There is no such thing in Xenomai POSIX API. The native API proposes rt_pipes:
http://www.xenomai.org/documentation/trunk/html/api/group__pipe.html

-- 


					    Gilles Chanteperdrix.

