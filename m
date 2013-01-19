From: Gregory Perry <Gregory.Perry@govirtual.tv>
Date: Sat, 19 Jan 2013 18:12:51 +0000
Message-ID: <718DFA7882181D45B8BD18F31C46D554219008E1@MBX201.domain.local>
References: <718DFA7882181D45B8BD18F31C46D554218F71D6@MBX201.domain.local>,
	<50FA920A.1070900@xenomai.org>
In-Reply-To: <50FA920A.1070900@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai Documentation for ARM Integration
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

>________________________________________
>From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
>Sent: Saturday, January 19, 2013 7:31 AM
>To: Gregory Perry
>Cc: xenomai@xenomai.org
>Subject: Re: [Xenomai] Xenomai Documentation for ARM Integration
[...]
>This process is already documented in the README.INSTALL guide...
>The part we do not document is the configuration and compilation of
>the Linux kernel, someone else volunteered to provide more documentation
>on this subject, you may want to coordinate your efforts with him.

It seems that this is the step where most of the confusion arises; OpenEmbe=
dded with Bitbake recipes are the recommended method for compiling a kernel=
 on the BeagleBone, but the way that OE is setup does not facilitate easy p=
atching of the kernel or even a reasonable way to fetch a specific kernel r=
evision that is compatible with Xenomai.  Subsequent invocations of Bitbake=
 will then destroy changes that have been made to a custom kernel, there ha=
s to be a better way to maintain a kernel with Xenomai than this.  I am thi=
nking a non-OE kernel + Xenomai integrated git repo with Buildroot for crea=
ting a minimal target kernel and filesystem with userland Xenomai support. =
 Unless there is a better way than this?

Regards

Gregory Perry

