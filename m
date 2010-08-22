From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C700E8A.8010305@domain.hid>
References: <1282047938.5255.89.camel@domain.hid>
	<4C6B146D.9010004@domain.hid>	<1282126974.5255.262.camel@domain.hid>
	<4C6BBD62.3050907@domain.hid>	<1282131617.5255.286.camel@domain.hid>
	<4C6BCB51.4010805@domain.hid>	<1282133876.5255.296.camel@domain.hid>
	<4C6BD403.4030902@domain.hid>	<1282136147.5255.306.camel@domain.hid>
	<4C6BE297.4060706@domain.hid>	<1282140262.5255.313.camel@domain.hid>
	<4C6BE9D3.1080907@domain.hid>	<1282141537.5255.315.camel@domain.hid>
	<4C6BEE9B.1080000@domain.hid>	<1282144162.5255.325.camel@domain.hid>
	<4C6BF8B1.8080206@domain.hid>	<1282297638.5255.373.camel@domain.hid>
	<4C6E50C1.9040700@domain.hid>	<1282319427.5255.400.camel@domain.hid>
	<4C70079D.4010502@domain.hid>  <4C700E8A.8010305@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Aug 2010 17:13:52 +0200
Message-ID: <1282490032.1961.31.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sat, 2010-08-21 at 19:36 +0200, Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
> > There are other issues to consider, such as detecting that a private
> > mutex created in the father continues to be used in the child.
> 
> A simple fix for this would be to keep a list of mutexes in the native
> and posix skin, and nullify their magic/opaque pointer at fork. The
> problem is that there is no more room in pthread_mutex_t, so we will
> have to malloc at pthread_mutex_init time.
> 

Please simply issue a warning as you suggested once when a potentially
dangerous situation arises upon fork regarding mutexes. Piling up
non-trivial code to prevent an obviously broken application from
misbehaving even more is way too expensive if such code could introduce
more overhead, and potentially secondary mode switches.

IIUC, we are discussing about apps using in a child context some private
mutexes which were initially created in the parent context, right? If
so, then a warning upon detection should suffice to have the author go
back to the drawing board, and optionally run "man pthread_mutex_init"
as well.

-- 
Philippe.



