MIME-Version: 1.0
In-Reply-To: <CAM1yFZ9ndx+EDWAig-nkYmcc-jgirwm6N0UYbK1g-8roQTMMYQ@mail.gmail.com>
References: <CAM1yFZ9ndx+EDWAig-nkYmcc-jgirwm6N0UYbK1g-8roQTMMYQ@mail.gmail.com>
Date: Wed, 6 Jun 2012 14:07:24 +0530
Message-ID: <CAM1yFZ94EbGhJeFosfTCVtuh5QjXLpnJPdQC5kgEFGRV1seeGg@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] ./rtnet start rteth0-mac: unknown interface: No such
 device ioctl: No such device
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Here is my output of `lsmod`. Please see if that's of any use.

`
linux-y3pi:# lsmod
Module                  Size  Used by
tdma                   18281  0
rtmac                   9274  1 tdma
rtcfg                  49485  0
rtcap                   7216  0
rt_loopback             1563  2
rtpacket                5517  0
rtudp                  10655  0
rt_8139too             11374  0
rtipv4                 22842  2 rtcfg,rtudp
rtnet                  42130  9
tdma,rtmac,rtcfg,rtcap,rt_loopback,rtpacket,rtudp,rt_8139too,rtipv4
ip6t_LOG                8480  6
xt_tcpudp               3540  2
xt_pkttype              1176  3
ipt_LOG                 8201  6
xt_limit                2159  12
snd_pcm_oss            44878  0
snd_mixer_oss          15151  1 snd_pcm_oss
snd_seq                55731  0
snd_seq_device          6698  1 snd_seq
edd                     8407  0
ip6t_REJECT             4306  3
nf_conntrack_ipv6       8186  4
nf_defrag_ipv6         10128  1 nf_conntrack_ipv6
ip6table_raw            1451  1
xt_NOTRACK              1112  4
ipt_REJECT              2397  3
xt_state                1314  8
iptable_raw             1478  1
iptable_filter          1706  1
ip6table_mangle         1756  0
nf_conntrack_netbios_ns     1678  0
nf_conntrack_ipv4       8957  4
nf_conntrack           80411  5
nf_conntrack_ipv6,xt_NOTRACK,xt_state,nf_conntrack_netbios_ns,nf_conntrack_ipv4
nf_defrag_ipv4          1561  1 nf_conntrack_ipv4
ip_tables              18872  2 iptable_raw,iptable_filter
ip6table_filter         1679  1
ip6_tables             19066  4
ip6t_LOG,ip6table_raw,ip6table_mangle,ip6table_filter
x_tables               24094  16
ip6t_LOG,xt_tcpudp,xt_pkttype,ipt_LOG,xt_limit,ip6t_REJECT,ip6table_raw,xt_NOTRACK,ipt_REJECT,xt_state,iptable_raw,iptable_filter,ip6table_mangle,ip_tables,ip6table_filter,ip6_tables
fuse                   69279  3
loop                   17417  0
dm_mod                 71671  0
snd_hda_codec_via      57768  1
snd_hda_intel          24871  2
snd_hda_codec          95006  2 snd_hda_codec_via,snd_hda_intel
snd_hwdep               6540  1 snd_hda_codec
snd_pcm                90716  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              22050  2 snd_seq,snd_pcm
snd                    71410  14
snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_hda_codec_via,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer
soundcore               7854  1 snd
iTCO_wdt               11716  0
iTCO_vendor_support     2942  1 iTCO_wdt
snd_page_alloc          8324  2 snd_hda_intel,snd_pcm
sr_mod                 13186  0
cdrom                  37628  1 sr_mod
i2c_i801                9677  0
pcspkr                  1950  0
sg                     28847  0
serio_raw               4534  0
ext4                  361361  2
jbd2                   82943  1 ext4
crc16                   1699  1 ext4
i915                  500199  2
drm_kms_helper         33537  1 i915
drm                   211193  3 i915,drm_kms_helper
sd_mod                 33977  5
i2c_algo_bit            5625  1 i915
intel_agp              11529  1 i915
intel_gtt              16397  3 i915,intel_agp
ata_generic             3787  0
ata_piix               22875  4
ahci                   20097  0
libahci                22089  1 ahci
libata                194812  4 ata_generic,ata_piix,ahci,libahci
scsi_mod              204709  4 sr_mod,sg,sd_mod,libata
linux-y3pi:/usr/local/rtnet/sbin #
`





On 5 June 2012 17:13, Anisha Kaul <born.rebel.83@gmail.com> wrote:
> Greetings,
>
> I have installed the RTnet over Xenomai without examples.
> RTnet compiled well, and I also tested loopback on the single machine
> and was able to ping.
>
> However I noticed `./rtnet start` showing the following output:
> What should I interpret when all it says is "no such device"?
>
> `
> linux-y3pi:/usr/local/rtnet/sbin # ./rtnet start
>
> rteth0: unknown interface: No such device
> rteth0-mac: unknown interface: No such device
> ioctl: No such device
> ioctl: No such device
> ioctl: No such device
> ioctl: No such device
> ioctl (add): No such device
> vnic0: unknown interface: No such device
> SIOCSIFADDR: No such device
> vnic0: unknown interface: No such device
> SIOCSIFNETMASK: No such device
> Waiting for all slaves...ioctl: No such device
> ioctl: No such device
>
> linux-y3pi:/usr/local/rtnet/sbin #
> `
>
> --
> Regards,
> Anisha



-- 
-Anisha

