Message-ID: <510BF234.9080804@xenomai.org>
Date: Fri, 01 Feb 2013 17:49:56 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5108FABD.8090401@sirius-es.it> <5108FB91.2040105@xenomai.org>
	<5108FED0.6030709@xenomai.org> <510BC015.3020408@sirius-es.it>
In-Reply-To: <510BC015.3020408@sirius-es.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FPU problems in Xenomai 2.4.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Cc: xenomai@xenomai.org

On 02/01/2013 02:16 PM, Matteo Facchinetti wrote:
> On 01/30/2013 12:06 PM, Philippe Gerum wrote:
>>
>> To sum up:
>>
>> - linux 2.6.29 + fpu management fixes + Xenomai 2.6.2.1
>> or,
>
> Unfortunately, for the moment I must use this kernel release.
>
> I try to backport adeos-ipipe-2.6.36.4-powerpc-2.12-05.patch to 2.6.29.
>
> Does, this patch, contains all "fpu management fixes" or is possible

It does.

> there are other commits to looking for?
>


-- 
Philippe.

