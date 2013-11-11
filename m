From: <dietmar.schindler@manroland-web.com>
Date: Mon, 11 Nov 2013 08:36:15 +0000
Message-ID: <208C6975C932E94F86239FEA59CCA6323259C39F@AUSMXMBX02.mrws.biz>
References: <527B5BBF.2040301@siemens.com> <527BD591.9060504@xenomai.org>
 <527C7CE6.6090603@siemens.com> <527D1E27.3030708@xenomai.org>
 <527D2AF3.5050904@siemens.com>
In-Reply-To: <527D2AF3.5050904@siemens.com>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [Xenomai-forge] [PATCH] Silence unused_result
	warning	from write()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

> Von: Jan Kiszka
> Gesendet: Freitag, 8. November 2013 19:18
>
> On 2013-11-08 18:23, Gilles Chanteperdrix wrote:
> > On 11/08/2013 06:55 AM, Gernot Hillier wrote:
> >> Am 07.11.2013 19:01, schrieb Gilles Chanteperdrix:
> >>> On 11/07/2013 10:22 AM, Gernot Hillier wrote:
> >>>> Some glibc versions mark write() with attribute warn_unused_result (=
found in
> >>>> Ubuntu 12.04 / eglibc 2.15 / gcc 4.6.3), so we need to silence this =
warning,
> >>>> especially when building with -Werror.
> >>>
> >>> Why not casting write result to void, it does not work?
> >>>
> >>
> >> No, it doesn't. For rationale, please see
> >> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25509.
> >>
> > ...
> >
> > I believe you still can do:
> >
> > rc =3D write
> > (void)rc
>
> Yep, that's what other projects do as well when there is really no use
> for the return code.
>
> >
> > The link you sent also indicates that the warning can be disabled with
> > -Wno-unused-result
> >
> > Can you not compile with this option on distributions with this behavio=
ur?
>
> Let's fix this in our source code, not in the ./configure command line.
> I expect the warning to become more frequent with recent compilers
> and/or distros.

Since this has been recognized as a bug http://sourceware.org/bugzilla/show=
_bug.cgi?id=3D11959 in glibc and fixed, it should become less frequent with=
 recent
distros. I think, source code shouldn't be cluttered with silly workarounds=
.
--
Best regards,
Dietmar Schindler
________________________________________
manroland web systems GmbH -- Managing Director: Eckhard Hoerner-Marass
Registered Office: Augsburg -- Trade Register: AG Augsburg -- HRB-No. 26816=
 -- VAT: DE281389840

Confidentiality note:
This eMail and any files transmitted with it are confidential and intended =
solely for the use of the individual or entity to whom they are addressed. =
If you are not the intended recipient, you are hereby notified that any use=
 or dissemination of this communication is strictly prohibited. If you have=
 received this eMail in error, then please delete this eMail.

! Please consider your environmental responsibility before printing this eM=
ail
________________________________________

