Message-ID: <50E5616D.8060303@siemens.com>
Date: Thu, 03 Jan 2013 11:46:05 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50E47751.1070005@siemens.com> <50E497AD.9000404@nta-inc.net>
In-Reply-To: <50E497AD.9000404@nta-inc.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] nucleus: Convert intrlock to a sleeping
	Linux lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@siemens.com>, Xenomai <xenomai@xenomai.org>

On 2013-01-02 21:25, Jeff Webb wrote:
> On 01/02/2013 12:07 PM, Jan Kiszka wrote:
>> Conceptually, all users of this lock are supposed to run over Linux
>> context already. Moreover, latest I-pipe patches complain that
>> ipipe_virtualize_irq is called with the Xenomai domain stalled which
>> invalidates that useful internal bug check.
>>
>> So rework the locking for dumping scheduling statistics and convert
>> intrlock to a sleeping Linux variant to avoid the alarm. And to simplify
>> some code paths.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
> 
> This patch seems to solve the original problem, but I get the following output in the kernel log, when I do a 'cat /proc/xenomai/stat'.
> 
> -Jeff
> 
> kernel: [  106.030870] ------------[ cut here ]------------
> kernel: [  106.030878] WARNING: at kernel/xenomai/nucleus/intr.c:903 xnintr_query_next+0x189/0x1a0()
> kernel: [  106.030880] Hardware name: Precision WorkStation T3400
> kernel: [  106.030882] Modules linked in: bnep rfcomm bluetooth binfmt_misc dm_crypt snd_hda_codec_analog snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq usbhid snd_timer snd_seq_device psmouse mac_hid snd hid coretemp dcdbas x38_edac ppdev soundcore snd_page_alloc serio_raw edac_core parport_pc microcode lp parport reiserfs nouveau tg3 ttm drm_kms_helper drm i2c_algo_bit mxm_wmi video wmi
> kernel: [  106.030932] Pid: 3106, comm: cat Not tainted 3.4.6-xenomai-2.6.2 #1
> kernel: [  106.030934] Call Trace:
> kernel: [  106.030941]  [<ffffffff8103cc0f>] warn_slowpath_common+0x7f/0xc0
> kernel: [  106.030944]  [<ffffffff8103cc6a>] warn_slowpath_null+0x1a/0x20
> kernel: [  106.030947]  [<ffffffff811060b9>] xnintr_query_next+0x189/0x1a0
> kernel: [  106.030951]  [<ffffffff81119003>] vfile_stat_next+0x163/0x200
> kernel: [  106.030955]  [<ffffffff8113063b>] vfile_snapshot_open+0x21b/0x2e0
> kernel: [  106.030960]  [<ffffffff81263cc3>] proc_reg_open+0xa3/0x180
> kernel: [  106.030963]  [<ffffffff81130160>] ? vfile_regular_release+0x50/0x50
> kernel: [  106.030967]  [<ffffffff81263c20>] ? proc_alloc_inode+0xb0/0xb0
> kernel: [  106.030972]  [<ffffffff81201ace>] __dentry_open+0x24e/0x310
> kernel: [  106.030975]  [<ffffffff81202f51>] nameidata_to_filp+0x71/0x80
> kernel: [  106.030979]  [<ffffffff81212afc>] do_last+0x26c/0x920
> kernel: [  106.030983]  [<ffffffff812132c3>] path_openat+0xd3/0x3c0
> kernel: [  106.030986]  [<ffffffff812136d2>] do_filp_open+0x42/0xa0
> kernel: [  106.030990]  [<ffffffff8121fb8f>] ? alloc_fd+0x4f/0x130
> kernel: [  106.030993]  [<ffffffff81203058>] do_sys_open+0xf8/0x1d0
> kernel: [  106.030997]  [<ffffffff813a5c4a>] ? __ipipe_syscall_root_thunk+0x35/0x67
> kernel: [  106.031001]  [<ffffffff81203151>] sys_open+0x21/0x30
> kernel: [  106.031005]  [<ffffffff816c61e6>] system_call_fastpath+0x16/0x1b
> kernel: [  106.031007] ---[ end trace 5ed7b1604d797a3f ]---
> 
> 

Yes, that's the XNARCH_TIMER_IRQ bug I was referring to.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

