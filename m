Message-ID: <486C811F.2050801@domain.hid>
Date: Thu, 03 Jul 2008 09:34:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51B669A8A7D2914E9AB2B3F40AC6553E647060@domain.hid>
	<486BC042.5030300@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E647061@domain.hid>
	<486BC7AD.3060108@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E647062@domain.hid>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E647062@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] remote gdb debugging and Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

Karch, Joshua wrote:
> Gilles,
> 
> so I installed the same version of gdb (6.4.90) which is older but is
> part of the debian distro I am using.  I've tried using gdbserver to
> connect as well as gdb.
> 
> When I use a version of gdbserver and gdb on the target machine, I
> can debug and set breakpoints without issues on the target machine.
> The Xenomai libraries have the symbols necessary for debugging. 
> However, on my desktop, I don't have those libraries installed.
> 
> I'm running eclipse with GDB set to gdbserver Debugger.  I also NFS
> mounted the Xenomai target machine and under the "Shared Libraries"
> of Debug from project properties in Eclipse I included the /lib,
> /usr/lib, and /usr/xenomai/lib directories.  I am using ssh tunneling
> to do "make" and the compile works fine.  I've also tried setting GDB
> to "remote gdb/Mi" through ssh, but I am unable to make that work.
> If I could run gdb over ssh tunneling through Eclipse, all of the
> proper symbols would be loaded, and I would be able to debug
> properly.  I keep getting tunnel errors if I try that method.  My
> only other option is using gdbserver, but that requires me to have
> the same version of gdb on both the Xenomai machine and my desktop,
> plus the libraries.  My issue in this case is I can't get the
> libraries off the Xenomai machine to be loaded by GDB on my desktop
> so I can debug.
> 
> Any ideas?

I know nothing about eclipse, sorry, after all, this is Xenomai
mailing-list, not eclipse mailing list.
However, what I can tell you is that the best way I have found to work
with gdb on targets, is to use gdb's solib-absolute-prefix.

All you have to do is to install all your packages with full debug
symbols in a staging directory, at the place they will be on the target.
And either use directly this directory via NFS on your target, or
generate another directory where all binaries and libraries are stripped
but at the same place as in the non-stripped staging directory, using
that second directory to generate your target system image. Then, when
running gdb with gdb server do:
set solib-absolute-prefix /path/to/non-stripped/staging/dir
After that, when gdbserver will open a (maybe stripped) file on the
target, gdb will look in the non-stripped staging dir for the same lib
with debug symbols and find it.

I suggest you understand and learn to use gdb without frontends before
using it through frontends, this will let you a lot understanding why
frontends do not work as you would expect.

-- 


					    Gilles.

