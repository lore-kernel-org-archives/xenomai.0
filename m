Message-ID: <51FE46F6.7020909@xenomai.org>
Date: Sun, 04 Aug 2013 14:20:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51F267DB.2050404@axelsw.it>
In-Reply-To: <51F267DB.2050404@axelsw.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] fcse best-effort mode has limitations in memory map
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Bielli <roberto.bielli@axelsw.it>
Cc: Xenomai <xenomai@xenomai.org>

On 07/26/2013 02:13 PM, Roberto Bielli wrote:

> Hi,
>
> i try to map a memory address fixed on 0x79000000 with mmap.
> if i don't enable FCSE with best effort the mmap give me the desire
> wanted address,
> otherwise seems only an adress minor than 32MB.
>
> But i understand that fcse with best effort cannot has limitations.
>
> Xenomai 2.6.2.1 on kernel 3.4.6, tx28 karo ( freescale imx28 ) ARM.


Hi,

sorry for not seeing this message earlier, yes, this is a limitation in 
the fcse patch modifications made to the mmap method. Note however that 
if the process for which you create this mapping is a real-time process, 
cache will be flushed every time the context is switched to this 
process. So, in short, you will get little benefit from the FCSE patch.

The best effort support for processes with address spaces larger than 
32MB is made for other uses cases:
- several processes with address-space larger than 32MB, but which are 
not activated often, so most of the time cache will not have to be flushed;
- only one process with an address-space larger than 32MB, and less than 
95 processes total, so that all processes can cohabit without any cache 
flushes.

Your case could apply to the second case, but since the address 
0x79000000 is very high, you will not be able to create many more 
processes, for efficiency reason the FCSE patch supposes that your 
process needs the whole space between 0 and the end of the 0x79000000 
mapping, so, you could only create around 33 more processes with PIDs 
above 0x7b000000 allowing to run your system without cache flushes.

That being said, I will try and remove this limitation, thanks for 
bringing this to the list attention.

Regards.

-- 
                                                                 Gilles.

