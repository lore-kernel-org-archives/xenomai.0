Message-ID: <4CB5A7DD.9090203@domain.hid>
Date: Wed, 13 Oct 2010 14:36:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DF9F3A3C150B0646A17FF1487C1B6D5E0380C00C@rennsmail06.eu.thmulti.com>
	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C00E@rennsmail06.eu.thmulti.com>
	<4CB57DB2.3010709@domain.hid>
	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C010@domain.hid>
In-Reply-To: <DF9F3A3C150B0646A17FF1487C1B6D5E0380C010@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_heap and DMA32 zone
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Daniel Jacques (Alten)" <jacques.daniel@domain.hid>
Cc: xenomai@xenomai.org

Daniel Jacques (Alten) wrote:
> Please find bellow and in attachment the requested information:
> 
> Linux kernel: 2.6.32.15
> Adeos patch: adeos-ipipe-2.6.32.15-x86-2.7-01.patch
> Xenomai: 2.5.4
> Host Linux distribution: Based on Debian 5.0
> Compiler: gcc version 4.3.2
> 
> Piece of code:
> #define HEAP_SIZE_IN_BYTES 16*1024*1024 
> static int __init audioInit_module(void)
> {
> int status;
> RT_HEAP heap;
> 
>  ...
> 
>   /* Create the global heap */
>   if( (status = rt_heap_create(&heap, "audioInputHeap", HEAP_SIZE_IN_BYTES, H_SHARED|H_DMA )) < 0 ) 
>   {
>     printk("rt_heap_create audioInputHeap error %d\n", status );
>     return status;        
>   }
>   else
>   {
>     printk ("Heap audioInputHeap created\n");
>   }
> 
> ...
> 
> }

So, if I understand correctly, the problem is that Linux does not use
the DMA32 pool when it is passed the GFP_DMA flag? In that case, you
probably need an H_DMA32 flag, which get translated into GFP_DMA32 by
the rtheap code.

-- 
					    Gilles.

