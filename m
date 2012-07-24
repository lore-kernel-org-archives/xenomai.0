Message-ID: <500EBD59.6090400@xenomai.org>
Date: Tue, 24 Jul 2012 17:20:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E2AB2206BF591546A1931EA4E7A9FBC859BAFA22@Maui.in.dynetics.com>	<500AF14A.30703@xenomai.org>
	<500B014B.6080206@xenomai.org>	<500D01AE.2090801@siemens.com>
	<500D0666.2000700@xenomai.org>	<500D0E10.1040707@xenomai.org>
	<500D11DE.5010203@xenomai.org>	<500D211C.4000808@xenomai.org>
	<500D2A69.5030505@xenomai.org>	<500D2E14.5000905@xenomai.org>
	<500EBD23.4060902@xenomai.org>
In-Reply-To: <500EBD23.4060902@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT_TASK affinity on more than 8 CPU's
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/24/2012 05:20 PM, Gilles Chanteperdrix wrote:

> On 07/23/2012 12:57 PM, Philippe Gerum wrote:
> 
>> Do you have fixes to the generic core pending? If so, I'd like to merge 
>> them, so that I can eventually send out an updated patch to the blackfin 
>> folks.
> 
> 
> I just pushed my branch (for-core-3.4 in the usual repository), I made 


It includes the work for the ARM architecture, but not yet x86

-- 
                                                                Gilles.

