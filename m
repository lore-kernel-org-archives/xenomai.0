Subject: Re: [PATCH v2 3/7] cobalt/kernel: convert to proc_ops
References: <20210327101912.2291474-1-rpm@xenomai.org>
 <20210327101912.2291474-4-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <60c2189c-b442-a5c8-d7b7-95804882ef07@siemens.com>
Date: Wed, 7 Apr 2021 11:52:59 +0200
MIME-Version: 1.0
In-Reply-To: <20210327101912.2291474-4-rpm@xenomai.org>
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

On 27.03.21 11:19, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  .../include/asm-generic/xenomai/wrappers.h    | 20 ++++++
>  kernel/cobalt/vfile.c                         | 26 ++++----
>  kernel/drivers/analogy/device.c               | 12 ++--
>  kernel/drivers/can/mscan/rtcan_mscan_proc.c   | 12 ++--
>  kernel/drivers/can/rtcan_module.c             | 66 +++++++++----------
>  .../drivers/can/sja1000/rtcan_sja1000_proc.c  | 12 ++--
>  6 files changed, 80 insertions(+), 68 deletions(-)
> 
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> index cd22a8db5..cc0cb0896 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> @@ -170,6 +170,26 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
>  #define __kernel_old_timeval	timeval
>  #endif
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,6,0)
> +#define DEFINE_PROC_OPS(__name, __open, __release, __read, __write) \
> +	struct file_operations __name = {			    \
> +		.open = (__open),				    \
> +		.release = (__release),				    \
> +		.read = (__read),				    \
> +		.write = (__write),				    \
> +		.llseek = seq_lseek,				    \
> +}
> +#else
> +#define DEFINE_PROC_OPS(__name, __open, __release, __read, __write)	\
> +	struct proc_ops __name = {					\
> +		.proc_open = (__open),					\
> +		.proc_release = (__release),				\
> +		.proc_read = (__read),					\
> +		.proc_write = (__write),				\
> +		.proc_lseek = seq_lseek,				\
> +}
> +#endif
> +
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0)
>  #define old_timespec32    compat_timespec
>  #define old_itimerspec32  compat_itimerspec
> diff --git a/kernel/cobalt/vfile.c b/kernel/cobalt/vfile.c
> index f65d46ddf..e9e10ce8d 100644
> --- a/kernel/cobalt/vfile.c
> +++ b/kernel/cobalt/vfile.c
> @@ -340,13 +340,12 @@ ssize_t vfile_snapshot_write(struct file *file, const char __user *buf,
>  	return ret;
>  }
>  
> -static struct file_operations vfile_snapshot_fops = {
> -	.open = vfile_snapshot_open,
> -	.read = seq_read,
> -	.write = vfile_snapshot_write,
> -	.llseek = seq_lseek,
> -	.release = vfile_snapshot_release,
> -};
> +static const DEFINE_PROC_OPS(vfile_snapshot_fops,
> +		       vfile_snapshot_open,
> +		       vfile_snapshot_release,
> +		       seq_read,
> +		       vfile_snapshot_write
> +);
>  
>  /**
>   * @fn int xnvfile_init_snapshot(const char *name, struct xnvfile_snapshot *vfile, struct xnvfile_directory *parent)
> @@ -592,13 +591,12 @@ ssize_t vfile_regular_write(struct file *file, const char __user *buf,
>  	return ret;
>  }
>  
> -static struct file_operations vfile_regular_fops = {
> -	.open = vfile_regular_open,
> -	.read = seq_read,
> -	.write = vfile_regular_write,
> -	.llseek = seq_lseek,
> -	.release = vfile_regular_release,
> -};
> +static const DEFINE_PROC_OPS(vfile_regular_fops,
> +		       vfile_regular_open,
> +		       vfile_regular_release,
> +		       seq_read,
> +		       vfile_regular_write
> +);
>  
>  /**
>   * @fn int xnvfile_init_regular(const char *name, struct xnvfile_regular *vfile, struct xnvfile_directory *parent)
> diff --git a/kernel/drivers/analogy/device.c b/kernel/drivers/analogy/device.c
> index 160dcf547..6ed588708 100644
> --- a/kernel/drivers/analogy/device.c
> +++ b/kernel/drivers/analogy/device.c
> @@ -95,12 +95,12 @@ static int a4l_proc_transfer_open(struct inode *inode, struct file *file)
>  	return single_open(file, a4l_rdproc_transfer, PDE_DATA(inode));
>  }
>  
> -static const struct file_operations a4l_proc_transfer_ops = {
> -	.open		= a4l_proc_transfer_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +static const DEFINE_PROC_OPS(a4l_proc_transfer_ops,
> +			     a4l_proc_transfer_open,
> +			     single_release,
> +			     seq_read,
> +			     NULL
> +);
>  
>  int a4l_proc_attach(struct a4l_device_context * cxt)
>  {
> diff --git a/kernel/drivers/can/mscan/rtcan_mscan_proc.c b/kernel/drivers/can/mscan/rtcan_mscan_proc.c
> index 6b54ad4c7..732a02765 100644
> --- a/kernel/drivers/can/mscan/rtcan_mscan_proc.c
> +++ b/kernel/drivers/can/mscan/rtcan_mscan_proc.c
> @@ -114,12 +114,12 @@ static int rtcan_mscan_proc_regs_open(struct inode *inode, struct file *file)
>  	return single_open(file, rtcan_mscan_proc_regs, PDE_DATA(inode));
>  }
>  
> -static const struct file_operations rtcan_mscan_proc_regs_ops = {
> -	.open		= rtcan_mscan_proc_regs_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +static const DEFINE_PROC_OPS(rtcan_mscan_proc_regs_ops,
> +			rtcan_mscan_proc_regs_open,
> +			single_elease,
> +			seq_read,
> +			NULL
> +);
>  
>  int rtcan_mscan_create_proc(struct rtcan_device* dev)
>  {
> diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
> index fbc5c35e4..7f3d4c395 100644
> --- a/kernel/drivers/can/rtcan_module.c
> +++ b/kernel/drivers/can/rtcan_module.c
> @@ -157,12 +157,12 @@ static int rtcan_proc_devices_open(struct inode *inode, struct file *file)
>  	return single_open(file, rtcan_read_proc_devices, NULL);
>  }
>  
> -static const struct file_operations rtcan_proc_devices_ops = {
> -	.open		= rtcan_proc_devices_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +static const DEFINE_PROC_OPS(rtcan_proc_devices_ops,
> +			rtcan_proc_devices_open,
> +			single_release,
> +			seq_read,
> +			NULL
> +);
>  
>  static int rtcan_read_proc_sockets(struct seq_file *p, void *data)
>  {
> @@ -220,13 +220,12 @@ static int rtcan_proc_sockets_open(struct inode *inode, struct file *file)
>  	return single_open(file, rtcan_read_proc_sockets, NULL);
>  }
>  
> -static const struct file_operations rtcan_proc_sockets_ops = {
> -	.open		= rtcan_proc_sockets_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> -
> +static const DEFINE_PROC_OPS(rtcan_proc_sockets_ops,
> +			rtcan_proc_sockets_open,
> +			single_release,
> +			seq_read,
> +			NULL
> +);
>  
>  static int rtcan_read_proc_info(struct seq_file *p, void *data)
>  {
> @@ -271,14 +270,12 @@ static int rtcan_proc_info_open(struct inode *inode, struct file *file)
>  	return single_open(file, rtcan_read_proc_info, PDE_DATA(inode));
>  }
>  
> -static const struct file_operations rtcan_proc_info_ops = {
> -	.open		= rtcan_proc_info_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> -
> -
> +static const DEFINE_PROC_OPS(rtcan_proc_info_ops,
> +			rtcan_proc_info_open,
> +			single_release,
> +			seq_read,
> +			NULL
> +);
>  
>  static int rtcan_read_proc_filter(struct seq_file *p, void *data)
>  {
> @@ -319,14 +316,12 @@ static int rtcan_proc_filter_open(struct inode *inode, struct file *file)
>  	return single_open(file, rtcan_read_proc_filter, PDE_DATA(inode));
>  }
>  
> -static const struct file_operations rtcan_proc_filter_ops = {
> -	.open		= rtcan_proc_filter_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> -
> -
> +static const DEFINE_PROC_OPS(rtcan_proc_filter_ops,
> +			rtcan_proc_filter_open,
> +			single_release,
> +			seq_read,
> +			NULL
> +);
>  
>  static int rtcan_read_proc_version(struct seq_file *p, void *data)
>  {
> @@ -341,13 +336,12 @@ static int rtcan_proc_version_open(struct inode *inode, struct file *file)
>  	return single_open(file, rtcan_read_proc_version, NULL);
>  }
>  
> -static const struct file_operations rtcan_proc_version_ops = {
> -	.open		= rtcan_proc_version_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> -
> +static const DEFINE_PROC_OPS(rtcan_proc_version_ops,
> +			rtcan_proc_version_open,
> +			single_release,
> +			seq_read,
> +			NULL
> +);
>  
>  void rtcan_dev_remove_proc(struct rtcan_device* dev)
>  {
> diff --git a/kernel/drivers/can/sja1000/rtcan_sja1000_proc.c b/kernel/drivers/can/sja1000/rtcan_sja1000_proc.c
> index b4af8ab2e..0fdee8c37 100644
> --- a/kernel/drivers/can/sja1000/rtcan_sja1000_proc.c
> +++ b/kernel/drivers/can/sja1000/rtcan_sja1000_proc.c
> @@ -50,12 +50,12 @@ static int rtcan_sja_proc_regs_open(struct inode *inode, struct file *file)
>  	return single_open(file, rtcan_sja_proc_regs, PDE_DATA(inode));
>  }
>  
> -static const struct file_operations rtcan_sja_proc_regs_ops = {
> -	.open		= rtcan_sja_proc_regs_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +static const DEFINE_PROC_OPS(rtcan_sja_proc_regs_ops,
> +			rtcan_sja_proc_regs_open,
> +			single_release,
> +			seq_read,
> +			NULL
> +);
>  
>  int rtcan_sja_create_proc(struct rtcan_device* dev)
>  {
> 

This leaves out a4l_proc_devs_ops and a4l_proc_drvs_ops, while
converting a4l_proc_transfer_ops. By accident? In any case, I've added
those two cases to the patch.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

