Message-ID: <52CC83F1.40000@xenomai.org>
Date: Tue, 07 Jan 2014 23:47:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org>
 <52CC7D71.4040703@steinkuehler.net>
In-Reply-To: <52CC7D71.4040703@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Altera Cyclone V
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 01/07/2014 11:19 PM, Charles Steinkuehler wrote:
> The single-core A8 on the
> BeagleBone is good for about 25 uS typical and 80 uS or so worst case
> latency.

That is really high. On a 720MHz OMAP3, with the latency test running
with a 100us period, I typically get latencies close to 40us (under
dohell load). Granted I do not run many functionalities of the SOC
(typically, not the graphic processor), but I would not expect latencies
to get so high. Is there any chance you could trigger a trace with the
I-pipe tracer?

-- 
                                                                Gilles.

