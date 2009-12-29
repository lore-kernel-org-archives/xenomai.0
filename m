Message-ID: <4B3A12B8.9030902@domain.hid>
Date: Tue, 29 Dec 2009 15:31:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B379DFC.6000800@domain.hid>	<27218735.319731261932640576.JavaMail.coremail@domain.hid>
	<27741962.171501262064832984.JavaMail.coremail@domain.hid>
In-Reply-To: <27741962.171501262064832984.JavaMail.coremail@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] test result on at91rm9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: robert165 <robert165@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

robert165 wrote:
>=20
>=20
>=20
> =E5=9C=A82009-12-28=EF=BC=8C"Gilles Chanteperdrix" <gilles.chanteperdri=
x@domain.hid> =E5=86=99=E9=81=93=EF=BC=9A
>>robert165 wrote:
>>> Hi,
>>> I have tested xenomai on my at91rm9200 board, I used
>>> xenomai 2.4.10 + linux-2.6.28 + adeos-ipipe-2.6.28-arm-1.12-05.patch
>>> Test result seems very poor, is that correct?
>>
>>Your test results are rather good for an at91rm9200 board, which is the=

>>sure sign that you are not loading the system enough.
>>
>>As I already told, you, the expected results are:
>>- user-space latency of 260us without FCSE
>>- user-space latency of 200us with FCSE
>>- kernel-space latency of 50us if running with unlocked context switche=
s
>>(an option which is only available in the upcoming 2.5 branch).
>>
>>> And is there any introduction of the tests, as their purper, their
>>> meanling...
>>
>>The latency test computes some latencies (either user-space scheduling
>>latency, kernel-space scheduling latency, or kernel-space interrupt
>>latency, depending on the options). The switchtest tests context
>>switches. The switchbench measures context switching time. cyclictest
>>does the same thing as the latency test (only, you need to run it with
>>the right options to avoid running in fact with Linux timer), and in
>>general return similar results. Here I do not know what is the meaning
>>of cyclictest results you got, but if you want to know, I am afraid you=

>>wil have to investigate, or simply ignore them.
>>
>=20
> Thanks for your introdution, and is there any document of it.=20
> The man pages just explain  parametres  of test scripts.  I could
> not understand the output of some test.

No there is no document. But patches are welcome, as usual. As far as I
can tell, I explained you what the tests do, there is not much more to
tell. Which test's output did you not understand?

>=20
>>>=20
>>> Test is under loads as followed,
>>>     dd if=3D/dev/zero of=3D/dev/null > /dev/null &
>>>     ping 172.18.23.10 > /dev/null &
>>>     while ls; do ls; done > /dev/null &
>>
>>This load is laughable. Do you find that they really stress the system,=

>>that they make it really unresponsive? Do you really expect a test whic=
h
>>sends one packet every second over network to stress the system in some=

>>way? That is what I meant when I said hammering the system real hard.
>=20
> The reason I procuce the load is:=20
> https://mail.gna.org/public/xenomai-help/2008-01/msg00023.html
> How can I produce a real hard load. Are there any direction about it.

The mail you are refering to is using ping -f, not ping, and talks about
stressing cache by running the cache calibrator. The way we do our tests
evolved a bit since then. We use netcat instead of ping -f, and the
hackbench test to stress the linux scheduler. That is when FCSE is
enabled in guaranteed mode. Without FCSE, we use ltp (the linux testing
project) and netcat.

--=20
					    Gilles.


