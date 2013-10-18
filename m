Message-ID: <5260ED32.6020503@xenomai.org>
Date: Fri, 18 Oct 2013 10:11:30 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <97C47D59E60521478493FB52050AD07E439CCCA5D3@hubmail>
In-Reply-To: <97C47D59E60521478493FB52050AD07E439CCCA5D3@hubmail>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FW:  Xenomai support for mips64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Saravana Kumar P M <saravanam@india.tejasnetworks.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/18/2013 09:50 AM, Saravana Kumar P M wrote:
> Hi,
> We are having a system with lots of legacy code(device drivers) developed out of kernel 2.6.32
> We are adding new processes which require hard real time performance.
> We are using Cavium-Octeon II device which has a mips64 core.
>
> To solve the problem of hard real time performance Xenomai seems to be a great solution.
> However, I am not very clear whether Xenomai can run on Cavium-Octeon II device(mips64)
> I tried searching for the info but was not able to get it. Sorry.
> Eventhough in the hardware support page MIPS is not available, I can see some mail threads on porting to MIPS as old in year 2006.
>
> Please let me know if a port of Xenomai is available for Cavium-Octeon II device(mips64).
>

There is no Xenomai port to mips*, at least, the project received no 
contribution regarding this, and to my knowledge, no core Xenomai 
developer ever tackled this task. This is why MIPS is not mentioned in 
our hardware support page.

This is unfortunate, since there would be no technical barrier to port 
Xenomai to the mips architecture though. However, porting is one 
reasonably simple thing to do, long term maintenance of the resulting 
port is a different, much more demanding task.

-- 
Philippe.

