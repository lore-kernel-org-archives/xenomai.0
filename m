From: <dietmar.schindler@manroland-web.com>
Date: Thu, 21 Nov 2013 07:28:41 +0000
Message-ID: <208C6975C932E94F86239FEA59CCA6323259CA19@AUSMXMBX02.mrws.biz>
References: <A4FA4D76-58FD-4DB4-AE7F-5B2D3D20FF35@mah.priv.at>
In-Reply-To: <A4FA4D76-58FD-4DB4-AE7F-5B2D3D20FF35@mah.priv.at>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] integrate event signaled by RT thread into non-RT
 event	loops (poll, select, eventfd..)?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> Von: Michael Haberler
> Gesendet: Mittwoch, 20. November 2013 15:33
>
> I'm looking for a simple method to post an event from an RT thread so a u=
serland non-RT
> thread can wait for, and pick it up via a file descriptor (without switch=
ing the originating
> thread to primary domain, of course)

Certainly you mean "secondary".
--
Mit freundlichen Gr=FC=DFen,
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

