From: Der Herr Hofrat <der.herr@domain.hid>
Message-Id: <200505030712.j437CaU18874@domain.hid>
In-Reply-To: <42622D20.3070609@domain.hid> from Wolfgang Grandegger at "Apr 17,
 2005 11:32:16 am"
Date: Tue, 3 May 2005 09:12:35 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: Interrupt Latency Question
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Wolfgang Grandegger <wolfgang.grandegger@domain.hid>
Cc: Fillod Stephane <stephane.fillod@domain.hid>, rtai@domain.hid, adeos-main@gna.org

> Hello,
> 
> I just run flushy on a low-end PowerPC system:
> 
>   XPC855xxZPnnD4 at 80 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
> 
> Unfortunately the results are not that clear than expected. I see the
> latency going up a bit but other activities do increase it as well
> (telnet, ping -f). Furthermore, from run to run the latency results are

did some measurements on a number of boxes and ping -f is a bad test as
especially on low end systems it results in the kernel more or less running
the same code in an infinite loop - resulting in "good" values. If you want
to see the network layer influence use NetPIPE and see the jitter jump ;)

> different. Well, I think it's a complex and arch-dependent interplay of
> various parameters, e.g. on the system above, the caches are quite small
> and therefore the influence of cache refills is low. When I have more
> time I might repeat the tests on other PowerPC archs as well.
> 
> 
> Apart from that, you can do little to reduce the latency degradation due
> to cache refills and TLB misses (at least not in a portable way). Linux
> simply requires it.
>
has anybody ever used gcov feedbacks for ppc ? (run load with kernel compiled
with -fprofile-arcs recompile -fbranch-probabilities rerun load and test 
jitter) . The PPC branch prediction should be almost ideal for this and that
would be a fairly portable way of doing it.

hofrat

