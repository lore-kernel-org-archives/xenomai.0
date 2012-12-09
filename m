Message-ID: <50C4EF5A.3030502@wanadoo.fr>
Date: Sun, 09 Dec 2012 21:06:50 +0100
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <50C1EF04.1090506@wanadoo.fr> <50C236B9.3030507@xenomai.org>
In-Reply-To: <50C236B9.3030507@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] iMX6q 1Hz tick
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

Le 07/12/2012 19:34, Gilles Chanteperdrix a écrit :
> On 12/07/2012 02:28 PM, Thierry Bultel wrote:
>
>> Hi,

Hello Gilles,

>>
>> I have "successfully" patched a 3.0.35 kernel from Freescale with
>> adeos-ipipe-3.0.36-1.18.11
>>
>> I have -not- applied the adeos-ipipe-3.0.36-arm-1.18-11-pre.patch
>> that showed too much "revert patch detected" errors.
>
>
>
> The patch should apply cleanly, the question, if you get too many
> rejections, it is because you do not apply it to the proper branch.
>

Of course it was not.
I started with a kernel provided by the module manufacturer. I estimate 
that this kernel is "almost" a rel_imx_3.0.35_12.09.02, I mean, that
I have not found a closer tag than this one.

My first idea was to attempt to apply the patches to that kernel
directly. I was not expecting it would have been simple, and it was 
actually not. But after a few hours I came to the initial result I said.



>>
>> BTW, I have understand that its purpose was mainly to upgrade to 3.0.36,
>> but what is actually the role of the
>> adeos-ipipe-3.0.36-arm-1.18-11-post.patch ? (I applied it).
>
>
> I have explained this in a previous mail.

Ok, I will seek in the history. I would be nice if the explanation
was in the README.

>
>>
>> I had to deal with some rejections but at least the kernel is booting
>> and my application running.
>>
>> But the target is very slow, and /proc/xenomai/irq shows that the
>> [timer] irq only comes about every 1 second.
>>
>> The /proc/interrupts shows an IRQ every 10ms, which was expected
>> since I have CONFIG_HZ=100
>>
>> I am pretty sure that I messed up something in the patch process,
>> however I do not know where to start to look for.
>
>
> Apply the patches to the proper imx release, and everything should be fine.


That is what I did, at last.
To do so, I have extracted the BSP from the given 'almost' 
rel_imx_3.0.35_12.09.02 kernel,
taken the rel_imx_3.0.15_12.03.00, applied the patches,
and brought back the BSP to the patched kernel.

The kernel boots, it is stuck for some seconds when initializing 
network, but I have noticed some substancial differences on the fec 
driver, I should take a look at that later.

I do not have the slowness issue anymore,
/proc/xenomai/irq shows the timer IRQ counter increasing, on the 4 CPUs


[root@buildroot ~]# cat /proc/xenomai/irq | grep timer
  29:      257278       86177       23138       11670         [timer]

However,

in /proc/interrupts,
I have
  87:          8          0          0          0       GIC  i.MX Timer Tick

The counter increases -very- slowly, I have not measured accurately, but 
I takes several minutes to increase by one.

Where can I look to fix that issue please ?


Another issue I have noticed is that the "reboot" command takes about 
10-12 seconds, whereas it is almost immediate with the original kernel.

regards
Thierry

>


