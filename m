Subject: Re: Can printk in the root domain cause the system to hung ?
References: <20210425183312.12d2e2a5@jamie-ThinkPad>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fa5a2efa-32ff-1386-630b-05099c49a7ff@siemens.com>
Date: Tue, 27 Apr 2021 18:36:02 +0200
MIME-Version: 1.0
In-Reply-To: <20210425183312.12d2e2a5@jamie-ThinkPad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jamie Huang <jamienstar@163.com>, xenomai@xenomai.org, rpm@xenomai.org

On 25.04.21 12:33, Jamie Huang via Xenomai wrote:
> Hi, all:
> 	We are now porting ipipe on mips architecture. There is a
> problem, after local_irq_enable() is called in start_kernel(), system
> looks hung. We found that this may be related to printk in root domain,
> if we use early_printk instead of printk, the system looks normal and
> can continue the kernel boot process. Can someone tell me the possible
> reason, thanks!

Is your code published already?

Also note that the I-pipe architecture is becoming legacy. We are moving
all archs to dovetail over 5.10 now.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

