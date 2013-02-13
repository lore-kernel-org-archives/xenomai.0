Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <511B7ED3.8060106@xenomai.org>
Date: Wed, 13 Feb 2013 15:35:40 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBF3A505-DBCB-492B-B788-2127A053DAF1@mah.priv.at>
References: <DC570CF5-F540-40FB-B313-596AF53EDDA2@mah.priv.at>
	<F43474DF-1ADA-4463-AF44-2B498EF3024E@mah.priv.at>
	<511B7ED3.8060106@xenomai.org>
Subject: Re: [Xenomai] puzzled: running switchtest improves latency figures
	permanently
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Schooner <schooner30@tiscali.co.uk>, sam sokolik <samco@empirescreen.com>, John Morris <john@zultron.com>, xenomai@xenomai.org

Henri, Jan, Gilles=20

thanks for the quick and profound answers

results are just coming in from 'the field' (the problem cases are in =
the colonies and the folks over there are still working their coffee =
mugs ;-)

Am 13.02.2013 um 12:53 schrieb Gilles Chanteperdrix:

> Do you get the same results with Xenomai latency test?

yes, it is reproducible

this is for boot option "nohlt idle=3Dpoll" added: =
http://imagebin.org/246556
(here for the linuxcnc latency test:http://imagebin.org/246546)

this is without that option: http://imagebin.org/246550 - notice sudden =
230uS spike

so I that takes the linuxcnc latency test out of the equation

>> Any suggestions?
>=20
>=20
> You have an issue with the idle loop. The three cases you mention =
cause
> the Linux kernel never to use the idle loop:
> - switchtest run with the -s argument as a (non real-time) loop
> occupying 100% of the CPU.
> - the shell loop does the same
> - running dohell does the same.

That makes sense.

Are there any specific knobs you'd suggest twisting?

--

thanks a lot! we already have a workaround based on Henri's suggestion; =
everything else is sugar on the cake

- Michael


