Message-ID: <4B065600.6060109@domain.hid>
Date: Fri, 20 Nov 2009 09:40:32 +0100
From: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
MIME-Version: 1.0
References: <4B0413DC.6090603@domain.hid>
	<72cf3fb0911180935l49de171cr8f77d32921be124d@domain.hid>
In-Reply-To: <72cf3fb0911180935l49de171cr8f77d32921be124d@domain.hid>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Analogy Sensoray s526
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Alexis Berlemont wrote:
> Hi,
>
> On Wed, Nov 18, 2009 at 4:33 PM, Alessio Margan @ IIT
> <alessio.margan@domain.hid> wrote:
>  =20
>> Hi,
>> I'm new to Xenomai and I am a bit confused about the status of Analogy.
>>    =20
>
> You can follow this thread:
> https://mail.gna.org/public/xenomai-help/2009-11/msg00083.html
>
> I am aware that documentation is lacking, I am trying to fix that point.
>
>  =20
>> One project in our lab
>> http://www.iit.it/en/advanced-robotics/projects/hydraulically-actuated-q=
uadruped-hyq.html
>> needs real time capabilities and due to hw configuration (pc104 cpu
>> board + 1 to 5 s526 Sensory boards) we choose RTAI+COMEDI.
>> We would like to switch to Xenomai, the Sensory s526 board will be
>> supported ?
>> With Xenomai-abe tree could I use the comedi kernel module for s526 ?
>>    =20
>
> We plan to add, in analogy, a compatibility layer with comedi. That is
> not available yet. So, you cannot use the comedi kernel module s526 in
> a real-time context.
>
> However, if you like kernel programming, the comedi -> analogy port is
> quite easy to perform.
>
> The last solution: I can add the port in my TODO list. In such a case,
> I just have one request:
> - Are you OK with testing and validating the analogy driver on your
> system (I do not own this card)?
>
> Alexis.
>  =20
Hi,
It would be great if you could add the port to your TODO list, of course
we test and validate the driver on our system, and any other
requirements need for the port.
In the mean time I start get practice with xenomai and RTDM (any
suggestion or pointer to speed up it ...) , we should have also support
from Jonas Buchli and Peter Pastor from USC
because the final goal is to run ouyr SL system based on Xenomai.

Thanks
Alessio


--=20

ISTITUTO ITALIANO
DI TECNOLOGIA

Alessio Margan
/Senior Technician/
mail me <mailto:alessio.margan@domain.hid>

Via Morego, 30 16163 Genova
<http://maps.google.com/maps?f=3Dq&hl=3Den&geocode=3D&q=3Dvia+morego,+30+ge=
nova&sll=3D37.0625,-95.677068&sspn=3D85.420533,191.601563&ie=3DUTF8&ll=3D44=
.474913,8.907037&spn=3D0.004685,0.011652&t=3Dh&z=3D17&iwloc=3Daddr>

www.iit.it <http://www.iit.it>

*Legal Disclaimer*
This electronic message contains information that is confidential. The
information is intended for the use of the addressee only. If you are
not the addressee we would appreciate your notification in this respect.
Please note that any disclosure, copy, distribution or use of the
contents of this message is prohibited and may be unlawful. We have
taken every reasonable precaution to ensure that any kind of attachment
to this e-mail has been swept for viruses. However, we cannot accept
liability for any damage sustained as a result of software viruses and
would advise you to carry out your own virus checks before opening any
attachment.
*Avvertenza legale*
Questo messaggio Email contiene informazioni confidenziali riservate ai
soli destinatari. Qualora veniate in possesso di tali informazioni senza
essere definito come destinatario vi reghiamo di leggere le seguenti
note. Ogni apertura, copia, distribuzione del contenuto del messaggio e
dei suoi allegati =E8 proibito e potrebbe violare le presenti leggi.
Abbiamo attivato ogni possibile e ragionevole precauzione per assicurare
che gli allegati non contengano virus. Comunque non assumeremo alcuna
responsabilit=E0 per ogni eventuale danno causato da virus software e
simili in quanto =E8 onere del destinatario verificarne l=92assenza in ogni
allegato attuando propri indipendenti controlli.



