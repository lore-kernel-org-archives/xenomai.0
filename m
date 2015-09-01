Message-ID: <55E60743.30600@xenomai.org>
Date: Tue, 01 Sep 2015 16:14:59 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55E5E453.1080400@xenomai.org>
 <CAPuu0=jX6ig5L7SJrmPVOhCmOm=gwxEmTafTpOqzE85hOji8CA@mail.gmail.com>
 <55E5F849.1070708@xenomai.org> <55E5FB89.3080604@xenomai.org>
In-Reply-To: <55E5FB89.3080604@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, Dmitriy Cherkasov <dmitriy@mperpetuo.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>


>>
>> Thanks Dimitry.
>> I'll also try to look into this for this specific platform (however I am hopping
>> that either Gilles or Philippe can spend some time on this soon)
> 
> No arm64 hw here, so unless this is easily reproducible on a vm, I can
> only help with code review. Did you enable
> CONFIG_XENO_ARCH_UNLOCKED_SWITCH? If so, any change when turning it off?

I'll try to send you one of the boards from Cambridge.
I could give you access to my lab here but disabling power management will end
up overheating the CPU and with the early kernel release I am not sure how safe
it would be just relying on the thermal monitor (I have seen it kicking in so it
should work but I'd rather not trust it too much yet)

It shouldn't take more than a few days anyway

CONFIG_XENO_ARCH_UNLOCKED_SWITCH id not set

# Machine/platform-specific options



#



# CONFIG_XENO_ARCH_UNLOCKED_SWITCH is not set



# CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH is not set

> 
>>
>> Just for completeness, as things stand this is pretty much that value I am
>> seeing over consecutive runs.
>>
>> RTD|      4.167|      6.099|     11.667|       0|     0|      3.333|     66.667
> 
> This latency seems high for such class of hardware, especially with no
> load. We'll need the tracer to dig this too.
> 

Don mentioned that the trace is not ready yet.


-- 
jro

