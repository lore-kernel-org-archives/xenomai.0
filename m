content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Apr 2005 16:55:16 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D3F@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: [Adeos-main] RE: Interrupt Latency Question
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
To: Wolfgang Grandegger <wolfgang.grandegger@domain.hid>, rtai@domain.hid
Cc: adeos-main@gna.org

Wolfgang Grandegger wrote:
>It's also my experience, that the large latencies are
>due to TLB misses and cache refills, especially the
>latter one. What helps is L2 cache or fast memory.
>For example, on an MPC 5200 I get significately better
>latencies with DDR-RAM than with SDRAM (which is ca.=20
>20% slower).

I keep on hearing people are having feeling that their latency
can be caused by TLB misses/cache refills, but never seen proof.
Is there some literature about that subject? Nobody in the RTAI=20
community had curiosity to explain and fix this interesting problem?

If not, what about showing (or not) that the large latencies are due
to TLB misses/cache refills with a tool like Flushy?

Using Flushy would be like using low-end hardware. It's far easier to
make=20
performance improvements on low-end hardware than high-end. It works as
a=20
magnifying glass. It reminds me a comment on Gnome mailing list, where
an=20
end-user wished that developers had high-end compile machine, but slow=20
hardware to test with.

>>Have a look at http://rtai.dk/cgi-bin/gratiswiki.pl?Latency_Killer
>>To get real bad cases, try the Flushy module.
>>You can try also to disable caches for better predictability, but it
really
>>hurts :*)
>
>I will try it on an embedded PowerPC platform a.s.a.p.

After thought, there would be a better design for Flushy. Instead of=20
an infinite loop in a separate module(process), we should instead call
the TLB flush/cache invalidate right before entering the RT world
from ADEOS. Therefore, we should get "predictable" worst case latencies
wrt=20
TLB/cache conditions.

Where is the best place in ADEOS to do that?
The earlier, the better. Tapping at the exception level would be the
best, right before saving registers, but we need couple registers to
call the=20
TLB/cache flush.
Any idea?

I've Cc:'d the adeos-main list to reach some more gurus.

>>Note: if it turns out this latency is due to cache misses, then
solutions
>>exist.
>
>Can you be more precise here.

With reproducible latencies, we can then use OProfile (where available)
to
spot slow areas. We have to sort out whether TLB misses, I-cache misses
or
D-cache misses is the bigger culprit. Make your guess :-)
Modern processors have cache control instructions, like prefetch for
read,
zero cache line, writeback flush, etc. With nice cpp macros, we can use
them (where available) ahead of time in the previously spotted places,=20
to render the memory access latency predictable.

Do you think that will do it? Anybody has experience to share?


Thanks
--=20
Stephane


