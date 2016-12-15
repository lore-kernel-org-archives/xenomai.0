From: Philippe Gerum <rpm@xenomai.org>
References: <3aafa6c7-d201-bc14-d32c-48480e56bf2a@smile.fr>
Message-ID: <07d9d1dc-8855-bf5d-50ac-83c02aa44fc2@xenomai.org>
Date: Thu, 15 Dec 2016 15:14:28 +0100
MIME-Version: 1.0
In-Reply-To: <3aafa6c7-d201-bc14-d32c-48480e56bf2a@smile.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __map_umm return NULL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Stephan <julien.stephan@smile.fr>, Xenomai@xenomai.org

On 12/15/2016 10:59 AM, Julien Stephan wrote:
> Hello,
> 
> As explained in my previous question "TIP_HEAD bit during Xenomai
> initialization" I am porting xenomai 3 on a new architecture.
> 
> 
> My problem here is that the function __map_umm return NULL. This cause a
> SEGV in cobalt_commit_memory.
> 
> I step into __map_umm with gdb and noticed that there is an open on
> /dev/rtdm/memdev-private which return fd = 0 : I think this is not
> normal ....
> 
> Then there is the ioctl command, which does not return an error and
> finally, the mmap function that return NULL. I am pretty sure that this
> is not normal too.
> 
> So what could be the cause?
> 
> 

The code implementing the syscall interception by the pipeline seems
broken. Since you did not mention which architecture you are porting to,
I can't comment further.

-- 
Philippe.

