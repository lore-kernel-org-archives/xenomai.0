Message-ID: <47DA9296.6030902@domain.hid>
Date: Fri, 14 Mar 2008 15:58:30 +0100
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <47DA7CCD.40901@domain.hid> <47DA842E.3070305@domain.hid>
	<47DA887C.1020109@domain.hid> <47DA8C86.3030100@domain.hid>
In-Reply-To: <47DA8C86.3030100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Moving from 2.6.14(ppc) to 2.6.20(powerpc):
 illicit calls detected by ipipe
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai help <xenomai@xenomai.org>

Philippe,

Philippe Gerum wrote:
> Johan Borkhuis wrote:
>   
>   
>   
>> Below is the call-trace:
>>
>> I-pipe: Detected illicit call from domain 'Xenomai'
>>        into a service reserved for domain 'Linux' and below.
>> Call Trace:
>> [97A479E0] [8000817C] show_stack+0x7c/0x1a4 (unreliable)
>> [97A47A10] [8005C2A4] ipipe_check_context+0xb8/0xc0
>> [97A47A30] [800D88F0] kmem_cache_zalloc+0xe4/0xf4
>> [97A47A50] [80033520] __request_region+0x48/0xd4
>> [97A47A70] [800335E0] __check_region+0x34/0x6c
>> [97A47A80] [A1216F94] men_OSS_AssignResources+0xec/0x1dc [men_oss]
>> [97A47AB0] [A12309BC] A201_Init+0x618/0x708 [men_bb_a201]
>> [97A47B10] [A12319F0] InitWrapper+0x38/0x50 [men_bb_a201]
>> [97A47B20] [A122C5E4] OpenDevice+0x4a8/0x634 [men_bbis_kernel]
>> [97A47C20] [A122CF9C] bbis_open+0x130/0x220 [men_bbis_kernel]
>> [97A47C60] [A126B450] mk_ioctl_core+0x548/0xcec [men_mdis_kernel]
>> [97A47DB0] [A126FA6C] mdisctl_ioctl_rt+0x84/0x1b40 [men_mdis_kernel]
>>     
>
> If you want to call into the regular Linux services from a rtdm-based ioctl
> routine, you should define your routine in the _nrt section not in the _rt one.
> E.g.
> struct rtdm_device device = {
> 	...
> 	.ops = {
> 		.ioctl_nrt =      mdisctl_ioctl,
>
> If you really need part of your ioctl code to run in RT mode, then you should
> split it in two separate routines, one declared in the _rt section, and the
> other one in the _nrt section.
>   

This did indeed solve the problem of the illicit calls. Thanks! The code 
run from the ioctl call is basically the ioctl code from the original 
driver, with a wrapper for Xenomai, so it should haven been a NRT IOCTL 
function all the time.

Kind regards,
    Johan Borkhuis

-- 
Johan Borkhuis                                  Dutch Space BV
email:        j.borkhuis@domain.hid          Newtonweg 1
phone:        071-5245788                       Leiden
fax:          071-5245499                       The Netherlands


