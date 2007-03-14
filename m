MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-5
Content-Transfer-Encoding: 7bit
Message-ID: <17912.31765.786905.929691@domain.hid>
Date: Wed, 14 Mar 2007 23:49:57 +0100
Subject: Re: [Xenomai-help] mem usage and other application
In-Reply-To: <45F87970.5060506@domain.hid>
References: <45F86426.9000309@domain.hid>
	<17912.26777.313494.393466@domain.hid>
	<45F87970.5060506@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maksym Veremeyenko <verem@domain.hid>
Cc: Xenomai-help@domain.hid

Maksym Veremeyenko wrote:
 > Gilles Chanteperdrix ~~~~~:
 > 
 > >  > 
 > >  > Second problem:  other applications sometimes (50% attemps) fail to 
 > >  > start (especially perl scripts and Eclipse) then at least one Xenomai 
 > >  > application running.
 > >  > 
 > >  > I use linux 2.6.17.14, Adeos 1.5-02, Xenomai trunk 2170
 > > 
 > > Could you try running "switchtest" while your Xenomai application is
 > > running ?
 > > 
 > 
 > during running program i got:
 > [root@domain.hid switchtest]# ./switchtest
 > == Testing FPU check routines...
 > r0: 1 != 2
 > r1: 1 != 2
 > r2: 1 != 2
 > r3: 1 != 2
 > r4: 1 != 2
 > r5: 1 != 2
 > r6: 1 != 2
 > r7: 1 != 2
 > == FPU check routines: OK.
 > ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
 > == Threads: sleeper_ufps-0RTT|  326087:53:20
 > RTH|ctx switches|-------total
 > RTD|           0|           0

You should probably increase the system heap size, with the option
CONFIG_XENO_OPT_SYS_HEAPSZ

-- 


					    Gilles Chanteperdrix.

