Message-ID: <5491BF2F.7060706@siemens.com>
Date: Wed, 17 Dec 2014 18:36:47 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5491B5E9.4030200@siemens.com> <5491BB1B.7020306@xenomai.org>
 <20141217171734.GE2012@hermes.click-hack.org>
In-Reply-To: <20141217171734.GE2012@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mayday mechanism broken on x86-64 - simpler approach
 feasible?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2014-12-17 18:17, Gilles Chanteperdrix wrote:
> On Wed, Dec 17, 2014 at 06:19:23PM +0100, Philippe Gerum wrote:
>> On 12/17/2014 05:57 PM, Jan Kiszka wrote:
>>> Hi,
>>>
>>> while porting the sigdebug test case to forge I noticed occasional
>>> crashes of the test after it received a watchdog signal. It turned out
>>> that the problem is in the way mayday works on x86-64:
>>>
>>> 1. sp/ip/ax of interrupted thread is saved
>>> 2. ip is set to mayday page
>>> 3. mayday page executes the mayday syscall via the syscall instruction
>>> 4. the syscall restores state on original state on return
>>>
>>> That that's the theory. Unfortunately the syscall instructions
>>> overwrites the cx register with the caller's instruction pointer. We
>>> could save it but there is no way to restore it on syscall return
>>> without significant changes to the Linux code in entry_64.S.
> 
> Maybe we can restore it in xnarch_fixup_mayday, if nothing touches
> it ?

The problem is that cx is mangled again on preparing sysret - we are in
a syscall return path at that point, but we need an interrupt/exception
path in fact.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

