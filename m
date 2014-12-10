Date: Wed, 10 Dec 2014 19:41:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141210184130.GO1524@hermes.click-hack.org>
References: <20141207124041.GS10014@hermes.click-hack.org>
 <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>
 <20141207135204.GT10014@hermes.click-hack.org>
 <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>
 <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
 <3d1763453771465c9d014b3313bc82c6@EX132MBOX1A.de2.local>
 <20141209205914.GQ30777@hermes.click-hack.org>
 <2a74ff40de88431da68f4922b415da89@EX132MBOX1A.de2.local>
 <20141210162625.GL1524@hermes.click-hack.org>
 <146c26d17efd4456a8ad86ef13313aa6@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146c26d17efd4456a8ad86ef13313aa6@EX132MBOX1A.de2.local>
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

On Wed, Dec 10, 2014 at 06:23:03PM +0000, Stoidner, Christoph wrote:
> [<c00b6b48>] xnshadow_relax+0x94/0x168
> [<c00b7384>] losyscall_event+0x240/0x26c

That is strange, are these tasks running with the SCHED_OTHER policy ?

-- 
					    Gilles.

