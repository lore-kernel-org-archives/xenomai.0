Message-ID: <54FF64AF.5000300@xenomai.org>
Date: Tue, 10 Mar 2015 22:39:59 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t3_phHv3kUfCZcwr2bqTys3JPL3iaWACLjP+f1yoD_Nag@mail.gmail.com>
 <54F97594.2060605@xenomai.org>
 <CAKk99t1AGHj8sOf7Vgy_UZ_+rECP5Vx22cyup--FHsh=RuK2zA@mail.gmail.com>
 <54F97E05.8010107@xenomai.org>
 <CAKk99t3FfAff0X0nGzKD+YcVFQWm5aeSRFB4U6No1YSPuS_qpA@mail.gmail.com>
 <CAKk99t03p_Pc41meo_zzZ0V6X_vjHZRWBeO1aNb+DM2c38pNTg@mail.gmail.com>
In-Reply-To: <CAKk99t03p_Pc41meo_zzZ0V6X_vjHZRWBeO1aNb+DM2c38pNTg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Error boilerplate/wrappers.h no found trying to
 compile RTDM module on 3.x-rc3 cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/09/2015 07:57 PM, Helder Daniel wrote:
> Hi again,
> 
> I am sorry to ask help again about this point but I still am no able to
> compile a kernel module with Xenomai 3.x support.
> 
> I made the changes pointed in the previous email:
> In the module is now being included just:
> 
> <rtdm/driver.h>
> 
> and the makefile is now:
> 
> EXTRA_CFLAGS := $(shell xeno-config --kcflags)
> all:
> 
> make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
> 

You need /lib/modules/$(shell uname -r)/build to refer to a kernel tree
prepared with the Xenomai kernel sources, i.e. scripts/prepare-kernel.sh
should have run in this source tree at some point. The errors you get
indicate that no Xenomai code can be found there.

A basic Makefile for foo_module.ko composed of a single source foo.c,
and pulling the extra CFLAGS from xeno-config, could look like:

$(eval ccflags-y = $(shell xeno-config --kcflags))
obj-y += foo_module.o
foo_module-y := foo.o

-- 
Philippe.

