From: Henry Bausley <hbausley@deltatau.com>
In-Reply-To: <503675C7.5040300@xenomai.org>
References: <1345745901.24823.36.camel@lx-henry> <503675C7.5040300@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Aug 2012 11:59:42 -0700
Message-ID: <1345748382.24823.49.camel@lx-henry>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] nanosleep returns -1 unless using SCHED_FIFO.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thanks. 
 
I did compile with --enable-dlopen-skins  and
--enable-posix-auto-mlockall.  Without --enable-dlopen-skins everything
is fine

On Thu, 2012-08-23 at 20:26 +0200, Gilles Chanteperdrix wrote:
> On 08/23/2012 08:18 PM, Henry Bausley wrote:
> 
> > 
> > 
> > With xenomai 2.5.6 nanosleep no longer works unless the application is
> > using SCHED_FIFO.  Previously we used xenomai 2.4.10 and the code would
> > nanosleep.
> > 
> > 
> > int main(void) 
> > {
> >   struct timespec SecSleeper = {0};
> >   SecSleeper.tv_sec = 1;
> >   SecSleeper.tv_nsec = 0;
> >   int P[3];
> > 
> >   // param.__sched_priority = 1;
> >   // pthread_setschedparam(pthread_self(),  SCHED_FIFO, &param);    
> >   while (1)
> >   {
> >         printf("Dummy\n");
> >         P[1]++;
> >         P[2] = nanosleep(&SecSleeper, NULL);
> >         P[3] = errno;
> 
>             ^ out of bounds
> 
> >   }  
> >   return 0;
> > }
> > 
> > 
> > Is this behavior expected?
> 
> 
> nanosleep is reserved to xenomai threads. But normally the main thread
> is a xenomai thread, unless you configured xenomai user-space with
> --enable-dlopen-skins, so, should be allowed to nanosleep. Apart from
> the missing call to mlockall (unless you configured xenomai user-space
> with --enable-posix-auto-mlockall), your test case runs fine with
> xenomai 2.6.1.
> 





Outbound scan for Spam or Virus by Barracuda at Delta Tau


