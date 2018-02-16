MIME-Version: 1.0
In-Reply-To: <b64eb377-5c88-a933-b7b6-a7ad3c194e30@iit.it>
References: <b64eb377-5c88-a933-b7b6-a7ad3c194e30@iit.it>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 16 Feb 2018 11:41:02 -0500
Message-ID: <CALLqZ8TPGMLN=rq3a3zAiRPBQZw710Ec4FHpeKHeOFFpnhiVMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Nvidia TX1/TX2 Boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alessio margan <alessio.margan@iit.it>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

    As far as I know there is no Ipipe patch for L4T so you'd have to
use mainline Linux if you'd like to run Xenomai on the TX1 or TX2.
I'm not sure what tools this would leave you with for the GPU but I
don't think Cuda works with the nouveau drivers.
    The other issue that I've seen on x86 boards with Nvidia gpus is
it's unknown how long the Nvidia driver turn interrupts off for, so
latency may be affected.  I don't think there are plans to port the
ipipe to L4T but if you would like to try I'm sure people here would
be willing to answer questions.

-Greg

On Fri, Feb 16, 2018 at 10:10 AM, alessio margan <alessio.margan@iit.it> wr=
ote:
> Hi all,
>
> does anybody have successfully run Xenomai-3+RTnet on NVIDIA Jetson TX1/T=
X2
> compute modules ?
>
> this is a TX1 lscpu output
>
> nvidia@tegra-ubuntu:~$ lscpu
>
> Architecture:          aarch64
> Byte Order:            Little Endian
> CPU(s):                4
> On-line CPU(s) list:   0-3
> Thread(s) per core:    1
> Core(s) per socket:    4
> Socket(s):             1
> Model name:            ARMv8 Processor rev 1 (v8l)
> CPU max MHz:           1734.0000
> CPU min MHz:           102.0000
> Hypervisor vendor:     (null)
> Virtualization type:   full
> L1d cache:             32K
> L1i cache:             48K
> L2 cache:              2048K
>
> TIA
>
> Alessio
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
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

