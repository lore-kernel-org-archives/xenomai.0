Message-ID: <4BBB9D96.7060808@domain.hid>
Date: Tue, 06 Apr 2010 13:46:14 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4BBA5480.9090608@domain.hid> <4BBA61AD.5020100@domain.hid>
In-Reply-To: <4BBA61AD.5020100@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------020606010405060107040406"
Subject: Re: [Xenomai-help] Adeos patch interference with Angstrom 2.6.29-r46
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020606010405060107040406
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I am using the TI OMAP3530 on a BeagleBoard. I need better real time 
support than vanilla Angstrom offers, so I am attempting to integrate 
Xenomai into it. The 2.6.29-R46 kernel version seems to be the latest 
supported by Angstrom for the BeagleBoard (as of two weeks ago). The 
distribution comes with a large number of patches. I know that Xenomai 
was tested against a vanilla kernel, but I believe that it is likely 
that if I omit all the Angstrom patches, some Angstrom functionality 
will be broken. I seems easier to start with a known working system and 
integrate one thing (Xenomai) into it than to try to rebuild all of 
Angstrom around a Xenomai patched kernel.

I plan to port a couple of my device drivers from the Linux environment 
to become real time drivers and write a real time user task that makes 
heavy use of the OMAP NEON and VFP units. The real time user task will 
asynchronously publish state/status to subscribed Linux applications. In 
general, I need to read a set of sensors and do some heavy number 
crunching on the results every millisecond. Actions requiring 
tens-of-milliseconds or less latency will be performed in the Xenomai 
environment.

More below...

On 4/5/2010 3:18 PM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>   
>> First, thanks for the help getting me started with Xenomai in 
>> openembedded. Special thanks to Felipe Brandao Cavalcanti for the files 
>> he posted. (I was sidetracked on another project, so I could not 
>> follow-up sooner.)
>>
>> I added  adeos-ipipe-2.6.29-arm-1.13-04.patch to the end of the normal 
>> set of kernel patches to be applied against Angstrom 
>> linux-omap-2.6.29.bb recipe file (it builds the -r46 revision). There 
>> are conflicts with four Angstrom patches. There are two conflicts that I 
>> am concerned about. (The first two below.)
>>     
>
> Hi,
>
> first of all, the Adeos patch is made for the vanilla kernel, not for
> patched versions, and validated with that kernel. So, I would recommend
> you to upgrade the kernel, instead of using a kernel with backported
> changes. Maintaining the Adeos patch is enough time consuming.
>
> Second, on what processor do you intend to run Xenomai? Some of the
> patches may not be needed at all for the processor you want to use, so
> you should not even bother to try and apply them.
>   
Addressed above.
>> Conflict with 
>> '0001-implement-TIF_RESTORE_SIGMASK-support-and-enable-the.patch'.
>> patching file arch/arm/include/asm/thread_info.h
>> Hunk #1 FAILED at 136.
>> Hunk #2 FAILED at 146.
>> 2 out of 2 hunks FAILED -- rejects in file 
>> arch/arm/include/asm/thread_info.h
>> Adeos wants TIF_MMSWITCH_INT   20, but the other patch wants 
>> TIF_RESTORE_SIGMASK   20.
>> Can I define TIF_MMSWITCH_INT  as 21? Will that bother anything?
>>     
> You need to inspect the code carefully to see if 21 is not used for
> anything else.
>   
I examined the patch closely. the value 21 is not used for anything else.
>> Conflict with 'no-cortex-deadlock.patch'.
>> patching file arch/arm/kernel/entry-common.S
>> Hunk #5 FAILED at 82.
>> Hunk #6 succeeded at 272 (offset 4 lines).
>> Hunk #8 succeeded at 494 (offset -6 lines).
>> 1 out of 8 hunks FAILED -- rejects in file arch/arm/kernel/entry-common.S
>> Some Arm silicon require the "dmb" instruction in this fix to avoid 
>> deadlock. Does Xenomai account for this elsewhere?
>>     
> What you see is what you get. All the changes made by Xenomai are
> available in the Adeos patch. Without seeing the code I can not tell. Is
> the processor you want to use affected by this patch?
>   
I determined that this patch is not needed. BeagleBoard Rev. B7 and 
above use ES3.0 silicon. This patch seems to be needed for ES2.0 and 
earlier silicon.
>> Conflict with '/cache/l1cache-shift.patch'
>> patching file arch/arm/mm/Kconfig
>> Hunk #1 FAILED at 717.
>> 1 out of 1 hunk FAILED -- rejects in file arch/arm/mm/Kconfig
>> No real conflict, the other patch just added a config entry that the 
>> Adeos patch wasn't expecting.
>>     
I'm sure that the above patch is not a problem.
>> Conflict with 'vfp/03-vfp-corruption.patch'
>> patching file arch/arm/vfp/vfphw.S
>> Hunk #5 succeeded at 136 with fuzz 1.
>> Hunk #6 FAILED at 156.
>> 1 out of 6 hunks FAILED -- rejects in file arch/arm/vfp/vfphw.S
>> I allowed the #ifdef CONFIG_PREEMPT segment to match before the Adeos 
>> insertion.
>>     
> Risky business, we patch a bit the vfp support, and are going to patch
> it even further in next revisions. Here again, without the code, I can
> not tell.
>   
Your statement concerns me. I need NEON/VFP support and here are four 
patches applied to it by the distribution.
           file://vfp/02-vfp-ptrace.patch;patch=1 \
           file://vfp/03-vfp-corruption.patch;patch=1 \
           file://vfp/04-vfp-threads.patch;patch=1 \
           file://vfp/05-vfp-signal-handlers.patch;patch=1 \
Are these patches well known? Can you identify them from the above?

The specific area of detected conflict is with vfp/03-vfp-corruption.patch.
The conflicting part of the patch just seems to be decrementing a 
preemption counter.
@@ -154,16 +156,18 @@ look_for_VFP_exceptions:
     @ Fall into hand on to next handler - appropriate coproc instr
     @ not recognised by VFP
 
+    enable_irq_cond
     DBGSTR    "not VFP"
 #ifdef CONFIG_PREEMPT
    get_thread_info    r10
    ldr    r4, [r10, #TI_PREEMPT]    @ get preempt count
    sub    r11, r4, #1        @ decrement it
    str    r11, [r10, #TI_PREEMPT]
 #endif
     mov    pc, lr

The #ifdef/#endif block were the unexpected statements. I think that 
moving the enable_irq_cond after the #ifdef block is probably the 
correct thing to do. I am assuming hat Xenomai is trying to enable some 
kind of interrupt just before this segment returns.

Regards,
Bob Feretich




--------------020606010405060107040406
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
I am using the TI OMAP3530 on a BeagleBoard. I need better real time
support than vanilla Angstrom offers, so I am attempting to integrate
Xenomai into it. The 2.6.29-R46 kernel version seems to be the latest
supported by Angstrom for the BeagleBoard (as of two weeks ago). The
distribution comes with a large number of patches. I know that Xenomai
was tested against a vanilla kernel, but I believe that it is likely
that if I omit all the Angstrom patches, some Angstrom functionality
will be broken. I seems easier to start with a known working system and
integrate one thing (Xenomai) into it than to try to rebuild all of
Angstrom around a Xenomai patched kernel.<br>
<br>
I plan to port a couple of my device drivers from the Linux environment
to become real time drivers and write a real time user task that makes
heavy use of the OMAP NEON and VFP units. The real time user task will
asynchronously publish state/status to subscribed Linux applications.
In general, I need to read a set of sensors and do some heavy number
crunching on the results every millisecond. Actions requiring
tens-of-milliseconds or less latency will be performed in the Xenomai
environment.<br>
<br>
More below...<br>
<br>
On 4/5/2010 3:18 PM, Gilles Chanteperdrix wrote:
<blockquote cite="mid:4BBA61AD.5020100@domain.hid" type="cite">
  <pre wrap="">Bob Feretich wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">First, thanks for the help getting me started with Xenomai in 
openembedded. Special thanks to Felipe Brandao Cavalcanti for the files 
he posted. (I was sidetracked on another project, so I could not 
follow-up sooner.)

I added  adeos-ipipe-2.6.29-arm-1.13-04.patch to the end of the normal 
set of kernel patches to be applied against Angstrom 
linux-omap-2.6.29.bb recipe file (it builds the -r46 revision). There 
are conflicts with four Angstrom patches. There are two conflicts that I 
am concerned about. (The first two below.)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Hi,

first of all, the Adeos patch is made for the vanilla kernel, not for
patched versions, and validated with that kernel. So, I would recommend
you to upgrade the kernel, instead of using a kernel with backported
changes. Maintaining the Adeos patch is enough time consuming.

Second, on what processor do you intend to run Xenomai? Some of the
patches may not be needed at all for the processor you want to use, so
you should not even bother to try and apply them.
  </pre>
</blockquote>
Addressed above.<br>
<blockquote cite="mid:4BBA61AD.5020100@domain.hid" type="cite">
  <blockquote type="cite">
    <pre wrap="">Conflict with 
'0001-implement-TIF_RESTORE_SIGMASK-support-and-enable-the.patch'.
patching file arch/arm/include/asm/thread_info.h
Hunk #1 FAILED at 136.
Hunk #2 FAILED at 146.
2 out of 2 hunks FAILED -- rejects in file 
arch/arm/include/asm/thread_info.h
Adeos wants TIF_MMSWITCH_INT   20, but the other patch wants 
TIF_RESTORE_SIGMASK   20.
Can I define TIF_MMSWITCH_INT  as 21? Will that bother anything?
    </pre>
  </blockquote>
  <pre wrap=""><!---->You need to inspect the code carefully to see if 21 is not used for
anything else.
  </pre>
</blockquote>
I examined the patch closely. the value 21 is not used for anything
else.<br>
<blockquote cite="mid:4BBA61AD.5020100@domain.hid" type="cite">
  <blockquote type="cite">
    <pre wrap="">Conflict with 'no-cortex-deadlock.patch'.
patching file arch/arm/kernel/entry-common.S
Hunk #5 FAILED at 82.
Hunk #6 succeeded at 272 (offset 4 lines).
Hunk #8 succeeded at 494 (offset -6 lines).
1 out of 8 hunks FAILED -- rejects in file arch/arm/kernel/entry-common.S
Some Arm silicon require the "dmb" instruction in this fix to avoid 
deadlock. Does Xenomai account for this elsewhere?
    </pre>
  </blockquote>
  <pre wrap=""><!---->What you see is what you get. All the changes made by Xenomai are
available in the Adeos patch. Without seeing the code I can not tell. Is
the processor you want to use affected by this patch?
  </pre>
</blockquote>
I determined that this patch is not needed. BeagleBoard Rev. B7 and
above use ES3.0 silicon. This patch seems to be needed for ES2.0 and
earlier silicon.<br>
<blockquote cite="mid:4BBA61AD.5020100@domain.hid" type="cite">
  <blockquote type="cite">
    <pre wrap="">Conflict with '/cache/l1cache-shift.patch'
patching file arch/arm/mm/Kconfig
Hunk #1 FAILED at 717.
1 out of 1 hunk FAILED -- rejects in file arch/arm/mm/Kconfig
No real conflict, the other patch just added a config entry that the 
Adeos patch wasn't expecting.
    </pre>
  </blockquote>
</blockquote>
I'm sure that the above patch is not a problem.<br>
<blockquote cite="mid:4BBA61AD.5020100@domain.hid" type="cite">
  <blockquote type="cite">
    <pre wrap="">Conflict with 'vfp/03-vfp-corruption.patch'
patching file arch/arm/vfp/vfphw.S
Hunk #5 succeeded at 136 with fuzz 1.
Hunk #6 FAILED at 156.
1 out of 6 hunks FAILED -- rejects in file arch/arm/vfp/vfphw.S
I allowed the #ifdef CONFIG_PREEMPT segment to match before the Adeos 
insertion.
    </pre>
  </blockquote>
  <pre wrap=""><!---->Risky business, we patch a bit the vfp support, and are going to patch
it even further in next revisions. Here again, without the code, I can
not tell.
  </pre>
</blockquote>
Your statement concerns me. I need NEON/VFP support and here are four
patches applied to it by the distribution.<br>
           <a class="moz-txt-link-freetext" href="file://vfp/02-vfp-ptrace.patch;patch=1">file://vfp/02-vfp-ptrace.patch;patch=1</a> \<br>
           <a class="moz-txt-link-freetext" href="file://vfp/03-vfp-corruption.patch;patch=1">file://vfp/03-vfp-corruption.patch;patch=1</a> \<br>
           <a class="moz-txt-link-freetext" href="file://vfp/04-vfp-threads.patch;patch=1">file://vfp/04-vfp-threads.patch;patch=1</a> \<br>
           <a class="moz-txt-link-freetext" href="file://vfp/05-vfp-signal-handlers.patch;patch=1">file://vfp/05-vfp-signal-handlers.patch;patch=1</a> \<br>
Are these patches well known? Can you identify them from the above?<br>
<br>
The specific area of detected conflict is with
vfp/03-vfp-corruption.patch.<br>
The conflicting part of the patch just seems to be decrementing a
preemption counter.<br>
<tt>@@ -154,16 +156,18 @@ look_for_VFP_exceptions:<br>
     @ Fall into hand on to next handler - appropriate coproc instr<br>
     @ not recognised by VFP<br>
 <br>
+    enable_irq_cond<br>
     DBGSTR    "not VFP"<br>
 #ifdef CONFIG_PREEMPT<br>
    get_thread_info    r10<br>
    ldr    r4, [r10, #TI_PREEMPT]    @ get preempt count<br>
    sub    r11, r4, #1        @ decrement it<br>
    str    r11, [r10, #TI_PREEMPT]<br>
 #endif<br>
     mov    pc, lr</tt><br>
<br>
The #ifdef/#endif block were the unexpected statements. I think that
moving the <tt>enable_irq_cond</tt> after the #ifdef block is probably
the correct thing to do. I am assuming hat Xenomai is trying to enable
some kind of interrupt just before this segment returns.<br>
<br>
Regards,<br>
Bob Feretich<br>
<br>
<br>
<br>
</body>
</html>

--------------020606010405060107040406--

