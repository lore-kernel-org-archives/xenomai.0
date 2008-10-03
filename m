Message-ID: <48E66224.7060709@domain.hid>
Date: Fri, 03 Oct 2008 20:19:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b054e88e0809290735x19e1618eh6facc56ee6baef18@domain.hid>	<48E3541E.8090808@domain.hid>
	<b054e88e0810030957l3e25a1beo8866a3e8f79d9e9b@domain.hid>
In-Reply-To: <b054e88e0810030957l3e25a1beo8866a3e8f79d9e9b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Error while building Xenomai on Powerpc
 with	instrument function entries enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Giammarco Zacheo <g.zacheo@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Giammarco Zacheo wrote:
> I was wrong. I am able to compile the kernel, but it hangs very early,
> giving this output:
> 
> zImage starting: loaded at 0x00400000 (sp: 0x017ffe50)
> Allocating 0x590acc bytes for kernel ...
> OF version = 'EFIKA5K2,1.3'
> gunzipping (0x01800000 <- 0x00407000:0x00619b3b)...done 0x4cd39c bytes
> 
> Linux/PowerPC load: root=/dev/nfs rw nfsroot=192.168.10.122:/opt/eldk/ppc_6xx
> ip=dhcp console=ttyPSC0
> Finalizing device tree... using OF tree (promptr=01003ed8)
> cpu_exception:
> SRR0 0x0180B338 SRR1  0x00043030 MSR  0x00003030
> LR   0x01C704B4 CTR   0x01800000 CR   0x42002042   XER 0x0
> DAR  0x00000000 DSISR 0x00000000 Type 2
> GPR[] 0x40000000 0x017FFE20 0x00000000 0x41820014 0x01C704B4 0x42002042
> 0xC04D0000 0x017FFD90
> GPR[] 0x00000001 0x00625C04 0x07C00008 0x07C00008 0x42002044 0x1004A33C
> 0x01C647A0 0x017FFC2C
> GPR[] 0x01BDCA4C 0x01BDCA6C 0x01BF66C4 0x01BDCA78 0x08000000 0x01BDCA10
> 0xFFFFFFFF 0x07C53FC8
> GPR[] 0x01800000 0x00590ACC 0x07C548A8 0x00000000 0x00000000 0x004062C8
> 0x0040E134 0x00000000
> ibat0U 0x00001FFF ibat0L 0x00000012
> ibat1U 0xF0001FFF ibat1L 0xF0000012
> ibat2U 0x00000000 ibat2L 0x00000000
> ibat3U 0x00000000 ibat3L 0x00000000
> dbat0U 0xF0001FFF dbat0L 0xF000002A
> dbat1U 0x80001FFF dbat1L 0x8000002A
> dbat2U 0x00001FFF dbat2L 0x00000012
> dbat3U 0xC0001FFF dbat3L 0xC000002A
> HID0 0x0000C000
> deadend:
> 
> Any hint about?

Did you try using vmalloc for the tracer logs ?


-- 
					    Gilles.

