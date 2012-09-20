From: "Franz Engel" <franz_lambert_engel@yahoo.de>
References: <1347634862.78737.YahooMailNeo@web29605.mail.ird.yahoo.com>
	<5055E244.4040101@web.de>
In-Reply-To: <5055E244.4040101@web.de>
Date: Thu, 20 Sep 2012 17:24:38 +0200
Message-ID: <003501cd9744$0c80a460$2581ed20$@de>
MIME-Version: 1.0
Content-Language: de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Context Switch with rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Jan Kiszka' <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

Hi Jan,

> > Hi,
> >
> > I've a little problem. I'm using the rtnet.h-header and the following
> function:
> > ret = recvfrom ( ethernetConnection.sock, &recBuffer, sizeof (
> > recBuffer ),0, ( struct sockaddr * )
> > &ethernetConnection.dest_addr,&destlen );
> >
> >
> > I compiled the program with the xenomai compiling flags and library.
> >
> > When I look to the xenomai state I get something like this:
> > CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
> >  22  0      0          834840     0     00000082    0.1  rtnet-stack
> >  22  0      0          1          0     00000082    0.0  rtnet-rtpc
> >   0  6262   2          2          0     00300380    0.0
> qs_robotpositio
> >   2  6265   2          6          0     00300380    0.0
> qs_robotpositio
> >   0  6266   1          1          0     00300380    0.0
> robotrsiinterfa
> >   1  6268   1147       2365       0     00300182    0.8
> robotrsiinterfa
> >
> > You can see, I get a lote of context and module switches just as the
> rtnet-stack itself. Is that normal?
> 
> Well, I have no clue what you configured, so I can only guess. If your
> task 6268 is a pure RT task that is not supposed to interact with Linux
> services, you first of all have a bug in your software stack. You
> should look for the reason of those mode switches to Linux, e.g. by
> asking Xenomai to raise SIGXCPU when this happens.

I use the SIGXCPU signal to look where I get a context switch. It is exactly
in the line of the recvfrom. I get the same result when I step through my
code. I debug from line to line and check the /proc/xenomai/state, so I can
see that the CSW and MSW increases when I step over the recvfrom. I tried my
code also with the native commands, like rt_recvfrom. But the result is the
same.

> 
> Regarding the rtnet-stack context switches: basically, every switch is
> one packet arriving at your NIC. Either you are receiving a lot of
> small but valid packets or you are on an open network, and that is
> basically heavy unrelated broadcast traffic of other sources than the
> RT device(s).
> 
> Jan

I'm connected to a robot that sends me his position every 4ms.

I send you a minimal example of my code. But I'm not sure if I understand
your question for the configuration correct. Depends the realtime capability
of rtnet only by my kdevelop project (cmake, *.c and *.h) or is it possible
that I miss some settings in the kernel? I start rtnet before I run my
program and I load the modules for my NIC and for UDP etc. Is there
something more what I have to do?

Thanks and regards,
    Franz

-------------- next part --------------
A non-text attachment was scrubbed...
Name: DemoCSW.tar.gz
Type: application/octet-stream
Size: 3601 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120920/c87f6809/attachment.obj>
