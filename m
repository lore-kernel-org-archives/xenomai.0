Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A9D449B25
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586184; cv=none; b=kyafijVATY9qHvTO40K/H+HxQouCq1cKsbLf9Rb5SSCt+dS7dpDKtFHX5FUzdGDu+r7a53zMsSqUufAsoMRUx7tBlYNxHLuuel+a8DJ15kzpgpu2wo9TkbPLRnpoT07DkE/Ply/Xsp+U699B/nol6mM3yslvnsG4a9flAHPDx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586184; c=relaxed/simple;
	bh=34WeOqMGn0TUqudFDxGIsr1aL17+2lcWHsSPGg3WmWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2Tee4XRPLViBv4W/EvHptUhtzAnBuOW1yhP12Stbn/Aw1+XNDqnuNRlyAJ8O5iZEtTAiEvsSljmuCYt/p+Z1uKc06o+SVNyWXkg0uK98e1daTzw4TBbW87YatZ9Dqw+MM1aep0COlmOEZLJAvIhV5ZaF4u2pOY0HjtbLrkfBBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXlb1xle; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXlb1xle"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso6946933f8f.3
        for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 15:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784586181; x=1785190981; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5VhISMiPQA1fbnzOuknuT0nzfS9TF+2I9EqkyODsVjQ=;
        b=sXlb1xle0nH667OZwl/sNyJ7PD35krGrfZa4DjfJ5+9NnkazEfvjh4OYBcWjJEcWHD
         JfgBKjf4AKlxsJ4sOJGHD/UmNYc8yE0BNoOGapR4yWE9S5q/AtL4Ll20ruwj5KAiPKTo
         b/26u6yAgRM1LOBFPa8vh5SKQiRKLncdDu+5TeN3R3O5MpY3WeQMAYgb6zwetrn5N1+1
         c8xORBXMG+zS51h4yxYUvIg4doYXLEobFwUzgryq6M8phaOupODOU1CnGzUWz5QjH3iL
         rPBhrY0YD30CYSSBtYbAyDLjf4bYE/BZQHhBF9rQV6AOFxR/xJN3PCEuumkJF7JXFcIw
         Ab9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784586181; x=1785190981;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5VhISMiPQA1fbnzOuknuT0nzfS9TF+2I9EqkyODsVjQ=;
        b=mo8U2uUSsQvTXXjV6oJpfyKFKQ4dFqlFCjnD5Vk0/Iqe0+eQngY0Xw/V/G5j8fkaXD
         p0UuuBfh/iG06mt7CUnqsYdq4YtpgqgigTYpZDJBTenrSUTEgfi7qo7v/JPfjPzrzQJo
         AjFpHSTC53AO5VzTe1WfYrRhXLyI+h3vrVZCIkI862AebEpAY+BhRkPJ++OTY1MkX0QC
         TzlahufQvcBJBmXauwrHDdJNKOkZ7BEJRjws3UJokGcmZF7Us4VvJV/7J1nmu5ryl5pZ
         eMuFXjZeXdB00NtO8BtGlLAtUxFba8CZoe+MZJNWYrbh2edDMyvYtwYE36TSwkA7OMBn
         ucFg==
X-Forwarded-Encrypted: i=1; AHgh+RpVn20pEIRIwpzljbko4UmP//gVDhbKH6NUVMD+GOUpcyI90fq0FnigRV/hDTGmt/WCfspfVtAp@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2ePGyEBWi0UxTzDsdnBIZfUnXk4juEvl9+dk1BvpBXhlCwqaE
	bKAZCjhEOpK6ZfjLOZLnsTBHYH/y2MNBeuEhdZem3777dc5KD+R2uRyf
X-Gm-Gg: AR+sD11cKcsMgOOGds/sZuHXLxaPeUleRYn9y/L+4PsYcyEbd5rBTblJZI8RYfDMUA8
	9U767H2cFnfMjeDtx9s66T2tGV52dUIaoFxrXEP9parBvxAMZfFiqKY8PTCwbHNq8wOPIiJyf4q
	XGv3G0hTrvqFrO+qgVxm/ILSa4UtgW4bXP6cZuaJ5+yFRbIPwT/PXDNP3xr+hKA4IgvhVhwAlLi
	SJWa9hq+2YEVaI9XlL1BlxEEhz6g6qoQLjYIrFotAsnadZBnd7bY2FB79IVeHGOMh6FZgMBpaK8
	Fv93g4IRGmsMQd7F6yBMRoEGiZ+RiNx8MZqQ3mpjiphI7rLSRepn9eHvFTF1YdOtpkIWdQ86Mgz
	tTOzjCsvCO11YkwNQxAAD+oLlYPM6gqkl+vK4/MgBW+1SoNP1/46AXdrSPckqeWfObakAnRFdEF
	P8W/mb3vTREI7UhO3aKtJE
X-Received: by 2002:adf:e00f:0:20b0:460:3233:beed with SMTP id ffacd0b85a97d-47f6232e20cmr13764248f8f.41.1784586180703;
        Mon, 20 Jul 2026 15:23:00 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm35890577f8f.21.2026.07.20.15.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 15:22:59 -0700 (PDT)
Message-ID: <2d7c3324-28f6-444e-a8a0-a028368804b6@gmail.com>
Date: Tue, 21 Jul 2026 00:22:59 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] libevl: Add debian package config
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20260717205820.8359-1-hannes.diethelm@gmail.com>
 <60f4470e-cdb7-40a7-a73a-9bb6d4a10ebd@siemens.com>
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <60f4470e-cdb7-40a7-a73a-9bb6d4a10ebd@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.07.26 um 16:30 schrieb Jan Kiszka:
> Hi Hannes,
> 
> thanks for carrying this over.

Thanks for all the feedback.

> 
> On 17.07.26 22:58, Hannes Diethelm wrote:
>> This patch adds a debian package config that allows to build a deb's
>> using dpkg-buildpackage -b -uc.
>>
>> The packages are libevl / libevl-test similar to[1]. However, latmus
>> is placed in libevl. One might not need the tests but still want to
>> use latmus.
> 
> For the purpose of tuning the core, or what is the reasoning here?

Yes exactly. One might need latmus but won't care about the tests.

Based on the comment from Florian, it would probably make more sense to create more packages:

- libevl (only library)
- libevl-bin (evl / latmus / oob-* tidbits)
- libevl-test (tests)
- libevl-dev (headers / libevl.a)

> 
>>
>> Additionally, libevl installs /usr/lib/udev/rules.d/90-libevl.rules which sets all evl
>> device files to group evl, g+rw. libevl.postinst adds this group and triggers an udev reload.
>>
>> This allows to use libevl without root. However, using SCHED_FIFO still
>> needs either root or setcap cap_sys_nice+ep and possibly some other tweaks.
>> Some tests and my application work with cap_sys_nice+ep. However, for example latmus fails
>> due to unknown reasons. The debian packages sets no capabilities but this could be added
>> if desired.
>>
>> Caveats:
>>
>> The test ptrace-sync fails with <timeout waiting for gdb>. dh_strip -Xptrace-sync from[1]
>> does not help and it is not needed: When libevl-test-dbgsym is installed, the symbols are
>> available but the test still fails. With dh_strip -Xptrace-sync, the symbols are not found:
>> warning: could not find '.gnu_debugaltlink' file for /usr/libexec/evl/tests/ptrace-sync
> 
> But the package built by xenomai-images does not have this problem and
> runs the ptrace test successfully. Already dug into the key differences?

Not yet. Might be just a different gdb version or path issue. I am using Debian Trixie.

Is there a way to download this images? I've seen there is a way to build them locally, i can also try this.

> 
>>
>> If linux-evl is also built and installed as a debian package, linux-libc-dev can not be
>> installed due to /usr/include/evl/*-abi.h are both installed by libevl and linux-libc-dev
>> from the kernel build. However, installing linux-libc-dev from debian trixie works fine.
> 
> This looks wrong: The kernel is providing us with a different UAPI, thus
> also needs to deliver an alternative linux-libc-dev package. It should
> be the role of libevl to deliver those headers as it has no knowledge
> about the actual kernel in use here. That's why xenomai-images is
> generating a new linux-libc-dev and is not relying on libevl here.
> 

Yes, Philippe sent me the hint with the -Dinstall-uapi=false switch, thanks.

One remaining issue is the versioning / dependency's. For now, to keep it simple, I just used the libevl tag
as the version. And it doesn't recommend a xenomai4 kernel.

For now, the packages are:
libevl_59_amd64.deb
libevl-test_59_amd64.deb dep libevl >= 59
linux-image-6.12.90-cip24-xenomai4-r59_6.12.90-3_amd64.deb (Withouth PREEMT_RT)
linux-image-6.12.90-cip24-xenomai4-r59-rt_6.12.90-3_amd64.deb (With PREEMT_RT)

I am working here [1] on creating Debian xenomai4 packages for linuxcnc. Not perfect but does the job. It's still WIP
but a few people got this already working without knowledge how to build kernels.
I did not yet push the latest version and I have to change from pushing the binary's to github releases.

With the uapi installed with linux-libc-dev, libevl has to depend on the right linux-libc-dev.

Version 59 is not really correct. The kernel has EVL ABI 45. Libevl has API 36, needs API >= 45.
For kernel dependency's, the ABI version is important, right?

For libevl, it could be either the API = 36 / dso_version = 8.0.0 / version = 0.59.

Variant with API/ABI as version:
- libevl 36 recommends linux-image-xenomai4 >= 45 or linux-image-xenomai4-rt >= 45
- libevl-bin 36 dep libevl >= 36
- libevl-test 36 dep libevl >= 36
- libevl-dev 36 dep libevl >= 36 linux-libc-dev >= 1:45

Dependency packages, needed to convert the ABI versioning into kernel versioning:
- linux-image-xenomai4 45 dep linux-image-6.12.90-cip24-xenomai4-45 or other kernel versions
- linux-image-xenomai4-rt 45 dep linux-image-6.12.90-cip24-xenomai4-rt-45 or other kernel versions
- linux-libc-dev 1:45 dep linux-libc-dev-xenomai4-45

Kernel packages:
- linux-image-6.12.90-cip24-xenomai4-45 6.12.90
- linux-image-6.12.90-cip24-xenomai4-rt-45 6.12.90
- linux-libc-dev-xenomai4-45 6.12.90

To create a linux-libc-dev-xenomai4-45 package, I would have to add a patch for linux-evl, the standard
kernel debian package system doesn't support custom names for linux-libc-dev. But this should be not to
complicated.

It's the first Debian package I am working on that's not only for me. I have to read a bit more in the
doc's how this dependency's are normally created properly.

Also linux-libc-dev 1:45 is a bit dirty: Using the epoch to replace the standard linux-libc-dev by a dependency
package that will not be replaced by the latest stock one. It should work tough.

Alternatives:
-Install the abi with libevl
-Create a linux-libc-dev-xenomai4 package from linux-evl and depend on that / remove the evl headers from linux-libc-dev
  so linux-libc-dev stock can be installed together with linux-libc-dev-xenomai4. I compared the content, most evl related files
  are new, only fnctl.h has
  #define O_OOB		010000000000
  added. However, I don't see any usage in libevl. So this should work.
-Leave the dependency's on the kernel packages away and solve this by documentation
  However, you would have to place a hold on linux-libc-dev so it doesn't get replaced as soon as your OS has a newer kernel.

Do you have other ideas how to solve the version / dependency's / linux-libc-dev issue?

For now I named the kernel packages -xenomai4 but I am thinking about changing to -evl or xenomai-evl. What is more appropriate?

> Jan
> 

[1] https://github.com/hdiethelm/xenomai4-linuxcnc
