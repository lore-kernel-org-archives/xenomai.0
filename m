Message-ID: <50F2994F.6060904@web.de>
Date: Sun, 13 Jan 2013 12:23:59 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com> <50F1B329.80303@xenomai.org>
	<50F2592F.3010300@zultron.com>
In-Reply-To: <50F2592F.3010300@zultron.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Kernel OOPS during regression tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-01-13 07:50, John Morris wrote:
> On 01/12/2013 01:02 PM, Gilles Chanteperdrix wrote:
>> On 01/12/2013 06:26 PM, John Morris wrote:
>>
>>> Hi list,
>>>
>>> The el6 packages are coming along nicely:
>>>
>>> https://github.com/zultron/kernel-ml/tree/branch3.5.3-xeno
>>>
>>> Still a few problems when running xeno-regression-test.
>>>
>>> 1)  Most worrisome is "kernel BUG at mm/mmap.c:2313!   invalid opcode:
>>> 0000 [#2] SMP".  Is this related to HEAPSZ or STACKPOOLSZ?  My mind is
>>> getting foggy about all the things I've seen, but it seems like it was
>>> happening earlier in the tests until these config values were quadruple=
d.
>>
>>
>> Try disabling transparent hugepages, as noted by Jan.
>>
>>>
>>> 2)  posix/mprotect is failing:  "FAILURE: sigdebug_handler triggered,
>>> reason 2    memory write after exec enable".
>>>
>>> 3)  FPU warning:  "fptest.h:24: Warning: Linux is compiled to use FPU in
>>> kernel-space.    For this reason, switchtest can not test using FPU in
>>> Linux kernel-space."
>>>
>>> Regression test run log:
>>> http://www.zultron.com/static/2013/01/xenomai/foo-xeno-regression-test.=
log
>>
>>
>> You should normally use the -l option to use a non default "load", and
>> run the test for a long time.
>>
>> See xeno-regression-test --help and dohell --help
>>
>>
> =

> =

> Jan's fix appears to have solved 1) above, but 2) posix/mprotect is
> still failing.  Thanks for the xeno-regression-test tips; ran a couple
> more (not for a long time, will do that later).

Can you clarify how your setup looks like? The kernel is a vanilla 3.5.3
patched with ipipe-core-3.5.3-x86-2.patch? And then you just disabled
THP? Or did you switch to my for-upstream/3.5 I-pipe branch?

I'll have a look at your .config next week.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130113/978ba19=
3/attachment.pgp>
