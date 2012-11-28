Message-ID: <50B61BBB.9010605@xenomai.org>
Date: Wed, 28 Nov 2012 15:12:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50B61654.40504@gmail.com> <50B617CA.8080209@xenomai.org>
In-Reply-To: <50B617CA.8080209@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] EDF on Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 11/28/2012 02:55 PM, Philippe Gerum wrote:
> On 11/28/2012 02:49 PM, Sebastian Pavez wrote:
>> Hi everybody,
>>
>> It's there support for EDF schedulling on Xenomai? I found this question
>> before
>> (http://www.xenomai.org/pipermail/xenomai-core/2007-10/msg00137.html)
>> and the answer was no. It's still the answer?
> 
> Yes, no EDF yet.
> 

In case somebody is interested in contributing this, Xenomai implements
policies as plugins over a common scheduler infrastructure. See
ksrc/nucleus/sched*.c

-- 
Philippe.

