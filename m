Message-ID: <4DF1C36F.4060204@domain.hid>
Date: Fri, 10 Jun 2011 09:10:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTimhH=Tk9xERNHD0wh7ZbXzYaB3xrA@mail.gmail.com>
In-Reply-To: <BANLkTimhH=Tk9xERNHD0wh7ZbXzYaB3xrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Need help to use Xenomai on Debian (even after
 reading the wesite tutorial)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Luis Rossi <luisf.rossi@domain.hid>
Cc: xenomai@xenomai.org

On 06/10/2011 03:45 AM, Luis Rossi wrote:
> Hi,
> 
> I am trying to use Xenomai with Debian, but i am kind lost here. Even after
> reading this: http://www.xenomai.org/index.php/Building_Debian_packages, i
> could not figure out how to use Xenomai on a Debian with a x86. I am really
> not experienced with linux kernel.
> 
> First of all i have a few questions. If Xenomais is a patch, why should i
> build a patched kernel? Is it no suposed to patch an already built kernel?

Xenomai is not really a patch, Xenomai relies on a patch, the Adeos
I-pipe patch. And this patch is a patch for the kernel sources, not a
binary patch, so, yes, the patched kernel needs to be compiled. For more
details about Adeos, see:

http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-rev-B.pdf

> 
> Why there isnt available already built kernels for every architecture?

Because, currently, a Linux kernel needs to be well tuned for your
particular machine. See:
http://www.xenomai.org/index.php/Configuring_x86_kernels

> 
> On a final stage i need to use xenomai on a PC104 with an Atom, with no
> keyboard, Mouse or display, and a debian system with just the baisc
> packages, a ssh server and Xenomai. What wouldbe the most portable way to
> use Xenomai so i can replicate that system easily?
> 
> 
> On the Web page is said "For development, linux-patch-xenomai and
> libxenomai-dev are needed, for "production" systems, you should just need
> xenomai-runtime und libxenomai1 (together with the self built kernel as
> described in the next section)." What development means? Development of
> Xenomai itself?

Xenomai is a library, not really different from say, the C library. The
programs you write need the library to run, the library being provided
by the xenomai-runtime and libxenomai packages, but in order to develop
these programs, you need the interface definitions for this library, the
header files, these ones are provided by the libxenomai-dev package.

> 
> Can any one provide me an explanations for dummies on how to build a debian
> with xenomai, with a simple explanation on what is being made and why?

The debian instructions are relatively clear. For more details, look at
other documents on Xenomai website which are not specific to Debian. The
installation instructions are found here:
http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL

For a page pointing to most of the Xenomai project documentation, start
here:
http://www.xenomai.org/index.php/Included_documentation_summary

-- 
					    Gilles.

