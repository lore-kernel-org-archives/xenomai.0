Date: Tue, 8 Dec 2015 21:13:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151208201331.GA3667@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A70DB46@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A70DB46@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Loose determinism when reading pcap and sending as
 raw ethernet packets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Dec 08, 2015 at 05:25:21PM +0000, Umair Ali wrote:
> Hi there,
> 
> I am reading the pcap file using the following technique:
> "
> mlockall(MCL_CURRENT|MCL_FUTURE);
> fd = open (file.pcap, O_RDONLY);
> status = fstat (fd, & s);
> size = s.st_size;
>  /* Memory-map the file. */
>  mapped = mmap (0, size, PROT_READ, MAP_PRIVATE, fd, 0);"
> 
> 
> Then i have the pcap file in mapped variable in the form of chracters (hex numbers). I read packet by packet and send them as raw packet over the network with following code:
> "struct timespec ts;
> ts.tv_sec = 0;
> ts.tv_nsec = 5000;
> j=24;
> 
>  while (j < size){
>          i = (unsigned char) mapped[j + 8];
>          sendto(sock, &mapped[j+16], i, 0,(struct sockaddr *)&peer, sizeof(peer));
>          nanosleep(&ts, NULL);
>           j = j+i+16;
> }
> "
> 
> When i run the program and receive the packets on the receiver
> then i have observed that behaviour of sending raw packets is not
> constant. Sometimes nanosleep finish little late or quickly.

There are several problems with this program:
- for a program to run in primary mode only, pthread_setschedparam
should be called with a priority higher than 1 for the SCHED_FIFO
(or SCHED_RR) policy;
- when you call a function which returns a value, like send or
nanosleep, you should always check the return value for errors;
- if you want to send a message on average every 5us then
nanosleep(5us) is not what you should be using, you should be using
clock_nanosleep with an absolute date, or the easier but less
portable timerfd;
- what you observe is the jitter, you can measure the timer
interrupt jitter with the "latency" test, but I bet that maybe the
latency may be higher than 5us;
- if you really really need to reduce the jitter, then using kernel
timers instead of sleeping in a user-space thread is recommended,
see:
http://letsmakerobots.com/node/28812
http://letsmakerobots.com/node/32347

-- 
					    Gilles.
https://click-hack.org

