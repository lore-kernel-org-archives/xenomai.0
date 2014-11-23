Date: Sun, 23 Nov 2014 17:26:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141123162633.GD24229@sisyphus.hd.free.fr>
References: <C34B698C-EAE2-4FDB-806A-42534A6CBD22@gatech.edu>
 <20141120192151.GD4545@sisyphus.hd.free.fr>
 <ED3D3EA3-E2CF-4D13-AD18-68E75705DD83@gatech.edu>
 <20141122164224.GO6931@sisyphus.hd.free.fr>
 <9D034F52-BEA4-41E5-B9D3-7CFF49F669EB@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D034F52-BEA4-41E5-B9D3-7CFF49F669EB@gatech.edu>
Subject: Re: [Xenomai] GPU Processing Question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Nov 23, 2014 at 11:17:44AM -0500, Yogi A. Patel wrote:
> 
> > On Nov 22, 2014, at 11:42, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > 
> > On Sat, Nov 22, 2014 at 10:18:32AM -0500, Yogi A. Patel wrote:
> >> I understand your point about the primary mode issues with the Linux kernel based GPU drivers and needing to port them. However, the solution I was thinking about was to use a library called ArrayFire. 
> >> 
> >> ArrayFire (http://arrayfire.com/) the library communicates with the GPU through synchronous and asynchronous function calls made on the host (CPU) side. 
> > 
> > I do not think a library which accesses GPU registers from
> > user-space is even possible:
> > - the GPU registers are kind of a trade secret, sure NVIDIA released
> > some documentations, but I believe it is for some old GPUs, not the
> > latest ones, sure there is nouveau, but I do not think they got all
> > the registers covered; 
> > - since the GPU registers are shared with the graphic driver, which
> > handles what is displayed on your screen, you have obvious
> > concurrence issues, and doing this would result in a risk of
> > breaking what is displayed on the screen by the OpenGL pipeline, and
> > a risk of the graphic drivers breaking what you are doing. You need
> > a centralized arbiter to all that, and the driver is that
> > centralized arbiter. If it had been possible to do everything from
> > user-space, I believe NVIDIA would have done it instead of
> > implementing their controversial driver.
> > 
> > Extracted from ArrayFire README.md
> > 
> > ArrayFire's multiple backends (CUDA, OpenCL and native CPU) make it
> > platform independent and highly portable.
> > 
> > The native CPU port probably does not use the GPU, and CUDA and
> > OpenCL are probably based on libraries which interact with GPU
> > drivers.
> 
> Thanks, Gilles.
> 
> I spoke to the company that makes that library and they said that
> which registers are used by the CUDA application is left up to the
> nvidia compiler.

We are not talking about the same registers. You are talking about
the registers used by the CUDA compiler, on the GPU. I am talking
about the GPU registers available through PCI express. You will have
to program these to get the GPU to execute the code compiled by
CUDA. And the way to program these is to use the nvidia driver.

-- 
					    Gilles.

