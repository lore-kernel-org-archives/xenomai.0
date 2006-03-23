From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] Hard real-time and C++
Date: Thu, 23 Mar 2006 14:04:29 -0300
References: <20060322203422.2866.qmail@domain.hid>
	<Pine.LNX.4.63.0603230852070.18530@domain.hid>
In-Reply-To: <Pine.LNX.4.63.0603230852070.18530@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603231404.30513.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

Em Quinta 23 Mar=3DE7o 2006 04:55, Klaas Gadeyne escreveu:

>> I'm willing to develop a framework for helping people to program mobile
>> robots for doing hard real-time tasks. Assuming most of them will have a
>> limitated knowledge both to RTOS and programming, I would like to keep it
>> simple to use.
>
>Do you know <http://www.orocos.org>?

Yes, I didn't like the idea of using RT-CORBA. But I won't discuss this top=
=3D
ic=3D20
here neither. At least in the moment since I'm very worried about my=3D20
deadline...

>> Please, if someone could list me a list of disadvantages of C++ use on
>> hard real-time systems, requiring object oriented approach, I would be
>> very glad to read it. Better yet if it comes with the possible solutions
>> to each problem or pointing out that there is no solution at all.
>
><http://people.mech.kuleuven.be/~psoetens/orocos/doc/orocos-faq.html#id245=
=3D
1300>

Thank you very much, specially for the technical report. BTW, in section=3D=
20
4.2.2.2 (Dynamic Memory Allocation), what the IS-5.3.4 means? Where do I fi=
=3D
nd=3D20
it? And the other references too...

>ps.  There's experimental (i.e. untested) xenomai support in the latest
>orocos release.

How is dynamic memory management done in OROCO's classes? Do you override a=
=3D
ll=3D20
new() methods?

Thanks,

Best Regards,

Rodrigo.

	=09
_______________________________________________________=20
Novo Yahoo! Messenger com voz: Instale agora e fa=E7a liga=E7=F5es de gra=
=E7a.=20
http://br.messenger.yahoo.com/


