Message-ID: <52CC8A18.2020807@xenomai.org>
Date: Wed, 08 Jan 2014 00:13:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org>
 <52CC7D71.4040703@steinkuehler.net> <52CC83F1.40000@xenomai.org>
 <52CC85C5.4060703@steinkuehler.net>
In-Reply-To: <52CC85C5.4060703@steinkuehler.net>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/07/2014 11:55 PM, Charles Steinkuehler wrote:
> On 1/7/2014 4:47 PM, Gilles Chanteperdrix wrote:
>> On 01/07/2014 11:19 PM, Charles Steinkuehler wrote:
>>> The single-core A8 on the BeagleBone is good for about 25 uS
>>> typical and 80 uS or so worst case latency.
>> 
>> That is really high. On a 720MHz OMAP3, with the latency test
>> running with a 100us period, I typically get latencies close to
>> 40us (under dohell load). Granted I do not run many
>> functionalities of the SOC (typically, not the graphic
>> processor), but I would not expect latencies to get so high. Is
>> there any chance you could trigger a trace with the I-pipe
>> tracer?
> 
> I can try...give me a while to sort through the I-pipe:Tracer wiki
> page (or are there better instructions?).

Enable I-pipe tracer in kernel configuration, especially
IPIPE_TRACE_MCOUNT, and IPIPE_TRACE_VMALLOC.

When the system has booted, do:

echo 1 > /proc/ipipe/trace/enable
echo 1000 > /proc/ipipe/trace/back_trace_points

Then launch latency -p 200 -f

Run the load you usually run (for instance dohell).

When the test is finished, do
cat /proc/ipipe/trace/frozen > /tmp/frozen.txt

then post the resulting frozen.txt to this list.

Expect the latency found by the test to be double the latency you get
without the I-pipe tracer.

> 
> This may also have improved somewhat...my numbers are from a year
> or so ago when everything first started working.  I haven't been
> regression testing the latest kernels.  <blush>  I know there have
> been significant improvements on both the Xenomai side and with the
> BeagleBone kernel patches/drivers.

Actually, OMAP3 latency has been around 40us since 2.6.35. 2.6.33 even
was at 35us. Note that it is the latency at 10kHz, if you are running
with a lower frequency, you will get higher latencies.

Also note that there are some options which improve latency, such as:
compiling kernel and user-space using thumb2 (but in that case do not
forget to enable ARM_ERRATA_430973)
optimize for size
disable CONFIG_PREEMPT
enable stack unwinding
disable CONFIG_SMP (obviously, but it may be enabled by default if you
are using omap2plus_defconfig, since it also compiles for omap4)
disable unlocked context switch (xenomai option)
disable root thread priority coupling (xenomai option)


- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFSzIoYGpcgE6m/fboRAhyRAJ48P6kxKSPh2IeNP0xwwh8cr35KhwCfQo20
cMlOFxFAV7dVNKaPWi6+XW0=
=hMP+
-----END PGP SIGNATURE-----

