Date: Tue, 3 Nov 2015 15:46:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151103144651.GC26720@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A705D34@mb2010-3.intra.tut.fi>
 <20151103114717.GA26720@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A705DA6@mb2010-3.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A705DA6@mb2010-3.intra.tut.fi>
Subject: Re: [Xenomai] Pcap replay tool for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Nov 03, 2015 at 02:31:34PM +0000, Umair Ali wrote:
> [    0.489562] Xenomai: real-time nucleus v2.6.0 (Movin' On)
> loaded.

Xenomai 2.6.0 is seriously outdated (released in 2011).

> I have run the latency tests on the xenomai and it works fine. The results of the latency are as follows
-----
> RTS|      0.545|      1.328|     12.077|       0|     0|    00:00:06/00:00:06

I hope you have run the test for more than 6 seconds before
concluding that xenomai runs fine.

> root@cpc:/usr/xenomai/bin# "
> 
> Now i follow the following links to install the RTnet on xenomai:
> 1) https://xenomai.org/rtnet-installation/ 2)
> http://rtnet.org/doc.html

> And used the guide also for the initial
> test of the RTnet drivers. When i type the command "sudo ./rtnet
> start" my pc froze and i need to do the brutal restart. But some
> time it works and i am able to do ping by "sudo ./rtping <loop
> back IP>". But after the "sudo ./rtnet stop" it never ping again.
> The config.log and rtnet.conf files for the configuration of the
> Rtnet are attached with the email. Also I did not observe any
> error while installation. Therefore i am not sure if RTnet will
> work for me. Please guide me how i can go from here to achieve my
> goal. Thanks in advance for your time and advice

That version of RTnet is not maintained by the Xenomai project. We
merged RTnet in Xenomai 3, but in order to benefit from it, you
would have to install Xenomai 3.0.1 (and note that the above
installation instructions do not apply, since RTnet is now merged,
it means the kernel-space support has to be enabled in the kernel
configuration, and the user-space support is compiled
unconditionally). Also note that the loopback interface is broken in
Xenomai 3.0.1, it will be fixed in 3.0.2, however 8139too should
work.

Please keep the conversation on the mailing list.

-- 
					    Gilles.
https://click-hack.org

