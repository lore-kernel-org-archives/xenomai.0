MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17642.7881.594162.256489@domain.hid>
Date: Mon, 21 Aug 2006 22:59:53 +0200
Subject: Re: [Xenomai-core] Re: xeno-load: line 182: 2794
	Floating	point	exception$suflag $* $cmdargs
In-Reply-To: <44E9EE06.8010303@domain.hid>
References: <44E91231.8070403@domain.hid> <44E955E0.40009@domain.hid>
	<1156143410.4723.4.camel@domain.hid> <44E9663C.2030904@domain.hid>
	<17641.43126.189924.769218@domain.hid>
	<44E9EE06.8010303@domain.hid>
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jim Cromie wrote:
 > Gilles Chanteperdrix wrote:
 > >
 > > You likely have a division by 0 because nsamples is 0. nsamples come
 > > from the numeric argument of the -n option, and I think you do not pass
 > > a numeric argument to -n, so atoi returns 0.
 > >
 > >   
 > 
 > Yup, thats it.
 > 
 > prog was getting -n -l 1000
 > -l is illegal option, but -n needs an arg, and -l became it, and 
 > converts to 0.
 > so no error caused by -l either !
 > 
 > attached patch does:

Applied, thanks.

 > 
 > xeno-test:     drop most options passed to switchbench,, added -h
 > switchbench:
 >     - sanity check on nsamples.
 >     - 1st column labels on Histogram
 >     - compute statistics (sort of -  I couldnt get 'sqrt' to link..)

sqrt is a math function, which requires linking with -lm. It is
fixed in the repository.

-- 


					    Gilles Chanteperdrix.

