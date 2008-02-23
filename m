Message-ID: <fd6a47a90802231336o208aa6c6w4fa99516126fb2fd@domain.hid>
Date: Sat, 23 Feb 2008 22:36:47 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
In-Reply-To: <47C021F3.20002@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8403_23516243.1203802607690"
References: <47C020A9.3050704@domain.hid> <47C021F3.20002@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 3/4] Uninline heavy locking functions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

------=_Part_8403_23516243.1203802607690
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Without any patch of this series:
>   text    data     bss     dec     hex filename
> 79189    2168     308   81665   13f01
> kernel/xenomai/skins/native/xeno_native.o
> 26668    2176    1104   29948    74fc
> kernel/xenomai/skins/rtdm/xeno_rtdm.o
> 102661    1376  160224  264261   40845
> kernel/xenomai/skins/posix/xeno_posix.o
> 112482    5440  444340  562262   89456
> kernel/xenomai/nucleus/xeno_nucleus.o
>
> With 1+2 applied:
>   text    data     bss     dec     hex filename
> 76099    2168     308   78575   132ef
> kernel/xenomai/skins/native/xeno_native.o
> 25871    2176    1104   29151    71df
> kernel/xenomai/skins/rtdm/xeno_rtdm.o
> 97816    1376  160224  259416   3f558
> kernel/xenomai/skins/posix/xeno_posix.o
> 108818    5440  444340  558598   88606
> kernel/xenomai/nucleus/xeno_nucleus.o
>
> With this one applied:
>   text    data     bss     dec     hex filename
> 49469    2168     308   51945    cae9
> kernel/xenomai/skins/native/xeno_native.o
> 19247    2176    1104   22527    57ff
> kernel/xenomai/skins/rtdm/xeno_rtdm.o
> 60200    1376  160224  221800   36268
> kernel/xenomai/skins/posix/xeno_posix.o
> 79453    5440  444340  529233   81351
> kernel/xenomai/nucleus/xeno_nucleus.o


How badly would the inlining affect the cache ? I imagine that having the
respective (un)locking functions in a single place would greatly reduce the
chance of it being swapped out.

Is there a difference on the latency values with those patches applied ?


Jeroen.

------=_Part_8403_23516243.1203802607690
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Without any patch of this series:<br>&nbsp;&nbsp;text&nbsp;&nbsp;&nbsp;&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp; bss&nbsp;&nbsp;&nbsp;&nbsp; dec&nbsp;&nbsp;&nbsp;&nbsp; hex filename<br>79189&nbsp;&nbsp;&nbsp;&nbsp;2168&nbsp;&nbsp;&nbsp;&nbsp; 308&nbsp;&nbsp; 81665&nbsp;&nbsp; 13f01 kernel/xenomai/skins/native/xeno_native.o<br>
26668&nbsp;&nbsp;&nbsp;&nbsp;2176&nbsp;&nbsp;&nbsp;&nbsp;1104&nbsp;&nbsp; 29948&nbsp;&nbsp;&nbsp;&nbsp;74fc kernel/xenomai/skins/rtdm/xeno_rtdm.o<br>102661&nbsp;&nbsp;&nbsp;&nbsp;1376&nbsp;&nbsp;160224&nbsp;&nbsp;264261&nbsp;&nbsp; 40845 kernel/xenomai/skins/posix/xeno_posix.o<br>112482&nbsp;&nbsp;&nbsp;&nbsp;5440&nbsp;&nbsp;444340&nbsp;&nbsp;562262&nbsp;&nbsp; 89456 kernel/xenomai/nucleus/xeno_nucleus.o<br>
<br>With 1+2 applied:<br>&nbsp;&nbsp;text&nbsp;&nbsp;&nbsp;&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp; bss&nbsp;&nbsp;&nbsp;&nbsp; dec&nbsp;&nbsp;&nbsp;&nbsp; hex filename<br>76099&nbsp;&nbsp;&nbsp;&nbsp;2168&nbsp;&nbsp;&nbsp;&nbsp; 308&nbsp;&nbsp; 78575&nbsp;&nbsp; 132ef kernel/xenomai/skins/native/xeno_native.o<br>25871&nbsp;&nbsp;&nbsp;&nbsp;2176&nbsp;&nbsp;&nbsp;&nbsp;1104&nbsp;&nbsp; 29151&nbsp;&nbsp;&nbsp;&nbsp;71df kernel/xenomai/skins/rtdm/xeno_rtdm.o<br>
97816&nbsp;&nbsp;&nbsp;&nbsp;1376&nbsp;&nbsp;160224&nbsp;&nbsp;259416&nbsp;&nbsp; 3f558 kernel/xenomai/skins/posix/xeno_posix.o<br>108818&nbsp;&nbsp;&nbsp;&nbsp;5440&nbsp;&nbsp;444340&nbsp;&nbsp;558598&nbsp;&nbsp; 88606 kernel/xenomai/nucleus/xeno_nucleus.o<br><br>With this one applied:<br>&nbsp;&nbsp;text&nbsp;&nbsp;&nbsp;&nbsp;data&nbsp;&nbsp;&nbsp;&nbsp; bss&nbsp;&nbsp;&nbsp;&nbsp; dec&nbsp;&nbsp;&nbsp;&nbsp; hex filename<br>
49469&nbsp;&nbsp;&nbsp;&nbsp;2168&nbsp;&nbsp;&nbsp;&nbsp; 308&nbsp;&nbsp; 51945&nbsp;&nbsp;&nbsp;&nbsp;cae9 kernel/xenomai/skins/native/xeno_native.o<br>19247&nbsp;&nbsp;&nbsp;&nbsp;2176&nbsp;&nbsp;&nbsp;&nbsp;1104&nbsp;&nbsp; 22527&nbsp;&nbsp;&nbsp;&nbsp;57ff kernel/xenomai/skins/rtdm/xeno_rtdm.o<br>60200&nbsp;&nbsp;&nbsp;&nbsp;1376&nbsp;&nbsp;160224&nbsp;&nbsp;221800&nbsp;&nbsp; 36268 kernel/xenomai/skins/posix/xeno_posix.o<br>
79453&nbsp;&nbsp;&nbsp;&nbsp;5440&nbsp;&nbsp;444340&nbsp;&nbsp;529233&nbsp;&nbsp; 81351 kernel/xenomai/nucleus/xeno_nucleus.o</blockquote>
<div>&nbsp;</div>
<div>How badly would the inlining affect the cache ? I imagine that having the respective (un)locking functions in a single place would greatly reduce the chance of it being swapped out.</div>
<div>&nbsp;</div>
<div>Is there a difference on the latency values with those patches applied ?</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.<br>&nbsp;</div></div>

------=_Part_8403_23516243.1203802607690--

