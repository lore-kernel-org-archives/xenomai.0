Message-ID: <5360E648.90201@xenomai.org>
Date: Wed, 30 Apr 2014 14:02:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <535FD440.7000104@zultron.com> <535FD6DC.3020802@xenomai.org>
In-Reply-To: <535FD6DC.3020802@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CONFIG_XENO_OPT_NATIVE_INTR=y
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, John Morris <john@zultron.com>, xenomai@xenomai.org

On 04/29/2014 06:44 PM, Philippe Gerum wrote:
> On 04/29/2014 06:33 PM, John Morris wrote:
>> My Debian kernel packages [1] use Gilles's kernel config snippet [2] for
>> Xenomai configuration, where CONFIG_XENO_OPT_NATIVE_INTR is turned off.
>>
>> Michael Haberler requested [3] that option be turned on to support RT
>> parport ISRs [4], presumably since many LinuxCNC and Machinekit users
>> attach stepper motor drivers through the parport.
>>
>> Given the 'one size fits all' approach to these kernel packages, which
>> are intended to run on a variety of x86 hardware for a variety of
>> applications (not necessarily just Machinekit), is this an appropriate
>> option to enable for general use?  Is there a specific reason this is
>> turned off in Gilles's configuration?
>
> The reason to turn this off by default is because this interface is
> deprecated, and was dropped from the upcoming 3.x API. The preferred
> (and strongly suggested) way for dealing with interrupts from userland
> is via an RTDM driver, for reliability reasons.

Note that we have an in-tree analogy driver for PC parallel port, I do 
not know if it fits Michael needs. The driver seems ported from comedi, 
so it may exist for preempt_rt and rtai as well.

-- 
					    Gilles.

