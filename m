Message-ID: <54C27115.7030901@xenomai.org>
Date: Fri, 23 Jan 2015 17:04:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <129277905.Ag2XebZWbK@soho>
In-Reply-To: <129277905.Ag2XebZWbK@soho>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, xenomai@xenomai.org

On 01/23/2015 01:09 PM, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> now that I have some kernel to boot, I would like to ask some aspects of 
> Xenomai-3 in order to package it.
> 
> Reading the documentation, now the new libxenomai could use two kind of 
> kernels: the patched one (Cobalt) or the preempt_rt (Mercury).
> 

Mercury does not require preempt-rt. In some cases, one may want the API
emulation capabilities without actually having real-time requirements.

> 1) Is it possible to have _only_ one library (binary) that uses one or another 
> kernel in function which is running?
> 

No. Definitely not.

> 2) If not, as we must recompile the library, all the programs linked against 
> must be recompiled or if it's binary compatible?
> 

Can't have the same ABI. Two separate builds are required.

> 3) Comparing the files generated (xenomai-2.x vs xenomai-3.x, if you bump the 
> sonames of libanalogy, libpsos and libvxworks you could have (I guess) both 
> binary versions installed in the same box.
> 

This would make sense, but only for libs. Scripts, includes would conflict.

> 4) Why the libvxworks has lower soname version in 2.6.4 than in 3.0.0?
> 

Because it has been entirely rewritten over the copperplate interface
and extended in terms of emulated services.

-- 
Philippe.

