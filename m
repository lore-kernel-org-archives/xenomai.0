Message-ID: <5527E7BC.1020501@denx.de>
Date: Fri, 10 Apr 2015 17:09:48 +0200
From: Stefan Roese <sr@denx.de>
MIME-Version: 1.0
References: <5527DF9B.9020304@galauner.de>
In-Reply-To: <5527DF9B.9020304@galauner.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Linux 3.18 on Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Galauner <andreas@galauner.de>, xenomai@xenomai.org

Hi Andy,

On 10.04.2015 16:35, Andreas Galauner wrote:
> I'm playing around with Xenomai for a few months now on and off and I
> want to get Xenomai running on the Xilinx 3.18 Kernel to use it on a
> Zynq board. I had it running with 3.14, but I need the Xilinx Video
> Pipeline drivers which only work for me on 3.18.
>
> Now I've been keeping an eye on the i-pipe 3.18 branch for a while and
> I've been trying to run it on my board, but I keep having massive
> problems during bootup when Xenomai is enabled.
>
> Most of the time it just freezes at some point in time during bootup.
> Sometimes it boots completely and then freezes afterwards.
>
> The funniest thing we saw was, that it booted completely, we quickly
> logged in, ran xeno-test which seemed to work fine until Linux processes
> seem to be hanging randomly, but then it recovered after a few seconds,
> ran for a few seconds, hang again etc.
>
> I tried all kinds of things to find out where this hanging comes from. I
> disabled all kinds of peripherals, because I suspected drivers to behave
> in a wrong way during interrupt handling, I tried to debug it via JTAG,
> but because I don't even know where to start that didn't help at all. I
> also tried Xenomai 2.6 and 3. All the same.
>
> Just to be sure: Was the 3.18 kernel with i-pipe patches ever tested
> with Xenomai on real hardware? Because I'm not sure if I'm searching for
> a bug in the Xilinx part or in the general i-pipe/Xenomai part of the
> kernel. I know, that the 3.18 kernel unstable, that's why I'm asking.
> Should I keep looking or just wait?
>
> On a sidenote: That patch
> https://git.xenomai.org/ipipe-gch.git/commit/?h=for-ipipe-3.18&id=f98b6d95359ea0429307d98759357d54dcfba7e8
> makes the board stop directly after the bootloader jumps into the
> kernel. Without it, it panics with a NULL-pointer deref on 3.18.10. All
> patches before that lead to the mentioned freezing-behaviour.
>
> Any pointers in any direction where to start looking would be great!

This might be a problem with your kernel configuration. Please send me 
your .config and I'll take a look at it...

Thanks,
Stefan


