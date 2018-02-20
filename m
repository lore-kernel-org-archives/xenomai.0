MIME-Version: 1.0
In-Reply-To: <6a753ece-74f3-4236-3172-057eb6862a0d@iit.it>
References: <5a8c1128.0721240a.9bf50.bc31@mx.google.com>
 <6a753ece-74f3-4236-3172-057eb6862a0d@iit.it>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 20 Feb 2018 10:59:09 -0500
Message-ID: <CALLqZ8RiW8A=ik0vVCvMWxt5d=_FbjSfFYavnES0xzyF-qOkZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [was Nvidia TX1/TX2 Boards] rpi rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alessio margan <alessio.margan@iit.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I've seen a couple of RTnet drivers for the beaglebone black.  Let me
see if I can find them and I'll post back here.  I pinged the author
about upstreaming them but never heard back.  I'll look into the RPI
RTNet this week and hopefully have some more info for you on the
weekend.

-Greg

On Tue, Feb 20, 2018 at 9:14 AM, alessio margan <alessio.margan@iit.it> wro=
te:
> Hi,
>
>
> On 20/02/2018 13:14, Greg Gallagher wrote:
>>
>> Hi,
>>     The RPI images I've been working on are close to being ready to shar=
e.
>> I have a couple bcm2835 issues I'm working through. I haven't made my wa=
y to
>> the RTNET drivers yet. Are you looking to evaluate RTNET on an arm based
>> board?
>
> yes
> we use xenomai3+rtnet for our robotics platform based on ethercat (raw
> socket, no tcp/udp ) but for some application we use also tcp and udp.
> At the moment we use COM-express form factor boards with x86_64 arch with
> intel network chip that works with fine with rtnet.
>
> Alessio
>
>
> --
>
> ISTITUTO ITALIANO DI TECNOLOGIA
>
> Alessio Margan
> Chief Technician
> Advanced Robotics Department
>
> alessio.margan@iit.it
> Via Morego 30, 16163 Genova
> Tel. +39 010 71781-754
>
> www.iit.it
>
> Legal Disclaimer
> This electronic message contains information that is confidential. The
> information is intended for the use of the addressee only.
> If you are not the addressee we would appreciate your notification in thi=
s
> respect.
> Please note that any disclosure, copy, distribution or use of the content=
s
> of this message is prohibited and may be unlawful.
> We have taken every reasonable precaution to ensure that any kind of
> attachment to this e-mail has been swept for viruses.
> However, we cannot accept liability for any damage sustained as a result =
of
> software viruses
> and would advise you to carry out your own virus checks before opening an=
y
> attachment.
> Avvertenza legale
> Questo messaggio Email contiene informazioni confidenziali riservate ai s=
oli
> destinatari.
> Qualora  veniate in possesso di tali informazioni senza essere definito c=
ome
> destinatario vi reghiamo di leggere le seguenti note.
> Ogni apertura, copia, distribuzione del contenuto del messaggio e dei suo=
i
> allegati =C3=A8 proibito e potrebbe violare le presenti leggi.
> Abbiamo attivato ogni possibile e ragionevole precauzione per assicurare =
che
> gli allegati non contengano virus.
> Comunque non assumeremo alcuna responsabilit=C3=A0 per ogni eventuale dan=
no
> causato da virus software e simili
> in quanto =C3=A8 onere del destinatario verificarne l=E2=80=99assenza in =
ogni allegato
> attuando propri indipendenti controlli.
>

