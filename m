MIME-Version: 1.0
Date: Sun, 26 Aug 2012 07:59:02 +0430
Message-ID: <CAKKWdte-kjOSZgPPkVe8UtGpeVSh0E52+-u1HyK2G2E0OS+RPg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] stall/unstalling the pipeline domain automatically
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

As far as I understood the pipeline stage is stalled (for all
interrupts) automatically before servicing an interrupt handler and it
is unstalled upon returning from the interrupt. is that right?

If i use an API function inside an interrput routine which stalls the
pipeline domain explicitly, will that domain remain in the stall state
after returning from the interrupt routine? (is there such an API
function?)
I mean , can i do something to force a domain to stay in a stalled state?

