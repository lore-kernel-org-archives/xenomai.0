Message-ID: <51921F78.60504@xenomai.org>
Date: Tue, 14 May 2013 13:26:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <516BA4E9.3070201@xenomai.org> <5182B1B5.1000107@xenomai.org>
	<12E434B4-4F26-44AC-8D50-2CF70B5089E1@kabelmail.de>
	<5183FFB3.1000006@xenomai.org>
	<8D9AB79C-4A66-4511-B08B-ACF825FED1BF@kabelmail.de>
	<518A98F5.30000@xenomai.org>
	<0ECFC8C0-CF1D-4D65-9724-B0A1A91887DC@kabelmail.de>
	<518CF43E.3080601@xenomai.org>
	<5F179C54-A023-4C27-9082-13195B16B9BB@kabelmail.de>
	<518D07BB.1060900@xenomai.org>
	<A359148C-7FCB-4D8C-A5DC-461065767DDA@kabelmail.de>
	<518D24E8.6070305@xenomai.org> <518D2815.7000602@xenomai.org>
	<19C79116-400B-4A5C-BFDA-87EEF8799554@kabelmail.de>
	<41BEC449-99F8-4C31-AA75-B98690DB3F23@kabelmail.de>
	<5191DC82.6090509@xenomai.org>
	<E7E166CE-6815-443A-AC5A-D8B103122CE5@kabelmail.de>
	<5191ED8D.90105@xenomai.org>
	<42470BFE-71B5-41BD-9A90-EA3ACF1D1C1C@kabelmail.de>
	<519201D7.6050800@siemens.com>
	<BBCD4113-6506-4F69-9E29-AC39CBD5686C@kabelmail.de>
	<51921369.4000703@siemens.com> <519219C0.9000209@xenomai.org>
	<51921BFC.9020404@siemens.com>
In-Reply-To: <51921BFC.9020404@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Raspberry and Beaglebone patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Stephan Kappertz <stephan.kappertz@kabelmail.de>, Xenomai <xenomai@xenomai.org>

On 05/14/2013 01:11 PM, Jan Kiszka wrote:

> On 2013-05-14 13:02, Gilles Chanteperdrix wrote:
>>> OK, I pushed the patch for upstream merge. It's probably better to carry
>>> the workaround than letting users find out the reason the hard way.
>>> Gilles, please consider it for 2.6.3.
>>
>>
>> Ok, but does not the workaround of un-inlining xeno_bind_skin make more
>> sense?
> 
> The issue is not with xeno_bind_skin and its inlining but with patterns like
> 
> my_function()
> {
> 	if (condition)
> 		return;
> 	do_other_stuff();
> }
> 
> gcc tends to push do_other_stuff into a sub-function called
> my_function.part.0, and that part is then incorrectly registered as
> constructor function as well.


I understood that, but in the case of the native skin, the only such
branch is created by the fact that xeno_bind_skin is inlined (and it is
the other way around, it is the if branch that goes in a helper
function, the unlikely branch in fact). So, if the native skin
initialization is the only one to be problematic, then it fixes the
issue. If the native skin initialization is not the only one to be
problematic, then your patch is unsufficient. It is also unsufficient
because it does not guarantee that the compiler will not inline
__init_xeno_interface in __init_wrapper when we use other more
aggressive compilation options, at minimum __attribute__((noinline))
would be needed, and not only for the native skin. So, I nack this patch.

So, since we know that this is a broken compiler and that there are
other versions that work, I propose to detect it in the configure script
and abort compilation when we find this compiler.

Yet another solution would be to suppress the automatic binding with
__attribute__((constructor)) and bind the skin on first use of the
"muxid", with a static inline function using a static pthread_once_t.

-- 
                                                                Gilles.

