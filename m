Date: Fri, 13 Mar 2015 18:10:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150313171016.GG1497@hermes.click-hack.org>
References: <CANWkrRPz2B5FgOAVLy5-i+DOFOHf5QDZQoHP28n_oAdaSmYTBw@mail.gmail.com>
 <5502AEAF.3010003@xenomai.org>
 <CANWkrRNmZqnN7p2nmNCc_8C8iFUW79E03L1Z62nnx4zWmSJ8Sw@mail.gmail.com>
 <CANWkrRM3hD_LG-7EQFDxF5U-YS3YJYe8jNyL3cOZqSEL+tqQNg@mail.gmail.com>
 <CAKk99t3XcTPTD=7VoFsJ=hsZeX7mVAR4dnyecCd_yZ2NiiZzzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKk99t3XcTPTD=7VoFsJ=hsZeX7mVAR4dnyecCd_yZ2NiiZzzw@mail.gmail.com>
Subject: Re: [Xenomai] rtdm/driver.h location - Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>
Cc: Michael Smith <2michael.smith@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Mar 13, 2015 at 05:06:06PM +0000, Helder Daniel wrote:
> I was having the same problem.
> What I did was (for a one source code file module only to keep it simple):
> 
> In the source code: #include <rtdm/driver.h>
> 
> The makefile that I use is:
> 
> obj-m += modulesource.o
> 
> $(eval EXTRA_CFLAGS := $(shell xeno-config --kcflags))
> #or:
> #$(eval ccflags-y = $(shell xeno-config --kcflags))
> 
> all:
> make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
> clean:
> make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
> 
> It assumes that:
> 
> /lib/modules/3.16.0-ipipe/build -> /usr/src/linux-3.16.0-ipipe/
> 
> points the full source tree (not just a headers tree like the one created
> by the debian kbuild)

Once again, typing:

make -C /usr/src/linux-3.16.0-ipipe/ M=$(PWD) modules

is shorter and avoids the need for a symbolic link which requires
root privileges.

-- 
					    Gilles.

