Date: Mon, 19 Jan 2015 07:42:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150119064245.GG1991@hermes.click-hack.org>
References: <74BA8E0B069CA64E8F62901CD1E66D50089C7DB3@TOSBLRMBX02.TOSHIBA-TSIP.COM>
 <CA+HFbxAGWHR_JdXpG7FHwxbGsQD3nzu3u_+etTn5ymjGZP3i9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HFbxAGWHR_JdXpG7FHwxbGsQD3nzu3u_+etTn5ymjGZP3i9A@mail.gmail.com>
Subject: Re: [Xenomai] needs help
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: satya patel <satya087@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Jan 19, 2015 at 11:52:47AM +0530, satya patel wrote:
> Hi,
> 
> I am trying to compile linux-10.32+ipipe-10.32  with xenomai 3 while
> compilation I am getting below warnings after enabling
> CONFIG_IPIPE_ARM_KUSER_TSC.
> 
> 
> 
> 
> 
> WARNING: arch/arm/kernel/built-in.o(.text+0x8988): Section mismatch in
> reference from the function __ipipe_tsc_register() to the variable
> .init.text:__ipipe_tsc_area_start
> 
> The function __ipipe_tsc_register() references
> 
> the variable __init __ipipe_tsc_area_start.
> 
> This is often because __ipipe_tsc_register lacks a __init
> 
> annotation or the
> 
> annotation of __ipipe_tsc_area_start is wrong.
> 
> 
> 
> Please let me know what might be reason for this warning.

The reason for the warning is explained in the warning itself. The
issue has been fixed since then, you should not have it with the
I-pipe patch for Linux 3.14.

-- 
					    Gilles.

