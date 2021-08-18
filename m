References: <20210818112407.12264-1-florian.bezdeka@siemens.com>
 <20210818112407.12264-2-florian.bezdeka@siemens.com>
 <87zgteyjcl.fsf@xenomai.org>
 <619aa02fb42c2d7a4d03e76be934e1aefcd77ce0.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [RFC PATCH 1/4] cobalt/registry: Make the root directory for
 proc exports optional
In-reply-to: <619aa02fb42c2d7a4d03e76be934e1aefcd77ce0.camel@siemens.com>
Date: Wed, 18 Aug 2021 16:02:44 +0200
Message-ID: <87tujmyhob.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>


Bezdeka, Florian <florian.bezdeka@siemens.com> writes:

> On Wed, 2021-08-18 at 15:26 +0200, Philippe Gerum wrote:
>> Florian Bezdeka via Xenomai <xenomai@xenomai.org> writes:
>> 
>> > Previously the root directory was mandatory, which means that exports
>> > to the proc file system were forced to be located in
>> > /proc/xenomai/registry/<root-dir>/<class>/<file>.
>> > 
>> > The <root-dir> virtual directory is now optional. If not supplied the
>> > root node of <class> is set to registry_vfroot, which represents
>> > /proc/xenomai/registry.
>> 
>> This is not needed. You may want to try something along these lines
>> (excerpt from the Xenomai 2 implementation the registry originates from,
>> with a few adaptations for readability, ksrc/skins/native/queue.c):
>> 
>> static DEFINE_XNPTREE(__queue_ptree, "native");
>> 
>> static struct xnpnode_snapshot __q_pnode = {
>> 	.node = {
>> 		.dirname = "queues",
>> 		.root = &__queue_ptree,
>> 		.ops = &xnregistry_vfsnap_ops,
>> 	},
>> 	.vfile = {
>> 		.privsz = sizeof(struct vfile_priv),
>> 		.datasz = sizeof(struct vfile_data),
>> 		.ops = &vfile_ops,
>> 	},
>> };
>> 
>> ...
>> 
>> xnregistry_enter(q->name, q, &q->handle, &__q_pnode.node);
>> 
>> With this, you would get the /proc/xenomai/registry/queues root
>> directory for queues created automatically, the way the registry wants
>> it to be done.
>> 
>
> I tried exactly that, but ended up all queues to be visible in
> /proc/xenomai/registry/native/queues/<name> which was not what I wanted
> to achieve.
>
> But if you tell me that there must be an additional subdirectory, I'm
> fine with it...
>

DEFINE_XNPTREE(rtipc_ptree, "rtipc") already exists in the hierarchy,
with protocols attached underneath. The current registry still exhibits
some Xenomai 2 legacy, which would have one root per interface (native,
posix, vxworks etc.)

So, you could either graft your mqueue hierarchy directly under the
registry root the way your patch does, or reshuffle the whole thing a
bit in order to account for a new set of object families, like POSIX
(incl. mqueues), rtdm and other namespaces for some drivers if you plan
to export more objects in the future.

The point being that POSIX and RTDM for instance both implement
semaphores and threads. So either living with /proc/registry/posix_sema4
_and_ /proc/registry/rtdm_sema4 is ok with you, otherwise you may go for
keeping toplevel categories so as to have /proc/registry/posix/sema4 and
/proc/registry/rtdm/sema4.

-- 
Philippe.

