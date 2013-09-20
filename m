Message-ID: <41178a65d105c2ecba29517766108672.squirrel@127.0.0.1>
In-Reply-To: <OFC8321BA4.DEA5320E-ONC1257BEC.0055985D-C1257BEC.00567EE5@marposs.com>
References: <OF396B4F72.527821E8-ONC1257BEC.0054EA5D-C1257BEC.00550203@marposs.com>
	<31e1856136e687804b394e184552f972.squirrel@127.0.0.1>
	<OFC8321BA4.DEA5320E-ONC1257BEC.0055985D-C1257BEC.00567EE5@marposs.com>
Date: Fri, 20 Sep 2013 18:02:18 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] memory mapped IO and secondary mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: stefano.franzoni@marposs.com
Cc: xenomai@xenomai.org


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


