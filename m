References: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <201401301624.25756.paul_c@tuxcnc.org> <52EA816B.9060305@xenomai.org>
 <201401301957.54742.paul_c@tuxcnc.org> <52EB9590.8020008@xenomai.org>
Message-ID: <1391177284.30382.YahooMailNeo@web163901.mail.gq1.yahoo.com>
Date: Fri, 31 Jan 2014 06:08:04 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <52EB9590.8020008@xenomai.org>
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

=0A=0AOn Friday, January 31, 2014 1:23 PM, Gilles Chanteperdrix <gilles.cha=
nteperdrix@xenomai.org> wrote:=0A =0AOn 01/30/2014 08:57 PM, Paul wrote:=0A=
> On Thursday 30 January 2014, Gilles Chanteperdrix wrote:=0A>> On 01/30/20=
14 05:24 PM, Paul wrote:=0A>>> On Wednesday 29 January 2014, Gilles Chantep=
erdrix wrote:=0A>>>> On 01/29/2014 08:05 PM, Gilles Chanteperdrix wrote:=0A=
>>>>> On 01/29/2014 03:36 PM, Huub Van Niekerk wrote:=0A>>>>>> Hi,=0A>>>>>>=
=0A>>>>>> I'm trying to build the xenomai libs on Ubuntu 12.04 armhf=0A>>>>=
>> according to=0A>>>>>> http://www.xenomai.org/index.php/Building_Debian_p=
ackages. It=0A>>>>>> goes wrong with a message "cannot create=0A>>>>>> <use=
r>/Downloads/xenomai-2.6.3/debian/libxenomai1/etc/udev//xeno=0A>>>>>> ma i.=
rules: Directory nonexistent". Any idea what the cause of=0A>>>>>> this is =
? I did it before on x86, which went great.=0A>>>>>=0A>>>>> I do not see wh=
y this even works on x86... Please try the=0A>>>>> following patch:=0A>>>>=
=0A>>>> Please try this one instead:=0A>>>>=0A>>>> diff --git a/debian/libx=
enomai1.install=0A>>>> b/debian/libxenomai1.install index 093956b..9c732f5 =
100644=0A>>>> --- a/debian/libxenomai1.install=0A>>>> +++ b/debian/libxenom=
ai1.install=0A>>>> @@ -1 +1,2 @@=0A>>>> +etc/udev/rules.d/*=0A>>>>=A0  usr/=
lib/*.so.*=0A>>>> diff --git a/debian/rules b/debian/rules=0A>>>> index 391=
5fd6..c842986 100755=0A>>>> --- a/debian/rules=0A>>>> +++ b/debian/rules=0A=
>>>> @@ -61,14 +61,12 @@ install: build=0A>>>>=A0  =A0=A0=A0 dh_testroot=0A=
>>>>=A0  =A0=A0=A0 dh_prep=0A>>>>=A0  =A0=A0=A0 dh_installdirs=0A>>>> +=A0=
=A0=A0 mkdir -p $(CURDIR)/debian/tmp/etc/udev/rules.d=0A>>>=0A>>> This shou=
ldn't be necessary as etc/udev/rules.d is listed in=0A>>> libxenomai1.dirs =
- dh_installdirs uses this to create the target=0A>>> dirctories.=0A>>>=0A>=
>>>=A0  =A0=A0=A0 $(MAKE) install DESTDIR=3D$(CURDIR)/debian/tmp/=0A>>>>=A0=
  =A0=A0=A0 dh_install --sourcedir=3D$(CURDIR)/debian/tmp=0A>>>>=A0  =A0=A0=
=A0 # xeno-config should be only in libxenomai-dev=0A>>>>=A0  =A0=A0=A0 rm =
-f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config=0A>>>>=A0  =A0=A0=
=A0 rm -f=0A>>>> $(CURDIR)/debian/xenomai-runtime/usr/share/man/man1/xeno-c=
onfig.1=0A>>>> -=A0=A0=A0 for f in $(CURDIR)/ksrc/nucleus/udev/*.rules ; do=
 \=0A>>>> -=A0=A0=A0 =A0 =A0 cat $$f >>=0A>>>> $(CURDIR)/debian/libxenomai1=
/etc/udev/xenomai.rules ; \ -=A0=A0=A0 done=0A>>>=0A>>> This is needed so t=
hat the udev rules get copied across.=0A>>=0A>> If the directory /etc/udev/=
rules.d exists, Xenomai's "make install",=0A>> should copy the rules itself=
.=0A> =0A> The default install is in debian/tmp where as udev rules should =
be =0A> installed in debian/libxenomai1 so that they end up in the correct =
=0A> package. The attached patch aims to do just this and also removes a =
=0A> symlink created when installing the package.=0A=0AI see there exist so=
me dh_installudev and dh_installmodules to take care=0Aof the udev rules an=
d modprobe snnippet, maybe we could use that?=0A=0A=0A-- =0A=A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.=0A=0AI just tested a cross-=
compile to armhf on x86. As said previously, debuild for x86 goes well. The=
 cross-compile using "debuild -eCROSS_COMPILE=3Darm-none-linux-gnueabihf- -=
aarmhf -uc -us" results in the same error as native compilation on armhf. U=
sing "debuild -eCROSS_COMPILE=3Darm-none-linux-gnueabihf- -uc -us" (so with=
out -aarmhf) results in the build of x86 packages. So as far as I can there=
's indeed a bug in debuild for armhf.=0A
