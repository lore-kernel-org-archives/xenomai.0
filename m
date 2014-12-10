Date: Wed, 10 Dec 2014 17:26:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141210162625.GL1524@hermes.click-hack.org>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
 <20141207124041.GS10014@hermes.click-hack.org>
 <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>
 <20141207135204.GT10014@hermes.click-hack.org>
 <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>
 <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
 <3d1763453771465c9d014b3313bc82c6@EX132MBOX1A.de2.local>
 <20141209205914.GQ30777@hermes.click-hack.org>
 <2a74ff40de88431da68f4922b415da89@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a74ff40de88431da68f4922b415da89@EX132MBOX1A.de2.local>
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

On Wed, Dec 10, 2014 at 04:23:51PM +0000, Stoidner, Christoph wrote:
> 
> >
> > Anyway, is not it simply a deadlock in your application ?
> 
> I don't think so. Here is a list of all tasks:
> 
> ~ # cat /proc/xenomai/stat 
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>   0  0      0          7452       0     00500080   98.9  ROOT
>   0  83     196        196        0     00300380    0.0  DOS4
>   0  81     13         13         0     00300380    0.0  DOS5
>   0  97     618        830        0     00300380    0.0  @WDG
>   0  101    751        1127       0     00300380    0.0  HSSR
>   0  128    1268       2186       0     00300380    0.0  DOS8
>   0  129    1          1          0     00300380    0.0  @CGI
>   0  130    7          10         0     00300182    0.0  LOG 
>   0  131    1          2          0     00300184    0.0  IOXP
>   0  142    20         42         0     00300380    0.0  KTMR
>   0  151    1652       1901       0     00300380    0.0  Sdrv
>   0  152    383        489        0     00300380    0.0  LApp
>   0  156    0          1          0     00300380    0.0  DOS9
>   0  0      0          14937556   0     00000000    1.0  IRQ16: [timer]
> 
> Most of them are in state 00300380, that means:
>   XNSTARTED
>   XNMAPPED
>   XNRELAXED
>   XNFPU
>   XNSHADOW
> 
> For a deadlock I would expect all threads must be wait for a semaphore or something else (state flag XNPEND). However all tasks are freezed.

Well no, XNRELAXED state means that it is suspended from xenomai
scheduler point of view, and handled by Linux scheduler. So, if
there is a deadlock, it happens in secondary mode.

-- 
					    Gilles.

