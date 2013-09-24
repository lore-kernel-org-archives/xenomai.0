In-Reply-To: <52408833.3020701@xenomai.org>
References: <OF396B4F72.527821E8-ONC1257BEC.0054EA5D-C1257BEC.00550203@marposs.com>
	<31e1856136e687804b394e184552f972.squirrel@127.0.0.1>
	<OFC8321BA4.DEA5320E-ONC1257BEC.0055985D-C1257BEC.00567EE5@marposs.com>
	<41178a65d105c2ecba29517766108672.squirrel@127.0.0.1>
	<OF9F68F0D3.ACCF0213-ONC1257BEF.002B87CA-C1257BEF.002CB465@marposs.com>
	<52408833.3020701@xenomai.org>
Message-ID: <OF7E86F86A.D7514A07-ONC1257BF0.002BDD7A-C1257BF0.002C8E24@marposs.com>
From: stefano.franzoni@marposs.com
Date: Tue, 24 Sep 2013 10:06:39 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] memory mapped IO and secondary mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I tried the function rt_timer_tsc but it does not generate the swap to
secondary mode.
It seems that the first write access generates the fault instead the read
accesses do not generate it.
I attach a simple example.


(See attached file: mmio_SecondaryModeSwitch.c)




                                                                           
             Gilles                                                        
             Chanteperdrix                                                 
             <gilles.chanteper                                          To 
             drix@xenomai.org>         stefano.franzoni@marposs.com        
                                                                        cc 
             23/09/2013 20:28          xenomai@xenomai.org                 
                                                                   Subject 
                                       Re: [Xenomai] memory mapped IO and  
                                       secondary mode switch               
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




On 09/23/2013 10:08 AM, stefano.franzoni@marposs.com wrote:
> I have understood that the problem is related to the first access to
memory
> mapped IO, probably the first access generates the fault caused by lack
of
> memory page and then the transition to the secondary mode.
> If I force an access outside real time task, the problem does not happen
> anymore.
> However, I ask if, in a more complex application, the page can be swapped
> and then the transition to secondary mode can happens again.
>
> I used mlockall (MCL_CURRENT | MCL_FUTURE) before mapping the IO and I
> thought that this would prevent memory paging to the swap area.
>
> What is wrong?

I am surprised the I/O pages are mapped on demand. Do you have the same
behaviour when you use rt_timer_tsc? rt_timer_tsc also uses a mapped
I/O. Otherwise no, I/O pages are not swapped out, it would not make
sense? mlockall only has an influence on memory mapping, not I/O mappings.

>
> Stefano
>
>
>
>
>

>              "Gilles

>              Chanteperdrix"

>              <gilles.chanteper
To
>              drix@xenomai.org>         stefano.franzoni@marposs.com

>
cc
>              20/09/2013 18:02          "Gilles Chanteperdrix"

>
<gilles.chanteperdrix@xenomai.org>,
>                                        xenomai@xenomai.org

>
Subject
>                                        Re: [Xenomai] memory mapped IO and

>                                        secondary mode switch

>

>

>

>

>

>

>
>
>
>
>
> stefano.franzoni@marposs.com wrote:
>> These is the initialization functions
>>
>>
>> StartAddress = 0x60000000
>> Size = 4096
>>
>> ...
>> int memD = open("/dev/mem", O_RDWR | O_SYNC))
>> ..
>> vouid *pMemIO = mmap(0, Size, PROT_READ | PROT_WRITE, MAP_SHARED, memD,
>> StartAddress);
>> ...
>>
>>
>>
>> Then all access are made to pMemIO[4]
>
> So, void * is char *, you need to lookup in the SOC documentation if this
> register can be accessed in byte mode, or if you need to use for instance
> a 32 bits access with *(unsigned *)&pMemIo[4].
>
> --
>                                               Gilles
>
>
>
>


--
                                                                Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mmio_SecondaryModeSwitch.c
Type: application/octet-stream
Size: 2296 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130924/a93b3ea6/attachment.obj>
