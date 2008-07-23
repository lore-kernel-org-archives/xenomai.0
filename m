Message-ID: <48873F7E.7000108@domain.hid>
Date: Wed, 23 Jul 2008 16:26:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A0137F4FC@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A0137F4FC@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Thread policy and priority in secondary mode
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
>> __real_pthread_setschedparam(). Note: this will propagate the 
>> priority to the underlying Xenomai thread as well.
>>
> 
> Does this mean that the Xenomai thread will run with the new (Linux)
> priority when it returns to primary mode ?

Yes. However, the propagation only occurs when the skin and Linux have
compatible priority scales, which is the case with the POSIX skin.

> And the other way round :
> when a posix thread switches to secondary mode (without using
> __real_pthread_setschedparam), does it run in Linux with the priority
> set in Xenomai (with pthread_setschedparam)?

Yes.

> Or better : what is the Linux-prority when a Xenomai thread (posix or or
> any other Xenomai thread)switches to secondaary mode ?
>

It depends on the skin. When the priority scales are compatible (i.e. a given
priority level exists in both and scales are both upwarding, like POSIX skin <->
Linux, and native skin <-> Linux), you get the same priority level in both
modes, and changing the priority from one mode affects the other mode as well.

When they are not compatible, the skin-based priority is "normalized" and
applied to the Linux side when needed (e.g. when VxWorks taskPrioritySet() is
invoked), but __real_pthread_setschedparam does not trigger the converse
propagation (since 2.4.4 actually, because experience showed that propagating in
that case made little sense, and would beget weird behaviours). The way priority
levels are normalized depends on the skin.

> Best regrads
> Roderik
> 
> Achtung: Neue E-Mail-Adresse! Attention: New e-mail-address! roderik.wildenburg@domain.hid
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall, Paul Steidle   
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
> 


-- 
Philippe.

