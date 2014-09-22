Message-ID: <542092EE.8090904@xenomai.org>
Date: Mon, 22 Sep 2014 23:21:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <loom.20140922T230305-367@post.gmane.org>
In-Reply-To: <loom.20140922T230305-367@post.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] main : can't open rtser0 (write) for ./cross-link
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: bob <kobebry48@gmail.com>, xenomai@xenomai.org

On 09/22/2014 11:11 PM, bob wrote:
> Hi,
> so I've been searching google for a while now and the results haven't been
> helping.
> 
> i tried setserial /dev/ttyS0 , i get the typical io=0x3f8, IRQ=4
> 
> i set uart to none, and my normal serial programs with my device don't read
> anything as expected
> 
> i did /sbin/modprobe xeno_16550A \
>                io=0x3f8 \
>                irq=4 \
>                baud_base=115200
> 
> and modprobe xeno_16......
> 
> and sudo and all the permutations possible
> 
> i dont get nay mesasge back, but when i run cross-link it still gives me the
> same error, main : can't open rtser0 (write) 
> 
> im not sure if im loading the xenomai driver right, is there something im
> missing?
> 
> my lsmod DOES NOT show any of these
> # lsmod
> Module                  Size  Used by
> xeno_16550A            12392  0
> xeno_rtdm              23460  1 xeno_16550A
> xeno_native           114384  0
> xeno_nucleus           82696  3 xeno_16550A,xeno_rtdm,xeno_native
> xeno_hal               23616  4

Well, did you compile the module? Or is it builtin?

> 
> http://www.acadis.org/pages/captain.at/serial-port-example 
> makefile does not work for me
> 
> http://www.acadis.org/pages/captain.at/xeno-16550A
> i don't have a directory in /usr/realtime/

These pages are outdated. Xenomai 2.2 dates back from 9 years ago.

> 
> anyone have any ideas or suggesitons or recommendation of alcohol?

Maybe you could try the xenomai.org documentation:
http://xenomai.org/serial-16550a-driver/


-- 
                                                                Gilles.

