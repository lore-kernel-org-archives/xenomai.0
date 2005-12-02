Message-ID: <439071EF.3040004@domain.hid>
Date: Fri, 02 Dec 2005 17:10:23 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] i386 2.4 backport performing (too?) well
References: <Pine.LNX.4.63.0512021139500.2791@domain.hid>
	<4390470F.8040503@domain.hid>
In-Reply-To: <4390470F.8040503@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Klaas Gadeyne wrote:
> 
>>With the arrival of the 2.4 i386 adeos ipipe patch for xenomai [1], I
>>decided to try to compile xenomai-trunk for a 2.4 kernel. This worked
>>flawlessly, and moreover, I got excellent latency results:
>>
>>I used the "same" kernel config as for our 2.4.31 rtai3.0r5 kernel,
>>which is based on Takis Issaris' liveCD config.
>>
>>This resulted in a maximal latency of 30 usec after a run of over 100
>>minutes under heavy load (tar and dd loops, compiling, keyboard
>>interrupts and ping flood) [2].
>>
>>For comparison, on the same hardware platform: - the RTAI lxrt-latency
>>on rtai 3.0r5 (adeos oldgen r18c1
>>  patch for 2.4.31 also) test reports 38 usec
>>- the latency test of xenomai 2.01 running on a 2.6.14-ipipe-1.0-10
>>  kernel resulted in a latency of 80 usec.
>>
>>This seems too good to be true?  Can one simply compare the results of
>>the former RTAI lxrt-latency test with the xenomai latency test?
> 
> 
> Mmh, I tend to be sceptical as well, also remembering the results
> Wolfgang posted about 2.6 vs. 2.4 on low-end PPC
> (https://mail.gna.org/public/xenomai-core/2005-11/msg00131.html).
> 
> Well, such worst-case improvement may be real if and only if there is
> less *kernel* code in hard-irq-off sections with 2.4. The complexity of
> adeos/ipipe and xenomai isn't changed between both scenarios.
> 
> But I rather think that 2.4 just stresses the caches less than 2.6, thus
> is may be more tricky to trigger the real worst-case path. So, what we
> already saw with PPC: 2.4 and 2.6 may likely show similar RT
> performances under Xenomai, but the overall system performance is much
> better on low-end! However, I would be happy if this theory is too
> pessimistic.

In the meantime I have measured latencies a few PowerPC systems with 
Xenomai 2.1 under Linux 2.4 and 2.6 and RTAI 3.0r5 (using RTHAL) under 
2.4. The latency figures for Xenomai compared with RTAI 3.0r5 are 
roughly a factor of two worse but I have not realized a significant 
difference between 2.4 and 2.6 (with Xenmomai, of course).

Wolfgang.

