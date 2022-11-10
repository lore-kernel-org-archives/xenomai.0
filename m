Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEAF39D
	for <xenomai@lists.linux.dev>; Thu, 10 Nov 2022 06:52:46 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id bk15so841325wrb.13
        for <xenomai@lists.linux.dev>; Wed, 09 Nov 2022 22:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7SwFxPW9RdqyeJzzAGtMDRXYNxef2aEN0LJ4myF3LM=;
        b=ADwnnE/SGEZovZiVpn/zNwid3vQkh9/n2XPyPjfe8bdJXPhtxE0Ekuo5itoBcP3IUR
         49HuAz47CxLWdlffc9m9bUXMao1rV9b8sud9OXcRy9PK2GRvWirieMcHYlLV9bTHVfNs
         rEHMTlCBYWOlxr1cTusVZx0EQNw2R9n/9kW9qMCrjHJ+O7zfs+GZPWl7hVHMghXgvbQN
         /b10HcLV2bF5Qd5Bwzl+VcBHf+kVBCcalbrJvih9rx+FAExkBztk7NB40kz8BXQNAHWc
         ba8D5Jb2xL5AOrbagiHAEJEaCu7qnJJ4upmql9MyHpWWhNW85V4bkT58iY/uG9h1CVw5
         7gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7SwFxPW9RdqyeJzzAGtMDRXYNxef2aEN0LJ4myF3LM=;
        b=p/ctxDpzSosvVdIVrz3n6LrEKsYecocG9M+wI1yHbYnXHm/VA4M1QF6epLFJelfCLy
         FE3TBOBZtucCigwZ+kUoqtYP3MalRU6NSdqxkylBQ6izUaZQzrUyQR7vG+yGQBADRART
         8eKEPo+DhN3sb+42ogDwSuVBDU/h+vTZ1therJBZKeHhmRRl/RgVNDtax9UdzMQ+rz3B
         leVGAb3WN7byvJo7WNz1whpgfe2dR5wUGF3e9Pit7YFZuOeS3AVxNMGYzHADn+JhRTMf
         nxGbkQrqyFUVPKceLm7zCkruTUnoU0VnaUnlRdz50kOw3pQigSsjkEtI4Fuy18LUDmSh
         iRDg==
X-Gm-Message-State: ACrzQf29fMAIYUAJHfwvdLV/7FnJjUScFN0Ts6FA+L5zS7WArDuu5L/Q
	WDi7+LXw8HaJbVXcFKHB9rg=
X-Google-Smtp-Source: AMsMyM6sVrtxttA55Uy73rTvbaO0Xh+OI2ZD9CF8VEOQnISg58KcpCPVy0U4DGcfNJWKuxpSBkqB3Q==
X-Received: by 2002:a5d:4688:0:b0:236:8e4d:5cb3 with SMTP id u8-20020a5d4688000000b002368e4d5cb3mr42136919wrq.710.1668063164736;
        Wed, 09 Nov 2022 22:52:44 -0800 (PST)
Received: from [192.168.42.52] (62-47-42-87.adsl.highway.telekom.at. [62.47.42.87])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c4e0e00b003c6bd12ac27sm3948949wmq.37.2022.11.09.22.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 22:52:44 -0800 (PST)
Message-ID: <3ef4b7b1-8bd4-edea-9518-1b2efce90cce@gmail.com>
Date: Thu, 10 Nov 2022 07:52:42 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: cyclictest vs. latmus
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <49fb01fa-abda-46eb-cf47-31d48810d7eb@gmail.com>
 <87a653p28w.fsf@xenomai.org>
From: Robert Berger <xenomai.list@gmail.com>
In-Reply-To: <87a653p28w.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the explanations and sorry for the late reply.

My comments are inline.

On 07/11/2022 08:32, Philippe Gerum wrote:
> 
> The results are available from [4][5] and [6][7] respectively. To sum
> up, we have ~62 µs worst-case in non-isolated mode, 37 µs when
> isolated. Both figures are in line with the expectations on this SoM.

Yep and this is what I would expect, so most likely something is wrong 
in my configuration ;

> 
> To help figuring out the reason for this behavior with latmus on your
> test board, you may want to share your .config. However, I don't think
> the results you observed with cyclictest are relevant to EVL.
> 

Please note, that I use a multi_v7_defconfig. I guess you use something 
else.

Here[1] you can find the config.gz, which I pulled from the board.

Those are the components I use:

root@multi-v7-ml:~# cat /proc/version
Linux version 5.15.64-evl-student-g96fa4a8fcde6 
(student@HP-ZBook-15-G4-2) (arm-resy-linux-gnueabi-gcc (GCC) 12.2.0, GNU 
ld (GNU Binutils) 2.39.0.20220819) #1 SMP IRQPIPE Fri Nov 4 01:10:57
CET 2022


git show 96fa4a8fcde6d9361777daf05caaa527a44e418e
commit 96fa4a8fcde6d9361777daf05caaa527a44e418e (HEAD -> 
v5.15.64-evl3-rebase_LOCAL)
Author: student <student@ReliableEmbeddedSystems.com>
Date:   Fri Nov 4 01:10:35 2022 +0100

     commit not to be -dirty

diff --git a/arch/arm/configs/multi_v7_defconfig 
b/arch/arm/configs/multi_v7_defconfig
index 33572998dbbe..f770b9681a98 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1187,3 +1187,8 @@ CONFIG_DEBUG_FS=y
  CONFIG_CHROME_PLATFORMS=y
  CONFIG_CROS_EC=m
  CONFIG_CROS_EC_CHARDEV=m
+CONFIG_DA9062_WATCHDOG=y
+CONFIG_MFD_DA9062=y
+CONFIG_REGULATOR_DA9062=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y

commit 5c75c622911d192dc8c2988679713576cff89d45 (HEAD -> r39_LOCAL, tag: 
r39, origin/next, origin/master, origin/HEAD, master)
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Mon Oct 31 12:16:38 2022 +0100

     libevl r39

     Signed-off-by: Philippe Gerum <rpm@xenomai.org>

[1] 
https://drive.google.com/drive/folders/1yPOiKzfEgyXmdB-y4Pc4EzP15V4OtMyV?usp=sharing

Regards,

Robert

-- 
Robert Berger
Embedded Software Evangelist

Reliable Embedded Systems
Consulting Training Engineering
URL: https://www.reliableembeddedsystems.com

Schedule a web meeting:
https://calendly.com/reliableembeddedsystems/
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--

