From: Martin Haag <haag@aim-online.com>
Subject: RTDM read/write callback with parameters
Message-ID: <ab28815f-96f0-606f-bb0d-c812678ef97b@aim-online.com>
Date: Mon, 21 Sep 2020 15:49:12 +0200
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear list members=2C

I am porting a Linux PCI character device driver to Xenomai 2=2E6=2E5=2E

I can not find a RTDM expression for the =22parameters=22 argument of the=
=20
struct file=5Foperations read callback=2E

struct file=5Foperations=3A
ssize=5Ft aim=5Fread=28struct file* file=2C char =5F=5Fuser *parameters=2C=
 size=5Ft=20
parameterSize=2C loff=5Ft* offset=29=3B

struct rtdm=5Foperations=3A
ssize=5Ft aim=5Frtdm=5Fread=28struct rtdm=5Fdev=5Fcontext *context=2C rtdm=
=5Fuser=5Finfo=5Ft=20
*user=5Finfo=2C void *buf=2C size=5Ft nbyte=29


Should I use IOCTL to implement read/write with parameters or is there a=20=

different way to get to this information=2E


Please let me know if I forgot to mention important details about my setup=
=2E


Thanks=2C
Martin




AIM - Gesellschaft f=C3=BCr angewandte Informatik und Mikroelektronik m=2Eb=
=2EH
Registered Office=3A Freiburg
District Court of Freiburg HRB 3520
Managing Directors=3A Hansj=C3=B6rg Frey=2C Joachim Schuler

This E-mail and any attachment=28s=29 to it are for the addressee=27s use o=
nly=2E
It is strictly confidential and may contain legally privileged information=
=2E=20
No confidentiality or privilege is waived or lost by any mistransmission=2E=

If you are not the intended addressee=2C then please delete it from your sy=
stem and notify the sender immediately=2E=20
You are hereby notified that any use=2C disclosure=2C copying or any action=
 taken in reliance on it is strictly prohibited and may be unlawful=2E
 - Thank you=2E


