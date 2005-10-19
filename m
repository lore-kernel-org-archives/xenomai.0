From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Message-ID: <17238.36242.970133.229781@domain.hid>
Date: Wed, 19 Oct 2005 20:16:50 +0200
Subject: Re: [Xenomai-help] newbie question
In-Reply-To: <4356860F.9030906@domain.hid>
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid> <435403C8.80400@domain.hid>
	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid> <435408E5.8020007@domain.hid>
	<435419B0.8030004@domain.hid>
	<4354AD5A.7010305@domain.hid>
	<17237.13723.766826.515585@domain.hid>
	<43553F22.80805@domain.hid>
	<17237.19216.373031.430361@domain.hid>
	<43554BD2.1050305@domain.hid>
	<17237.20014.842135.310718@domain.hid>
	<43555065.40704@domain.hid>
	<435605E7.90201@domain.hid> <43567F17.2020302@domain.hid>
	<4356860F.9030906@domain.hid>
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
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Ignacio Garc~a P~rez wrote:
 > > Hi,
 > > 
 > > I'm quite new to xenomai (switching from RTAI). I noticed that the
 > > latency_rt.ko module fails to start the timer if the posix skin module
 > > (xeno_posix.ko) is loaded. Is this the expected behaviour?
 > >
 > 
 > Yes and no. There is a change pending in my tree that makes rt_time_start() a 
 > bit smarter, trying its best effort to check whether the requested setting fits 
 > any current one, in which case the call returns without error. In the case you 
 > mentioned, both timer setups at nucleus level asked for oneshot, so this should 
 > have been ok with this patch, instead of bailing out on error rather uselessly. 
 > The UVM skin already enforces this for instance. I have just committed it to the 
 > SVN repo.

The problem is that you also have to make the module_exit function
smarter and avoid to stop the system timer if another module is
running. This means adding a sort of reference counter to the system
timer.

-- 


					    Gilles Chanteperdrix.

