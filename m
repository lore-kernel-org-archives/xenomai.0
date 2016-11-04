References: <CAPdz0-x=sQMY-0DKYQX+PXjXM0br6eGm=Kyo_CrBPtwJndGfnA@mail.gmail.com>
 <20161104144806.GP1465@csclub.uwaterloo.ca>
From: =?UTF-8?Q?St=c3=a9phane_LOS?= <slos@hilscher.com>
Message-ID: <2ef2ba48-8598-eac0-b605-4372b39dd23e@hilscher.com>
Date: Fri, 4 Nov 2016 15:57:43 +0100
MIME-Version: 1.0
In-Reply-To: <20161104144806.GP1465@csclub.uwaterloo.ca>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Writing into files without mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, "Florian G." <florian.r.groeger@gmail.com>
Cc: xenomai@xenomai.org

You could have a Linux process writing in your file data coming from=20
your RT process through IPC RT communication.

Best Regards,
Cordialement,

St=E9phane LOS
slos@hilscher.com
Support technique

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hilscher France
12, rue du 35=E8me R=E9giment d'Aviation
Miniparc du Ch=EAne
69500 BRON
France
T=E9l. : +33 (0) 4 72 37 98 40
Fax  : +33 (0) 4 78 26 83 27
http ://www.hilscher.fr
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Le 04/11/2016 =E0 15:48, Lennart Sorensen a =E9crit :
> On Fri, Nov 04, 2016 at 12:55:01AM +0100, Florian G. wrote:
>> I'm using Xenomai 2.6.5 on a 3.8.13 kernel on an ARM 32-bit(BeagleBone
>> Black).
>> Right now we need a way to write into files without getting a mode switc=
h.
>> I tried to use the rtdk.h header, but it won't work.
>> rt_printf works perfectly fine, but I am not able to write something in a
>> file. The code is compiled with gcc and the xenomai flags of the native
>> skin.
>>
>> What do I do wrong?
>> Do I have to set an additional flag? Open the file in a different way?
>> Is there another way to achieve writing into a file without mode switch
>> and without writing my own RTDM?
> Well filesystems are managed by linux, disk response time is not
> predictable, so really, I don't see how you could do file access from
> realtime.
>
> I could be wrong, but I just don't see it.
>




Hilscher France S.a.r.l.   |  12, rue du 35i=E8me R=E9giment d=92Aviation =
=96 Miniparc du Ch=EAne  |  69500 Bron  |  France  |  www.hilscher.com
Hot Line: +33 (0) 472 379 843  |  Centre de formation agr=E9=E9  |  RandD: =
+33 (0) 472 379 840
N=B0 de TVA intracommunautaire: FR 43 449 481 779  |  N=B0 de SIRET: 449 48=
1 779 00014
Dirigeant: Christophe Levra

Important Information:
This e-mail message including its attachments contains confidential and leg=
ally protected information solely intended for the addressee. If you are no=
t the intended addressee of this message, please contact the addresser imme=
diately and delete this message including its attachments. The unauthorized=
 dissemination, copying and change of this e-mail are strictly forbidden. T=
he addresser shall not be liable for the content of such changed e-mails.

Hilscher cannot be held responsible of whatever nature, resulting from alte=
ration, falsifying or using of the information contained in this message an=
d disclaims all liability in case of contamination of the computer hardware=
 of the addressee resulting from the distribution of a virus or other compu=
ting infections.


Information Importante:
Ce message =E9lectronique incluant les pi=E8ces jointes contient des inform=
ations confidentielles et prot=E9g=E9es par la loi qui sont =E0 l=92intenti=
on exclusive de son destinataire. Si vous n'=EAtes pas le destinataire  de =
ce message, merci de contactez imm=E9diatement l'exp=E9diteur et de supprim=
er ce message incluant les pi=E8ces jointes. Toute diffusion ou copie ou mo=
dification de ce message =E9lectronique, totale ou partielle, non autoris=
=E9e est strictement interdit. L'exp=E9diteur ne peut =EAtre tenu responsab=
le du contenu de tels messages =E9lectroniques qui auraient =E9t=E9 modifie=
s.

Hilscher ne pourra =EAtre tenue responsable de quelque dommage, de quelque =
nature qu=92il soit, r=E9sultant de l=92alt=E9ration, de la falsification o=
u de l=92utilisation des informations contenues dans ce message et d=E9clin=
e toute responsabilit=E9 en cas de contamination des mat=E9riels informatiq=
ues du destinataire r=E9sultant de la propagation d'un virus ou autres infe=
ctions informatiques.



