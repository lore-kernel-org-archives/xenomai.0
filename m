Message-ID: <54E503FD.6030804@siemens.com>
Date: Wed, 18 Feb 2015 22:28:29 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <20150218181334.GE30317@hermes.click-hack.org>
 <54E4D835.1040204@siemens.com> <20150218182632.GG30317@hermes.click-hack.org>
 <54E4DDEA.3060909@siemens.com> <20150218184943.GH30317@hermes.click-hack.org>
 <54E4E166.5030701@siemens.com> <20150218190549.GI30317@hermes.click-hack.org>
 <54E4E546.8080801@siemens.com> <20150218192712.GJ30317@hermes.click-hack.org>
 <54E4FAF4.7050004@siemens.com> <20150218210012.GP30317@hermes.click-hack.org>
In-Reply-To: <20150218210012.GP30317@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] arm: Late delivery of pending Linux signals?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-02-18 22:00, Gilles Chanteperdrix wrote:
> On Wed, Feb 18, 2015 at 09:49:56PM +0100, Jan Kiszka wrote:
>> On 2015-02-18 20:27, Gilles Chanteperdrix wrote:
>>> On Wed, Feb 18, 2015 at 08:17:26PM +0100, Jan Kiszka wrote:
>>>> The Versatile Express is the ARM reference board, not something
>>>> arbitrary virtual. It's also what you get when you obtain the Fast Model
>>>> (CPU and system emulator) from ARM.
>>>
>>> Nevertheless, it is a board that nobody uses for real projects,
>>> so adding support for it is still a waste of resources.
>>
>> No need to worry, it mostly just works. Apparently, I-pipe already
>> covers the whole Cortex-A series with its unified timers, clocks, and
>> interrupt controllers. Well, with the exception of SoCs that have
>> additional interrupt controllers - like the NVIDIA Tegra124, which I'm
>> currently looking at for other purposes.
>>
>> "Mostly" because sshd is dying for unknown reasons. Same rootfs, same
>> emulator but newer kernel without I-pipe, and it works fine. One after
>> the other.
> 
> That is the joys of of not using real hardware. The I-pipe uses some
> registers or configure others that may not be implemented in the emulator.

We will see where this one comes from.

For now, I'm able to reproduce all the issues and effects I've seen on
the AM335x in QEMU's Integrator/CP.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

