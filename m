Date: Fri, 16 Nov 2018 08:21:29 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1848440323.12443247.1542378089283.JavaMail.zimbra@wolfram.com>
In-Reply-To: <29e3d91b-1fb5-d813-b800-7e6eee361519@siemens.com>
References: <2015799461.12414544.1542356079122.JavaMail.zimbra@wolfram.com>
 <29e3d91b-1fb5-d813-b800-7e6eee361519@siemens.com>
Subject: Re: Use of DESTDIR in xeno-config
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

----- Den 16 nov 2018, p=C3=A5 kl 14:29, Jan Kiszka <jan.kiszka@siemens.com=
> skrev:=20

> On 16.11.18 09:14, Per Oberg via Xenomai wrote:
> > Hi everyone

>> I'm confused over the xeno-config use of DESTDIR and cross-compiling. In=
 the
> > documentation (1) it is claimed that it follows the GNU coding standard=
s.

> > Snippet:
>> "If DESTDIR was set when installing Xenomai - typically after cross-comp=
iling -
>> DESTDIR must be set to the same value before calling xeno-config for acc=
essing
> > the target-based directories and files from the build system."

>> The example that is given handles install, and the GNU coding standards =
(2) also
>> talks about installation. It even specifies: "DESTDIR should be supporte=
d only
>> in the install* and uninstall* targets, as those are the only targets wh=
ere it
> > is useful."

> > However, xeno-config is hardly used during install.

> > My specific problem boils down to the following:
>> I have built a toolchain for Yocto/Poky that has a xeno-config in the sy=
sroot
>> for the target machine. When using it together with autotools used in th=
e
>> etherlab ethercat master i need to set DESTDIR at configure time so that=
 when
>> xeno-config is called the paths to bootstrap.o and dynlib.ld. This feels=
 wrong
> > because of the above statements.

> > Can anyone enlighten me of the correct way of doing this?


> From my reading of both the documentation and what you did, this seems
> consistent: You need to set DESTDIR when you access the toolchain - inclu=
ding
> xeno-config - from within the build system. Once you are on target system=
 (or
> chroot into it), DESTDIR is out of the game.

> The problem when looking at Yocto-like toolchains (SDKs) is that those mi=
ght be
> relocated (moved around, installed to different directory) after being
> generated. In that case, DESTDIR may actually have to be updated accordin=
gly as
> well. I already received the suggestion internally to derive the necessar=
y base
> path in that case for the location of the compiler, which is doable but f=
eels
> not really correct to me as well.

I see the usefulness, but I fail to see how it's complicit with the GNU sta=
ndards. What worries me (a little, not much) is that I may be getting other=
 things wrong because of it.=20

I'm thinking that this has to be a common problem for most stuff that is cr=
oss-compiled with distributed toolchains, and there is the "--sysroot=3Dmys=
ysroot" flag that will make -I=3D/usr/ and -L=3D/usr/ translate to -Isysroo=
t/usr and -Lsysroot/usr. Are you saying that there is a hole in the way thi=
ngs are normally done because xenomai is special?

I will not persist, I know to little about it, but I am not convinced, yet.

I do like the idea with picking the location from the script, that would ma=
ke sense i.m.h.o.=20

Per =C3=96berg=20

> Jan

> > (1) https://xenomai.org/documentation/xenomai-3/html/man1/xeno-config/i=
ndex.html
> > (2) https://www.gnu.org/prep/standards/standards.html

> > TTFN
> > Per =C3=96berg



> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux



