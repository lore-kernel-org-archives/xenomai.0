References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <1b035acc-5784-f0b0-f16f-09279d5a8845@siemens.com>
 <07716080-d5cd-2508-20cc-b679a72f6f68@xenomai.org>
From: =?UTF-8?Q?St=c3=a9phane_LOS?= <slos@hilscher.com>
Message-ID: <dfe038bb-e379-bc90-5cf7-ecddce9ed887@hilscher.com>
Date: Fri, 24 Nov 2017 09:52:35 +0100
MIME-Version: 1.0
In-Reply-To: <07716080-d5cd-2508-20cc-b679a72f6f68@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Subject: Re: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: Daniel Wagner <daniel.wagner@siemens.com>

Hi,

Wouldn't integrating both projects make sense ?

It seems both share a significant amount of work and similar lack of=20
resources.

Best Regards,
Cordialement,

St=C3=A9phane LOS
slos@hilscher.com
Support technique

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hilscher France
12, rue du 35=C3=A8me R=C3=A9giment d'Aviation
Miniparc du Ch=C3=AAne
69500 BRON
France
T=C3=A9l. : +33 (0) 4 72 37 98 40
Fax  : +33 (0) 4 78 26 83 27
http ://www.hilscher.fr
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Le 23/11/2017 =C3=A0 21:45, Philippe Gerum a =C3=A9crit=C2=A0:
> On 11/22/2017 09:26 PM, Jan Kiszka wrote:
>> On 2017-11-21 18:11, Philippe Gerum wrote:
>>> So, let's talk about the elephant in the room: the current situation of
>>> the Xenomai project is not viable in the long run. I can only encourage
>>> people who feel concerned about it to discuss openly the practical step=
s
>>> to best address this challenge.
>> Thanks for bringing this frankly on the table! For those who follow the
>> project, it's likely no news. So we were working on this issue also
>> internally, with users of Xenomai inside Siemens. And we have the
>> backing to enhance our involvement in upstream work. Right now we are
>> working on making this concrete.
>>
>> There are many areas where contributions can be beneficial for the
>> project and its community, and many do not require deepest understanding
>> of the core, like around CI, test automation, distro packaging,
>> documentation, or user support. But some essential elements in my eyes a=
re
>>
>>   - building up a core team of kernel maintainers for Cobalt
>>
>>   - offloading work from the shoulders of our extremely valuable
>>     maintainer
>>
>> The second part will be achieved to a certain degree by the first one as
>> Philippe can probably confirm.
> Yes, extending "Cobalt" to the pipeline. A significant portion of the
> overall maintenance involves the I-pipe. Hence the work on rethinking
> how the interrupt pipeline is integrated into the Linux kernel, how we
> can make the former a regular feature of the latter instead of an
> add-on, with the goal of simplifying the maintenance, but also making
> the whole thing way more natural, easier to grasp.
>



Hilscher France S.a.r.l.   |  12, rue du 35i=C3=A8me R=C3=A9giment d=E2=80=
=99Aviation =E2=80=93 Miniparc du Ch=C3=AAne  |  69500 Bron  |  France  |  =
www.hilscher.com=0A=
Hot Line: +33 (0) 472 379 843  |  Centre de formation agr=C3=A9=C3=A9  |  R=
andD: +33 (0) 472 379 840=0A=
N=C2=B0 de TVA intracommunautaire: FR 43 449 481 779  |  N=C2=B0 de SIRET: =
449 481 779 00014=0A=
Dirigeant: Christophe Levra=0A=
=0A=
Important Information:=0A=
This e-mail message including its attachments contains confidential and leg=
ally protected information solely intended for the addressee. If you are no=
t the intended addressee of this message, please contact the addresser imme=
diately and delete this message including its attachments. The unauthorized=
 dissemination, copying and change of this e-mail are strictly forbidden. T=
he addresser shall not be liable for the content of such changed e-mails.=
=0A=
=0A=
Hilscher cannot be held responsible of whatever nature, resulting from alte=
ration, falsifying or using of the information contained in this message an=
d disclaims all liability in case of contamination of the computer hardware=
 of the addressee resulting from the distribution of a virus or other compu=
ting infections.=0A=
=0A=
=0A=
Information Importante:=0A=
Ce message =C3=A9lectronique incluant les pi=C3=A8ces jointes contient des =
informations confidentielles et prot=C3=A9g=C3=A9es par la loi qui sont =C3=
=A0 l=E2=80=99intention exclusive de son destinataire. Si vous n'=C3=AAtes =
pas le destinataire  de ce message, merci de contactez imm=C3=A9diatement l=
'exp=C3=A9diteur et de supprimer ce message incluant les pi=C3=A8ces jointe=
s. Toute diffusion ou copie ou modification de ce message =C3=A9lectronique=
, totale ou partielle, non autoris=C3=A9e est strictement interdit. L'exp=
=C3=A9diteur ne peut =C3=AAtre tenu responsable du contenu de tels messages=
 =C3=A9lectroniques qui auraient =C3=A9t=C3=A9 modifies.=0A=
=0A=
Hilscher ne pourra =C3=AAtre tenue responsable de quelque dommage, de quelq=
ue nature qu=E2=80=99il soit, r=C3=A9sultant de l=E2=80=99alt=C3=A9ration, =
de la falsification ou de l=E2=80=99utilisation des informations contenues =
dans ce message et d=C3=A9cline toute responsabilit=C3=A9 en cas de contami=
nation des mat=C3=A9riels informatiques du destinataire r=C3=A9sultant de l=
a propagation d'un virus ou autres infections informatiques.=0A=



