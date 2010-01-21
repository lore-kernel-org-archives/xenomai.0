Message-ID: <4B5881AB.4080102@domain.hid>
Date: Thu, 21 Jan 2010 17:32:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <065A7D06F7D4E546A18E80E08D066E18146A3016C3@domain.hid>
	<4B4B64AF.3040704@domain.hid>
	<065A7D06F7D4E546A18E80E08D066E18146A301A0A@ILMA1.IL.NDS.COM>	
	<4B4C5EDA.5000703@domain.hid>
	<065A7D06F7D4E546A18E80E08D066E18146A341B1B@ILMA1.IL.NDS.COM>
	<4B4F2F05.1040407@domain.hid>
	<065A7D06F7D4E546A18E80E08D066E18146A3CE4CA@ILMA1.IL.NDS.COM>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E18146A3CE4CA@ILMA1.IL.NDS.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai user app working very slowly - "select"
 issue
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Landau, Bracha wrote:
> You say "There is not much point using several thread to select on the same file descriptor. The point of select is rather the reverse: being able to wait for several file descriptors with only one thread"
> I rely on this in my design. Are you saying that Xenomai does not support having a few threads wait on the same file descriptor?

No, I say this is braindamaged design, because you will get lots of
spurious wakeups. But it should work.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

