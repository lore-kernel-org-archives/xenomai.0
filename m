References: <mailman.24.1362279196.1444.xenomai@xenomai.org>
	<1362305720.60639.YahooMailNeo@web192403.mail.sg3.yahoo.com>
	<CAJjOJyY3GZ2UO2xiJc4VXYnf7dJmh4aj_3jR=HHiN7CdCKnw8Q@mail.gmail.com>
Message-ID: <1362372963.15714.YahooMailNeo@web192402.mail.sg3.yahoo.com>
Date: Mon, 4 Mar 2013 12:56:03 +0800 (SGT)
From: Amlekar Gopal <gopal_amlekar@yahoo.com>
In-Reply-To: <CAJjOJyY3GZ2UO2xiJc4VXYnf7dJmh4aj_3jR=HHiN7CdCKnw8Q@mail.gmail.com>
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
To: Jonathan Wallace <jonmon6691@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0A=0A=0A________________________________=0A From: Jonathan Wallace <jon=
mon6691@gmail.com>=0ATo: Amlekar Gopal <gopal_amlekar@yahoo.com> =0ACc: "xe=
nomai@xenomai.org" <xenomai@xenomai.org> =0ASent: Sunday, 3 March 2013 4:59=
 PM=0ASubject: Re: [Xenomai] Problem Handling GPIO interrupts - compiling e=
xample codes=0A =0A=0A=A0=0A=0AOn Sunday, March 3, 2013, Amlekar Gopal  wro=
te:=0A=0A=0A>=0A>=0A>Date: Sat, 2 Mar 2013 18:53:09 -0800=0A>From: Jonathan=
 Wallace <jonmon6691@gmail.com>=0A>To: Gilles Chanteperdrix <gilles.chantep=
erdrix@xenomai.org>=0A>Cc: Xenomai <xenomai@xenomai.org>=0A>Subject: Re: [X=
enomai] Problem Handling GPIO interrupts=0A>Message-ID:=0A>=A0=A0=A0 <CAJjO=
JyYkOmXyyrXCvQ+EHrW9qs98TdFw4SPV+1d9_ozMVM2xBg@mail.gmail.com>=0A>Content-T=
ype: text/plain; charset=3DISO-8859-1=0A>=0A>On Fri, Mar 1, 2013 at 10:44 P=
M, Gilles Chanteperdrix=0A><gilles.chanteperdrix@xenomai.org> wrote:=0A>> O=
n 03/02/2013 07:38 AM, Jonathan Wallace wrote:=0A>>=0A>>> On Fri, Mar 1, 20=
13 at 9:41 PM, Gilles Chanteperdrix=0A>>> <gilles.chanteperdrix@xenomai.org=
=0A>>> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:=0A>>>> On 03/02/20=
13 05:47 AM, Jonathan Wallace wrote:=0A>>>>=0A>>>>> Hi all,=0A>>>>>=0A>>>>>=
 I'm trying to get a small variation of the usr_irq.c example working,=0A>>=
>>> but rt_intr_wait keeps returning -38 without blocking and perror=0A>>>>=
> prints success. If I don't let it print anything (so it will run=0A>>>>=
=0A>>>>=0A>>>> Sorry for the empty reply. The native skin does not use errn=
o, so,=0A>>>> perror will not print anything, rt_intr_wait return value has=
 to be=0A>>>> considered the error itself.=0A>>>>=0A>>>> -38 is -ENOSYS, me=
aning that the kernel does not implement the function.=0A>>>>=0A>>>> Indeed=
, handling interrupts in user-space is deprecated, for this=0A>>>> reason, =
support is disabled by default in Xenomai kernel.=0A>>>>=0A>>>> In order to=
 add support for the rt_intr_* services, you have to enable=0A>>>> CONFIG_X=
ENO_OPT_NATIVE_INTR=0A>>>> in the kernel configuration.=0A>>>>=0A>>>>=0A>>>=
>> faster) it seg faults after about 4 or 5 seconds, calling rt_intr_wait=
=0A>>>>> in an infinite loop during that time.=0A>>>>>=0A>>>>> I'm also hav=
ing an issue where if I run the program from an SSH=0A>>>>> session, rt_tas=
k_create returns EPERM, but will return a success if I=0A>>>>> run the prog=
ram from the serial console. I can only assume there's=0A>>>>> some differe=
nce in the shell processes at the kernel level, but if=0A>>>>> there's a wa=
y to get around this, I would love to know too.=0A>>>>=0A>>>>=0A>>>> I do n=
ot know if this is related, but Xenomai services are by default=0A>>>> only=
 available to the "root" user, so, if you are not loging with ssh as=0A>>>>=
 root user, what you observe is normal. If not, then what you observe is=0A=
>>>> a new bug. Maybe ssh restrict some capabilities even when logging at r=
oot?=0A>>>>=0A>>>>=0A>>>>=0A>>>>>=0A>>>>> A little background about the IRQ=
, because I could have this all wrong=0A>>>>> too... I exported a gpio pin =
and echoed "falling" into the edge file=0A>>>>> in sysfs. This added an ent=
ry in /procs/interrupts "205: 42=0A>>>>> GPIO gpiolib" The number 42, incre=
ments every time I press my=0A>>>>> button to cause an physical interrupt o=
n the pin so I know its at=0A>>>>> least working up to that point. I used t=
his number 205 as the argument=0A>>>>> to rt_intr_create, but I'm not sure =
that was the right thing to do.=0A>>>>=0A>>>>=0A>>>> This should probably w=
ork. You may have to run rt_intr_enable after=0A>>>> rt_intr_create though.=
=0A>>>>=0A>>>> --=0A>>>>=0A>>>> Gilles.=0A>>>=0A>>> Oh, the API documentati=
on doesn't list ENOSYS as a possible return value=0A>>> for rt_intr_wait, i=
s there a Xenomai version of errno that I should use=0A>>> for the definiti=
ons of the error codes or are they just part of the=0A>>> standard headers?=
=0A>>=0A>>=0A>> ENOSYS is defined of errno.h, the error are not returned th=
rough the=0A>> "errno" variable by native skin services, but directly as ne=
gative=0A>> values. ENOSYS is a "generic" return value, meaning that a serv=
ice is=0A>> not implemented by the kernel, and generally means that you hav=
e to=0A>> enable some option in the kernel configuration to enable the serv=
ice.=0A>> Maybe we can document this in TROUBLESHOOTING.=0A>>=0A>>>=0A>>> E=
ither way I'd rather run this in kernel space I thought I'd just=0A>>> impl=
ement it the easy way if possible to make sure things were working=0A>>> on=
 the Xenomai side of things.=0A>>=0A>>=0A>> You can try to implement this i=
n user-space. Chances are, however, that=0A>> handling interrupts in user-s=
pace is in fact harder than handling them=0A>> in kernel-space.=0A>>=0A>>>=
=0A>>> For the SSH part, I was root in both terminals, I'll check the ssh g=
roup=0A>>> permissions though. This is on a beaglebone btw.=0A>>=0A>>=0A>> =
Maybe your rootfs has /etc/security/capabilities.conf or=0A>> /etc/security=
/limits.conf ?=0A>>=0A>> (re-adding the list to cc).=0A>>=0A>> --=0A>>=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.=0A>=0A>I've mov=
ed my test app over to a bare-bones module where I can printk=0A>to see if =
its working, but I can't get it to compile using a simple=0A>Makefile that =
works for cross-compiling modules that don't #include=0A>Xenomai headers. I=
t quits when it can't find native/task.h. So I ran=0A>make with V=3D1 and i=
t looks like -Iinclude/xenomai isn't added to the=0A>(enormous) gcc command=
, which should put native/* in the search path.=0A>I don't know what the "p=
roper" way of adding this to the CFLAGS is so=0A>I thought I'd look at some=
 of the examples in the xenomai source...=0A>=0A>I ended up modifying the m=
akefile in=0A>.../xenomai-2.6.2.1/examples/rtdm/driver-api to try and make =
it=0A>compile just the rtdm examples for my board but the preprocesser isn'=
t=0A>finding the Xenomai headers either and has a few other errors. I ran=
=0A>this one with V=3D1 also and it looks like some of the "-I" paths,=0A>i=
ncluding .../include/xenomai, are missing the XENO_DESTDIR prefix so=0A>its=
 looking in my native machine's /lib/modules path instead of the=0A>target'=
s, I don't know how to fix this one either. I can send one or=0A>both of th=
ese makefiles if it would help, but if there was an example=0A>with a makef=
ile built for cross-compiling modules, that would make my=0A>life a lot eas=
ier.=0A>=0A>As far as the SSH permissions issue, I checked the files under=
=0A>/etc/security and there aren't any policies configured, ssh has a very=
=0A>minimal config (dropbear server). Let me know if there's anything else=
=0A>you want me to check, I don't know if there is a bugreporting site,=0A>=
but I'd be happy to write up a small report on it if you think its=0A>somet=
hing worth looking into.=0A>=0A>-Jon=0A>=0A>=0A>=0A>-----------------------=
-------=0A>I had similar issues when compiling the examples in source folde=
r. After some trials, the following sequence worked for me. I just followed=
 the steps on xenomai website here (http://www.xenomai.org/documentation/xe=
nomai-2.6/html/README.INSTALL/#arm) and here (http://www.xenomai.org/index.=
php/Examples).=0A>=0A>1. Patch the kernel sources with prepare-kernel.sh in=
 scripts/=0A>2. Build kernel in the same folder as the source. (Not to use =
the make O=3D option).=0A>3. Configure xenomai source for user space for bu=
ilding (Using configure script in src/). This step I did from a new folder =
created somewhere other than the xenomai source code. ($build_root as menti=
oned in the links above).=0A>4. Build Xenomai user space.i=0A=0AI've alread=
y gotten the kernel booting with the patch using the steps on the website a=
s well as with a little help from the how to at this link:=A0http://yapatel=
.org/wiki/index.php/Installing_Xenomai_on_a_beaglebone=0AI even got the use=
r space tools installed. The purpose of my question was to better understan=
d how to build my own modules outside of the Xenomai source tree, you and G=
uilles answered that question very well.=0A=A0=0A5. Now, to compile the exa=
mples, DESTDIR is the staging directory where your xenomai user space is bu=
ilt. This is where the folder usr/xenomai appears after build. XENO=3D is D=
ESTDIR/usr/xenomai so that it includes the neccessary files for the EXTRA_C=
FLAGS and KSRC is the linux source tree (not xenomai source tree as I had m=
isunderstood earlier).=0A>6. In addition, I had specified the ARCH=3D and C=
ROSS_COMPILE=3D flags as well.=0A=0AI keep forgetting I need to do this eve=
ry time I run make on a kernel build, the link you provided to the wiki art=
icle on compiling the examples is very helpful, and made me realize I was f=
orgetting these options also.=0A=0A---- I made a shell script for that long=
 command but running that script gave some error again, so I am just contin=
uing with the long command directly. I think I should put those flags like =
XENO=3D and so inside the Makefile itself. Will try it sometime later. ---=
=0A=0A=0A>Inspite of this, I have got shared library not found while runnin=
g some of the examples on beagleboard C4. For now, I copied the library fil=
es appearing in usr/xenomai to /usr/lib and it worked. Don't know if that i=
s the correct method. I will put up a separate message for that.=0ACould yo=
u post the error you were getting? Sounds like the same problem I was havin=
g a few days ago. Turns out I needed to add /usr/Xenomai/lib to the library=
 reach path. I did that by putting that path in /etc/ld.so.conf, it may be =
a folder called ld.so.conf.d on other systems, in that case add the path to=
 any file in that directory.=0A=0A=0A--- I'm not right now in front of that=
 PC and the error has gone away now. But I remember it was something like "=
Shared library libnative.so.1 not found". I will try modifying the library =
search path and removing those files from /usr/lib. But for now, its workin=
g so it's tempting for me to skip past it. ----=0A=A0=0AAnother thing in st=
ep 4 was that the --host option needed to be put without the last "-" usual=
ly appearing in the cross_compile options. ( I use arm-angstrom-linux-gnuea=
bi- toolchain, so I had to give that option as arm-angstrom-linux-gnueabi f=
or the --host option).=0A>=0A>I am much noob to xenomai but just thought to=
 share..=0A>Hope it helps.=0A>=0A>Thanks,=0A>Gopal=0A>_____________________=
__________________________=0A>Xenomai mailing list=0A>Xenomai@xenomai.org=
=0A>http://www.xenomai.org/mailman/listinfo/xenomai=0A>=0A=0AThanks for the=
 input, I'm a Linux kernel noob on top of being a Xenomai noob, it's all ma=
king my head spin just a little bit, but a good challenge is always rewardi=
ng.=0A-Jon=A0=0A=0A---- =A0 +1 for this :-) =A0and good to be of help. ---=
=0AI will put my long make command in next message when resume work tonight=
 from home...=0A=0Aoh and yes, did you make sure that the Makefile in your =
folder has the name of your program in that. For e.g. if you are compiling =
a user space module of your own (foo.c) then the line should be APPLICATION=
S =3D foo and it could be followed by other modules as well in the same fol=
der. If you are compiling a kernel module (bar.c) the module name should ap=
pear in the MODULES =3D bar.
