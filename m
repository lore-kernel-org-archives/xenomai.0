References: <20210327101912.2291474-1-rpm@xenomai.org>
 <20210327101912.2291474-8-rpm@xenomai.org>
 <1d59794e-4d8c-7d50-2f99-a724f893098d@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v2 7/7] drivers/net: cfg: fix config file load up
In-reply-to: <1d59794e-4d8c-7d50-2f99-a724f893098d@siemens.com>
Date: Tue, 04 May 2021 19:18:32 +0200
Message-ID: <87o8dqs9hz.fsf@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 27.03.21 11:19, Philippe Gerum wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> set_fs() is on its way out, so we cannot open code a file read
>> operation by calling the VFS handler directly anymore, faking a user
>> address space.
>> 
>> We do have kernel interfaces for loading files though, particularly
>> kernel_read_file(). So let's use that one for loading the
>> configuration file contents. Unfortunately, the signature of this
>> service changed during the 5.9-rc cycle, so we have to resort to an
>> ugly wrapper to cope with all supported kernels once again. Sigh.
>> 
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>  .../include/asm-generic/xenomai/wrappers.h    | 15 ++++
>>  kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c  | 74 +++++++++----------
>>  2 files changed, 52 insertions(+), 37 deletions(-)
>> 
>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> index cfd28fc47..f15fe4389 100644
>> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> @@ -220,4 +220,19 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
>>  	})
>>  #endif
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,9,0)
>> +#define read_file_from_kernel(__file, __buf, __buf_size, __file_size, __id) \
>> +	({								\
>> +		loff_t ___file_size;					\
>> +		int __ret;						\
>> +		__ret = kernel_read_file(__file, __buf, &___file_size,	\
>> +				__buf_size, __id);			\
>> +		(*__file_size) = ___file_size;				\
>> +		__ret;							\
>> +	})
>> +#else
>> +#define read_file_from_kernel(__file, __buf, __buf_size, __file_size, __id) \
>> +	kernel_read_file(__file, 0, __buf, __buf_size, __file_size, __id)
>> +#endif
>> +
>>  #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
>> diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c b/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
>> index 769b4e143..e460571c2 100644
>> --- a/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
>> +++ b/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
>> @@ -22,6 +22,7 @@
>>   *
>>   */
>>  
>> +#include <linux/fs.h>
>>  #include <linux/file.h>
>>  #include <linux/vmalloc.h>
>>  
>> @@ -196,6 +197,40 @@ void cleanup_cmd_detach(void *priv_data)
>>  		kfree_rtskb(cmd->args.detach.stage2_chain);
>>  }
>>  
>> +static int load_cfg_file(struct rtcfg_file *cfgfile, struct rtcfg_cmd *cmd)
>> +{
>> +	size_t file_size = 0;
>> +	struct file *filp;
>> +	loff_t i_size;
>> +	int ret;
>> +
>> +	filp = filp_open(cfgfile->name, O_RDONLY, 0);
>> +	if (IS_ERR(filp))
>> +		return PTR_ERR(filp);
>> +
>> +	i_size = i_size_read(file_inode(filp));
>> +	if (i_size <= 0) {
>> +		/* allocate buffer even for empty files */
>> +		cfgfile->buffer = vmalloc(1);
>> +	} else {
>> +		cfgfile->buffer = NULL;
>> +		/* Assume 1Mb should be enough for a config file... */
>
> This limitation is new, and I'm not sure if that would be a good idea.

This would be the size of a config file. 1MB would be too tight in some
real world scenario(s)? Anyway, we don't need to impose this limit, I
agree.

> But I need to read up the protocol details again.
>
> Why do we need that limit? We know i_size already, no?
>

Yes we do. So here is a better option I'm going to push upstream
instead:

diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c b/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
index e460571c2..158d7118f 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
@@ -213,10 +213,10 @@ static int load_cfg_file(struct rtcfg_file *cfgfile, struct rtcfg_cmd *cmd)
 		/* allocate buffer even for empty files */
 		cfgfile->buffer = vmalloc(1);
 	} else {
-		cfgfile->buffer = NULL;
-		/* Assume 1Mb should be enough for a config file... */
+		cfgfile->buffer = NULL; /* Leave allocation to the kernel. */
 		ret = read_file_from_kernel(filp, &cfgfile->buffer,
-				1UL << 30, &file_size, READING_UNKNOWN);
+					i_size_read(file_inode(filp)),
+					&file_size, READING_UNKNOWN);
 		if (ret < 0) {
 			fput(filp);
 			return ret;

-- 
Philippe.

