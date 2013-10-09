From: "Daniel Merrill" <daniel.merrill@psware.com>
Date: Wed, 9 Oct 2013 09:29:38 -0700 (MST)
Message-ID: <efafe9af.0000172c.00000011@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
MIME-Version: 1.0
Content-Language: en-us
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] t_suspend and XNBREAK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

All,

 

I'm hoping maybe someone can shed a little more light on the issue we see
occasionally. Occasionally our code using the psos+ skin will fail a
t_suspend(0) with error code -4, which I found to be EINTR and appears to
be set if the XNBREAK flag is set. After digging around in the
documentation I found some references that seem to indicate that this
means the thread was forcibly unblocked for some reason. Is there some way
to diagnose what caused this (I'm having trouble pinpointing anything)? It
appears when debugging that the thread never really suspends at all but
returns immediately from the call. Does anyone have some pointers on what
might be a good place to start looking for the culprit? Thanks in advance.

 

 

Dan Merrill

