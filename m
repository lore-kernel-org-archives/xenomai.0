From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18011.14565.787935.188919@domain.hid>
Date: Mon, 28 May 2007 22:17:41 +0200
In-Reply-To: <f3fcrk$3eg$1@domain.hid>
References: <f3es61$8a2$1@domain.hid>
	<18011.7896.952588.610032@domain.hid>
	<f3fcrk$3eg$1@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] add tut02-skeleton
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: trem <tremyfr@domain.hid>
Cc: xenomai@xenomai.org

trem wrote:
 > Hi
 > 
 > Thanks for the reply (jan too). I've tried to use all of your feedback,
 > and I send you the new release of this tut02.
 > 
 > (...)
 > +	/* no memory-swapping for this programm */
 > +	ret = mlockall(MCL_CURRENT | MCL_FUTURE);
 > +	if (ret) {
 > +		fprintf(stderr, "ERROR : mlockall failled: %s\n", strerror(-ret));
 > +		fflush(stdout);
 > +		exit(1);
 > +	}

Some further comment, mlockall returns its error in errno, so you should
replace strerror(-ret) with strerror(errno), or to make it short, use
perror.
Also note that since you fflush stdout after having printed the error
message, if there are any non printed message in stdout, they will only
appear after the error message, which will make it hard for the user to
catch the error message. Besides, exit already flushes the file
descriptors, so flushing stdout before calling exit is useless. IMHO,
you should call fflush(stdout) before printing the error message.

-- 


					    Gilles Chanteperdrix.

