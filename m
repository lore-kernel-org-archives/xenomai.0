Message-ID: <5086FB19.1010302@xenomai.org>
Date: Tue, 23 Oct 2012 22:16:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi-udUjfD3fQ8cu9x8AsHCx+fbeJrO17wHJ5EhJadjcP7Q@mail.gmail.com>
In-Reply-To: <CANzNmi-udUjfD3fQ8cu9x8AsHCx+fbeJrO17wHJ5EhJadjcP7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem booting the kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: xenomai@xenomai.org

On 10/23/2012 06:17 PM, Sebastian Pavez wrote:

> Hi everyone,
> 
> I'm trying to install xenomai-2.6.0 with linux-2.6.38.8 on ubuntu 12.04.


Please:
- remove "quiet" from the kernel command line, changing grub
configuration, so that you get the boot messages when booting
- try recompiling a kernel without Xenomai applied, disabling the
options described on this page:
http://www.xenomai.org/index.php/Configuring_x86_kernels
- update to Xenomai 2.6.1, there is absolutely no reason to use xenomai
2.6.0 instead of xenomai 2.6.1
- when it works, try and add xenomai support, if it does not work,
please post the details asked on this page:
http://www.xenomai.org/index.php/Request_for_information

-- 
                                                                Gilles.

