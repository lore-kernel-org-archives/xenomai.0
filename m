From: <dietmar.schindler@manroland-web.com>
Date: Thu, 6 Aug 2015 09:25:31 +0000
Message-ID: <208C6975C932E94F86239FEA59CCA632E0D9E8A1@AUSMXMBX02.mrws.biz>
References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org>
 <20150805172427.GA21690@hermes.click-hack.org>
 <55C30F85.1090505@xenomai.org>
 <20150806074939.GA20331@hermes.click-hack.org> <55C31423.6070008@xenomai.org>
In-Reply-To: <55C31423.6070008@xenomai.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Segfaults and ENOMEM during rt_event_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

> Von: Philippe Gerum
> Gesendet: Donnerstag, 6. August 2015 10:01
>
> ..., but the ternary operator is a bit special since by
> design, it won't compete for precedence with the expressions it evaluates=
.

Actually, this is not special - no operator will "compete for precedence wi=
th the expressions it evaluates", because _which_ expressions it evaluates =
is determined by the very outcome of the "competition for precedence". And =
sure enough, the expression

    b =3D a ? 0 : 1

is not equivalent to

    (b =3D a) ? 0 : 1

(but by this remark I do not at all want to advocate the undue use of paren=
theses).

--
Best regards,
Dietmar Schindler
________________________________
manroland web systems GmbH -- Managing Director: Joern Gosse
Registered Office: Augsburg -- Trade Register: AG Augsburg -- HRB-No.: 2681=
6 -- VAT: DE281389840

Confidentiality note:
This eMail and any files transmitted with it are confidential and intended =
solely for the use of the individual or entity to whom they are addressed. =
If you are not the intended recipient, you are hereby notified that any use=
 or dissemination of this communication is strictly prohibited. If you have=
 received this eMail in error, then please delete this eMail.

! Please consider your environmental responsibility before printing this eM=
ail !
________________________________

