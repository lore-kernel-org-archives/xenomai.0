References: <6309036.vrZ57LHtHK@wirbelwind> <8954471.7jTm9DH39K@wirbelwind>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56645788.6030604@xenomai.org>
Date: Sun, 6 Dec 2015 16:43:04 +0100
MIME-Version: 1.0
In-Reply-To: <8954471.7jTm9DH39K@wirbelwind>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] powerpc 440 userspace latency test does nothing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: steven.seeger@nasa.gov, xenomai@xenomai.org

On 12/06/2015 04:46 AM, Steven Seeger wrote:
> I went ahead and used the ipipe-core-3.14.39-powerpc-8 patch and built the 
> vendor's 3.14.2 kernel against it. I didn't have to do as much work as I did 
> with the 3.18.20 patch. I had the same results (both with latency and with 
> freezing.)
> 
> At this point I've got the answers I need from this exercise, but it would be 
> good to understand the problem and possibly fix it. If anyone can point me in 
> the right direction maybe I can take a look at it.
> 

For the Virtex5 family, we likely need the xilinx-intc controller, and
that one has not been made pipeline-aware in the kernel tree. I checked
Xenomai 3.0.1 over a yosemite 44xFP SoC and all went well, so this is
consistent with a SoC-dependent issue on the ml507 (AMCC's 440EP sports
a single UIC).

I would suggest to have a look at arch/powerpc/sysdev/xilinx_intc.c, and
make sure it implements the I-pipe helpers and tweaks.

/proc/interrupts should reveal all interrupt controllers in use for a
given configuration (make sure to enable GPIOs to have a complete
report). From that point you should be able to cross-check that each of
them is supported by the pipeline.

-- 
Philippe.

