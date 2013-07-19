From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 19 Jul 2013 09:29:22 -0400
Message-ID: <20130719132922.GA17022@csclub.uwaterloo.ca>
References: <BC6109C5-9FF8-488D-9A1C-A983B1AD3415@imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BC6109C5-9FF8-488D-9A1C-A983B1AD3415@imag.fr>
Subject: Re: [Xenomai] Xenomai and NVIDIA graphics drivers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Skander Bahloul <skander.bahloul@imag.fr>
Cc: xenomai@xenomai.org

On Fri, Jul 19, 2013 at 11:32:25AM +0200, Skander Bahloul wrote:
> Dear Xenomai list members,
> 
> I'am a student and beginner.
> I am in charge of installing, configuring and testing Xenomai for hard real-time interactive physically based simulation.
> The laboratory and myself have very small experience on Xenomai.
> 
> I need high quality graphics on the machine with the NVIDIA drivers, but do not succeed.
> 
> I have various installation ongoing, eg on Debian, Ubuntu, fedora.
> Only Debian is successful so far.
> OS :
> 	Debian 7.1 AMD64
> 	Kernel 3.2.21 (updated from 3.1.0 AMD64)
> 	Xenomai 2.6.1
> Final xenomai version (uname -r) : Xenoami-ipipe-3.2.21
> Machine :
> 	Architecture : Intel X86
> 	GPU Quadro 2000
> 
> 
> Is it possible ? It is AFAIK.
> Can you indicate a good tutorial on this issue ?
> 
> 
> More details now.
> 
> 
> I tried installing the drivers before Xenomai, but i cannot : 
> 
> 
> I tried installing the NVIDIA drivers after installing Xenomai, but then the installation fails:
> 
> Error! bad return status for module build on kernel 3.2.21-xenomai-ipipe (X86-64). consult /var/lib/dkms/nvidia/319.31/build/make.log for me more information.

Did you actually do what it told you to do?  That is, look at the build
log for the error/problem?

> I try to do :
> $ sh Nvidia-linux-x86-319.31.run --kernel-name='xenomai-ipipe-3.2.21' 
> 
> but it fails.

-- 
Len Sorensen

