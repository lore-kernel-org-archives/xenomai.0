Message-ID: <9c789a000811051100y23a562a9nd69416a63b859ea@domain.hid>
Date: Wed, 5 Nov 2008 21:00:33 +0200
From: "Cristian Axenie" <cristian.axenie@domain.hid>
In-Reply-To: <9c789a000811050028s6cad302erdb4afd7b7d56fa23@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7426_3744562.1225911633240"
References: <9c789a000811031222oab34c08n32d94f83288154f3@domain.hid>
	<9c789a000811032341l94ad3can622a31d3088230dc@domain.hid>
	<9c789a000811040012n2f776c44m51e34f5139f6066b@domain.hid>
	<200811042338.47072.berlemont.hauw@domain.hid>
	<9c789a000811050028s6cad302erdb4afd7b7d56fa23@domain.hid>
Subject: Re: [Xenomai-help] SegFault on Comedi-rtdm for Xenomai!!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

------=_Part_7426_3744562.1225911633240
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> >OK. You are not supposed to use the branch comedi-rtdm-dev. The
> comedi4rtdm
>
>> >>code has been integrated in the trunk.
>>
>>
>> >>Could you check whether you have the same problem with the trunk code ?
>> The NI
>> >>driver is not integrated into the trunk; it was not validated.
>> >>Instead of using the NI driver, you could use the fake driver
>> >>(XENO_DRIVERS_COMEDI_FAKE).
>>
>
> I build a new kernel with the Xenomai + COmedi trunk and also added
> XENO_DRIVERS_COMEDI_FAKE AND LOOP  but it seems that the Segmentation Fault
> is still an open problem. So after compiling my kernel I manually copied the
> libs (libcomedi.so, librtdm.so....) in my target's /lib directory, and
> wanted to run ./comedi_config (i.e.) and the problem persists.
>
   What shall I do , am I missing something , am I doing wrong with the
kernel build steps??
   Some advices would be appreciated !

Thanks,
Cristian

------=_Part_7426_3744562.1225911633240
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>&gt;OK. You are not supposed to use the branch comedi-rtdm-dev. The comedi4rtdm<br>
<div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">
&gt;&gt;code has been integrated in the trunk.<br>
<div><br>
<br>
</div></div><div class="Ih2E3d">&gt;&gt;Could you check whether you have the same problem with the trunk code ? The NI<br>
&gt;&gt;driver is not integrated into the trunk; it was not validated.<br>
&gt;&gt;Instead of using the NI driver, you could use the fake driver<br>
&gt;&gt;(XENO_DRIVERS_COMEDI_FAKE).</div></blockquote><div><br>I build a new kernel with the Xenomai + COmedi trunk and also added XENO_DRIVERS_COMEDI_FAKE AND LOOP&nbsp; but it seems that the Segmentation Fault is still an open problem. So after compiling my kernel I manually copied the libs (libcomedi.so, librtdm.so....) in my target&#39;s /lib directory, and wanted to run ./comedi_config (i.e.) and the problem persists.</div>
</div></blockquote><div>&nbsp;&nbsp; What shall I do , am I missing something , am I doing wrong with the kernel build steps??<br>&nbsp;&nbsp; Some advices would be appreciated !<br><br>Thanks,&nbsp; <br>Cristian<br>
</div></div><br>

------=_Part_7426_3744562.1225911633240--

