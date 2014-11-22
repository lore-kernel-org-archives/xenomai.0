Date: Sat, 22 Nov 2014 17:42:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141122164224.GO6931@sisyphus.hd.free.fr>
References: <C34B698C-EAE2-4FDB-806A-42534A6CBD22@gatech.edu>
 <20141120192151.GD4545@sisyphus.hd.free.fr>
 <ED3D3EA3-E2CF-4D13-AD18-68E75705DD83@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED3D3EA3-E2CF-4D13-AD18-68E75705DD83@gatech.edu>
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

On Sat, Nov 22, 2014 at 10:18:32AM -0500, Yogi A. Patel wrote:
> I understand your point about the primary mode issues with the Linux kernel based GPU drivers and needing to port them. However, the solution I was thinking about was to use a library called ArrayFire. 
> 
> ArrayFire (http://arrayfire.com/) the library communicates with the GPU through synchronous and asynchronous function calls made on the host (CPU) side. 

I do not think a library which accesses GPU registers from
user-space is even possible:
- the GPU registers are kind of a trade secret, sure NVIDIA released
some documentations, but I believe it is for some old GPUs, not the
latest ones, sure there is nouveau, but I do not think they got all
the registers covered; 
- since the GPU registers are shared with the graphic driver, which
handles what is displayed on your screen, you have obvious
concurrence issues, and doing this would result in a risk of
breaking what is displayed on the screen by the OpenGL pipeline, and
a risk of the graphic drivers breaking what you are doing. You need
a centralized arbiter to all that, and the driver is that
centralized arbiter. If it had been possible to do everything from
user-space, I believe NVIDIA would have done it instead of
implementing their controversial driver.

Extracted from ArrayFire README.md

ArrayFire's multiple backends (CUDA, OpenCL and native CPU) make it
platform independent and highly portable.

The native CPU port probably does not use the GPU, and CUDA and
OpenCL are probably based on libraries which interact with GPU
drivers.

-- 
					    Gilles.

