Date: Mon, 23 Feb 2015 13:52:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150223125226.GB16040@hermes.click-hack.org>
References: <9BA84827B30CBE4996725F98F7DC912342902DC9@SMExchange01.siebmeyer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912342902DC9@SMExchange01.siebmeyer.org>
Subject: Re: [Xenomai] rt_heap_bind, Error=-11 -> EWOULDBLOCK why?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander <alexander.haenel-baas@sieb-meyer.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Feb 23, 2015 at 12:44:21PM +0000, Hänel-Baas, Alexander wrote:
> Hi
> 
> We have a working system with xeno 2.6.4, Kernel 3.14.17 and a Kontron PC TT-Module.
> 
> It is a normal situation: a Pci card with an fpga spends memory and the kernel driver create the shared mem with rt_crate_heap.
> The userspace program get the memory with rt_bind_heap.
> This works fine.
> 
> Now I change only the cpu from TT-Module to a Bytrail-Modul, and now I get the error that the named heap was not found?
> "rt_heap_bind(shmName=SLINK4) failed. Error=-11"
> 
> The kernel says:
> []sd3:826 map pfn expected mapping type uncached-minus for [mem 0x00050000-0x0005afff], got write-back
> 
> I found out, when I add  "nopat" to the kernel cmd line, the rt_heap_bind function are lucky.
> But I think this is not the best solution, probably I allocate the memory with wrong flags?
> 
> Any ideas what must I do?

Did you try adding H_NONCACHED to rt_heap_create flags ? Since your
new device seems to require the memory to be uncached.

-- 
					    Gilles.

