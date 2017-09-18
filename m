From: Aiolfi Mattia <mattia.aiolfi@bettinelli.it>
Date: Mon, 18 Sep 2017 14:59:23 +0000
Message-ID: <1505746763154.88541@bettinelli.it>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai Cobalt shared objects problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Good morning,

I am using Xenomai 3.0.4 with cobalt kernel. I am trying to allocate heap a=
nd I succeed in it, but when I try to bind to heap the function returns -11=
. This problem does occur only when executing  the bind function from a sou=
rce that is different from the source where I create the heap; if I use the=
 same source and allocate two threads the bind works. In Xenomai configurat=
ion we set the --enable-pshared flag.

Can you help me? Thank You

Mattia


[http://www.bettinellispa.eu/EDP/logoMailHCS.gif]

________________________

Mattia Aiolfi
Electronics Engineer
R&D

.

+39.0373.237411 Phone
+39.0373.237538 Fax

www.hcs-dpt.com<http://www.hcs-dpt.com/>

CONFIDENTIALITY NOTICE:
This message and its attachments are addressed solely to the persons above =
and may contain confidential information. If you have received the message =
in error, be informed that any use of the content hereof is prohibited. Ple=
ase return it immediately to the sender and delete the message. Thank you
