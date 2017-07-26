References: <20170711113213.16427-1-henning.schild@siemens.com>
 <20170711134009.63101673@md1em3qc>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8137ae2d-e178-740c-803a-1c388b80f2f7@xenomai.org>
Date: Wed, 26 Jul 2017 17:22:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170711134009.63101673@md1em3qc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/2] lib/alchemy: fix rt_mutex_create return
 values
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, "xenomai @ xenomai . org" <xenomai@xenomai.org>

On 07/11/2017 01:40 PM, Henning Schild wrote:
> I am not sure i like what is happening there. Maybe we should just
> allow rt_mutex_create to return whatever syncluster_addobj returns.
> I just looked at the code and the pattern where any error from
> syncluster_addobj is turned into an EEXIST is in several places.
> 

I'm not sure I like it either, that does not make any sense actually -
it even hides the ENOMEM error, which would be just insane. I pushed a
patch fixing the issue globally for all callers of syncluster_addobj(),
updating the inline documentation in the same move.

> We have an application that creates shadow threads whenever the first
> cobalt syscall returns -EPERM. You can argue whether that is a good
> idea, but turning an -EPERM into something else is also not a good idea.

As I mentioned lately, I would recommend pthread_kill(pthread_self(), 0)
as a more robust way for a thread to check this. Receiving ESRCH would
mean that it has not been shadowed.

-- 
Philippe.

