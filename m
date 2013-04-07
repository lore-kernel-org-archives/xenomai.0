Message-ID: <51618B70.7070809@xenomai.org>
Date: Sun, 07 Apr 2013 17:06:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51613CE2.6010900@wanadoo.fr>
In-Reply-To: <51613CE2.6010900@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel 3.5.7 not booting in qemu for vexpress-a9 with
 xenomai-2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 04/07/2013 11:31 AM, Thierry Bultel wrote:

> Hi,
> 
> I am using a vanilla 3.5.7 kernel in qemu-1.4.0
> The base defconfig is the vexpress.
> 
> I want to use xenomai-2.6.2.1 with it.
> 
> The non-patched kernel boots fine, the patched one doesnot, there is 
> nothing on the console,
> the boot logo does not comeand Qemu then takes 100% CPU.
> 
> Here is my command line
> ./qemu-1.4.0/arm-softmmu/qemu-system-arm -M vexpress-a9 -kernel 
> ./Buildroot/output.linaro.vexpress-a9/build/linux-3.5.7/arch/arm/boot/uImage 
> -append "console=ttyAMA0" -m 1024M -serial stdio
> 
> Any ideas ? May I have missed something ?


Well, vexpress is not in the list of machines supported by Xenomai. So,
someone needs to port the I-pipe kernel to it.


-- 
                                                                Gilles.

