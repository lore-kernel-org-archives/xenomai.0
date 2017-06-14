References: <c62e4ab4-a439-9e7a-5e84-43702f2ffbf7@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <98117539-c9ee-8b13-8850-0878e1cafe31@xenomai.org>
Date: Wed, 14 Jun 2017 11:47:03 +0200
MIME-Version: 1.0
In-Reply-To: <c62e4ab4-a439-9e7a-5e84-43702f2ffbf7@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86/ipipe: force lazy FPU management
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 06/14/2017 11:30 AM, Jan Kiszka wrote:
> Hi Philippe,
> 
> this commits looks fishy: the original code already disabled eager mode
> reliably because of
> 
> if (cpu_has_xsaveopt && eagerfpu != DISABLE)
>                         ^^^^^^^^^^^^^^^^^^^
> 
> right after the original disabling under I-pipe. Instead, the new code
> now keeps xfeatures_mask untouched as it performs the disabling too
> late. Could you clarify this?
> 

Messed up, aka -ENOBRAIN triggered. This was a spurious backport of the
fix I did for 4.9, as the former location of the eagerfpu fixup
introduced a weird bug. The fpu switch init code there postpones the
update of the eager FPU capability until the very end of the routine.

Commit reverted, I'll be issuing a patch within minutes.

Thanks for the heads up.

-- 
Philippe.

