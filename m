Subject: Re: [Adeos-main] port 2.6.19 x86_64 to 2.6.20
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45EB0295.5070506@domain.hid>
References: <45E220D7.6060004@domain.hid> <1172469398.1764.79.camel@domain.hid>
	<45E9F580.3010107@domain.hid> <1172962682.13721.74.camel@domain.hid>
	<45EB0295.5070506@domain.hid>
Content-Type: text/plain
Date: Sun, 25 Mar 2007 19:19:48 +0200
Message-Id: <1174843188.5612.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: trem <trem@domain.hid>
Cc: adeos-main@gna.org

On Sun, 2007-03-04 at 18:32 +0100, trem wrote:
> Hi
> 
> As I've got your start now, I've ported (at least tried) the 2.6.19
> x86_64 adeos patch to 2.6.20.
> I've tried it and it seems to works fine, here the latency :
> 
> [trem@domain.hid ~]$ cat latency_xenomai_2_6_20.txt
> [trem@domain.hid bin]$ sudo ./latency -T 10
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|       0.737|       1.067|       3.332|       0|       0.737|      
> 3.332
> RTD|       0.744|       1.067|       3.568|       0|       0.737|      
> 3.568
> RTD|       0.724|       1.080|       3.362|       0|       0.724|      
> 3.568
> RTD|       0.730|       1.070|       2.900|       0|       0.724|      
> 3.568
> RTD|       0.711|       1.071|       3.441|       0|       0.711|      
> 3.568
> RTD|       0.733|       1.066|       3.547|       0|       0.711|      
> 3.568
> RTD|       0.735|       1.079|       4.523|       0|       0.711|      
> 4.523
> RTD|       0.716|       1.072|       3.307|       0|       0.711|      
> 4.523
> RTD|       0.715|       1.066|       3.507|       0|       0.711|      
> 4.523
> ---|------------|------------|------------|--------|-------------------------
> RTS|       0.711|       1.071|       4.523|       0|    00:00:10/00:00:10
> 
> 
> The patch (2.6.20 x86_64) can be found here :
> http://zarb.org/~trem/adeos-ipipe-2.6.20-x86_64-1.7-07-trem.patch
> 
> I hope it could be used.
> 

Merged, thanks. This upgrade is now available from the Adeos GIT repo
and Xenomai's SVN trunk.

> regards,
> trem
> 
> 
> Philippe Gerum wrote:
> > On Sat, 2007-03-03 at 23:24 +0100, trem wrote:
> >   
> >> Philippe Gerum wrote:
> >>     
> >>> On Mon, 2007-02-26 at 00:50 +0100, trem wrote:
> >>>   
> >>>       
> >>>> Hi
> >>>>
> >>>> I've tried to port the 2.6.19 x86_64 adeos patch to 2.6.20. you can find
> >>>> it here :
> >>>> http://zarb.org/~trem/adeos-ipipe-2.6.20-x86_64-1.7-03-trem.patch
> >>>>     
> >>>>         
> >>> The good news is that moving to 2.6.20 does not seem to be too much of a
> >>> hell. Right?
> >>>
> >>>   
> >>>       
> >> Yes, there are few conflict so it's quite easy to port xenomai to 2.6.20.
> >>     
> >>>> I can apply it with with prepare_kernel.sh (from xenomai svn), but I haven't
> >>>> tested it yet (I mean run kernel).
> >>>>
> >>>> I hope this patch is good enough to be used. Otherwise, I'd be pleased
> >>>> to fix it (maybe with a bit of help).
> >>>>
> >>>>     
> >>>>         
> >>> We are hopefully close to have a reasonably good patch for 2.6.19. Once
> >>> we achieve this, porting to 2.6.20 should be the next step. Thanks.
> >>>
> >>>   
> >>>       
> >> I've seen ths in the Changelog : "this closes the implementation phase
> >> of the x86_64 port."
> >> So I suppose that the patch for 2.6.19 is finished. I've tried it and it
> >> works fine.
> >> The result of latency is :
> >>
> >> [trem@domain.hid bin]$ sudo ./latency -T 10
> >> == Sampling period: 100 us
> >> == Test mode: periodic user-mode task
> >> == All results in microseconds
> >> warming up...
> >> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> >> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> >> worst
> >> RTD|       0.760|       1.073|       3.660|       0|       0.760|      
> >> 3.660
> >> RTD|       0.737|       1.063|       3.012|       0|       0.737|      
> >> 3.660
> >> RTD|       0.741|       1.083|       3.396|       0|       0.737|      
> >> 3.660
> >> RTD|       0.755|       1.088|       2.344|       0|       0.737|      
> >> 3.660
> >> RTD|       0.754|       1.093|       3.431|       0|       0.737|      
> >> 3.660
> >> RTD|       0.755|       1.089|       5.119|       0|       0.737|      
> >> 5.119
> >> RTD|       0.724|       1.091|       3.126|       0|       0.724|      
> >> 5.119
> >> RTD|       0.762|       1.089|       3.171|       0|       0.724|      
> >> 5.119
> >> RTD|       0.751|       1.097|       5.508|       0|       0.724|      
> >> 5.508
> >> ---|------------|------------|------------|--------|-------------------------
> >> RTS|       0.724|       1.085|       5.508|       0|    00:00:10/00:00:10
> >>
> >> If I don't mistake, I see a max latency of 5us. Is it realistic ?
> >>
> >>     
> >
> > Yes. X-related problems Paul told us about being put aside (likely MTRR
> > issues, still to be chased), I see < 10 us under SMP test load on a 2 x
> > dual core Opteron 285 here (test load meaning two parallel kernel
> > compilations (-j5), and some significant network load).
> >
> > We still have to benchmark this port more exhaustively and aggressively
> > (e.g. different I/O loads and severe cache trashing, for longer than 8
> > hours), but the foundations look sane, especially since the
> > Xenomai/x86_64 port currently runs with a default latency calibration
> > set to 500 ns over this.
> >
> >   
> >> Now, the port to 2.6.20 is open ? we can work on ?
> >>
> >>     
> >
> > Yep. Have fun.
> >
> >   
> >> trem
> >>
> >>
> >>
> >>     
> 
> 
-- 
Philippe.



