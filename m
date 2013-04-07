Message-ID: <51613CE2.6010900@wanadoo.fr>
Date: Sun, 07 Apr 2013 11:31:14 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Kernel 3.5.7 not booting in qemu for vexpress-a9 with
	xenomai-2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi,

I am using a vanilla 3.5.7 kernel in qemu-1.4.0
The base defconfig is the vexpress.

I want to use xenomai-2.6.2.1 with it.

The non-patched kernel boots fine, the patched one doesnot, there is 
nothing on the console,
the boot logo does not comeand Qemu then takes 100% CPU.

Here is my command line
./qemu-1.4.0/arm-softmmu/qemu-system-arm -M vexpress-a9 -kernel 
./Buildroot/output.linaro.vexpress-a9/build/linux-3.5.7/arch/arm/boot/uImage 
-append "console=ttyAMA0" -m 1024M -serial stdio

Any ideas ? May I have missed something ?

Regards
Thierry
