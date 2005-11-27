From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17289.59986.830043.755977@domain.hid>
Date: Sun, 27 Nov 2005 18:18:10 +0100
Subject: Re: [Xenomai-help] 2.6 kernel module with math functions
In-Reply-To: <4386DBD1.90605@domain.hid>
References: <20051125093348.40193.qmail@domain.hid>
	<4386DBD1.90605@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum wrote:
 > Cedric Herreman wrote:
 > > OK,
 > > 
 > > I made an extra math module, copying some of the source code from newlib 
 > > for the functions i needed. It works.
 > > 
 > > Another question : if i create an application (in stead of kernel 
 > > module) that starts a real time thread. Can i then use math functions 
 > > inside the real time running part ?
 > > 
 > > In the latency example, the sqrt function is used for displaying the 
 > > results of the latency test.  This is outside the real time task. Is it 
 > > possible to use this call in the real time function ? Or any other 
 > > library function (that is not performing system calls) ?
 > >
 > 
 > Yes. RT threads in user-space have their own FPU context managed by Xenomai.

As for math functions implemented in libm, they may be called from
real-time threads, but if we want to be precise, we can not guarantee
their worst case behaviour, you have to do a mathematical analysis of
their implementation for that (sqrt is probably implemented in hardware,
so you have to read intel spec to know if the max cycles count is known,
but it would be strange if it was not).

-- 


					    Gilles Chanteperdrix.

