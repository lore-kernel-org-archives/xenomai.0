MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17668.27299.684625.830711@domain.hid>
Date: Sun, 10 Sep 2006 21:42:27 +0200
Subject: Re: [Xenomai-core] Xenomai on PXA
In-Reply-To: <45046563.5B837BC4@domain.hid>
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<17595.47131.142881.132531@domain.hid>
	<1153153788.11603.2.camel@domain.hid>
	<17595.49478.157044.654500@domain.hid>
	<1154334859.9569.12.camel@domain.hid>
	<44CDCB61.2DEDCBFF@vollmann.ch>
	<1154342029.9569.27.camel@domain.hid>
	<44CDE4C2.77465253@domain.hid>
	<17616.42011.663899.554796@domain.hid>
	<1154525585.9559.22.camel@domain.hid>
	<17616.59841.283196.201008@domain.hid>
	<1154596354.9835.28.camel@domain.hid>
	<17617.63387.138316.343123@domain.hid>
	<1154617014.5010.29.camel@domain.hid>
	<17618.12042.631648.702921@domain.hid>
	<1154703176.9602.26.camel@domain.hid>
	<17631.9753.589322.882530@domain.hid>
	<4503D322.1E88D034@domain.hid>
	<17668.739.465406.379629@domain.hid>
	<45043DD7.5A317C85@domain.hid>
	<17668.16225.396071.612679@domain.hid>
	<45046563.5B837BC4@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Detlef Vollmann <dv@domain.hid>
Cc: xenomai@xenomai.org

Detlef Vollmann wrote:
 > Gilles Chanteperdrix wrote:
 > > Detlef Vollmann wrote:
 > >  > Another point: did you run the switchbench test?
 > >  >
 > >  > With '-n 100000' I get a sure softlock.
 > > 
 > > Probably the default sampling period of 100 us is too hard for ARM,
 > Maybe, but I'm not sure (my PXA runs at 520MHz).
 > 
 > > Xenomai never gets out of the timer interrupt handler,
 > I don't think that's the problem.
 > With '-n 1000', everything is fine.
 > With '-n 10000', on a non-loaded machine, everything is still fine,
 > but on a loaded machine, I get the softlock.
 > With '-n 30000' even on an unloaded machine I get a softlock
 > most of the time.
 > 
 > I think I'll go and try to understand what switchbench actually
 > does and what happens on that softlock.  Then I'll probably come
 > back with more questions.

You should try -p 1000. Really.

-- 


					    Gilles Chanteperdrix.

