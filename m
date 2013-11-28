Message-ID: <5297BD30.4060007@xenomai.org>
Date: Thu, 28 Nov 2013 23:01:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>
In-Reply-To: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] test suite programs crash with Illegal instruction on
 MPC5200
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bukuli Norbert <norbert.bukuli@mediso.hu>, Xenomai <xenomai@xenomai.org>

On 11/28/2013 02:31 PM, Bukuli Norbert wrote:
> Hello!
>
> I am having a little problem with some programs from the Xenomai test
> suite. The clocktest, cyclictest and switchtest crashes with "Illegal
> instruction":
>
> ~ # /usr/xenomai/bin/clocktest
> == Tested clock: 0 (CLOCK_REALTIME)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>    0                  0.0            0.000          0            0.0
> Illegal instruction
>
>

Please make sure you are using a compiler for the 6xx processor family, 
for building the user-space programs for an icecube/lite52xx/tqm5200 board.

If the issue is still there, you should run the failing test over gdb, 
then paste the backtrace output ("bt" command) obtained after the fault 
to this list.

> When I turn the debug.exception-trace kernel option on,
> and run the clocktest, I have got the following kernel message:
>
> clocktest[243]: unhandled signal 4 at 0fdf4e74 nip 0fdf4e74 lr 0ffd8af8
> code 30001
>

gdb will give you the faulty location in symbolic form.

> I have read in a previous messages on this list, that the
> CONFIG_XENO_HW_UNLOCKED_SWITCH option should be turned off, but
> unfortunately this did not help.
>

Unlocked switching is no more an issue with 3.8.13 and beyond.

-- 
Philippe.

