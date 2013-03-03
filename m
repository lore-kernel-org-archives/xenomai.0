References: <mailman.24.1362279196.1444.xenomai@xenomai.org>
Message-ID: <1362305720.60639.YahooMailNeo@web192403.mail.sg3.yahoo.com>
Date: Sun, 3 Mar 2013 18:15:20 +0800 (SGT)
From: Amlekar Gopal <gopal_amlekar@yahoo.com>
In-Reply-To: <mailman.24.1362279196.1444.xenomai@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Problem Handling GPIO interrupts - compiling example
	codes
Reply-To: Amlekar Gopal <gopal_amlekar@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0A=0ADate: Sat, 2 Mar 2013 18:53:09 -0800=0AFrom: Jonathan Wallace <jon=
mon6691@gmail.com>=0ATo: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai=
.org>=0ACc: Xenomai <xenomai@xenomai.org>=0ASubject: Re: [Xenomai] Problem =
Handling GPIO interrupts=0AMessage-ID:=0A=A0=A0=A0 <CAJjOJyYkOmXyyrXCvQ+EHr=
W9qs98TdFw4SPV+1d9_ozMVM2xBg@mail.gmail.com>=0AContent-Type: text/plain; ch=
arset=3DISO-8859-1=0A=0AOn Fri, Mar 1, 2013 at 10:44 PM, Gilles Chanteperdr=
ix=0A<gilles.chanteperdrix@xenomai.org> wrote:=0A> On 03/02/2013 07:38 AM, =
Jonathan Wallace wrote:=0A>=0A>> On Fri, Mar 1, 2013 at 9:41 PM, Gilles Cha=
nteperdrix=0A>> <gilles.chanteperdrix@xenomai.org=0A>> <mailto:gilles.chant=
eperdrix@xenomai.org>> wrote:=0A>>> On 03/02/2013 05:47 AM, Jonathan Wallac=
e wrote:=0A>>>=0A>>>> Hi all,=0A>>>>=0A>>>> I'm trying to get a small varia=
tion of the usr_irq.c example working,=0A>>>> but rt_intr_wait keeps return=
ing -38 without blocking and perror=0A>>>> prints success. If I don't let i=
t print anything (so it will run=0A>>>=0A>>>=0A>>> Sorry for the empty repl=
y. The native skin does not use errno, so,=0A>>> perror will not print anyt=
hing, rt_intr_wait return value has to be=0A>>> considered the error itself=
.=0A>>>=0A>>> -38 is -ENOSYS, meaning that the kernel does not implement th=
e function.=0A>>>=0A>>> Indeed, handling interrupts in user-space is deprec=
ated, for this=0A>>> reason, support is disabled by default in Xenomai kern=
el.=0A>>>=0A>>> In order to add support for the rt_intr_* services, you hav=
e to enable=0A>>> CONFIG_XENO_OPT_NATIVE_INTR=0A>>> in the kernel configura=
tion.=0A>>>=0A>>>=0A>>>> faster) it seg faults after about 4 or 5 seconds, =
calling rt_intr_wait=0A>>>> in an infinite loop during that time.=0A>>>>=0A=
>>>> I'm also having an issue where if I run the program from an SSH=0A>>>>=
 session, rt_task_create returns EPERM, but will return a success if I=0A>>=
>> run the program from the serial console. I can only assume there's=0A>>>=
> some difference in the shell processes at the kernel level, but if=0A>>>>=
 there's a way to get around this, I would love to know too.=0A>>>=0A>>>=0A=
>>> I do not know if this is related, but Xenomai services are by default=
=0A>>> only available to the "root" user, so, if you are not loging with ss=
h as=0A>>> root user, what you observe is normal. If not, then what you obs=
erve is=0A>>> a new bug. Maybe ssh restrict some capabilities even when log=
ging at root?=0A>>>=0A>>>=0A>>>=0A>>>>=0A>>>> A little background about the=
 IRQ, because I could have this all wrong=0A>>>> too... I exported a gpio p=
in and echoed "falling" into the edge file=0A>>>> in sysfs. This added an e=
ntry in /procs/interrupts "205: 42=0A>>>> GPIO gpiolib" The number 42, incr=
ements every time I press my=0A>>>> button to cause an physical interrupt o=
n the pin so I know its at=0A>>>> least working up to that point. I used th=
is number 205 as the argument=0A>>>> to rt_intr_create, but I'm not sure th=
at was the right thing to do.=0A>>>=0A>>>=0A>>> This should probably work. =
You may have to run rt_intr_enable after=0A>>> rt_intr_create though.=0A>>>=
=0A>>> --=0A>>>=0A>>> Gilles.=0A>>=0A>> Oh, the API documentation doesn't l=
ist ENOSYS as a possible return value=0A>> for rt_intr_wait, is there a Xen=
omai version of errno that I should use=0A>> for the definitions of the err=
or codes or are they just part of the=0A>> standard headers?=0A>=0A>=0A> EN=
OSYS is defined of errno.h, the error are not returned through the=0A> "err=
no" variable by native skin services, but directly as negative=0A> values. =
ENOSYS is a "generic" return value, meaning that a service is=0A> not imple=
mented by the kernel, and generally means that you have to=0A> enable some =
option in the kernel configuration to enable the service.=0A> Maybe we can =
document this in TROUBLESHOOTING.=0A>=0A>>=0A>> Either way I'd rather run t=
his in kernel space I thought I'd just=0A>> implement it the easy way if po=
ssible to make sure things were working=0A>> on the Xenomai side of things.=
=0A>=0A>=0A> You can try to implement this in user-space. Chances are, howe=
ver, that=0A> handling interrupts in user-space is in fact harder than hand=
ling them=0A> in kernel-space.=0A>=0A>>=0A>> For the SSH part, I was root i=
n both terminals, I'll check the ssh group=0A>> permissions though. This is=
 on a beaglebone btw.=0A>=0A>=0A> Maybe your rootfs has /etc/security/capab=
ilities.conf or=0A> /etc/security/limits.conf ?=0A>=0A> (re-adding the list=
 to cc).=0A>=0A> --=0A>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
  Gilles.=0A=0AI've moved my test app over to a bare-bones module where I c=
an printk=0Ato see if its working, but I can't get it to compile using a si=
mple=0AMakefile that works for cross-compiling modules that don't #include=
=0AXenomai headers. It quits when it can't find native/task.h. So I ran=0Am=
ake with V=3D1 and it looks like -Iinclude/xenomai isn't added to the=0A(en=
ormous) gcc command, which should put native/* in the search path.=0AI don'=
t know what the "proper" way of adding this to the CFLAGS is so=0AI thought=
 I'd look at some of the examples in the xenomai source...=0A=0AI ended up =
modifying the makefile in=0A.../xenomai-2.6.2.1/examples/rtdm/driver-api to=
 try and make it=0Acompile just the rtdm examples for my board but the prep=
rocesser isn't=0Afinding the Xenomai headers either and has a few other err=
ors. I ran=0Athis one with V=3D1 also and it looks like some of the "-I" pa=
ths,=0Aincluding .../include/xenomai, are missing the XENO_DESTDIR prefix s=
o=0Aits looking in my native machine's /lib/modules path instead of the=0At=
arget's, I don't know how to fix this one either. I can send one or=0Aboth =
of these makefiles if it would help, but if there was an example=0Awith a m=
akefile built for cross-compiling modules, that would make my=0Alife a lot =
easier.=0A=0AAs far as the SSH permissions issue, I checked the files under=
=0A/etc/security and there aren't any policies configured, ssh has a very=
=0Aminimal config (dropbear server). Let me know if there's anything else=
=0Ayou want me to check, I don't know if there is a bugreporting site,=0Abu=
t I'd be happy to write up a small report on it if you think its=0Asomethin=
g worth looking into.=0A=0A-Jon=0A=0A=0A=0A------------------------------=
=0AI had similar issues when compiling the examples in source folder. After=
 some trials, the following sequence worked for me. I just followed the ste=
ps on xenomai website here (http://www.xenomai.org/documentation/xenomai-2.=
6/html/README.INSTALL/#arm) and here (http://www.xenomai.org/index.php/Exam=
ples). =0A=0A1. Patch the kernel sources with prepare-kernel.sh in scripts/=
=0A2. Build kernel in the same folder as the source. (Not to use the make O=
=3D option).=0A3. Configure xenomai source for user space for building (Usi=
ng configure script in src/). This step I did from a new folder created som=
ewhere other than the xenomai source code. ($build_root as mentioned in the=
 links above).=0A4. Build Xenomai user space.i=0A5. Now, to compile the exa=
mples, DESTDIR is the staging directory where your xenomai user space is bu=
ilt. This is where the folder usr/xenomai appears after build. XENO=3D is D=
ESTDIR/usr/xenomai so that it includes the neccessary files for the EXTRA_C=
FLAGS and KSRC is the linux source tree (not xenomai source tree as I had m=
isunderstood earlier).=0A6. In addition, I had specified the ARCH=3D and CR=
OSS_COMPILE=3D flags as well.=0A=0AInspite of this, I have got shared libra=
ry not found while running some of the examples on beagleboard C4. For now,=
 I copied the library files appearing in usr/xenomai to /usr/lib and it wor=
ked. Don't know if that is the correct method. I will put up a separate mes=
sage for that.=0AAnother thing in step 4 was that the --host option needed =
to be put without the last "-" usually appearing in the cross_compile optio=
ns. ( I use arm-angstrom-linux-gnueabi- toolchain, so I had to give that op=
tion as arm-angstrom-linux-gnueabi for the --host option).=0A=0AI am much n=
oob to xenomai but just thought to share..=0AHope it helps. =0A=0AThanks,=
=0AGopal
