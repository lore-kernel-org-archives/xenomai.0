In-Reply-To: <41178a65d105c2ecba29517766108672.squirrel@127.0.0.1>
References: <OF396B4F72.527821E8-ONC1257BEC.0054EA5D-C1257BEC.00550203@marposs.com>
	<31e1856136e687804b394e184552f972.squirrel@127.0.0.1>
	<OFC8321BA4.DEA5320E-ONC1257BEC.0055985D-C1257BEC.00567EE5@marposs.com>
	<41178a65d105c2ecba29517766108672.squirrel@127.0.0.1>
Message-ID: <OF9F68F0D3.ACCF0213-ONC1257BEF.002B87CA-C1257BEF.002CB465@marposs.com>
From: stefano.franzoni@marposs.com
Date: Mon, 23 Sep 2013 10:08:17 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
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

I have understood that the problem is related to the first access to memory
mapped IO, probably the first access generates the fault caused by lack of
memory page and then the transition to the secondary mode.
If I force an access outside real time task, the problem does not happen
anymore.
However, I ask if, in a more complex application, the page can be swapped
and then the transition to secondary mode can happens again.

I used mlockall (MCL_CURRENT | MCL_FUTURE) before mapping the IO and I
thought that this would prevent memory paging to the swap area.

What is wrong?

Stefano




                                                                           
             "Gilles                                                       
             Chanteperdrix"                                                
             <gilles.chanteper                                          To 
             drix@xenomai.org>         stefano.franzoni@marposs.com        
                                                                        cc 
             20/09/2013 18:02          "Gilles Chanteperdrix"              
                                       <gilles.chanteperdrix@xenomai.org>, 
                                       xenomai@xenomai.org                 
                                                                   Subject 
                                       Re: [Xenomai] memory mapped IO and  
                                       secondary mode switch               
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           





stefano.franzoni@marposs.com wrote:
> These is the initialization functions
>
>
> StartAddress = 0x60000000
> Size = 4096
>
> ...
> int memD = open("/dev/mem", O_RDWR | O_SYNC))
> ..
> vouid *pMemIO = mmap(0, Size, PROT_READ | PROT_WRITE, MAP_SHARED, memD,
> StartAddress);
> ...
>
>
>
> Then all access are made to pMemIO[4]

So, void * is char *, you need to lookup in the SOC documentation if this
register can be accessed in byte mode, or if you need to use for instance
a 32 bits access with *(unsigned *)&pMemIo[4].

--
                                              Gilles




