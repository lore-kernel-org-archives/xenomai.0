Message-ID: <4433DC01.6060104@domain.hid>
Date: Wed, 05 Apr 2006 11:02:25 -0400
From: Randy Smith <rsmith@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Questions porting existing rtai-24.1.12 app to
	xenomai (PART II)
References: <1CFEB358338412458B21FAA0D78FE86D042A2FEE@rennsmail02.eu.thmulti.com>	<44328187.6080005@domain.hid>
	<44327F66.10800@domain.hid> <44329186.3080908@domain.hid>
	<44329D27.1000400@domain.hid>
In-Reply-To: <44329D27.1000400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org



Philippe Gerum wrote:
>
> Ok, just to be 100% sure, I've just tried the following on a stock 
> 2.1.0 grabbed from the mirror:
>
> ../somewhere/xenomai-2.1.0/configure --build=i686-linux 
> --host=ppc-linux --prefix=$HOME/xenomai-install  CC=ppc_82xx-gcc 
> CXX=ppc_82xx-gcc AR=ppc_82xx-ar LD=ppc_82xx-ld
>
> The resulting tree builds and install fine under $HOME/xenomai-install 
> afterwards. There is no kernel dependency whatsoever since the 
> user-space support does not even know about the kernel version which 
> is going to be used in the first place, so we should be able to get 
> the same user-space setup. Could you try rebuilding in a clean build 
> tree using equivalent switches at config time, and let me know of the 
> outcome? TIA,
>
Philippe,

Thanks for your patient help.  I did what you asked and it works fine 
for the user side.

The kernel side is what is screwed up.  I am using the ELDK 3.1 from the 
DENX CD and when I try applying the Adeos patch, it fails in several 
places.  I ended up applying the patch by hand and I only had a few 
places where I was scratching my head as to where to apply the changes 
so that might be what I screwed up.  Is the 
xenomai-2.1.0/ksrc/arch/powerpc/patches/adeos-ipipe-2.4.25-ppc-denx-1.0-03.patch 
supposed to apply to the develop tree for ELDK 3.1 instead??  I couldn't 
make heads or tails of the numbering scheme used on the patch wrt the 
"denx-1.0-03" part. 

I'm so close...and I really want to figure this out.

-Randy

