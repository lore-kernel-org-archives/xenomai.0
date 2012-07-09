Message-ID: <4FFB18F7.4070002@xenomai.org>
Date: Mon, 09 Jul 2012 19:46:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658302ED62BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
In-Reply-To: <4F534D1A615F544D95E57BFD8460658302ED62BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] shared memory segments
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Jorge Ramirez Ortiz, HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/09/2012 12:26 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
> Hi all, I am doing a port of a  shared library; in this library , a
> shared memory segment is being mapped (now using the Xenomai POSIX
> skin.) Some semaphores and data are placed on that shared segment.
> 
> Is there a way to mark the shared memory segment for deletion
> (unlink) after the last process detaches it (basically what
> shmctl(shmid, IPC_RMID, &shmInfo) does) cheers Jorge

Just so we are clear: the only thing xenomai posix skin shared memory
are useful for is sharing memory between kernel-space and user-space.
So, if your intent is to simply share memory between two xenomai
user-space applications, you can use plain linux shared memory,
including system 5 shared memory if you prefer.

-- 
                                                                Gilles.

