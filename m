Message-ID: <50E94E72.5050309@xenomai.org>
Date: Sun, 06 Jan 2013 11:14:10 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50E47751.1070005@siemens.com> <50E59112.6080005@siemens.com>
In-Reply-To: <50E59112.6080005@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v3] nucleus: Convert intrlock to a sleeping
 Linux lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@siemens.com>, Xenomai <xenomai@xenomai.org>

On 01/03/2013 03:09 PM, Jan Kiszka wrote:

> +static struct xnvfile_lock_ops vfile_stat_lockops = {
> +	.get = xnintr_get_query_lock,
> +	.put = xnintr_put_query_lock,
> +};
> +
>  static struct xnvfile_snapshot stat_vfile = {
>  	.privsz = sizeof(struct vfile_stat_priv),
>  	.datasz = sizeof(struct vfile_stat_data),
>  	.tag = &nkpod_struct.threadlist_tag,
>  	.ops = &vfile_stat_ops,
> +	.entry = { .lockops = &vfile_stat_lockops },
>  };

This would introduce a regression. stat_vfile's rewind/next handlers
compete with code altering the global thread queue which may run in
primary mode, such as xnpod_delete_thread() when deleting a kernel task.
So we can't use a linux lock to protect it.

-- 
Philippe.

