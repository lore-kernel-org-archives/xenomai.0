Message-ID: <b131c9f0712310604k2aac428rccacaf2006ecd147@domain.hid>
Date: Mon, 31 Dec 2007 16:04:40 +0200
From: "vikesh rambaran" <vikesh.rambaran@domain.hid>
In-Reply-To: <200712310033.05927.paul_c@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_16683_13038650.1199109880755"
References: <b131c9f0712300411w46996c98i395344b377c6bacf@domain.hid>
	<200712310033.05927.paul_c@domain.hid>
Subject: Re: [Xenomai-help] Large (negative) latency test results and fast
	PC clock
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

------=_Part_16683_13038650.1199109880755
Content-Type: multipart/alternative; 
	boundary="----=_Part_16684_10762253.1199109880756"

------=_Part_16684_10762253.1199109880756
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

Thanx for taking the time to reply over this festive season !

Although suboptimal for this PC, i am compiling using ubuntu's default
config file.
The idea is to make a general kernel image .deb file which can be used to
install
xenomai on older PC architectures (not necessarily AMD 64 bit CPUs)
Therefore the processor shows up as "CONFIG_M586"

This seems to be what Paul is making available as well - thanx i will try
them out.

Jan, i have checked the kernel config file. The following are set

CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y

Is this combination a problem ?
dmesg shows that the APIC is configured and enabled, but no information of
the HPET is displayed. (dmesg output is attached)

I have not been able to find the message "NOTE: Xenomai needs either
X86_LOCAL_APIC enabled or HPET_TIMER disabled."
during kernel configuration (make menuconfig) or during the xenomai
configuration. Is there a specific place where i should look ?

To build the kernel image package i used

fakeroot makekpkg --initrd --append_to_version "-adeos-realtime"
kernel_image kernel_headers

For the xenomai configuration i used

./configure --disable-x86-tsc


Note, on this same PC, using ubuntu 6.06, kernel 2.6.20.12, xenomai 2.3.1,
the latency test runs without large
(negative) latencies and no noticeable PC clock speedup. Test configuration
was also for CONFIG_M586=y
but with SMI workaround not enabled.

Please let me know if any other information that i can provide or tests that
can be done to solve this.

Thanx for your help
Vicki

------=_Part_16684_10762253.1199109880756
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi<br><br>Thanx for taking the time to reply over this festive season !<br><br>Although suboptimal for this PC, i am compiling using ubuntu&#39;s default config file. <br>The idea is to make a general kernel image .deb file which can be used to install 
<br>xenomai on older PC architectures (not necessarily AMD 64 bit CPUs) <br>Therefore the processor shows up as &quot;CONFIG_M586&quot;<br><br>This seems to be what Paul is making available as well - thanx i will try them out.
<br><br>Jan, i have checked the kernel config file. The following are set<br><br>CONFIG_X86_LOCAL_APIC=y<br>CONFIG_X86_IO_APIC=y<br><br>CONFIG_HPET_TIMER=y<br>CONFIG_HPET_EMULATE_RTC=y<br><br>Is this combination a problem ? 
<br>dmesg shows that the APIC is configured and enabled, but no information of the HPET is displayed. (dmesg output is attached)<br><br>I have not been able to find the message &quot;NOTE: Xenomai needs either X86_LOCAL_APIC enabled or HPET_TIMER disabled.&quot;
<br>during kernel configuration (make menuconfig) or during the xenomai configuration. Is there a specific place where i should look ?<br><br>To build the kernel image package i used<br><br>fakeroot makekpkg --initrd --append_to_version &quot;-adeos-realtime&quot; kernel_image kernel_headers
<br><br>For the xenomai configuration i used<br><br>./configure --disable-x86-tsc<br><br><br>Note, on this same PC, using ubuntu 6.06, kernel <a href="http://2.6.20.12">2.6.20.12</a>, xenomai 2.3.1, the latency test runs without large 
<br>(negative) latencies and no noticeable PC clock speedup. Test configuration was also for CONFIG_M586=y<br>but with SMI workaround not enabled.<br><br>Please let me know if any other information that i can provide or tests that can be done to solve this. 
<br><br>Thanx for your help<br>Vicki<br>

------=_Part_16684_10762253.1199109880756--

------=_Part_16683_13038650.1199109880755
Content-Type: application/zip; name=dmesg.txt.zip
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fav2zrq20
Content-Disposition: attachment; filename=dmesg.txt.zip

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

------=_Part_16683_13038650.1199109880755--

