Message-ID: <52B89D01.2080703@xenomai.org>
Date: Mon, 23 Dec 2013 21:28:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52B71AB4.5090204@xenomai.org> <52B856F5.7090704@xenomai.org>
In-Reply-To: <52B856F5.7090704@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] file descriptors rework
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 12/23/2013 04:29 PM, Philippe Gerum wrote:
> On 12/22/2013 06:00 PM, Gilles Chanteperdrix wrote:
>>
>> Here is the new proposed API for file descriptors:
>>
>> struct xnfd_ops {
>> 	int (*destroy)(struct xnfd *fd);
>> 	int (*select_bind)(struct xnfd *fd, struct xnselector *selector,
>> 			unsigned type, unsigned index);
>> };
>>
>> struct xnfd {
>> 	unsigned magic;
>> 	struct mm_struct *mm;
>> 	int ufd;
>> 	struct xnfd_ops *ops;
>> 	unsigned refs;
>> 	struct hlist_node hlink; /* Link in global hash */
>> 	struct list_head link;	 /* Link in per-process queue */
>> };
>>
>> int xnfd_enter(struct xnfd *xnfd, unsigned magic, int ufd,
>> 	struct mm_struct *mm, struct xnfd_ops *ops);
>>
>> struct xnfd *xnfd_get(int ufd, struct mm_struct *mm, unsigned magic);
>>
>> int xnfd_put(struct xnfd *xnfd);
>>
>> int xnfd_close(struct xnfd *xnfd);
>>
>> The xnfd structure has to be put inside larger structure, and
>> container_of used to access the larger structure. The magic is there to
>> cope with the fact that different file descriptors users will have
>> different structures, so the actual type has to be found before using
>> container_of.
>>
>> refs is incrementer on get, decremented on put, when it reaches 0, the
>> "destroy" callback is called, this in order to avoid destroying a file
>> descriptor under another file descriptor user's feet.
>>
>> xnfd_close negates the magic in order to render the file descriptor invalid.
>>
>> the select_bind callbacks is needed to implement select uniformly.
>>
>> If nobody disagrees with this API, I will start implementing ASAP, and
>> rebase the message queues code upon this.
>>
> 
> Looks fairly straightforward to me. AFAICT, there may be an opportunity 
> to merge the xnselect features with a broader fd-oriented support.
> 
Currently, linking the file descriptors index with the actual object
happens in posix/select.c, but it is true that if there is only one way
to obtain file descriptors, we can make this generic in cobalt/select.c.
That and duplicating file descriptors upon fork. My current focus is on
removing the posix registry.

-- 
                                                                Gilles.

