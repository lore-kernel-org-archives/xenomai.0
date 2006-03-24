Date: Fri, 24 Mar 2006 15:59:07 +0100 (CET)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Subject: Re: [Xenomai-help] Hard real-time and C++
In-Reply-To: <200603231404.30513.lbocseg@domain.hid>
Message-ID: <Pine.LNX.4.63.0603241555380.22865@domain.hid>
References: <20060322203422.2866.qmail@domain.hid>
	<Pine.LNX.4.63.0603230852070.18530@domain.hid>
	<200603231404.30513.lbocseg@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-703928996-1143212347=:22865"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-703928996-1143212347=:22865
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 23 Mar 2006, Rodrigo Rosenfeld Rosas wrote:
> Em Quinta 23 Mar=E7o 2006 04:55, Klaas Gadeyne escreveu:
[...]
>> Do you know <http://www.orocos.org>?
>
> Yes, I didn't like the idea of using RT-CORBA. But I won't discuss this t=
opic
> here neither. At least in the moment since I'm very worried about my
> deadline...

<Off-topic>Orocos !=3D RT-CORBA</Off-topic>

>>> Please, if someone could list me a list of disadvantages of C++ use on
>>> hard real-time systems, requiring object oriented approach, I would be
>>> very glad to read it. Better yet if it comes with the possible solution=
s
>>> to each problem or pointing out that there is no solution at all.
>>
>> <http://people.mech.kuleuven.be/~psoetens/orocos/doc/orocos-faq.html#id2=
451300>
>
> Thank you very much, specially for the technical report. BTW, in section
> 4.2.2.2 (Dynamic Memory Allocation), what the IS-5.3.4 means? Where do I =
find
> it? And the other references too...

It refers to the C++ standard I guess.  I doubt it's on the web though.

> How is dynamic memory management done in OROCO's classes? Do you override=
 all
> new() methods?

Never.  Just don't allocate memory in the real-time parts of your
code.

Klaas
--8323328-703928996-1143212347=:22865--

