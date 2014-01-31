References: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <52E950FB.70400@xenomai.org> <52E95E66.2060905@xenomai.org>
 <1391067115.6898.YahooMailNeo@web163904.mail.gq1.yahoo.com>
 <52EA0FDF.6040604@xenomai.org>
 <1391072739.44037.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <52EA1A55.3040907@xenomai.org>
 <1391074883.36568.YahooMailNeo@web163905.mail.gq1.yahoo.com>
 <52EA2EDF.2050900@xenomai.org>
 <1391083620.48248.YahooMailNeo@web163903.mail.gq1.yahoo.com>
 <52EA4B35.2090306@xenomai.org>
 <1391088235.30999.YahooMailNeo@web163901.mail.gq1.yahoo.com>
 <52EAA41F.1020005@xenomai.org>
Message-ID: <1391151524.70706.YahooMailNeo@web163904.mail.gq1.yahoo.com>
Date: Thu, 30 Jan 2014 22:58:44 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <52EAA41F.1020005@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] debuild of xenomai failing: Directory nonexistent
Reply-To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm just using the debuild script/command as a user, i.e. ../xenomai-2.6.3$=
 debuild. So if debuild uses fakeroot, then yes.=0A=0A=0A=0A=0A=0AOn Thursd=
ay, January 30, 2014 8:12 PM, Gilles Chanteperdrix <gilles.chanteperdrix@xe=
nomai.org> wrote:=0A =0AOn 01/30/2014 02:23 PM, Huub Van Niekerk wrote:=0A>=
 I've added the mkdir's I thought were necessary. However, what I don't=0A>=
 understand is the message "ERROR: ld.so: object 'libfakeroot-sysv.so'=0A> =
from LD_PRELOAD cannot be preloaded: ignored". After this it asks for=0A> t=
he sudo password. After that the error message shows again, the script=0A> =
goes on shortly and ends in the "cannot create directory" error. Do you=0A>=
 have any idea what the cause of the ld.so error may be ?=0A=0AHave you tri=
ed debuild -rfakeroot?=0AOr are you using fakeroot debuild directly?=0A=0A=
=0A-- =0A=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 Gilles.
