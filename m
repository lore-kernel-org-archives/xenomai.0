Message-ID: <513D92B0.7000504@xenomai.org>
Date: Mon, 11 Mar 2013 09:15:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512BFD9E.5010501@crubille.lautre.net>	<512BE5A2.3090505@xenomai.org>	<513DA0B5.5060304@crubille.lautre.net>
	<513D8C24.4010009@xenomai.org>
In-Reply-To: <513D8C24.4010009@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Linux port to ARM Allwinner A13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul@crubille.lautre.net>
Cc: xenomai@xenomai.org

On 03/11/2013 08:47 AM, Gilles Chanteperdrix wrote:

> On 03/11/2013 10:15 AM, Paul wrote:
> 
>> Hello,
>>
>> Here are pre and post patch for xenomai on sun5i (allwinner A13). It
>> should work for sun4i (allwinner A10) too, but is not tested for this
>>  proc.


Also, you seem to have duplicated the timer code, this should not be
needed, right?

-- 
                                                                Gilles.

