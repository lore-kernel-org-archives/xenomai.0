Message-ID: <8592118.1163777339046.JavaMail.ngmail@domain.hid>
Date: Fri, 17 Nov 2006 16:28:59 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Re: Re: What happens if task entry function
	returns?
In-Reply-To: <455DCE75.1080300@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_23051_21822536.1163777339045"
References: <455DCE75.1080300@domain.hid>
	<455DC001.2040001@domain.hid>	<434646.1163765689576.JavaMail.ngmail@domain.hid>
	<16178634.1163773048304.JavaMail.ngmail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

------=_Part_23051_21822536.1163777339045
Content-Type: multipart/alternative; 
	boundary="----=_Part_23050_19572554.1163777339045"

------=_Part_23050_19572554.1163777339045
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jan!

I have modified my test to use a sleep(1) at the end of the task functions.
I have enclosed the strace logs to this mail.
The file strace.tls is the one that uses the /lib/tls/... libraries.
The file strace is the one that uses the /lib/... libraries.

I hope that helps...
BTW: I have updated to the latest SVN version of Xenomai (kernel is 2.6.17.=
7) - the same effect here.

Thanks for the feedback!

Regards

Mathias

> > First, I give you some more information about the error.
> > The output is the following:
> > Hi, I am task A Hello
> > Hi, I am task B World
> > Main waits for A
> > This is the end of A
> > Main waits for B
> >=20
> > Then the system hangs.
>=20
> You mean completely? Or just that application? Please enable the Xenomai
> watchdog to see if we have a run-away RT thread in that case.
Only the application hangs!

>=20
> >=20
> > I have done two tests to verify if there is an SMP issue.
> > First, I have set all CPUs in use with the application to CPU 0.
> > There was no change. However, I am able to stop the application with
> CTRL-C
> > and everything is cleaned up fine.
> >=20
> > Then, I have modified the BIOS settings of the PC to disable
> Hyperthreading.
>=20
> [Which is recommended anyway to keep latencies bounded - HT is evil for
> RT!]
>=20
> > Again, no change. The same effect as with the test before.
> >=20
> > The strange thing here is, when I use the original test (main on CPU 0,=
 rt
> tasks on CPU 1)
> > on a SMP machine, I am not able to terminate the application with CTRL-=
C.
> > I have to reboot the PC.
> >=20
> > That means, there seems to be a relation to SMP...
>=20
> Probably in so far that the symptom changes. But !SMP doesn't make it go
> away.
>=20
> >=20
> > Another thing I have detected:
> > When I modify the program to replace the final rt_task_delete by
> > a sleep(1) call everything runs perfectly again.
>=20
> Ok, could you try on a non-hanging setup to grab what is happening via
> strace?


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2
------=_Part_23050_19572554.1163777339045--

------=_Part_23051_21822536.1163777339045
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=strace.tgz

H4sIAK/TXUUAA+1abVPiyhL2M79irp/CFmomCXmxynsPR+ORWgQLcHct2UqFZNCUkFBJcPHqnt9+
eibhJbwpgq737rTrEiYz0z3dz/R08hjFoe2QnTcVEURVFPYJwj7x+DuWsVrcwWJR0uQiLsp4R8QY
F7UdJL6tWYkMotgOEdoJgyBe3Y+E0XsY9L5ChsS5J8Lu/kFv0I292I7uot0Cus42fIeWg09IktG9
HUbo08H3PDpCYm7g2z0iPEYP0dFuxfMHQxjqBy452g3jvgNf9vf3f+YR69sO7wQRrp8T6DvURcUG
aORsxyFRJOwekNg56Lr7UbDvB7c/HLsPc59atc/50Zg9jMxqzaw2kVANUDRwblHH6xIUhMj1QuLE
QfiQz/V6dl8SqpeVSgHp2JAK6KJea1p1s3TyxK6+1stNs4DOSxfWRb38pdQ0n+h1qVqrXp3XLhsF
UFRAIlv9sK11iLHEzH5IuoHtgpn19c0M+sTPzObYzi2BuWpW/aRWrVyN55NzHcBvrCqCXECPUWz1
qPcbVvm0bv71RHddAUFr5P2XHGFdUvEoJDQi095Ib47dkfFBAcmZRSt00U43iIggPxtRqmnbcUwd
NIjCgyHxg57tHXS9Nv317di7J1SBmPEXdVVIbJf6abeFNc2snLYw+xHnfuT0d3RPkuC7sgueK6Ai
luhs8LHa9VqxOHG9pCuSusz1kqRp6hwSzW/m8TwQT8zqVYrRTEhcQkOSzJrESIaGAlJEY37qJSA/
LX8zTxZpGSqT0MsfJPRpuPvxLY3qfLw3DLgqllriegHP7DUda+LSvSbLkiHpG0Zcd2Yibtgs4uuk
teURd8d62LQZPQ7TI6ma/BpNS1Mpm/cDQcuh86nzSXdTaElis4U3yCUYK5omL80m6+z4pbHQ25Og
p+cDVGTKpqAlmjgDJh0nYNJVbQuoxXhqCXhWlc5UQaGpzC/j9bBl064F214/DGLAXNYDoqKLU2al
RVNv4MMKhMmxm57Us4peW2CxMfBNpQFfMTYZw3qtqScZE5HYSlK1ZcP/wiPx4/DB8ge9NgkPYXvu
/RsBbNt2RCzbdcPDxERIcgXU9XpefIjBQUWN7gNyY8lSmzYVkBP4MUwVHUI/NjutZ63A7z4cjkZa
nm/17RsS0f50sB/EFpRnEYyjnaCwt9tdcojTzXRD4r7nCi8IJTaKei6k2/LGdmIv8IVG+a9687xc
hU2c5DQFE1BxDfWz+LOA0sIz0TM/0MLjcbJDV37NJnvhYGkyuCiuVgoAdHpQ2NOR1p+V2vHnKV3P
9b+sTkZYePGAiWHfji8ux4ZpmrHMsF43cO7sblc4P65Yx5f1OiTrJ3p9etm8rJtTuXftCEVQO7sW
DLI7Hc/34geBNsNGoukMPSKMfuaT7kraN5rqK051BLvf7h+a4C9kwBXqlfJ5uWk1miXq7kfaajmD
8Ige8Z+wKEG9wdp69vCI9rXK1dNytdy8SmcaLxzg7gUhrIZ2FRrHZ+YJpLbT2vh8NIzNO3v+os44
1/f6RLiG/Kx8XxkxajGkUZ8Izq3XhSDEtnN3xPKA42qw1k7XvomOjiu1qml9OX9KLk4bo4tyxRxd
A+7OStWTfIIAI/cDLCSCwk7r9Bgujo7jScUHv3JL1uinlj3Kk9MaKwyr8LFoWzTM5nmp8XkE6/F2
SvE9ZQKU0C2pKLaUFp7okCSF6ZY1rQXPA/1/wZXKLJFY6zZsSEZEgwjqHFe4XhqOI/QfZNZNwF29
Wa1RTyKhGaA2gRRL35bExM3n9vb20CjdIeHSv/ODHz6C+X27i2Soa/4ASNNzAjrmoDkk8SD0n9m0
VLNAl4NgtpH9+Q8CZB70dw164jzIubvntuejH7YXR6gDFXup5UNVjrVJaLTfzy/zoBo/YPzBPu5b
UFKyO3/TRxSW4LBGH0aUeVgt9fWfC3z9nAEyaGZXAGcFAF5Ushl1hXbTd1HQQT0wIlEs5TMOgQel
Zdql6YRNrZCU+iibD+ECj3bZb72nILC0dKKn4mhxlvWVnZoznqbn5tTTBymS8QulOdXUJ2QIpfZN
GAz6qx8OwLLcr37pzWUsEeN/9uPuG3Ibz/A/WClO+B9JVin/o6kS53/eQzj/89vwPxKW6SPjEhIi
ufky/uejkACc/xnzP+4s/yO9Df8jfZDQ03DDoXXgqbp64PSC+5Vs0GbRV8SzdcmgTPR1A+rQZdHX
RCwqG0bfac9E3zW2yAWRCcqMWT3tBGVFdZuv1NmsHxZkC3ihTeFVW0AIbZ3TcdiJusafC0gKLupL
cQu3NVnflBAyZhFFScAtEkKSNln/LPfkaCkhJL8mRy73s7Y2IbTlUBODcVJZnmnk2MU80yv4GaZH
/QUETYYTS/7MgVUvizgxti7PZTbTDJGarYl6fqYvNmRjNZnjdBQnpS8aJfqOuVw9ra3D6sAE0mSC
9L3A03NzLSVf6PuCRRTM9giEdcr7VcSPS8n9LRA/i5gc2fiwTM5ab6Knk4BqqPLGzyZE19Zna1/P
CmeyTaI7k82q6SumZTQP3Zea4ryG50m/Nc+Yr9JbV40vDXM0umE2m5XRqIsSxRhrK4+6H5+VKyfW
ccWEHTluPDFh40CsCqgPSdFnmaQfhyNj2x0AUzZRLkiRWrv9nikSpmNunTM1IcOUX45KTZ1HC2tb
Fy26+j+EFl19EVqg2y9HCzM1RQtej4XpDGIyFKa3ByRx85v1tVRuFhj6kuQ/zY6tRTq8kCPIVAg6
f2/NhQsXLly4cOHChQsXLly4cOHChQsXLly4cOHChQsXLly4cPm/ln8AuilM0gBQAAA=
------=_Part_23051_21822536.1163777339045--


