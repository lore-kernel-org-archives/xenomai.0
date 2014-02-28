Message-ID: <53104C58.3040903@xenomai.org>
Date: Fri, 28 Feb 2014 09:44:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1WJ3I1-00060i-NR@sd-51317.dedibox.fr>
 <530F96D3.4040407@xenomai.org>
In-Reply-To: <530F96D3.4040407@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : copperplate/registry:
 reap sysregd selectively
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 02/27/2014 08:49 PM, Gilles Chanteperdrix wrote:
> On 02/27/2014 04:54 PM, git repository hosting wrote:
>>   	memset(&sa, 0, sizeof(sa));
>>   	sa.sa_handler = SIG_IGN;
>>   	sigaction(SIGCHLD, &sa, NULL);
>
> Why not masking the signal here instead of ignoring it? So that the
> notifications which would happen during the short interval are not lost?
>
>

We only want the child to be reaped instead of going zombie, we don't 
actually care about the exit status.

-- 
Philippe.

