Message-ID: <50B4FFBE.20204@xenomai.org>
Date: Tue, 27 Nov 2012 19:00:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <04934a1da80b9542fe5e0375b07d3663@isir.upmc.fr>
	<50AF48DA.9010200@xenomai.org>
	<80c97c7c58b1c913fd0fb2ec83a86b3d@isir.upmc.fr>
	<50AFA44E.4070506@xenomai.org>
	<b5d8fc2c77444a0bf20a3446d6a7edd0@isir.upmc.fr>
	<50AFB64E.4030702@xenomai.org>
	<b6df56ed969c01a5916ff3efc3ce4c87@isir.upmc.fr>
In-Reply-To: <b6df56ed969c01a5916ff3efc3ce4c87@isir.upmc.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone from
 Angstrom branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: WONG Sheng Chao <wong@isir.upmc.fr>
Cc: xenomai@xenomai.org

On 11/27/2012 05:40 PM, WONG Sheng Chao wrote:
> Hi Gilles
> 
> Following your advice i tracked down the include files which need to be 
> included to remove the error. The kernel now compiles without errors. I 
> followed the instructions in
> 
> http://www.xenomai.org/pipermail/xenomai/2012-July/000481.html
> 
> to change the timer.c and also changing the .handle_irq with 
> ipipe_handle_multi_irq
> 
>  From the serial terminal i noticed that with CONFIG_IPIPE = ON the 
> timer is used correctly as in the above post but it hangs at

Are you sure the timer is running correctly?


> Any advice on how to proceed to debug this problem? I attach the 
> config files of two cases for your reference.

I would put a printk in linux timer irq handler.


-- 
					    Gilles.

