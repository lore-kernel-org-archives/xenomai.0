Message-ID: <51FE5208.9090008@xenomai.org>
Date: Sun, 04 Aug 2013 15:07:20 +0200
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
Cc: xenomai@xenomai.org

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


Well, actually it works here, maybe you forgot to pass the "MAP_FIXED" 
flag? If you do not pass this flag, the address is taken as a "hint", 
and mmap has no obligation to use it.

-- 
                                                                 Gilles.

