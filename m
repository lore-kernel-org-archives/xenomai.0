From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <8sm023$gq1qra@domain.hid>
References: <8sm023$gq1qra@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Sep 2010 09:52:59 +0200
Message-ID: <1283327579.1709.1890.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Powerpc kernel cannot boot with xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gao <gwysu@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-09-01 at 15:47 +0800, Gao wrote:
> Hi All,
>  
> I patched the kernel with xenomai, but the kernel "cuImage" cannot
> boot up, below is the console output:
>      
> U-Boot 2009.06.00-svn21572 (Aug 24 2010 - 11:20:12)
>  
> CPU:   MPC885ZPnn at 100 MHz: 8 kB I-Cache 8 kB D-Cache FEC present

This board is not supported. What goes wrong is likely the I-pipe patch
for this particular hardware.

> Board: RXT-2000
> I2C:   ready
> DRAM:  32 MB
> 1 gd->ram_size = (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
> 2 gd->ram_size = (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
> IRIS: bd->bi_memsize (2000000) gd(ff002ec0)->gd->ram_size(2000000)
> IRIS: bd->bi_memsize (2000000)
> Now running in RAM - U-Boot at: 01f89000
> FLASH: 16 MB
> In:    serial
> Out:   serial
> Err:   serial
> Net:   FEC ETHERNET
> IRIS: IDE testing
> IRIS: CONFIG_CMD_IDE
> PCMCIA:IRIS: NO CONFIG_START_IDE
> SanDisk SDP 5/3 0.6
>             Fixed Disk Card
>             IDE interface
>             [silicon] [unique] [single] [sleep] [standby] [idle] [low
> power]
> Bus 0: OK
>   Device 0: Model: SanDisk SDCFH-002G Firm: HDX 5.04 Ser#:
> AOZ043010001455
>             Type: Removable Hard Disk
>             Capacity: 1918.0 MB = 1.8 GB (3928176 x 512)
> Hit any key to stop autoboot:  0
> ## Booting kernel from Legacy Image at 00100000 ...
>    Image Name:   Linux-2.6.33.4
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1873951 Bytes =  1.8 MB
>    Load Address: 00400000
>    Entry Point:  00400558
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Memory <- <0x0 0x0> (0MB)
> ENET0: local-mac-address <- 00:00:00:00:00:00
> CPU clock-frequency <- 0x0 (0MHz)
> CPU timebase-frequency <- 0x0 (0MHz)
>  
> zImage starting: loaded at 0x00400000 (sp: 0x01b88990)
> Allocating 0x3d6de0 bytes for kernel ...
> gunzipping (0x00000000 <- 0x0040c000:0x007fd97c)...done 0x3adf34 bytes
>  
> Linux/PowerPC load:
> Finalizing device tree... flat tree at 0x80a300
> 
>  
>  
> Before I patched xenomai, the kernel can boot up with below console
> output:
>  
>  
> CPU:   MPC885ZPnn at 100 MHz: 8 kB I-Cache 8 kB D-Cache FEC present
> Board: RXT-2000
> I2C:   ready
> DRAM:  32 MB
> 1 gd->ram_size = (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
> 2 gd->ram_size = (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
> IRIS: bd->bi_memsize (2000000) gd(ff002ec0)->gd->ram_size(2000000)
> IRIS: bd->bi_memsize (2000000)
> Now running in RAM - U-Boot at: 01f89000
> FLASH: 16 MB
> In:    serial
> Out:   serial
> Err:   serial
> Net:   FEC ETHERNET
> IRIS: IDE testing
> IRIS: CONFIG_CMD_IDE
> PCMCIA:IRIS: NO CONFIG_START_IDE
> SanDisk SDP 5/3 0.6
>             Fixed Disk Card
>             IDE interface
>             [silicon] [unique] [single] [sleep] [standby] [idle] [low
> power]
> Bus 0: OK
>   Device 0: Model: SanDisk SDCFH-002G Firm: HDX 5.04 Ser#:
> AOZ043010001455
>             Type: Removable Hard Disk
>             Capacity: 1918.0 MB = 1.8 GB (3928176 x 512)
> Hit any key to stop autoboot:  0
> ## Booting kernel from Legacy Image at 00100000 ...
>    Image Name:   Linux-2.6.33.4
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1697346 Bytes =  1.6 MB
>    Load Address: 00400000
>    Entry Point:  00400558
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Memory <- <0x0 0x2000000> (32MB)
> ENET0: local-mac-address <- 00:d0:dd:ff:20:00
> CPU clock-frequency <- 0x5f5e100 (100MHz)
> CPU timebase-frequency <- 0x2faf08 (3MHz)
> CPU bus-frequency <- 0x2faf080 (50MHz)
>  
> zImage starting: loaded at 0x00400000 (sp: 0x01b88990)
> Allocating 0x35e3f0 bytes for kernel ...
> gunzipping (0x00000000 <- 0x0040c000:0x00799450)...done 0x349f2c bytes
>  
> Linux/PowerPC load: root=/dev/sda1 rw rootfstype=ext3
> ip=169.254.0.2::169.254.0.1:255.255.0.0 console=ttyCPM0,38400
> Finalizing device tree... flat tree at 0x7a6300
> Using RxT-Carrier machine description
> ...................
> 
>  
> It seems the boot loader doesn't pass the boot parameters to the
> kernel that cannot boot up. Any one can help me? Thanks in advance.
>  
>  
>  
>  
> Best regards,
> Wenyi Gao
>  
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



