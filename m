Message-ID: <1403028924.23153.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Tue, 17 Jun 2014 19:15:24 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] I2C RTDM driver
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

in the spirit of

http://www.xenomai.org/pipermail/xenomai/2006-November/006455.html

I would like to contribute my I2C RTDM driver to xenomai and ask for a revi=
ew.
It is based on the Linux 3.14 i2c framework, porting the omap i2c driver (t=
ested on
beaglebone black).

The following points mentioned in the above post have been addressed:

* usage of existing linux kernel structures when available
* combined address+request command

* ahead-of-time allocation via special IOCTL

The framework itself is contained in a single file "rti2c-dev.c", while mod=
ifications to=A0
drivers when porting to rtdm should be minimal. A readme file is included i=
n the patch as always,

thanks in advance for your comments,

Matthias Schneider
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Initial-i2c-commit.patch.gz
Type: application/x-gzip
Size: 20005 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140617/b68ffcf=
0/attachment.bin>
