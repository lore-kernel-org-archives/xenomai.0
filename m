From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44lhyrmuw9.fsf@be-well.ilk.org>
 <52CC7D71.4040703@steinkuehler.net> <52CC83F1.40000@xenomai.org>
Date: Tue, 07 Jan 2014 22:21:49 -0500
In-Reply-To: <52CC83F1.40000@xenomai.org> (Gilles Chanteperdrix's message of
 "Tue, 07 Jan 2014 23:47:13 +0100")
Message-ID: <44a9f7ma42.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] Altera Cyclone V
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:

> On 01/07/2014 11:19 PM, Charles Steinkuehler wrote:
>> The single-core A8 on the
>> BeagleBone is good for about 25 uS typical and 80 uS or so worst case
>> latency.
>
> That is really high. On a 720MHz OMAP3, with the latency test running
> with a 100us period, I typically get latencies close to 40us (under
> dohell load). Granted I do not run many functionalities of the SOC
> (typically, not the graphic processor), but I would not expect latencies
> to get so high. Is there any chance you could trigger a trace with the
> I-pipe tracer?

That seems high even to me. I got into that range on the Cyclone V eval
board with PREEMPT_RT alone.

