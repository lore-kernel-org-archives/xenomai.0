Message-ID: <54E619D5.4020208@xenomai.org>
Date: Thu, 19 Feb 2015 18:13:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20150218181334.GE30317@hermes.click-hack.org>
 <54E4D835.1040204@siemens.com> <20150218182632.GG30317@hermes.click-hack.org>
 <54E4DDEA.3060909@siemens.com> <20150218184943.GH30317@hermes.click-hack.org>
 <54E4E166.5030701@siemens.com> <20150218190549.GI30317@hermes.click-hack.org>
 <54E4E546.8080801@siemens.com> <20150218192712.GJ30317@hermes.click-hack.org>
 <54E4FAF4.7050004@siemens.com> <20150219151327.GN30245@csclub.uwaterloo.ca>
In-Reply-To: <20150219151327.GN30245@csclub.uwaterloo.ca>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 02/19/2015 04:13 PM, Lennart Sorensen wrote:
> On Wed, Feb 18, 2015 at 09:49:56PM +0100, Jan Kiszka wrote:
>> No need to worry, it mostly just works. Apparently, I-pipe already
>> covers the whole Cortex-A series with its unified timers, clocks, and
>> interrupt controllers. Well, with the exception of SoCs that have
>> additional interrupt controllers - like the NVIDIA Tegra124, which I'm
>> currently looking at for other purposes.
>>
>> "Mostly" because sshd is dying for unknown reasons. Same rootfs, same
>> emulator but newer kernel without I-pipe, and it works fine. One after
>> the other.
>>
>> BTW, I noticed that LPAE build is broken. Trivial to fix (missing
>> argument to cpu_switch_mm), but maybe there is more behind it as it was
>> not used so far. Anything mm-related that one has to look at carefully
>> on ARM(v7)?
> 
> LPAE support at all is very new, and not used by very many people yet.
> 
> Is it broken on 2.6 or 3.0 or both?
> 

I's not about LPAE being broken, it is about building with LPAE enabled
on a backport of my LPAE fixes to the stock pipelines, due to some
conflict with the FCSE changes. I dropped FCSE from the working tree for
LPAE fixes, since the former is not relevant on armv7 with VIPT caches
anyway.

-- 
Philippe.

