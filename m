Message-ID: <2ff1a98a0805280621k63327808ne547d0ebba6d51aa@domain.hid>
Date: Wed, 28 May 2008 15:21:12 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <df6ee85f837d916e8fffc4e64803ea79@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <df6ee85f837d916e8fffc4e64803ea79@domain.hid>
Subject: Re: [Xenomai-help] 32 bits Xenomai application over x86-64
	architecture
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

On Wed, May 28, 2008 at 2:50 PM, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
> Hi,
>
> I'm on a x86-64 architecture and I try to compile a 32 bits application. I
> use gcc with m32 option. I found out that Xenomai libraries are 64 bits
> libraries since, by default, the compilation of Xenomai Kernel keep the
> arch configuration. My problem is that there is no way I link a 64 bits
> library to a 32 bits application. I can't change the 32 bits environment of
> my application. Well, I investigate mail archives and I found some threads
> about installing Xenomai in 32 bits over a 64 bits arch, but I didn't found
> any issue. So my question is what can I do ? Use a configure the kernel
> with option like --arch=x86 ? Patch my kernel with 32 bits option for Adeos
> Kernel (prepare-kernel.sh --arch=i386 ) ? Reinstall my SuSE Linux ? Is
> there any wrapper that allow me to use 32 bits application over 64 bits
> Xenomai installation ?

Actually getting the 32 bits library on the 64bits architecture is not
that hard: you simply have to compile xenomai user-space support with
-m32. However, what will be missing next is a 32bits aware syscall
handler for each skin, and this does not exist as far as I know.

But as far as Xenomai syscalls are concerned there is no performance
gain to hope in using either 32 or 64 bits interfaces. Using 32 bits
interfaces would probably even be a bit slower since the 32bits
syscall handler would probably be implemented as simple wrappers to
the 64 bits versions.

So, you are left with two solutions: either be full 64 bits, or
implement the 32 bits syscalls wrappers for Xenomai.

-- 
 Gilles

