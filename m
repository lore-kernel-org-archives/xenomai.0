Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <52CCA101.2040604@steinkuehler.net>
Date: Sat, 11 Jan 2014 11:22:56 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FA64D57-1BB1-4B4A-AB25-AC8E280105F8@mah.priv.at>
References: <44lhyrmuw9.fsf@be-well.ilk.org>
 <52CC7D71.4040703@steinkuehler.net> <52CC83F1.40000@xenomai.org>
 <52CC85C5.4060703@steinkuehler.net> <52CC8A18.2020807@xenomai.org>
 <52CCA101.2040604@steinkuehler.net>
Subject: [Xenomai] i-pipe tracer on in production kernels? (was Re: Altera
	Cyclone V)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


http://www.xenomai.org/index.php/I-pipe:Tracer describes the trace API, =
which could be useful to track down issues

Q: does enabling the tracer incur significant overhead if compiled in =
but unused, or is it reasonable to leave it on in a production kernel?

if the former, we might have to build/make available a second i-pipe =
tracer enabled kernel to track down issues 'in the field'; if the =
latter, it'd be less build/distribution chores

thanks in advance,

Michael



Am 08.01.2014 um 01:51 schrieb Charles Steinkuehler =
<charles@steinkuehler.net>:

> On 1/7/2014 5:13 PM, Gilles Chanteperdrix wrote:
>> On 01/07/2014 11:55 PM, Charles Steinkuehler wrote:
>>> On 1/7/2014 4:47 PM, Gilles Chanteperdrix wrote:
>>>> On 01/07/2014 11:19 PM, Charles Steinkuehler wrote:
>>>>> The single-core A8 on the BeagleBone is good for about 25 uS
>>>>> typical and 80 uS or so worst case latency.
>>>>=20
>>>> That is really high. On a 720MHz OMAP3, with the latency test
>>>> running with a 100us period, I typically get latencies close to
>>>> 40us (under dohell load). Granted I do not run many
>>>> functionalities of the SOC (typically, not the graphic
>>>> processor), but I would not expect latencies to get so high. Is
>>>> there any chance you could trigger a trace with the I-pipe
>>>> tracer?
>>=20
>>> I can try...give me a while to sort through the I-pipe:Tracer wiki
>>> page (or are there better instructions?).
>>=20
>> Enable I-pipe tracer in kernel configuration, especially
>> IPIPE_TRACE_MCOUNT, and IPIPE_TRACE_VMALLOC.
>>=20
>> When the system has booted, do:
>=20
> <snip>
>=20
> Thanks for the details!  My to-do list just got longer...  :)
>=20
> I'll do some testing (on the BeagleBone) and post the results, but it
> might take a couple of days.
>=20
> FYI, the GPU is currently disabled on the BeagleBone, so no mysterious
> latency from that source (hopefully).  I need to migrate to a 3.12
> kernel to get the GPU working (and it doesn't currently support X11,
> only framebuffer applications), which is part of why I'm interested in
> Xenomai on the 3.10 or newer kernel for the Cyclone-V SoC.
>=20
> --=20
> Charles Steinkuehler
> charles@steinkuehler.net
>=20
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: signature.asc
> Type: application/pgp-signature
> Size: 261 bytes
> Desc: OpenPGP digital signature
> URL: =
<http://www.xenomai.org/pipermail/xenomai/attachments/20140107/99bb4e74/at=
tachment.sig>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


