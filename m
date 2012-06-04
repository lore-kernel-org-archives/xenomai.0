Message-ID: <4FCC8582.9080008@xenomai.org>
Date: Mon, 04 Jun 2012 11:53:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CALH4WdbGSKTfoLS013KW4aoO=vs9qBwMWE5RhW5FVi=FmhAs_w@mail.gmail.com>
	<8236197CA3DA864F9EF20609D9887263B7F87AF3@rrxchngmbx01.mro.roland-man.biz>
	<CALH4Wdbq459W__cBmSsCGhBcE22UzsS1chSCC7xZpLAs--A8eA@mail.gmail.com>
In-Reply-To: <CALH4Wdbq459W__cBmSsCGhBcE22UzsS1chSCC7xZpLAs--A8eA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] TCP communication problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik.bayart@triphase.com>
Cc: xenomai@xenomai.org

On 06/04/2012 11:33 AM, Frederik Bayart wrote:
> Dietmar, thanks for hint. Indeed, I noticed that the number of bytes
> sent !=3D bytes to send.
> If I wrap the send in a while lus, the problem is solved.
>
> Does anyone have a suggestion how to detect the interrupting signal
> (SIG_ALL doesn't exist)
>

Use strace.

It's likely SIGWINCH (aka SIGSHADOW for Xenomai), which we use internally.

> Frederik
>
> On 31 May 2012 11:54,<dietmar.schindler@manroland.com>  wrote:
>> Hallo,
>>
>> Frederik wrote:
>>> When the client (rtest.c attached) connects to the server (rtestd.c
>>> attached), the server starts sending packets to the client. Packets
>>> are paired : first a header and then a corresponding data packet. The
>>> payload of each packet starts with a sequence number (to match network
>>> traces and logging), followed with hdr[A..Z])2222222...222hdr[A..Z]
>>> for header and dat[A..Z]77777777...777dat[A..Z] for data packets.
>>> ...
>>> If you execute this some times after each other, we noticed that we
>>> have lost some data.
>>>
>>> In attached rtest.log, rule 6 , the tail of the packet
>>> (...22222222hdrE) is lost.
>>
>> Perhaps the hdr send() call has been interrupted by a signal; this would=
 have gone unnoticed because the server does not compare the return value o=
f the send() call (i. e. the  number of characters sent) to the hdr message=
 length.
>> If this is so, the question remains, which signal did occur?
>> --
>> Dietmar
>> ________________________________________
>> manroland web systems GmbH -- Managing Director: Uwe L=FCders
>> Registered Office: Augsburg -- Trade Register: AG Augsburg -- HRB-No. 26=
816 -- VAT: DE281389840
>>
>> Confidentiality note:
>> This eMail and any files transmitted with it are confidential and intend=
ed solely for the use of the individual or entity to whom they are addresse=
d. If you are not the intended recipient, you are hereby notified that any =
use or dissemination of this communication is strictly prohibited. If you h=
ave received this eMail in error, please notify us immediately via info@man=
roland-web.com, then delete this eMail.
>>
>> - Please consider your environmental responsibility before printing this=
 eMail
>> ________________________________________
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>
>
>


--=20
Philippe.

