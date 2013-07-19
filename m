References: <1374143094.1082.YahooMailNeo@web172202.mail.ir2.yahoo.com>
	<51E900B7.9070604@xenomai.org>
Message-ID: <1374227358.60075.YahooMailNeo@web172203.mail.ir2.yahoo.com>
Date: Fri, 19 Jul 2013 10:49:18 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
In-Reply-To: <51E900B7.9070604@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] __xn_sys_current_info failed: Operation not permitted
Reply-To: Franz Engel <franz_lambert_engel@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Philippe wrote:>> Franz Engel wrote:=0A>>=A0Hi,=0A>>=0A>>=A0I get this erro=
r when I run a programm:=0A>>=A0__xn_sys_current_info failed: Operation not=
 permitted=0A>>=0A>>=A0I know that the error comes from the assert_nrt_inne=
r(void) function inside the assert_context.c file. But I have no idea what =
is the reason. The Operation not permitted is the return value from XENOMAI=
_SYSCALL1(__xn_sys_current_info, &info);. But I found no documentation abou=
t this function.=0A=0A=0A>This is reminiscent of a symptom observed for a b=
ug fixed in the -forge=A0=0A>tree, a while ago:=A0=0A>http://git.xenomai.or=
g/?p=3Dxenomai-forge.git;a=3Dcommit;h=3D014898add6a697e1a0d69f9e20b910ade74=
f1940=0A=0A>Do you happen to call fork() in your application?=0A=0A=0AYes. =
I do? What I can do to solve the problem. Should I try to modify the xenoma=
i files as discrept in the git-link?=0A=0Aregards,=0A=A0 =A0 franz
