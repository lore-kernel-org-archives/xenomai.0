Message-ID: <5161CE7B.1040404@wanadoo.fr>
Date: Sun, 07 Apr 2013 21:52:27 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <51613CE2.6010900@wanadoo.fr> <51618B70.7070809@xenomai.org>
In-Reply-To: <51618B70.7070809@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Le 07/04/2013 17:06, Gilles Chanteperdrix a écrit :
> On 04/07/2013 11:31 AM, Thierry Bultel wrote:
>
>> Hi,
>>
>> I am using a vanilla 3.5.7 kernel in qemu-1.4.0
>> The base defconfig is the vexpress.
>>
>> I want to use xenomai-2.6.2.1 with it.
>>
>> The non-patched kernel boots fine, the patched one doesnot, there is
>> nothing on the console,
>> the boot logo does not comeand Qemu then takes 100% CPU.
>>
>> Here is my command line
>> ./qemu-1.4.0/arm-softmmu/qemu-system-arm -M vexpress-a9 -kernel
>> ./Buildroot/output.linaro.vexpress-a9/build/linux-3.5.7/arch/arm/boot/uImage
>> -append "console=ttyAMA0" -m 1024M -serial stdio
>>
>> Any ideas ? May I have missed something ?
>
>
> Well, vexpress is not in the list of machines supported by Xenomai. So,
> someone needs to port the I-pipe kernel to it.
>
>

Hi Gilles,

We already talked about the vexpress, it was at the beginning of the 
rtcan discussion.
It used to work (and pretty well), my configuration was:

linux-3.2.21+ipipe-core-3.2.21-arm-1.patch

and I have just successfully tested

linux-3.2.21+ipipe-core-3.2.21-arm-4.patch
as well.

There is likely not much missing for having it working on the 3.5.7 
kernel. I am taking a look.

Cheers
Thierry


