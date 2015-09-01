References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55E5E453.1080400@xenomai.org>
 <CAPuu0=jX6ig5L7SJrmPVOhCmOm=gwxEmTafTpOqzE85hOji8CA@mail.gmail.com>
 <55E5F849.1070708@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55E5FB89.3080604@xenomai.org>
Date: Tue, 1 Sep 2015 21:24:57 +0200
MIME-Version: 1.0
In-Reply-To: <55E5F849.1070708@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>, Dmitriy Cherkasov <dmitriy@mperpetuo.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

On 09/01/2015 09:11 PM, Jorge Ramirez Ortiz wrote:
> On 09/01/2015 02:27 PM, Dmitriy Cherkasov wrote:
>> We have seen this before, but so far have not found a way to consistently
>> reproduce it.
>>
>> There are some caveats with the current way context switching is done in Xenomai.
>>
>> On armv7, there was a completely separate implementation of xnarch_switch_to(),
>> as well as separate fpu and TLS switching. At this stage for armv8 however, we
>> are doing a direct call to the kernel's __switch_to(), which then performs the
>> relevant register switches.
>>
>> Another possibility is that this may be lurking in the mm switch. During calls 
>> to check_and_switch_context(), the interrupt state may not always
>> match what is expected according to the comments in the original
>> version of that function. 
>>
>> Overall, this mechanism could definitely benefit from further review.
>>
> 
> 
> Thanks Dimitry.
> I'll also try to look into this for this specific platform (however I am hopping
> that either Gilles or Philippe can spend some time on this soon)

No arm64 hw here, so unless this is easily reproducible on a vm, I can
only help with code review. Did you enable
CONFIG_XENO_ARCH_UNLOCKED_SWITCH? If so, any change when turning it off?

> 
> Just for completeness, as things stand this is pretty much that value I am
> seeing over consecutive runs.
> 
> RTD|      4.167|      6.099|     11.667|       0|     0|      3.333|     66.667

This latency seems high for such class of hardware, especially with no
load. We'll need the tracer to dig this too.

-- 
Philippe.

