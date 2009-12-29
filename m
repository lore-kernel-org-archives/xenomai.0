Message-ID: <4B3A30AA.5040103@domain.hid>
Date: Tue, 29 Dec 2009 17:39:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B3A12B8.9030902@domain.hid>
	<4B379DFC.6000800@domain.hid>	<27218735.319731261932640576.JavaMail.coremail@domain.hid>	<27741962.171501262064832984.JavaMail.coremail@domain.hid>
	<32053907.426821262104373569.JavaMail.coremail@domain.hid>
In-Reply-To: <32053907.426821262104373569.JavaMail.coremail@domain.hid>
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
> =E5=9C=A82009-12-29=EF=BC=8C"Gilles Chanteperdrix" <gilles.chanteperdri=
x@domain.hid> =E5=86=99=E9=81=93=EF=BC=9A
>>robert165 wrote:
>>>=20
>>>=20
>>>=20
>>> =E5=9C=A82009-12-28=EF=BC=8C"Gilles Chanteperdrix" <gilles.chanteperd=
rix@domain.hid> =E5=86=99=E9=81=93=EF=BC=9A
>>>>robert165 wrote:
>>>>> Hi,
>>>>> I have tested xenomai on my at91rm9200 board, I used
>>>>> xenomai 2.4.10 + linux-2.6.28 + adeos-ipipe-2.6.28-arm-1.12-05.patc=
h
>>>>> Test result seems very poor, is that correct?
>>>>
>>>>Your test results are rather good for an at91rm9200 board, which is t=
he
>>>>sure sign that you are not loading the system enough.
>>>>
>>>>As I already told, you, the expected results are:
>>>>- user-space latency of 260us without FCSE
>>>>- user-space latency of 200us with FCSE
>>>>- kernel-space latency of 50us if running with unlocked context switc=
hes
>>>>(an option which is only available in the upcoming 2.5 branch).
>>>>
>>>>> And is there any introduction of the tests, as their purper, their
>>>>> meanling...
>>>>
>>>>The latency test computes some latencies (either user-space schedulin=
g
>>>>latency, kernel-space scheduling latency, or kernel-space interrupt
>>>>latency, depending on the options). The switchtest tests context
>>>>switches. The switchbench measures context switching time. cyclictest=

>>>>does the same thing as the latency test (only, you need to run it wit=
h
>>>>the right options to avoid running in fact with Linux timer), and in
>>>>general return similar results. Here I do not know what is the meanin=
g
>>>>of cyclictest results you got, but if you want to know, I am afraid y=
ou
>>>>wil have to investigate, or simply ignore them.
>>>>
>>>=20
>>> Thanks for your introdution, and is there any document of it.=20
>>> The man pages just explain  parametres  of test scripts.  I could
>>> not understand the output of some test.
>>
>>No there is no document. But patches are welcome, as usual. As far as I=

>>can tell, I explained you what the tests do, there is not much more to
>>tell. Which test's output did you not understand?
>>
>=20
> when running: ./run -- -p 1000 -T 180 -t2 # latency
> result gave negative numbers like=20
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=
 worst
> RTD|      -3.739|      11.330|      39.530|       0|      -3.739|      =
39.530
> Is that means timer interrupts are not perfect, and may occur before or=
 after the exact moment.
> If so, the avg should calculate by the absolute value of the latency, a=
nd the best should be=20
> the least absolute value.

It is a matter of point of view. From our point of view, the timer
interrupt ticking in advance is a feature, it compensates a bit for the
latency. Anyway, if you do not like it, just
echo 0 > /proc/xenomai/latency

The timer interrupts happen at the time they are programmed, only it is
their handling which may be delayed, most probably due to interrupts
masking sections.

--=20
					    Gilles.


