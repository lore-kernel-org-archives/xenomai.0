Message-ID: <545A2CC1.3080909@selex-es.com>
Date: Wed, 5 Nov 2014 14:57:21 +0100
From: Pampolini Matteo <matteo.pampolini@selex-es.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] An explanation on cyclictest results and other...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello there,

my name is Matteo, I'm writing from Italy and I am a newbie in Xenomai, but=
 I'm really enjoying
playing with it, it seems to be a great piece of software, my congratulatio=
ns to all the developers!

Currently I'm working on a Freescale QorIQ P2020 evaluation board, with Lin=
ux kernel 3.8.13 and
Xenomai 2.6.4. I have to questions for you:

1) If I do not disable SMP support kernel crashes at boot, any ideas for th=
is?

2) Before realizing that Xenomai provides its own enhanced version of cycli=
ctest (sigh!) I took
the one from rt-tests package and recompiled it by using Xenomai POSIX skin=
. In my understanding
they should give similar results, but while I get an average latency of 1 w=
ith the Xenomai provided
one, I get 16 with the latter one! What am I doing wrong?

Many thanks in advance for your kind help,

Matteo
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
