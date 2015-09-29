References: <55E5F849.1070708@xenomai.org> <55E5FB89.3080604@xenomai.org>
 <55E60743.30600@xenomai.org>
 <CAJqUr7zP85A6V7n9O=++iC4tJK8LCG5JC8xtO9Xd+u3sQW4G1A@mail.gmail.com>
 <5604517A.2000602@mperpetuo.com>
 <20150925150248.GE1332@hermes.click-hack.org>
 <560580E6.6070208@mperpetuo.com>
 <20150925180137.GF1332@hermes.click-hack.org>
 <20150926112419.GH1332@hermes.click-hack.org>
 <CAPuu0=hEDw3g4pkJfWsAy-LkgwL=SrGyb1xPuU7a3-5LKYuHZg@mail.gmail.com>
 <20150929001233.GB15767@hermes.click-hack.org>
From: Jorge Ramirez Ortiz <jro@xenomai.org>
Message-ID: <560A89FC.9060808@xenomai.org>
Date: Tue, 29 Sep 2015 08:54:20 -0400
MIME-Version: 1.0
In-Reply-To: <20150929001233.GB15767@hermes.click-hack.org>
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
To: xenomai@xenomai.org

On 09/28/2015 08:12 PM, Gilles Chanteperdrix wrote:
> On Mon, Sep 28, 2015 at 04:57:28PM -0700, Dmitriy Cherkasov wrote:
>> On Sat, Sep 26, 2015 at 4:24 AM, Gilles Chanteperdrix <
>> gilles.chanteperdrix@xenomai.org> wrote:
>>
>>>
>>> Ok, I feel I have not been completely clear. There are three
>>> questions:
>>>
>>> - whether every context switch should switch the fpu context: your
>>> answer is yes, my answer is no: simply remove the line forcibly
>>> setting the XNFPU bit in xnarch_init_shadow_tcb and your port will
>>> only switch the FPU context for those tasks that have the XNFPU bit
>>> set. All user-space tasks have the XNFPU bit set, and some
>>> kernel-space tasks. And if you do that it would be nice to forbid
>>> using the FPU when entering a task which does not have the FPU bit
>>> set.
>>
>>
>>> - whether xnarch_init_shadow_tcb should forcibly clear the XNFPU
>>> bit, and the XNFPU bit be enabled upon first use of the FPU, your
>>> answer is no, my answer is yes. But in fact, the x86 and arm 32 bits
>>> could be the default, and the tasks which do not want to pay the
>>> price of a trap upon first use of the FPU could trigger an
>>> initialization of the FPU with pthread_set_mode_np for instance.
>>>
>>
>> To be accurate, my answer is not "no", but more of a "not yet".
>>
>> My original goal is to get it working without lazy switching, then optimize
>> later if needed.
>>
>>
>>>
>>> - whether the FPU faults should emit I-pipe events: here there is no
>>> other answer possible than yes, because otherwise the port is broken
>>> in case of FPU exception (division by zero, etc...).
>>>
>>>
>> Yes, this looks correct, and thank you for the patch. I've applied it to
>> ipipe and made the relevant changes to Xenomai. I will push this to our
>> gitlab shortly.
>>
>> However, armv8 does not trap divide by zero or overflows, and does not seem
>> to trap other things like sqrt(-1) either (at least on A53). So currently
>> I've been unable to exercise this code.
> 
> Ok, this page:
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0024a/CJHECGIH.html
> 
> seems to indicate that armv8 may or may not trap upon
> exception. Or maybe the exceptions can be enabled with the FPCR
> register? Or the glibc functions defined in the fenv.h header?
> 

the way it is worded it appears to be a decision left to the SoC vendor.
I'll post the question to support@arm.com for confirmation.

-- 
jro

