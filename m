References: <1403028924.23153.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Message-ID: <1403722907.95854.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Wed, 25 Jun 2014 20:01:47 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <1403028924.23153.YahooMailNeo@web171605.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] I2C RTDM driver
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----

> From: Matthias Schneider <ma30002000@yahoo.de>
> To: "xenomai@xenomai.org" <xenomai@xenomai.org>
> Cc: =

> Sent: Tuesday, June 17, 2014 8:15 PM
> Subject: [Xenomai] I2C RTDM driver
> =

> Hi all,
> =

> in the spirit of
> =

> http://www.xenomai.org/pipermail/xenomai/2006-November/006455.html
> =

> I would like to contribute my I2C RTDM driver to xenomai and ask for a re=
view.
> It is based on the Linux 3.14 i2c framework, porting the omap i2c driver =
(tested =

> on
> beaglebone black).
> =

> The following points mentioned in the above post have been addressed:
> =

> * usage of existing linux kernel structures when available
> * combined address+request command
> =

> * ahead-of-time allocation via special IOCTL
> =

> The framework itself is contained in a single file "rti2c-dev.c", =

> while modifications to=A0
> drivers when porting to rtdm should be minimal. A readme file is included=
 in the =

> patch as always,
> =

> thanks in advance for your comments,
> =

> Matthias Schneider


Please find attached an updated patch.
It fixes some problems when compiling as a module, when unloading the=A0
module and when being interrupted in rtdm_event_timedwait.

Regards,
Matthias
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Initial-i2c-commit-no.2.patch.gz
Type: application/x-gzip
Size: 19957 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140625/dcdbcde=
c/attachment.bin>
