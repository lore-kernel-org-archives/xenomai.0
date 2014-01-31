References: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <201401301624.25756.paul_c@tuxcnc.org> <52EA816B.9060305@xenomai.org>
 <201401301957.54742.paul_c@tuxcnc.org> <52EAB676.7000103@xenomai.org>
Message-ID: <1391151622.28778.YahooMailNeo@web163904.mail.gq1.yahoo.com>
Date: Thu, 30 Jan 2014 23:00:22 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <52EAB676.7000103@xenomai.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Paul <paul_c@tuxcnc.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Does this mean I have to re-download your patch, clean up xenomai, patch it=
 and run debuild again ?=0A=0A=0A=0A=0A=0AOn Thursday, January 30, 2014 9:3=
3 PM, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:=0A =0A=
On 01/30/2014 08:57 PM, Paul wrote:=0A> On Thursday 30 January 2014, Gilles=
 Chanteperdrix wrote:=0A>> On 01/30/2014 05:24 PM, Paul wrote:=0A>>> On Wed=
nesday 29 January 2014, Gilles Chanteperdrix wrote:=0A>>>> On 01/29/2014 08=
:05 PM, Gilles Chanteperdrix wrote:=0A>>>>> On 01/29/2014 03:36 PM, Huub Va=
n Niekerk wrote:=0A>>>>>> Hi,=0A>>>>>>=0A>>>>>> I'm trying to build the xen=
omai libs on Ubuntu 12.04 armhf=0A>>>>>> according to=0A>>>>>> http://www.x=
enomai.org/index.php/Building_Debian_packages. It=0A>>>>>> goes wrong with =
a message "cannot create=0A>>>>>> <user>/Downloads/xenomai-2.6.3/debian/lib=
xenomai1/etc/udev//xeno=0A>>>>>> ma i.rules: Directory nonexistent". Any id=
ea what the cause of=0A>>>>>> this is ? I did it before on x86, which went =
great.=0A>>>>>=0A>>>>> I do not see why this even works on x86... Please tr=
y the=0A>>>>> following patch:=0A>>>>=0A>>>> Please try this one instead:=
=0A>>>>=0A>>>> diff --git a/debian/libxenomai1.install=0A>>>> b/debian/libx=
enomai1.install index 093956b..9c732f5 100644=0A>>>> --- a/debian/libxenoma=
i1.install=0A>>>> +++ b/debian/libxenomai1.install=0A>>>> @@ -1 +1,2 @@=0A>=
>>> +etc/udev/rules.d/*=0A>>>>=A0  usr/lib/*.so.*=0A>>>> diff --git a/debia=
n/rules b/debian/rules=0A>>>> index 3915fd6..c842986 100755=0A>>>> --- a/de=
bian/rules=0A>>>> +++ b/debian/rules=0A>>>> @@ -61,14 +61,12 @@ install: bu=
ild=0A>>>>=A0  =A0=A0=A0 dh_testroot=0A>>>>=A0  =A0=A0=A0 dh_prep=0A>>>>=A0=
  =A0=A0=A0 dh_installdirs=0A>>>> +=A0=A0=A0 mkdir -p $(CURDIR)/debian/tmp/=
etc/udev/rules.d=0A>>>=0A>>> This shouldn't be necessary as etc/udev/rules.=
d is listed in=0A>>> libxenomai1.dirs - dh_installdirs uses this to create =
the target=0A>>> dirctories.=0A>>>=0A>>>>=A0  =A0=A0=A0 $(MAKE) install DES=
TDIR=3D$(CURDIR)/debian/tmp/=0A>>>>=A0  =A0=A0=A0 dh_install --sourcedir=3D=
$(CURDIR)/debian/tmp=0A>>>>=A0  =A0=A0=A0 # xeno-config should be only in l=
ibxenomai-dev=0A>>>>=A0  =A0=A0=A0 rm -f $(CURDIR)/debian/xenomai-runtime/u=
sr/bin/xeno-config=0A>>>>=A0  =A0=A0=A0 rm -f=0A>>>> $(CURDIR)/debian/xenom=
ai-runtime/usr/share/man/man1/xeno-config.1=0A>>>> -=A0=A0=A0 for f in $(CU=
RDIR)/ksrc/nucleus/udev/*.rules ; do \=0A>>>> -=A0=A0=A0 =A0 =A0 cat $$f >>=
=0A>>>> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rules ; \ -=A0=A0=A0 =
done=0A>>>=0A>>> This is needed so that the udev rules get copied across.=
=0A>>=0A>> If the directory /etc/udev/rules.d exists, Xenomai's "make insta=
ll",=0A>> should copy the rules itself.=0A> =0A> The default install is in =
debian/tmp where as udev rules should be =0A> installed in debian/libxenoma=
i1 so that they end up in the correct =0A> package. The attached patch aims=
 to do just this and also removes a =0A> symlink created when installing th=
e package.=0A=0AMerged, thanks.=0A=0A=0A=0A-- =0A=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.=0A=0A_________________________________=
______________=0AXenomai mailing list=0AXenomai@xenomai.org=0Ahttp://www.xe=
nomai.org/mailman/listinfo/xenomai
