Message-ID: <53C65420.6040608@xenomai.org>
Date: Wed, 16 Jul 2014 12:29:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <FEB36BE3-3DA6-4594-9064-213B66B059ED@gmail.com>
In-Reply-To: <FEB36BE3-3DA6-4594-9064-213B66B059ED@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] modprobe cannot find RTDM kernel module during boot
 sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Jaap Kempenaar <janjaapkempenaar@gmail.com>, xenomai@xenomai.org

On 07/15/2014 05:45 PM, Jan Jaap Kempenaar wrote:
> Hello,
> 
> We have a setup for controlling robots consisting of a Gumstix Overo Fire and an FPGA. These devices are connected using a GPMC.
> In order be able to exchange data with the FPGA we wrote a small kernel module according to the RTDM, this kernel modules compiles and functions as expected. However loading the module is a problem:
> 
> We copied the module to:
> /lib/modules/3.2.21/kernel/drivers/gpmc/rt_gpmc_module.ko

You should not use kernel 3.2.21, the I-piep patch is known to contain a
bug. Please update to a more recent patch.

> Then as root performed:
> depmod -a
> 
> After these two actions we are able to load the module using:
> modprobe rt_gpmc_module
> 
> Also:
> modprobe --list
> will list the .ko file.
> 
> Now for ease of use, we want to load the particular kernel module at boot. To achieve this we added rt_gpmc_module to the /etc/modules file.
> However when setting the /etc/init.d/module-init-tools to Verbose, the modprobe command gives the following error:
> FATAL: Module rt_gpmc_module not found

Some versions of modprobe try to insmod the module directly first, and
if that fails take the dependencies into account. If the module appears
in lsmod, I believe you can safely ignore this warning.


-- 
                                                                Gilles.

