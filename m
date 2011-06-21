Message-ID: <4E008174.2060305@domain.hid>
Date: Tue, 21 Jun 2011 13:33:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <3FF315C710820E47A04E55C6F7D9B0AD7FE9FF@AREXCH02.mra.roland-man.biz>
	<1308044391.2699.2.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FEA2C@AREXCH02.mra.roland-man.biz>
	<1308387052.2122.14.camel@domain.hid> <4DFCABDA.6000702@domain.hid>
	<1308406918.2122.24.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FECDA@AREXCH02.mra.roland-man.biz>
	<1308652557.2125.45.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FECF6@domain.hid>
In-Reply-To: <3FF315C710820E47A04E55C6F7D9B0AD7FECF6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On 06/21/2011 01:22 PM, roderik.wildenburg@domain.hid wrote:
>> 2% off seems a lot for a transient load, and this would not happen on a
>> periodic basis anyway. This needs to be investigated. Could you run
>> switchtest in nofpu mode?
> 
> Still fluctuates about 2% (see !!  mark) but now more erratic. The reduced number of context switches is caused by the reduced number of tasks?

switchest works by switching context between several tasks. One of this
task does sleep, in order to avoid starving linux, and also prints the
numbers approximately every second.

When there are less task, we enter the sleeping task more often, so,
yes, there are less context switches.

But more importantly, since, the time when we print the result is so
imprecise, some variations are normal, so, chances are that the 2%
variation is normal.

-- 
                                                                Gilles.

