Message-ID: <503F02B9.6050004@xenomai.org>
Date: Thu, 30 Aug 2012 08:05:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20120829215449.181030@gmx.com>
In-Reply-To: <20120829215449.181030@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Beaglebone Xenomai -- kernel Oops
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Zachary Prezkuta <fermion@gmx.com>
Cc: xenomai@xenomai.org

On 08/29/2012 11:54 PM, Zachary Prezkuta wrote:

> After patching the BeagleBone kernel with Xenomai, I made the mods
> described in the following thread:
> 
> http://www.xenomai.org/pipermail/xenomai/2012-July/000476.html
> 
> I tried booting the kernel with no I-pipe or Xenomai support, but got
> the "Unhandled fault: external abort on non-linefetch" I mentioned
> before. Since it seemed to be related to the 32k timer, I decided to
> enable I-pipe support (keeping full Xenomai disabled). Now I'm not
> getting the first error, but a kernel oops instead. I've attached my
> new kernel config. Does anyone know what's going wrong here?


Please try disabling CONFIG KGDB and CONFIG_THUMB2_KERNEL

THUMB2 kernels will be supported with Xenomai 2.6.2 as they have lower
latencies, but are not supported with Xenomai 2.6.1.


-- 
                                                                Gilles.

