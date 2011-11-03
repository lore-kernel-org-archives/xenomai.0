Message-ID: <4EB2FC62.2040406@domain.hid>
Date: Thu, 03 Nov 2011 21:41:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20111102201210.GY30117@domain.hid>
	<4EB1B691.9020801@domain.hid>
	<20111103151353.GB30117@domain.hid>
	<4EB2B58F.3070600@domain.hid>
	<20111103161844.GC30117@domain.hid>
	<20111103170042.GD30117@domain.hid>
	<4EB2CB84.3060004@domain.hid>
	<20111103190029.GE30117@domain.hid>
	<4EB2F6D5.4050208@domain.hid>
	<20111103203407.GG30117@domain.hid>
In-Reply-To: <20111103203407.GG30117@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] irq related kernel crash with adeos 3.0.4 powerpc.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Lennart Sorensen <lsorense@domain.hid>
Cc: adeos-main@gna.org

On 11/03/2011 09:34 PM, Lennart Sorensen wrote:
> On Thu, Nov 03, 2011 at 09:17:25PM +0100, Philippe Gerum wrote:
>> Ok. In case of a general issue with the pipeline on 83xx, and
>> specifically the changes introduced for dealing with the interrupt
>> controller, please let me know. I may have access to a 8308 to have
>> a look.
>
> OK, I found patch f42af6c486aa5ca6ee62800cb45c5b252020509d in Linus's
> tree from about two weeks ago.  It fixed the problem.
>
> Everything appears to be working now.
>
> Will beat up the system some more overnight.
>
> Cascading IRQs from both the QE and our own FPGA based interrupt
> controller are being handled by ipipe now, so I would say
> 3.0.8-powerpc-2.13-04 looks good.  Along with xenomai 2.5.6 with a few
> selected patches from xenomai-head to make it compile with 3.0 kernel.
>

Thanks for reporting. Gilles is about to push 2.6.0 out, which will 
include ipipe 3.0.8-2.13-04.

-- 
Philippe.

