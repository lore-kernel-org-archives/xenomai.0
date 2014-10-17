Date: Fri, 17 Oct 2014 20:04:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141017180447.GJ30661@sisyphus.hd.free.fr>
References: <1413460213.12609.YahooMailNeo@web121502.mail.ne1.yahoo.com>
 <20141016173200.GC30661@sisyphus.hd.free.fr>
 <1413567684.37999.YahooMailNeo@web121505.mail.ne1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413567684.37999.YahooMailNeo@web121505.mail.ne1.yahoo.com>
Subject: Re: [Xenomai] undefined reference of rt_timer_read()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Arsalan Shahid <arsalan_shahid116@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Oct 17, 2014 at 10:41:24AM -0700, Arsalan Shahid wrote:
> Thanks for your prompt response. 
> 
> Gilles, I compiled my code with OpenMP + Xenomai as 
> 
> > xeno-config --skin=--xeno-cflags
> > xeno-config --skin=--xeno-ldflags
> > export CFLAGS=`xeno-config --xeno-cflags`
> > export LDFLAGS=`xeno-config --xeno-ldflags`

This syntax of xeno-config is deprecated. You would know if you
had read xeno-config man page. I took the pain to send you the link
to the HTML version of this manual page.

> > gcc -fopenmp $CFLAGS $LDFLAGS  -lnative -lrtdk  code.c -o code
> 
> For -lrtdk I understood the point. But I think I am compiling the code correctly. What do you say ? 

No, you are not, I was sure you were doing that, already warned you
there was a trap, and posted a link to gcc documentation.

Why can not beginners simply read the documentation they are told
to?
.

-- 
					    Gilles.

