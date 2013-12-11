Message-ID: <52A89F14.8020104@xenomai.org>
Date: Wed, 11 Dec 2013 18:21:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <529F1913.4030604@xenomai.org> <529F1974.60900@xenomai.org>
 <529F2BED.2030403@xenomai.org> <529F5254.8060501@xenomai.org>
 <529F69AD.6060003@xenomai.org>
 <CE87D5F4-FE47-4310-A74F-7F8E4CCEC92B@open.ac.uk>
 <52A05ED2.9050003@xenomai.org>
 <E8F821A2-2BD0-440D-BDA1-3751BD443662@open.ac.uk>
 <52A5E155.2040303@xenomai.org>
 <4453D563-1D0B-4C5E-BCF1-3E2E8068B514@open.ac.uk>
 <20131211145136.GL20884@csclub.uwaterloo.ca>
 <1124806E0C09F04A992E69AE2EC7FA3CB1B138@swexchange01.itk.local>
In-Reply-To: <1124806E0C09F04A992E69AE2EC7FA3CB1B138@swexchange01.itk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tobias Luksch <Tobias.Luksch@itk-engineering.de>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>, Kurijn Buys <Kurijn.Buys@open.ac.uk>

On 12/11/2013 05:04 PM, Tobias Luksch wrote:
>>> On Wed, Dec 11, 2013 at 02:23:38PM +0000, Kurijn Buys wrote: I
>>> enabled APIC, and the latency peaks at 16us only now, and even
>>> less with
>> load.
>>> This also had an effect on my analogy problem, but not
>>> completely... I will
>> start a new thread for that...
>>
>> If your latency drops under loads, it sounds as if your CPU is
>> slowing down when idle and taking a while to speed back up.
>> Perhaps changing the CPU governer to performance or user controlled
>> and setting a fixed CPU speed would keep the latency low all the
>> time (although at the cost of more power consumption).
>
> I had a similar problem where the latency behavior changed depending
> on the CPU load on an Intel CPU (see " Problems with running Xenomai
> on Core i5" thread of this list). It turned out to be a C1E "feature"
> that I could not influence in the BIOS. But clearing the second bit
> of the MSR_IA32_POWER_CTL register did help. I used the wrmsr command
> of the msr-tools package.

Ok, we could integrate this C1E workaround as the SMI workaround or AMD 
C1E workaround. Do you have any pointer, which would explain me a way to 
detect that this MSR is available (and C1E is enabled, but I guess it is 
just a matter of reading the MSR). Second question is: has not this 
change any repercussion on processor temperature.

-- 
					    Gilles.

