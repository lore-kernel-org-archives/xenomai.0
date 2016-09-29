Date: Thu, 29 Sep 2016 12:49:18 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160929124918.4f33e69d@md1em3qc>
In-Reply-To: <52697293.XgM39KIdf6@soho>
References: <52697293.XgM39KIdf6@soho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rthal_strncpy_from_user bug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

Am Wed, 28 Sep 2016 13:12:12 +0200
schrieb Leopold Palomo-Avellaneda <leo@alaxarxa.net>:

> Hi,
> 
> 
> I'm trapped between 2.6.x and 3.x versions. The question to not
> boring you is that I'm having a lot of problems with this soft 3.x so
> I try to go back again to 2.6.
> 
> However, I need to use a modern hardware (new development) and 2.6
> have some issues especially rtnet that doesn't work without some
> patch with kernels greater than 3.17 (or at least I'm not able to).
> 
> After solving some other issues my tests fails with some ugly message 
> (killed!!!!)
> 
> [ 5761.024502] RIP  [<ffffffff8143079d>]
> rthal_strncpy_from_user+0xd/0x20 [ 5761.027017]  RSP
> <ffff88045a493e20> [ 5761.029456] CR2: 000000000040445d
> [ 5761.031859] ---[ end trace f092b4db2a9a9654 ]---
> [ 5773.810428] BUG: unable to handle kernel paging request at
> 000000000040445d [ 5773.812909] IP: [<ffffffff8143079d>]
> rthal_strncpy_from_user+0xd/0x20 [ 5773.815389] PGD 45a00c067 PUD
> 456d4e067 PMD 45aa42067 PTE 4517f5025 [ 5773.817864] Oops: 0001 [#16]
> SMP [ 5773.820293] Modules linked in: rt_igb(O) rt_e1000e(O)
> rt_loopback(O) rtcfg(O) rtudp(O) rtipv4(O) rtmac(O) rtpacket(O)
> rtnet(O) ctr ccm binfmt_misc nfsd auth_rpcgss nfs_acl nfs lockd
> fscache sunrpc nls_utf8 nls_cp437 vfat fat xeno_can_peak_pci
> xeno_can_sja1000 xeno_can x86_pkg_temp_thermal coretemp kvm_intel kvm
> peak_pci sja1000 joydev crc32_pclmul hid_generic usbhid
> ghash_clmulni_intel aesni_intel ppdev aes_x86_64 lrw can_dev gf128mul
> glue_helper xeno_rtdm snd_pcm snd_timer ablk_help
> 
> 
> looking on the web, I have found that his issue was solved:
> 
> http://git.xenomai.org/xenomai-jki.git/commit/?h=maintenance-2.6&id=2eceef4c62bc8d6b3713787c26882fdcd9b87842
> 
> However, although it was on December 2015, 2.6.5 (July 2016) doesn't
> have it.
> 
> So, there's any reason why this patch was not pushed to 2.6.5?

I guess the reason is that 2.6 is not officially maintained anymore, so
patches like this one do not get backported. You should see if you can
switch to 3.0 and solve your issues there!

If that really is not an option, this particular problem can be
addressed by disabling CONFIG_SMAP in your kernel. Or you could port
the patch back to 2.6. If you do that post it here, might get accepted
after all.

Henning

