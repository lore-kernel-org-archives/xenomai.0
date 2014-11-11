Message-ID: <5461FD66.4000703@selex-es.com>
Date: Tue, 11 Nov 2014 13:13:26 +0100
From: Pampolini Matteo <matteo.pampolini@selex-es.com>
MIME-Version: 1.0
References: <545A2CC1.3080909@selex-es.com>
 <4044_1415212954_545A6F9A_4044_2177_1_20141105184232.GA24737@sisyphus.hd.free.fr>
In-Reply-To: <4044_1415212954_545A6F9A_4044_2177_1_20141105184232.GA24737@sisyphus.hd.free.fr>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] An explanation on cyclictest results and other...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,

many thanks for your reply and sorry for the delay of mine.

I had a look at the page you pointed me at and now things are more clear
to me,
though I still have to study...

And what about SMP support (my first question), is it supported for
PowerPC 32
in the version I'm using?

Regards, Matteo

On 05/11/2014 19:42, Gilles Chanteperdrix wrote:
> On Wed, Nov 05, 2014 at 02:57:21PM +0100, Pampolini Matteo wrote:
>> 2) Before realizing that Xenomai provides its own enhanced version of cy=
clictest (sigh!) I took
>> the one from rt-tests package and recompiled it by using Xenomai POSIX s=
kin. In my understanding
>> they should give similar results, but while I get an average latency of =
1 with the Xenomai provided
>> one, I get 16 with the latter one! What am I doing wrong?
> You are making the assumption, that recompiling an application to
> use xenomai posix skin will magically get it working in primary mode
> on Xenomai co-kernel. This assumption is generally wrong, see:
>
> http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-ke=
rnel/
>

This email and any attachments are confidential to the intended recipient a=
nd may also be privileged. If you are not the intended recipient please del=
ete it from your system and notify the sender. You should not copy it or us=
e it for any purpose nor disclose or distribute its contents to any other p=
erson.
Questa e-mail e tutti i suoi allegati sono da intendersi inviati in via ris=
ervata all'effettivo destinatario e possono essere soggetti a restrizioni l=
egali. Se non siete l'effettivo destinatario o avete ricevuto il messaggio =
per errore siete pregati di cancellarlo dal vostro sistema e di avvisare il=
 mittente. E' vietata la duplicazione, l'uso a qualsiasi titolo, la divulga=
zione o la distribuzione dei contenuti di questa e-mail a qualunque altro s=
oggetto.

Prima di stampare questa comunicazione consideratene, per favore, l'impatto=
 ambientale
Please consider the environment before printing this email

