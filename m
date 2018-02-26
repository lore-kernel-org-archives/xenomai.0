References: <36415.147.91.1.44.1519652762.squirrel@mail.imp.bg.ac.rs>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7201e905-ba51-2781-e186-c1d1d11de916@xenomai.org>
Date: Mon, 26 Feb 2018 19:02:28 +0100
MIME-Version: 1.0
In-Reply-To: <36415.147.91.1.44.1519652762.squirrel@mail.imp.bg.ac.rs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] interrupt on edge problem, unexpected IRQ trap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: branislav.sasic@automatika.imp.bg.ac.rs, xenomai@xenomai.org

On 02/26/2018 02:46 PM, branislav.sasic@automatika.imp.bg.ac.rs wrote:
> Hello,
> 
> I have a problem with new I-pipe patch, which was not existing with legacy
> patch on 3.14 kernel, on BeagleBone platform.
> 
> When GPIO pin is configured as input with edge interrupt enable, on IRQ
> occurrence the following message appears:
> 
> 
> [  303.331386] irq 88, desc: dc1be400, depth: 0, count: 0, unhandled: 0
> [  303.331401] ->handle_irq():  c01a810c,
> [  303.331435] handle_edge_irq+0x0/0x194
> [  303.331442] ->irq_data.chip(): dc097b50,
> [  303.331454] 0xdc097b50
> [  303.331461] ->action(): da097380
> [  303.331467] ->action->handler(): c078dce4,
> [  303.331483] gpio_sysfs_irq+0x0/0x24
> [  303.331493]    IRQ_NOPROBE set
> [  303.331503] unexpected IRQ trap at vector 58
> 
> [  303.335814] ------------[ cut here ]------------
> [  303.335832] WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:883

As Greg pointed out, there is no way we can figure out which kernel you
are running, which is a key information for us to help you.

Anyway, looking at the backtrace, it looks like the interrupt is not
properly pipelined. You need drivers/gpio/gpio-omap.c to be fixed up in
your kernel the way this commit fixes up a mainline 4.14 kernel:

http://git.xenomai.org/ipipe-arm.git/commit/?id=63b8ee7f25b73547ac8eff7a6be5b587422015ca

-- 
Philippe.

