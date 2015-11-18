Date: Wed, 18 Nov 2015 18:57:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151118175738.GC27240@hermes.click-hack.org>
References: <trinity-3b905084-1366-4586-b761-0f15088b0d82-1447853696479@3capp-webde-bap53>
 <20151118135249.GA24942@hermes.click-hack.org>
 <trinity-1434a025-2abb-4454-9acd-44193ddea637-1447857385104@3capp-webde-bap53>
 <20151118162434.GB27240@hermes.click-hack.org>
 <trinity-c7adab7a-6515-4020-bf0e-ed57924e93e6-1447866660248@3capp-webde-bap53>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <trinity-c7adab7a-6515-4020-bf0e-ed57924e93e6-1447866660248@3capp-webde-bap53>
Subject: Re: [Xenomai] rtdm_clock_read overhead/accuracy question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JK.Behnke@web.de
Cc: xenomai@xenomai.org

On Wed, Nov 18, 2015 at 06:11:00PM +0100, JK.Behnke@web.de wrote:
> Hello Gilles,
>=20
> >On Wed, Nov 18, 2015 at 03:36:25PM +0100, JK.Behnke@web.de wrote:
> >> Hello Gilles,
> >>
> >> thanks for your quick response.
> >> See my comments/questions below.
> >>
> >> >On Wed, Nov 18, 2015 at 02:34:56PM +0100, JK.Behnke@web.de wrote:
> >> >> Hello,
> >> >>
> >> >> I'm currently debugging a problem in my xenomai application.
> >> >> In order ot get timing information I do the following inside the
> >> >> read-handler of my rtdm driver.
> >> >>
> >> >> // --- start code snippet ---------------------------------
> >> >> nanosecs_abs_t t1, t2;
> >> >> rtdm_lock_get_irqsave(&lockobj, lockctx);
> >> >>
> >> >> t1=3Drtdm_clock_read();
> >> >> rtdm_task_busy_sleep(10000); // code block to be measured.
> >> >> t2=3Drtdm_clock_read();
> >> >>
> >> >> rtdm_lock_put_irqrestore(&lockobj, lockctx);
> >> >> // --- end code snippet ---------------------------------
> >> >>
> >> >> I observe the following time differences t2-t1:
> >> >> min=3D10176 ns, max=3D10737 ns, avg=3D10314 ns
> >> >>
> >> >> This means in this case the average overhead of the two rtdm_clock_=
read
> >> >> calls is
> >> >> approximately 314 ns/2 =3D 157 ns.
> >> >
> >> >No, this means that the average overhead of rtdm_clock_read is
> >> >314ns.
> >> >
> >> >what you do is:
> >> >read time
> >> >convert to ns
> >> >busy sleep
> >> >read time
> >> >convert to ns
> >> >
> >> >As you can see, between the two time reads, there is only one
> >> >conversion to nanoseconds, (which we assume is the bulk of the
> >> >overhead). And more generally, the overhead of the second time read
> >> >is not counted either.
> >> >
> >> >
> >> >>
> >> >> Is that realistic?
> >> >
> >> >This seems to be a lot. The "tsc" test will measure the average
> >> >difference between two time reads, and the "arith" test will measure
> >> >the average time for a "multiply then shift" operation, adding the
> >> >two should give you an idea of the overhead. From what I recall,
> >> >reading the tsc on an atom N230 (a very old one) had an overhead
> >> >around 20ns.
> >> Where do I find the "tsc test", which test application do I have to ru=
n?
> >
> >The application is named "tsc".
>=20
> Thanks, meanwhile I found the tsc tool under
> /usr/xenomai/bin/regression

Yeah, well, not a very good default directory. You can onverride it
with an option from the configure script.

>=20
> Here are my "tsc" results
> Atom E640 (1.0 GHz): min: 26, max: 936, avg: 34.0001 -> 0.0262211 us=A0 =
=3D=3D> 26 ns
> Atom E660 (1.3 GHz): min: 26, max: 1105, avg: 34.0001 -> 0.0262211 us =3D=
=3D> 26 ns

Well, there is a problem with the time conversion routines. 34
cycles on a 1.0 GHz machine should be 34ns, not 26ns. Other than
that, it seems consistent with what I observe on my old atom.

>=20
> The "arith" tool delivered these results (only lines containing "llmulshf=
t")
> Atom E640 (1.0 GHz):
> inlined llmulshft: 0x79364d92ffffffe1: 29.088 ns, rejected 0/10000=A0=A0=
=A0=A0 =3D=3D> 29 ns
> out of line llmulshft: 0x79364d92ffffffe1: 40.097 ns, rejected 0/10000 =
=3D=3D> 40 ns
> inlined llmulshft: 0x86c9b26d0000001e: 30.222 ns, rejected 0/10000=A0=A0=
=A0=A0 =3D=3D> 30 ns
> out of line llmulshft: 0x86c9b26d0000001e: 44.118 ns, rejected 1/10000 =
=3D=3D> 44 ns

These values have the calibration subtracted, you may want to re-add
the calibration value to have an idea of the time it really took.
But other than that, it seems reasonably short.

--=20
					    Gilles.
https://click-hack.org

