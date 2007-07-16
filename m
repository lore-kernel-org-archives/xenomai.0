Message-ID: <2862c2c80707152040v1cc27cb2kc33f1cbf21932cba@domain.hid>
Date: Mon, 16 Jul 2007 11:40:28 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_39450_1325179.1184557228554"
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
Subject: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the AT91RM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_39450_1325179.1184557228554
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Dear all,
>
> I have applied the adeos-ipipe-2.6.20-arm-1.7.03.patch for kernel 2.6.20(patches with
> 2.6.20-at91.patch) on my AT91RM9200 board from kwikbyte.
>
> If I compile the kernel without IPIPE, mounting of nfs file system or
> jffs2 filesystem are both alright.
>
> Whenever I enable the IPIPE feature, the booting sequence will hang and I
> couldn't proceed to console login.
>
> -- mounting to jffs file system
> mice: PS/2 mouse device common for all mice
> AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Empty flash at 0x00ee6080 ends at 0x00ee6200
> Empty flash at 0x01d9d3f8 ends at 0x01d9d400
> Empty flash at 0x01d9efdc ends at 0x01d9f000
> VFS: Mounted root (jffs2 filesystem).
> Freeing init memory: 112K
> --> HANG
>
> -- mounting to NFS root file system
> AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> --> HANG
>
> I have try to enble IPIPE Tracer for debugging, but couldn't see the debug
> messages.
>
> Please help. Thanks
>
> regards,
> chun yeow
>

------=_Part_39450_1325179.1184557228554
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Dear all,<br><br>I have applied the adeos-ipipe-2.6.20-arm-1.7.03.patch
 for kernel 2.6.20 (patches with 2.6.20-at91.patch) on my AT91RM9200 board from kwikbyte.<br><br>If I compile the kernel without IPIPE, mounting of nfs file system or jffs2 filesystem are both alright.
<br><br>Whenever I enable the IPIPE feature, the booting sequence will hang and I couldn&#39;t proceed to console login. <br><br>-- mounting to jffs file system<br>mice: PS/2 mouse device common for all mice<br>AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire
<br>TCP cubic registered<br>NET: Registered protocol family 1<br>NET: Registered protocol family 17<br>Empty flash at 0x00ee6080 ends at 0x00ee6200<br>Empty flash at 0x01d9d3f8 ends at 0x01d9d400<br>Empty flash at 0x01d9efdc ends at 0x01d9f000
<br>VFS: Mounted root (jffs2 filesystem).<br>Freeing init memory: 112K<br><span style="color: rgb(255, 0, 0);">--&gt; HANG</span><br><br>-- mounting to NFS root file system<br>AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire
<br>TCP cubic registered<br>NET: Registered protocol family 1<br>NET: Registered protocol family 17<br><span style="color: rgb(255, 0, 0);">--&gt; HANG</span><br><br>I have try to enble IPIPE Tracer for debugging, but couldn&#39;t see the debug messages.
<br><br>Please help. Thanks<br><br>regards,<br><span class="sg">chun yeow<br>
</span></blockquote></div><br>

------=_Part_39450_1325179.1184557228554--

