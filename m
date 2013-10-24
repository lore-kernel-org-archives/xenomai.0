Message-ID: <52694D61.7090902@siemens.com>
Date: Thu, 24 Oct 2013 17:40:01 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5268DCEA.7000202@basystemes.fr> <5268F13E.4020402@siemens.com>
 <5269414F.6020806@xenomai.org>
In-Reply-To: <5269414F.6020806@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xsave/xrstor compilation error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-10-24 16:48, Gilles Chanteperdrix wrote:
> On 10/24/2013 12:06 PM, Jan Kiszka wrote:
>> We
>> can, of course, replace the instructions with their obcodes (like the
>> kernel does), just makes the code more ugly.
> 
> Jan, please do this, even if it makes the code more ugly, it makes sense
> for the 2.6.3 release to continue working with the tools it already
> supported. No question for -forge, but we try hard to keep ABI
> compatibility so that users can upgrade xenomai without even recompiling
> their application, it does not make sense to suddenly stop working with
> a toolchain which always worked before.

In fact, we already have legacy gas support: all these new instructions
are wrapped with CONFIG_AS_AVX, and only if that is set we use the new
assembler instructions. Given that this CONFIG has to be set based on
some test, something seems to go wrong in the kernel build over there.
But that's outside of the Xenomai scope. I'm currently trying to find
out if there was some related kernel issue back then.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

