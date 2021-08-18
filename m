References: <20210818112407.12264-1-florian.bezdeka@siemens.com>
 <20210818112407.12264-2-florian.bezdeka@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [RFC PATCH 1/4] cobalt/registry: Make the root directory for
 proc exports optional
In-reply-to: <20210818112407.12264-2-florian.bezdeka@siemens.com>
Date: Wed, 18 Aug 2021 15:26:34 +0200
Message-ID: <87zgteyjcl.fsf@xenomai.org>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@xenomai.org


Florian Bezdeka via Xenomai <xenomai@xenomai.org> writes:

> Previously the root directory was mandatory, which means that exports
> to the proc file system were forced to be located in
> /proc/xenomai/registry/<root-dir>/<class>/<file>.
>
> The <root-dir> virtual directory is now optional. If not supplied the
> root node of <class> is set to registry_vfroot, which represents
> /proc/xenomai/registry.

This is not needed. You may want to try something along these lines
(excerpt from the Xenomai 2 implementation the registry originates from,
with a few adaptations for readability, ksrc/skins/native/queue.c):

static DEFINE_XNPTREE(__queue_ptree, "native");

static struct xnpnode_snapshot __q_pnode = {
	.node = {
		.dirname = "queues",
		.root = &__queue_ptree,
		.ops = &xnregistry_vfsnap_ops,
	},
	.vfile = {
		.privsz = sizeof(struct vfile_priv),
		.datasz = sizeof(struct vfile_data),
		.ops = &vfile_ops,
	},
};

...

xnregistry_enter(q->name, q, &q->handle, &__q_pnode.node);

With this, you would get the /proc/xenomai/registry/queues root
directory for queues created automatically, the way the registry wants
it to be done.

-- 
Philippe.

