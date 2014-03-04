Message-ID: <5315ED1F.60602@xenomai.org>
Date: Tue, 04 Mar 2014 16:11:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1392993075.52404.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530766CD.3060707@xenomai.org>
 <1393198348.29895.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530A862C.1060805@xenomai.org>
 <1393204287.98060.YahooMailNeo@web140606.mail.bf1.yahoo.com>
 <530B374B.1080507@xenomai.org>
 <1393298793.43978.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530C6AC6.6030200@xenomai.org>
 <1393335358.33826.YahooMailNeo@web140603.mail.bf1.yahoo.com>
 <530C9D87.60805@xenomai.org>
 <1393871535.96739.YahooMailNeo@web140604.mail.bf1.yahoo.com>
 <5314CDDA.4030308@xenomai.org>
 <1393904852.42577.YahooMailNeo@web140603.mail.bf1.yahoo.com>
In-Reply-To: <1393904852.42577.YahooMailNeo@web140603.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] User Space Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/04/2014 04:47 AM, Bruno Tunes de Mello wrote:
> Hi Gilles,
> 
> You are right, in the first test, I executed both latency and xeno-test commands. Sorry.
> The others test I executed only latency command.
> 
> I tried to enable the discard service on /etc/inetd.conf, I don't know if I did it right, but in /etc/services file I found 'discard 9/tcp sink null' and 'discard 9/udp sink null'.
> Then I used the command you said:
> xeno-test -l "dohell -s 192.168.0.5 -m /media/linaro/PENDRIVE -l /opt/ltp" -c 0 -p 100 -g histo
> 
> I tested a few times and the better result is: http://pt-br.tinypic.com/r/206mmvn/8
> This result is not so good like that you showed.
> 
> My doubt is if this result is satisfactory (the platform is ready for develop applications) or do you think that I need to do some correction?

70us is a bit high, but on the other hand:
- the mx6q is a quad-core, whereas the omap4 is a dual core, the latency
increases with the number of cores;
- the tests I make on omap4 do not use much of the processor
peripherals, such as the graphic co-processor, so, if you use the
graphic co-processor, you may observe an increase in latencies as well.

Finally, whether this is satisfactory depends on your application.

The only way to improve latency is to enable the I-pipe tracer, and try
and understand where the maximum latency come from, but this is time
consuming.

Also, some settings are known to result in an improvement in latencies:
- turn off CONFIG_PREEMPT (i.e. enable CONFIG_PREEMPT_NONE), this looks
contradictory, as the menu entry says "low latency", but it is talking
about Linux latencies, not Xenomai's
- build kernel and user-space in thumb2
- disable Xenomai unlocked context switch

But do not expect these settings to reduce the latency by more than say 5us.


-- 
                                                                Gilles.

