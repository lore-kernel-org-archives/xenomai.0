Message-ID: <31e1856136e687804b394e184552f972.squirrel@127.0.0.1>
In-Reply-To: <OF396B4F72.527821E8-ONC1257BEC.0054EA5D-C1257BEC.00550203@marposs.com>
References: <OF396B4F72.527821E8-ONC1257BEC.0054EA5D-C1257BEC.00550203@marposs.com>
Date: Fri, 20 Sep 2013 17:31:57 +0200
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
>
>
> Dear experts
>
> I am developing a system with arm architecture (atmel AT91SAM9G20) with
> linux 2.6.30 and xenomai 2.5.4.
>
> I have written a very simple user xenomai application that creates and
> starts a real time task (rt_task_create and rt_task_start), with high
> priority, that periodically access a memory mapped IO.
>
> Using an oscilloscope I have seen a very little gitter but enabling the
> trace on secondary mode switch I have seen that the access to memory
> mapped
> IO, triggers the event of secondary mode switch.
>
> I have used open /dev(mem and mmap outside the rt task and I have obtained
> a virtual pointer.
> Inside the rt task I write the location using the virtual pointer.
>
> I obtain the same result using  xenomai latency example adding my memory
> mapped IO functions.
>
> I don't understand. Cannot I use this method to access memory mapped IO.

The access to this memory area causes a fault. The reason why this could
happen could be that:
- the area is mapped on demand, I do not believe this is the case for
/dev/mem;
- you are accessing the area using unaligned accesses.

-- 
                                              Gilles


