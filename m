Message-ID: <50D48EE0.5050407@xenomai.org>
Date: Fri, 21 Dec 2012 17:31:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC PATCH 0/10] Support ftrace on ipipe kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Cc: jan.kiszka@siemens.com, xenomai@xenomai.org

On 12/21/2012 02:26 PM, Wolfgang Mauerer wrote:
> Hi Gilles, Jan,
>
> here's a proposal to make ipipe compatible with ftrace that
> does not require global modifications to the preemption system,
> but makes do with local changes. The approach should be easy
> to maintain in the long run:
>

In the long run, we won't have any non-linux stacks to deal with. 
Xenomai 3.x will be moving kernel-based threads over regular linux 
kthreads soon, the conversion has begun today in my local tree actually. 
I guess that nobody is going to be saddened to see this non-sense go 
away (yes, I'm the original author of this non-sense, it's painful enough).

So basically, this patches series will be required for running the 2.6.x 
series only. For this reason, on a general note, I'd like to see all 
these extra bits moving to the legacy section in a way or another 
(CONFIG_IPIPE_LEGACY).

-- 
Philippe.

