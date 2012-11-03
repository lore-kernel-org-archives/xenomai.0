Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <c5618ea63b6ec1da7d2fa937467d9f4c.squirrel@www.xenomai.org>
Date: Sat, 3 Nov 2012 11:36:44 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <CF928888-710A-475C-B58A-D369B8B3C228@mah.priv.at>
References: <22700C72-58CD-4B92-B397-43DFC7943F14@mah.priv.at>
	<c5618ea63b6ec1da7d2fa937467d9f4c.squirrel@www.xenomai.org>
Subject: Re: [Xenomai] Question on rt_timer_tsc() vs rt_timer_read()
	semantics
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Gilles,

thanks for the fast reply, I will look into the I-pipe tracer.

as for the current code: yes, it uses the native API - I started with =
existing RTAI code and massaged that - but I'll rewrite it to RTDM if =
that's how it's supposed to be done.

--

as for how the LinuxCNC latency-test works:
It's a bit involved as lots of loadable kernel modules are involved =
which export named functions; these functions are then called in turn by =
the RT thread. The rough picture is this:

- a new thread is created in rtapi_task_new here : =
http://git.mah.priv.at/gitweb/emc2-dev.git/blob/5979d84f31c0ef8e9dccdb2642=
6732d0b83f3a87:/src/rtapi/xenomai_kernel_rtapi.c#l871

- it's actually started in rtapi_task_start here: =
http://git.mah.priv.at/gitweb/emc2-dev.git/blob/5979d84f31c0ef8e9dccdb2642=
6732d0b83f3a87:/src/rtapi/xenomai_kernel_rtapi.c#l1021

- the code it executes  is here: =
http://git.mah.priv.at/gitweb/emc2-dev.git/blob/5979d84f31c0ef8e9dccdb2642=
6732d0b83f3a87:/src/hal/hal_lib.c#l2672 - this just runs through the LKM =
function chain and does an rtapi_wait at the end

- rtapi_wait is rt_task_wait_period() with error reporting tacked on: =
http://git.mah.priv.at/gitweb/emc2-dev.git/blob/5979d84f31c0ef8e9dccdb2642=
6732d0b83f3a87:/src/rtapi/xenomai_common.c#l78

--

so this is the basic plumbing; the actual latency test works like so:

the threads module starts a thread through the mechanism outlined above =
:=20

=
http://git.mah.priv.at/gitweb/emc2-dev.git/blob/5979d84f31c0ef8e9dccdb2642=
6732d0b83f3a87:/scripts/latency-test#l58
(the actual code of the threads module is here, but it's a higher level =
API, so thats irrelevant: =
http://git.mah.priv.at/gitweb/emc2-dev.git/blob/5979d84f31c0ef8e9dccdb2642=
6732d0b83f3a87:/src/hal/components/threads.c)

- the timedelta module just samples with rtapi_get_time():

=
http://git.mah.priv.at/gitweb/emc2-dev.git/blob/5979d84f31c0ef8e9dccdb2642=
6732d0b83f3a87:/src/hal/components/timedelta.comp (this _is_ a kernel =
module, it's in preprocessor language).

rtapi_get_time() in turn calls rt_timer_read() here: =
http://git.mah.priv.at/gitweb/emc2-dev.git/blob/5979d84f31c0ef8e9dccdb2642=
6732d0b83f3a87:/src/rtapi/xenomai_kernel_rtapi.c#l657


whew, I think I covered it. Is this still comprehensible ;-?

best regards,

Michael


Am 03.11.2012 um 10:37 schrieb Gilles Chanteperdrix:

>=20
> Michael Haberler wrote:
>> I'm porting the LinuxCNC realtime support to Xenomai, and that has =
its own
>> latency-test program.
>>=20
>> I observe:
>> - the xenomai latency test is generally acceptable
>> - with the LinuxCNC latency-test program I see occasional spikes up =
to
>> maybe 80-100uS
>>=20
>>=20
>> the only difference in the code I could discern is:
>>=20
>> the xenomai src/testsuite/latency/latency.c code uses rt_timer_tsc() =
to
>> read the timestamp
>> my port currently uses rt_timer_read()
>>=20
>> the question is:
>>=20
>> a) did I commit a blunder and should just change rt_timer_read() to =
use
>> rt_timer_tsc() and all be fine, because that could be the explanation =
for
>> the spike
>=20
> Using rt_timer_read() instead of rt_timer_tsc() is probably not the =
cause
> for the spike. The difference between rt_timer_read() and =
rt_timer_tsc() is
> that on most platforms, rt_timer_tsc() is implemented without a system
> call, so the measured latencies is closer to reality (and smaller).
>=20
>> b) should I look elsewhere for the cause?
>=20
> Yes. Two things you can do:
> - show us the code of your latency test so that we can have a look at =
it
> for obvious mistakes
> - enable the I-pipe tracer in the kernel configuration and trigger a =
trace
> freeze (like latency -f option) when you hit the spike.
>=20
> http://www.xenomai.org/index.php/I-pipe:Tracer
>=20
> Also note that if LinuxCNC code runs in kernel-space, you should not =
be
> using the native API, but the RTDM API.
>=20
> --=20
>                    Gilles.
>=20


