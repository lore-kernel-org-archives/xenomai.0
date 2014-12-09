Date: Tue, 9 Dec 2014 21:59:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141209205914.GQ30777@hermes.click-hack.org>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
 <20141207124041.GS10014@hermes.click-hack.org>
 <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>
 <20141207135204.GT10014@hermes.click-hack.org>
 <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>
 <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
 <3d1763453771465c9d014b3313bc82c6@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1763453771465c9d014b3313bc82c6@EX132MBOX1A.de2.local>
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Dec 09, 2014 at 08:49:49PM +0000, Stoidner, Christoph wrote:
> 
> Now with the fix from above unfortunately I ran into another problem. 
> 
> After some undetermined situation nuclues freezes. That means all
> tasks running in primary domain are freezed. In contrast all
> processes and tasks of secondary domain are still running without
> any problem at the same time. The xenomai task states are looking
> normal:
> 
> ~ # cat /proc/xenomai/stat
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>   0  0      0          13914      0     00500080   98.8  ROOT
>   0  83     196        196        0     00300380    0.0  DOS4
>   0  82     13         13         0     00300380    0.0  DOS5
> 
> I have enabled ipipe traceing to figure out what's happening here
> (see output below, created after tasks have freezed). However I am
> not sure how to interpret that. Does anyone has an idea?

ipipe tracing will not help you, because you have no way to trigger
it at the right time.

Anyway, is not it simply a deadlock in your application ?

Please check that Xenomai timer is still running by checking that
its counter increases in cat /proc/xenomai/irq result.

If Xenomai and Linux timers are shared (I believe they are on
imx28), checking the same thing for Linux timer in /proc/interrupts
is sufficient, Xenomai timer can not possibly be jammed if Linux
timer still ticks.

-- 
					    Gilles.

