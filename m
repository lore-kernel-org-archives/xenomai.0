From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4FA4D76-58FD-4DB4-AE7F-5B2D3D20FF35@mah.priv.at>
Date: Wed, 20 Nov 2013 15:33:12 +0100
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: [Xenomai] integrate event signaled by RT thread into non-RT event
	loops (poll, select, eventfd..)?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm looking for a simple method to post an event from an RT thread so a =
userland non-RT thread can wait for, and pick it up via a file =
descriptor (without switching the originating thread to primary domain, =
of course)

event context can be minimal since the userland handler can figure; =
actual data transfer not required - event number or mask a plus

purpose would be integration into existing event loops; only =
RT->userland signalling needed

if it's possible from a kernel RT context, it's a plus

---

one scheme I thought of was: using rt_event services, monitor the event =
flag in a userland shadow thread and post to an eventfd whose other side =
could be integrated into an event loop. Making sense?

thanks in advance,

Michael

ps: this needs to be portable across RT kernel variants; my approach for =
RTAI would be to use rt_request_srq() and post to an eventfd from the =
Linux context


