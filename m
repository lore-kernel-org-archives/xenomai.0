Message-ID: <4B4C5EDA.5000703@domain.hid>
Date: Tue, 12 Jan 2010 12:36:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <065A7D06F7D4E546A18E80E08D066E18146A3016C3@domain.hid>
	<4B4B64AF.3040704@domain.hid>
	<065A7D06F7D4E546A18E80E08D066E18146A301A0A@ILMA1.IL.NDS.COM>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E18146A301A0A@ILMA1.IL.NDS.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai user app working very slowly
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
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Landau, Bracha wrote:
> After reading one of the links below, I added calls to
> pthread_setstacksize to limit memory usage, and this improved the
> timing. However, I still have several problems with the application. 
> In a thread I have a call to select which waits on two message
> queues. Each of these is a real-time message queue. In the regular
> application this works fine, but in the xenomai application the
> select returns with both sets returning true to "FD_ISSET", when
> there really is nothing to read from the queue. I did not find
> anything in the links that refers to problems with select (as long as
> they are both r/t descriptors, which they are).

Please verify that you still have the same issue with Xenomai latest
stable release (v2.5.0), then send a test case which has this issue.

-- 
					    Gilles.

