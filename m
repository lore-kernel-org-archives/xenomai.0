Message-ID: <4FE5A4A7.7060907@xenomai.org>
Date: Sat, 23 Jun 2012 13:12:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdteXA6cPJcXBg11S8pQpy3yc_pu-Ok6O+7=MmGdkn2x2_g@mail.gmail.com>
In-Reply-To: <CAKKWdteXA6cPJcXBg11S8pQpy3yc_pu-Ok6O+7=MmGdkn2x2_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] defconfig.frag !!
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 06/23/2012 10:56 AM, ali hagigat wrote:
> I have installed Xenomai 2.6.0 for Linux-2.6.38.8. There are 3 new
> files for vxworks:  /usr/xenomai/include/vxworks/syscall.h and
> /usr/xenomai/include/vxworks/vxworks.h and
> /usr/xenomai/include/vxworks/ppd.h.

> 
> Are these header files suffice to use the whole capabilities of
> VxWorks operating system? The complete VxWorks API and objects?

Only vxworks.h contains the list of VxWorks services emulated by
Xenomai. Xenomai does not emulate the complete VxWorks API.

> My another question is about scripts/defconfig.frag file. Does this
> file is used for configuring the Linux kernel?

When you run "prepare-kernel.sh", this file is added to all the
defconfig files for the architecture for which you are patching.


-- 
                                                                Gilles.

