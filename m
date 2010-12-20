Date: Mon, 20 Dec 2010 08:59:48 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20101220075948.GA8454@domain.hid>
References: <BAY149-w131A596DF2F2249BFEFAA3E4150@domain.hid>
	<1292524810.1837.261.camel@domain.hid>
	<BAY149-w569BBC6219044CB125C68BE4150@domain.hid>
	<1292576987.1837.291.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1292576987.1837.291.camel@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and timers.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai Help <xenomai@xenomai.org>

On Fri, Dec 17, 2010 at 10:09:47AM +0100, Philippe Gerum wrote:
> grained in essence. I'm talking about large arbitrary leaps forward done
> using clock_settime() from an application context.
> 
> A possible answer then, is two fold:

BTW, there has been some discussion on the lkml recently on the
question, how can a program detect that a clock has been reset?

The latest suggested patch and a summary is at:

   http://article.gmane.org/gmane.linux.kernel/1070389

Richard

