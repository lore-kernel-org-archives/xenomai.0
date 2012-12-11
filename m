Message-ID: <50C73FAD.4010705@antcom.de>
Date: Tue, 11 Dec 2012 15:14:05 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
References: <CAPpP=rOpsiFBEZLFUrc_Sjf88J66Q0zDgmrNkaQ5O4xoz=iwYQ@mail.gmail.com>
In-Reply-To: <CAPpP=rOpsiFBEZLFUrc_Sjf88J66Q0zDgmrNkaQ5O4xoz=iwYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RTDM/POSIX - Select mask return value missing in case
 of timeout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: xenomai@xenomai.org

Hi,

On 12/11/2012 03:07 PM, alex alex wrote:
> When the timeout interval expires of the =E2=80=9Cselect=E2=80=9D funct=
ion the return value
> of FD_ISSET(fdr,&readfds) is 1 whereas it should be 0.
>=20
> In ksrc/skins/posix/syscall.c we can see that they are not copy to
> userspace of select return value in case of timeout.
>=20
> The attached code shows this bug with the use of a rtdm driver.

I guess you are reporting the same issue you reported to Debian some
hours ago at:

http://bugs.debian.org/695657 (including attachment)

Since your attachment got removed from your xenomai mailing list mail on
the way to me, I'm putting this here just for reference.

Roland

