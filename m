Message-ID: <4B27AB53.6030409@domain.hid>
Date: Tue, 15 Dec 2009 16:29:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <784.75506.qm@domain.hid>
	<1260889958.2216.152.camel@domain.hid>
In-Reply-To: <1260889958.2216.152.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Porting Adeos-Ipipe on AVR32 (NGW 100),
	enable_pipeline.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos <adeos-main@gna.org>

Philippe Gerum wrote:
> (...) What you do care for is how you could get:
> 
> - a clock event source for the real-time domain
> - a high precision monotonic clock to get precise timestamps
> 
> And you probably want to use what your board provides to this end, e.g.
> using a freerunning timer to emulate the monotonic clock. It's possible
> to use 16bit timers for that (some ARM platforms do), but that is
> uselessly painful if you have better hw at hand.

Actually the ARM patch contains a few implementations of monotonic clock
emulations and clock event source based on all sort of kinds of hardware
counters. So, you may get some inspiration reading it. The usual scheme
is to use whatever Linux uses (except for AT91). We even try to document
this work, though you should take the advices with a grain of salt,
since they are intended to people writing support code for ARM, so, they
suppose that the whole generic I-pipe ARM support exists around.

http://www.xenomai.org/index.php/I-pipe:ArmPorting

-- 
                                          Gilles


