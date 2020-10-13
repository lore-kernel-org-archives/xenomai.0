Subject: Re: [PATCH] cobalt/kernel: vfile_snapshot: fix seq_file leakage on
 race detection
References: <20200929132504.448462-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <861d74da-4e59-3865-a609-b5b435180b67@siemens.com>
Date: Tue, 13 Oct 2020 15:34:16 +0200
MIME-Version: 1.0
In-Reply-To: <20200929132504.448462-1-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 29.09.20 15:25, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> vfile_snapshot_open() may re-run the data collection loop in case we
> detected a race by checking the revision tag of the data
> set. Unfortunately, the seq_file is already open at this point,
> causing a leakage as seq_open() will be called again.
> 
> The bug triggers after a while running the following commands
> concurrently:
> 
> $ while : ; do cat /proc/xenomai/sched/stat > /dev/null; done &
> $ while : ; do switchtest -T 5; done
> 
> As the private_data field of the backing file is not NULL once
> seq_open() has run, this bug triggers the following warning splat when
> calling it anew for the same file:
> 
> [   32.660548] WARNING: CPU: 0 PID: 446 at fs/seq_file.c:55 seq_open.cold+0xc/0x1a
> [   32.670934] CPU: 0 PID: 446 Comm: cat Not tainted 4.19.89+ #16
> [   32.686078] I-pipe domain: Linux
> [   32.689312] RIP: 0010:seq_open.cold+0xc/0x1a
> [   32.693592] Code: 48 8b 74 24 08 e8 1e 5e f9 ff 48 8b 5d 18 48 8b 55 08 4c 01 f3 48 89 5d 18 e9 25 fe ff ff 48 c7 c7 00 99 2b 82 e8 32 71 de ff <0f> 0b e9 d3 db ff ff 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54
> [   32.712354] RSP: 0018:ffff88815476f9b0 EFLAGS: 00010246
> [   32.717588] RAX: 0000000000000024 RBX: ffff888153ec7400 RCX: 0000000000000000
> [   32.724728] RDX: 1ffff1102b944a01 RSI: 0000000000000008 RDI: ffffed102a8edf2d
> [   32.731873] RBP: ffffffff828c5560 R08: 0000000000000024 R09: ffffffff815d0644
> [   32.739016] R10: ffffed102b946f1c R11: ffff88815ca378e7 R12: ffff888153ec74c8
> [   32.746156] R13: ffffffff828c75a0 R14: ffff8881544ebb80 R15: ffff888155a2d9c8
> [   32.753299] FS:  00007ff225dc3740(0000) GS:ffff88815ca00000(0000) knlGS:0000000000000000
> [   32.761395] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   32.767152] CR2: 00007ff225eb8120 CR3: 0000000153d8c000 CR4: 00000000003406f0
> [   32.774289] Call Trace:
> [   32.776746]  vfile_snapshot_open+0x2a8/0x560
> [   32.781022]  proc_reg_open+0x124/0x270
> [   32.784782]  ? proc_i_callback+0x20/0x20
> [   32.788713]  do_dentry_open+0x2ac/0x750
> [   32.792558]  ? proc_i_callback+0x20/0x20
> [   32.796492]  ? __x64_sys_fchmod+0x70/0x70
> [   32.800507]  ? inode_permission.part.0+0x4f/0x180
> [   32.805219]  ? security_inode_permission+0x13/0x60
> [   32.810015]  path_openat+0x456/0x1b80
> [   32.813681]  ? kmem_cache_alloc+0xd2/0x1c0
> [   32.817783]  ? getname_flags+0x35/0x240
> [   32.821624]  ? do_syscall_64+0x8a/0x240
> [   32.825466]  ? __rcu_read_unlock+0x66/0x80
> [   32.829572]  ? path_lookupat+0x430/0x430
> [   32.833497]  ? find_get_pages_range_tag+0x3a0/0x3a0
> [   32.838381]  ? finish_mkwrite_fault+0x1f0/0x1f0
> [   32.842916]  do_filp_open+0x103/0x210
> [   32.846586]  ? may_open_dev+0x50/0x50
> [   32.850253]  ? __fdget+0xe0/0xe0
> [   32.853491]  ? __virt_addr_valid+0xa6/0x100
> [   32.857677]  ? check_stack_object+0x1f/0x60
> [   32.861864]  ? __check_object_size+0x10c/0x1ce
> [   32.866316]  ? _raw_spin_unlock+0x9/0x30
> [   32.870245]  ? __alloc_fd+0x115/0x220
> [   32.873910]  do_sys_open+0x1c3/0x290
> [   32.877489]  ? __do_page_fault+0x494/0x7b0
> [   32.881588]  ? file_open_name+0x180/0x180
> [   32.885604]  do_syscall_64+0x8a/0x240
> [   32.889270]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fix this by deferring the call to seq_open() until after the data is
> fully collected without race, which prevents any seq_file leakage on
> race by design.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  kernel/cobalt/vfile.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/cobalt/vfile.c b/kernel/cobalt/vfile.c
> index dc311f9ce..f65d46ddf 100644
> --- a/kernel/cobalt/vfile.c
> +++ b/kernel/cobalt/vfile.c
> @@ -153,6 +153,8 @@ static int vfile_snapshot_open(struct inode *inode, struct file *file)
>  	struct seq_file *seq;
>  	caddr_t data;
>  
> +	WARN_ON_ONCE(file->private_data != NULL);
> +
>  	if ((file->f_mode & FMODE_WRITE) != 0 && ops->store == NULL)
>  		return -EACCES;
>  
> @@ -244,14 +246,10 @@ redo:
>  		it->endfn = vfile_snapshot_free;
>  	}
>  
> -	ret = seq_open(file, &vfile_snapshot_ops);
> -	if (ret)
> -		goto fail;
> -
>  	it->nrdata = 0;
>  	data = it->databuf;
>  	if (data == NULL)
> -		goto finish;
> +		goto done;
>  
>  	/*
>  	 * Take a snapshot of the vfile contents, redo if the revision
> @@ -260,12 +258,14 @@ redo:
>  	for (;;) {
>  		ret = vfile->entry.lockops->get(&vfile->entry);
>  		if (ret)
> -			break;
> +			goto fail;
>  		if (vfile->tag->rev != revtag)
>  			goto redo;
>  		ret = ops->next(it, data);
>  		vfile->entry.lockops->put(&vfile->entry);
> -		if (ret <= 0)
> +		if (ret < 0)
> +			goto fail;
> +		if (ret == 0)
>  			break;
>  		if (ret != VFILE_SEQ_SKIP) {
>  			data += vfile->datasz;
> @@ -273,22 +273,24 @@ redo:
>  		}
>  	}
>  
> -	if (ret < 0) {
> -		seq_release(inode, file);
> -	fail:
> -		if (it->databuf)
> -			it->endfn(it, it->databuf);
> -		kfree(it);
> -		return ret;
> -	}
> +done:
> +	ret = seq_open(file, &vfile_snapshot_ops);
> +	if (ret)
> +		goto fail;
>  
> -finish:
>  	seq = file->private_data;
>  	it->seq = seq;
>  	seq->private = it;
>  	xnvfile_nref(vfile)++;
>  
>  	return 0;
> +
> +fail:
> +	if (it->databuf)
> +		it->endfn(it, it->databuf);
> +	kfree(it);
> +
> +	return ret;
>  }
>  
>  static int vfile_snapshot_release(struct inode *inode, struct file *file)
> 

Thanks, applied.

I suspect this affects 3.0 as well. Will check if we can pick it up
there as well.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

