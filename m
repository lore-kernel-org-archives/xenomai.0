References: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <52E950FB.70400@xenomai.org> <52E95E66.2060905@xenomai.org>
Message-ID: <1391067115.6898.YahooMailNeo@web163904.mail.gq1.yahoo.com>
Date: Wed, 29 Jan 2014 23:31:55 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <52E95E66.2060905@xenomai.org>
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

I assume I have to save this patch into a textfile (e.g. debuild-patch) and=
 use the patch command: patch debuild debuild-patch ?=0A=0A=0A=0A=0A=0AOn W=
ednesday, January 29, 2014 9:02 PM, Gilles Chanteperdrix <gilles.chanteperd=
rix@xenomai.org> wrote:=0A =0AOn 01/29/2014 08:05 PM, Gilles Chanteperdrix =
wrote:=0A> On 01/29/2014 03:36 PM, Huub Van Niekerk wrote:=0A>> Hi,=0A>>=0A=
>> I'm trying to build the xenomai libs on Ubuntu 12.04 armhf according=0A>=
> to http://www.xenomai.org/index.php/Building_Debian_packages. It goes=0A>=
> wrong with a message "cannot create=0A>> <user>/Downloads/xenomai-2.6.3/d=
ebian/libxenomai1/etc/udev//xenomai.rules:=0A>> Directory nonexistent". Any=
 idea what the cause of this is ? I did it=0A>> before on x86, which went g=
reat.=0A> =0A> I do not see why this even works on x86... Please try the fo=
llowing =0A> patch:=0A=0APlease try this one instead:=0A=0Adiff --git a/deb=
ian/libxenomai1.install b/debian/libxenomai1.install=0Aindex 093956b..9c732=
f5 100644=0A--- a/debian/libxenomai1.install=0A+++ b/debian/libxenomai1.ins=
tall=0A@@ -1 +1,2 @@=0A+etc/udev/rules.d/*=0Ausr/lib/*.so.*=0Adiff --git a/=
debian/rules b/debian/rules=0Aindex 3915fd6..c842986 100755=0A--- a/debian/=
rules=0A+++ b/debian/rules=0A@@ -61,14 +61,12 @@ install: build=0A=A0=A0=A0=
 dh_testroot=0A=A0=A0=A0 dh_prep=0A=A0=A0=A0 dh_installdirs=0A+=A0=A0=A0 mk=
dir -p $(CURDIR)/debian/tmp/etc/udev/rules.d=0A=A0=A0=A0 $(MAKE) install DE=
STDIR=3D$(CURDIR)/debian/tmp/=0A=A0=A0=A0 dh_install --sourcedir=3D$(CURDIR=
)/debian/tmp=0A=A0=A0=A0 # xeno-config should be only in libxenomai-dev=0A=
=A0=A0=A0 rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config=0A=A0=
=A0=A0 rm -f $(CURDIR)/debian/xenomai-runtime/usr/share/man/man1/xeno-confi=
g.1=0A-=A0=A0=A0 for f in $(CURDIR)/ksrc/nucleus/udev/*.rules ; do \=0A-=A0=
=A0=A0 =A0 =A0 cat $$f >> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rul=
es ; \=0A-=A0=A0=A0 done=0A=A0=A0=A0 install -m 644 debian/libxenomai1.modp=
robe $(CURDIR)/debian/libxenomai1/etc/modprobe.d/xenomai.conf=0A=A0=A0=A0 #=
 remove empty directory=0A=A0=A0=A0 rm -rf $(CURDIR)/debian/xenomai-doc/usr=
/share/doc/xenomai-doc/ps=0A=0A=0A=0A=0A-- =0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.
