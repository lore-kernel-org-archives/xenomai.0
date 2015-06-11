Message-ID: <3f53684a76c1f4e0b4f97672bdaa90fb.squirrel@sourcetrek.com>
In-Reply-To: <CAL92PvU2DNPis5vtOH_NDpRJCYOwSBh3yvEQ83_OJ3POr17-3g@mail.gmail.com>
References: <CAL92PvU2DNPis5vtOH_NDpRJCYOwSBh3yvEQ83_OJ3POr17-3g@mail.gmail.com>
Date: Thu, 11 Jun 2015 18:47:42 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Timer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: cristian ramos <cristian0084@gmail.com>
Cc: xenomai@xenomai.org


cristian ramos wrote:
> Hello everybody,
>
>     First at all, thank very much for you attention and I would like
> receive your help.
>
>     I'm working with centos7 and 2.6.4 release. All is working perfect,
> but
> I don't understand because the code below I get a difference of two
> seconds.
>
>     clock_gettime(CLOCK_REALTIME, &ts);
>     RTIME rtime = rt_timer_read();
>     cout <<"posix: " << ts.tv_sec << ts.tv_nsec << endl;
>     cout <<"xeno:  "<<  rtime << endl;
>
> the result is:
>
>     posix: *1434035528*803555763
>     xeno: *1434035526*522192216
>
> you can see that clock_gettime has two seconds more than rt_timer_read.
> I'm
> using ntp for the synchronization between machines.
>
> Thank you very much for your time and would appreciate any help.

Oh boy, are there ambiguities between the words "clock" and "timer" this
afternoon.

See:
http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#Timing_services

rt_timer_read() is the same as Xenomai POSIX skin CLOCK_REALTIME.


-- 
                    Gilles.


