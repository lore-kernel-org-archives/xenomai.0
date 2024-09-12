Received: from sonic310-57.consmr.mail.ir2.yahoo.com (sonic310-57.consmr.mail.ir2.yahoo.com [77.238.177.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8E1ABEC3
	for <xenomai@lists.linux.dev>; Thu, 12 Sep 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.177.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147546; cv=none; b=cKa8oyKeKoN1gN9BgP81VlStcZZbRIxxAjV7EOMTrGHZ5pcUtyNibuvkMFd5FS36UDapb8+3hqbQfr8h+0jwg/STq6QSmQ4wJTaMH/eFA3A9Gx9w/haMW9WDGhpZreAjfwXTY/JtycRzCaDvdCWu3hwgcdxnB1SSsTSANmJaiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147546; c=relaxed/simple;
	bh=EXFrZv87zj0LcNCwfHdDtxPaFudUfUOmP+Ev554l5B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qCbLF6nDO4TxbHCBAqtrTVHc9/Zzg9n+gt48c8TGNRIAl5B5MDz+63yL17n58lNhtdmWlGNsHT7byhIydBrk7N321fXao0+u3k3mS4NRpIx4O7Hv9LrvNDfnikGPExGapjV7+A233z1SaMtE9OeI8sVBD0BfmtucKdB61eS3ke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LTCqqOu7; arc=none smtp.client-ip=77.238.177.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LTCqqOu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726147542; bh=W2Ql7Jak6oL2Z8dz6dMs+qEgx1fd4d/uPzJ3/4jpS6M=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=LTCqqOu7Hdxv3rMRA3WJfAZ+GwiAvZvyaCe9RgybzTotDtciBi6WDMZAh0OMxfkvsmfDW18JnaONmNWc8A9T9YTCV7inAQFvPMpiW/UobVijj5aMdM6joEhb4+3/WGzEFvkMKnhs9/la6bCDkvZiUjv9dIsDCOtySuBgm8WH7M3Zp6rh613F7pH6G6NvDgz/aAfZTFaMPnf8Lnb8aN30u32d/G2vAt46j6g7nLtIKsXwQLBNrQVzBZMaaG2jNp8dOI/qqUj+1Pc38I/FhHqQiqRuqsKK+WijyLYxcuj3pK68qZ/thOPJV+8E/PdQEbGaE/SSd1stpFzYqL3S7eJjEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726147542; bh=EgPSIeO0MRq64ulKbaQbbubiP2pjFWBxxjsG/y4zoYt=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=o7j36jCBIz09MzxBCDIEdRWyEh7PDyv37nXEjHsxxdLxIdGBEipeNw/i0kGTtkGVvM+0PBpl4s4WB2PfIKz2JgPevrKsmscKfWHKYy/xiRmnrgfDuXfcYhmF5PKWA4x4R8O//8q7Tr98MHYzvyhFdBbkVSsDz7Pv3prM4hf3gp5YtwRsedariu1+t66ppWESBUI4wMP3DJSCBQ+evUgH4/u1QzcrXlxvxqEpZ19Zrs9zXLe4Xl103tByVOOTSUCeO6X/VIk9ewCh3h0dw/ZQ0l56TrINA3r7MAty0kCZW3jzNTfnLJmV+AQNI7c0+sEMkUp4RRc++CjltEX5yXAkFQ==
X-YMail-OSG: bCwlzlcVM1lnYhGfYb8iiVOwPoCWYeAw2KXSzc8pIHEh1Re73uPzqiB4OSXJgpU
 aGlQAx8RbXAuUHiovXuEwVEmG3Gw829zeljWzvxyjiPakGqGk3MnFEExR8.8QP8mWQJ6HTl6gMrb
 N5IHLVEXvifY26x18fVD7qm_V9X0r1lv_nuKLCgOtLIDIErDANsd2jOftA.LhSlde25ecPJuAsYp
 VBwX42TzYXCyUktKRLDJ9Cvltit3C5IaLGSvLu9Y_.1We17CcIJzs9kK1F0hZc21jLILyM7FULWz
 xU7eM06ijQobsKr9laFcGk6SRkjEQmQN8dp6hWnxmh67ippMVTcdo0kITppZrG3RfG9nd4M9wfRK
 BM3ioVV.3JmU98IzM_XpBg0mbUY5bvA0qurTEKdY9t5MnMeTLnsy59Gj8p0KSKgvZKG9DcMuzSi7
 PrOm6U5HOMwAHjW1uH2lFQhQqlkri8AF0uwU.cg4bCTwQzjPVkrDtUSzptLEmZ10isvOFOmUZH.p
 xS9prTWbDvyvIGPBm5MvA3hzDRCQUH2AZ7M4IAkHwbh_K6p4lx_7b_y8w.qVrtSHk4MDSfyqH4L0
 h1PoaxnHoIsWULmXGzTeMSq5gp8gbK__k.vGx5Em4w_0pNbHt_kmtI1W5JEwHth66uHyhOKNCbyN
 34dBiV3wbyuvrQzUITIMn9sKokLjCsOwuUvg8NkSroT9U4GwDOREXraIakmwOTG_agY.e0T7uodw
 7tLWsDV54kVhgUOlGTFhHqFtKeJ1PJc30IZxI2mhu6kuvfdjzxPb30geAR2GFk7WRkk6bvp9a1DP
 Roc_KjyaATQKl13WN1RVydULW6QwfSeYtPmzpIx4gdwe1E7igrrYJykoJFl9fr9L8agNPAeXjoxx
 feD4pmOEfjU1LqjVb8Sqrgo938uhBdliCKEGm.6uyEi9RFCEJTXy0THC5nqLasLZUiiI1sv_SMoE
 Wwkk71ybnFsJujH.r5BxY1fXf.YJUuSc2HqudT2hAPPkbNhDzbBhz7tl4DWhYad9yqlILdEQxM6m
 zpVz5Fsq6vEzaEkiZodwTFFDF_rAK2w5uW7wuMwRqB9XpUhekH17tzSDQGlhadkvDBAFlmjMEOVN
 YMCHeP5c1CJGwPZzfdfOE9khXurMENoH0Nzm5nMEUNwspGQuHiGtBgkSnzDG6bLJ.4GBEf..EEOt
 jFz_EWe2Wm7fWpEq8VdEhjqP.wCxTzk7mVDNHtw0WPa5Bl5wo7uDceC6AOp7EU0TernsLNzlMka2
 qwDBbjL6Rx.5WvQpNfqq4FK14efRuK.WmtLjmVg0uw6Fk4WpyOT0ePGwhqEobG20I5_aAaGsHQvF
 0TPAtQIpqNL0fwL_GvxHynRF4s06x2Bb5WaMdMtdEvjvZ.3guMPcJzwV9ONSFiwHJvfckwRBrp2z
 CmoTVTCWBVD6fMa9WZRO1IiJgziqzAmFB.iRrS9n2oaQFBSl6Uw_GZ2atTPboigbO.Pl87kSItES
 _42wVS4YG5ZJpPxCgxiXTE46uldccHV2xZtEw71yYL3.UyKt83Z4epwIQ2BdCTb6tQAeuBW1cmG2
 1QvKOIDY38ldXlEzK8sHMFNh7yX3ExR4mLfr3u_MXHG56K6XsU5xf0X8PzxfpJqpjMRibpztxtXM
 4KoUJIY3nNnOIh4ytWBBXAx1le5dbq2uNyVP.jJ.LOZB8ZL_XclBwwstUhufLggfL0pLTGFgQx5G
 H7tcLRFTE_b_dfGOTjnldqd6b_LZKAszjjJb7wHnTQbz8rMU2FH2CSgw0jno8L0ZD4S8eaq_uGET
 Watj_Kxr.rDt9gdBYmv.wnD5KpXpypbfLnJTIUznLbnRYuYIKhBr7YW7Eu38AyuVazNaFfQjWzCU
 xFr4ew6gpPtmdUHxOOLLs2t7cSsA_.ogENb2raR0a_wA4bPsOgZAtZLT5wx4WYGhva0Kv524qP0j
 nD77mmTRq9ev7pHFV8pTIMAu6IWkrMsIWfKQR509Fm4Kkskiq1at5G2gCl_7h.GCbnPfJVPxe2l8
 17vwt03ZrmpgaprWBvfd0HSQLMkLI2trZrA_YnENypE1UQ9G0rLRjOTbrewbxHmd9gz5d.sX0Jhf
 NKXs9mTDJPmGv7elmfAw1.8fVJUhV2szGoNMNsRIwMyPxLjSsJRvVj03MWaXmqryWknCWD7ZdEcr
 T_3OKzeYFNPDD6J_TmCSaT3jTO8q84vvy5uipTIkFx3xg2Qxamrpl2y2tw7Os308rSYuYikid8Xp
 LqKL45ORtxYbB_6rF2tc-
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: bc06dd53-783a-429d-9217-3639f51157c3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Thu, 12 Sep 2024 13:25:42 +0000
Received: by hermes--production-ir2-6664f499fc-5vwr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d1d306b31e7e59fed53057e6e54e7939;
          Thu, 12 Sep 2024 12:24:51 +0000 (UTC)
Message-ID: <5ce29155-3b79-412c-846e-e183e3c88010@yahoo.com>
Date: Thu, 12 Sep 2024 14:24:49 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Need a help to understand xenomai 4
To: akshay.vaghasiya@dlr.de
References: <994786c98a894f3d96068bb184294ff8@dlr.de>
Content-Language: en-US, it
Cc: xenomai@lists.linux.dev
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <994786c98a894f3d96068bb184294ff8@dlr.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/09/24 13:53, akshay.vaghasiya@dlr.de wrote:
> Hello Dear Support Team,
> 
> I hope you are doing well.
>   
> I am Akshay, a master thesis student. I got your email from mailmap file of denx(Xenomai 4). I am adding linux-evl to my raspberry pi 4B. I have already inbuild kernel 6.1(64 bit Debian GNU/Linux 11 (bullseye)). I have added 6.10(linux-evl) and lib-evl to run some programs in xenomai 4 realtime. Everything is working fine but the problems are kernel headers, When I add linux-evl image to linux kernel at that time Raspberry pi loses menu, camera does not work, Chromium does not work. Only I can run my programs and could not run other softwares and libraries.
>   
> I have written whole process that How I compile my linux-evl on raspberry pi.
> Could You please suggest me solution Or suggestions what should I do to run this properly?
> Am I doing something wrong?
> Please see the file and please help me if I am making any mistake or doing it in wrong way.
>    
> My final linux-evl kernel(uname -r) output looks like this(6.10.06.10.0-00734-g81ec9bb82a9f)
> Also, linux-evl does not provide overlays, So Is it problem or do we have to generate it? Because in internet there is nothing for generating overlays for linux-evl.
>   
> Thanks and regards,
> Akshay
>   
> Deutsches Zentrum für Luft- und Raumfahrt e.V.(DLR) German Aerospace Center
>   
> Institute of Software Technology | Flight Software | Lilenthalüplatz 7 | 38108 |Braunschweig | Germany
>   
> Akshay Vaghasiya | Software Engineer (Master Thesis)
> 
> Process How I load the linux evl
> 
> Built Kernel Xenomai 4 on Raspberry 4
> 
> 1.	Add packages
> -	sudo apt install git bc bison flex libssl-dev make libncurses-dev
> 
> 2.	Clone the evl git project for with xenomai 4
> -	git clone https://source.denx.de/Xenomai/xenomai4/linux-evl
> 
> 3.	Check out the the base version and compile kernel		
> -	cd linux-evl
> 4.	
> 5.	Make de config
> -	make defconfig
> 


Hi,

you should use the kernel configuration shipped with Debian kernel to 
have all the Debian functionalities in.
Copy it (it should be in/boot) in the sources folder and rename it as 
.config, then proceed with the menuconfig step enabling all the Xenomai 
related stuff.

Regards

-- 
Mauro S.

> 6.	Make menu Config
> -	make menuconfig
>  > 7.	Select these options and make changes in your raspberry pi
> -	General setup
> o	Local version
> o	Kernel .config support
> o	Enable access to .config through /proc/config.gz
> -	Kernel Features
> o	EVL real-time core
> 	Debug support
> o	Timer frequency 1000Hz
> -	CPU Power Management
> o	CPU Frequency scaling
> 	Default CPUFreq gorvernor
> •	performance
> 
> 8.	Please set other options according to your needs. After setting up, you can start building
> -	make -j4 Image modules dtbs
> (This can take more than 1.30 hours)
> 9.	Put up the build.
> -	sudo make modules_install
> -	sudo cp arch/arm64/boot/dts/broadcom/*.dtb /boot/
> -	sudo cp arch/arm64/boot/Image /boot/nameKERNEL.img
> 
> 10.	Modify /boot/config.txt to make sure the system boots into our kernel(if it is already added in default setting).
> -	#Add this line	
> -	kernel=kernel8.img
> 11.	Reboot the system and the fire uname -r Command, Output will show new kernel version.
> -	My output looks like this.
> -	pi@raspberrypi:~ $ uname -r
> 6.10.06.10.0-00734-g81ec9bb82a9f
> 12.	After rebooting, you can see the following message listed in dmesg
> -	dmesg | grep EVL
> -	[    0.123482] IRQ pipeline: high-priority EVL stage added.
> -	[    0.125676] EVL: core started [DEBUG]
> (You can see that the EVL core has been successfully opened)
> 
> Libevl for process  (Just for knowledge)
> 13.	Download libevl
> -	git clone https://source.denx.de/Xenomai/xenomai4/libevl
> 14.	Compile and install, here you will need to use the header of linux-evl, here please modify the UAPI parameter to the corresponding folder.
> - cd libevl
> - mkdir /home/pi/libevl-build
> - cd /home/pi/libevl-build
>                (Please set up the path according to your path)
> -	meson setup -Dbuildtype=release -Dprefix=/usr/local -Duapi=/home/pi/linux-evl /home/pi/libevl
> -	meson compile
> -	sudo ninja install
> 
> 15.	Verify the Installation
> -	ls /usr/local/lib | grep libevl
> -	ls /usr/local/bin | grep evl
> 
> You should see libevl.so in the /usr/local/lib directory and evl utilities in the /usr/local/bin directory
> 
> 16.	Testing the Installation
> Just open this path
> /usr/local/bin
> Run these tests to see result
> ./evl
> ./latmus
> 
> 17.	Now, lets check the all libraries are installed and works successfully. (https://evlproject.org/core/testing/ refer this link to see the results)
> -	Just go to the folder where your elv tests are available ($prefix/tests as part of building libevl)
> -	Cd /libevl/tests
> -	Sudo evl test
> Finish
> If you get the error of permission or error of empty lib directory then this could be the solution.
> Add /usr/local/lib to the Library Path:
> -	echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/libevl.conf
> -	sudo ldconfig
> Check if the library path is correctly set and if the system can now find libevl.so.4.
> -	ldconfig -p | grep libevl
> Set the LD_LIBRARY_PATH Environment Variable:
> -	export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
> You can add this line to your .bashrc or .bash_profile file to make it persistent across sessions:
> -	echo "export LD_LIBRARY_PATH=/usr/local/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
> -	source ~/.bashrc
> Run the Utilities Again:
> -	./evl
> -	./latmus
> 
> To run other files, we need different meson set up and its files.(without meson build file)
> 
> 
