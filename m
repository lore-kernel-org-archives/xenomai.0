Message-ID: <BLU0-SMTP278EEBC31356A65C16755F1AF030@phx.gbl>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
From: Chiara <chiaracapretti@hotmail.it>
In-Reply-To: <52650713.3060807@xenomai.org>
Date: Wed, 23 Oct 2013 23:42:51 +0200
Content-Transfer-Encoding: quoted-printable
References: <BLU0-SMTP361A4801D1D3A47014E894BAF010@phx.gbl>,
 <5264FD93.2070705@xenomai.org>
 <DUB123-W36A18BFF7B209662EE8979AF010@phx.gbl> <52650713.3060807@xenomai.org>
Subject: Re: [Xenomai] Help with the histogram of latency test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,
I tried latency test and xeno-test..
I would compare my histogram with yours but I think that our parameters =
are different..
In my histogram the scale of the user space latency arrives on 300 =
microseconds and the difference between the values is 50 microseconds, =
while your's 5..could you say me how can I reproduce the same histogram? =
So I can compare them!

Thank you very much!


Il giorno 21/ott/2013, alle ore 12:50, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> ha scritto:

> On 10/21/2013 12:38 PM, Chiara Capretti wrote:
>> I resolved..my problem's very stupid..I forget "sudo", so latency - g
>> can't produce any graph!
>=20
> Well, no, simply pass a path to latency to a directory where you have
> permission to write and it will be able to create the graph. /usr/bin =
is
> not really appropriate for that. Or run latency from there, not from
> /usr/bin.
>=20
>=20
>> Do anyone know where I can find some information about the result of
>> latency test? I need to compare them between different architecture,
>> but I haven't any parameters of reference.
>=20
> Starting from the I-pipe patch for 3.2, I have saved the latencies I =
get
> on my test platforms:
>=20
> http://www.xenomai.org/~gch/core-3.2-latencies/
> http://www.xenomai.org/~gch/core-3.4-latencies/
> http://www.xenomai.org/~gch/core-3.5-latencies/
> http://www.xenomai.org/~gch/core-3.8-latencies/
> http://www.xenomai.org/~gch/core-3.10-latencies/
>=20
> At the top of the page, you will find the parameters I use with=20
> xeno-test. To get meaningful result, you need to generate some load on=20=

> the target, see xeno-test and dohell documentation:
> =
http://www.xenomai.org/documentation/xenomai-2.6/html/xeno-test/index.html=

> =
http://www.xenomai.org/documentation/xenomai-2.6/html/dohell/index.html
> --=20
> 					    Gilles.
>=20


