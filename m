Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3097A5CA1
	for <xenomai@lists.linux.dev>; Mon, 29 Aug 2022 20:20:53 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id og21so17988733ejc.2
        for <xenomai@lists.linux.dev>; Mon, 29 Aug 2022 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ycrdi-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=oDpgFVKv0tWqNQjPaCGERA2FRikqRDsLYr1jekQUPaA=;
        b=rVxMot3tvJgpPoDKalkofZtNNvsaESc22LfDa9yN9Mjs72Xn2GrqGabBJ8iBFQlS/z
         hMHMDbDd9srnD3s/KPON4AnON59xaY79r+vy1cRIpSWjA4Ji+mlCO1/ODsrHqx6WWHzc
         Jd7fZJhtvXA30uS81qCv01eZjx9ZcfAbj405devSnvgC190KzOjCyaXMwjuGqqzXGaeY
         oPLK/nnGUuXbtXA9hn1mTuOJVkLfWbL2Ggb0qkOV5xV7W2WOl9/q4GjtKwdob3gDg3G2
         vg6VYjc5cCZtsywrEqu94qXCwkvRlQ0Km91LxAWbtkgugY98Gc/BksMY1JRYlyuvwxf+
         PjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=oDpgFVKv0tWqNQjPaCGERA2FRikqRDsLYr1jekQUPaA=;
        b=IY7/M77QzEYWe1GhNqZd5LJOpy93ghkrW4cT84xPF2HycGRv11WgfYo2JDeqyKAgXk
         WpxlehRjBvcEHd/aMJM/O9K09WUqf5vAwSh7NaaAE3908Q5/hRetPdpQRozBA24aLNAG
         13yoJJQHNXMidT40q4B1pCDPNuyUfSe863fEM+kLqGn9sudfShhcp0iqqQrHdZbuznEB
         gni30RpkDoIuDYJPxPFa3azHF0DDlNAJZIPkBQlqDQ/Rb+yuKGVugBiF1Z8zommksp2Q
         9gPqyU8gpmShoAoQSjBIkeAdOE949dFziONxVUHu+hQffb/1UZ0zOahTcTdKkX0AqAkq
         4mug==
X-Gm-Message-State: ACgBeo385araoW3TQaQa6Fpu2PkAxwlrpMvf4xdkOKoqgMOenhfonEzf
	6e+J8DesCdAm0FFsKCRQBhQMW9qxuPFWG4K+D23o+s3943+P5Tcr
X-Google-Smtp-Source: AA6agR5Sl64x3mU+jIK2caDbDjt2dAd2nxaCmP3K7HvvAJ8EZFd+CwIVYHHKBlsHkCXekMlMwIW8gxvyWEA2ymEDePw=
X-Received: by 2002:a17:907:6d8a:b0:73b:d9e4:e628 with SMTP id
 sb10-20020a1709076d8a00b0073bd9e4e628mr14751115ejc.75.1661804450925; Mon, 29
 Aug 2022 13:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Steve Pavao <pavao@ycrdi.com>
Date: Mon, 29 Aug 2022 16:20:15 -0400
Message-ID: <CAFA6+bzfHxHHCgEAmck7DZu_3As0BP02wJiVpLN+fBWLaXcYiw@mail.gmail.com>
Subject: boot error using Xenomai Cobalt on iMX7D
To: xenomai@lists.linux.dev
Cc: pavao@ycrdi.com
Content-Type: text/plain; charset="UTF-8"

I get an error trying to run Xenomai Cobalt with mainline Linux
5.4.199 patched with I-PIPE 5.4.180 on a Toradex Colibri iMX7D.

Linux 5.4.199 without Xenomai Cobalt and without I-PIPE patch boots OK.

The error log is:
run sdboot
Booting from MMC/SD card...
** Bad device mmc 0 **
Colibri iMX7 #

My platform is Toradex Colibri eval board with an iMX7D SoM card. I am
using imx7d-colibri-eval-v3.dtb, and booting my custom kernel/rootfs
from a microSD card via the run sdboot option of the Toradex.  The
build is configured for 32-bit ARM and I am using the I-PIPE 5.4.180
patch for 32-bit ARM.  As I mentioned, the vanilla Linux build boots
OK, yet when adding Xenomai Cobalt and I-PIPE patch it builds OK, but
does not boot.

My buildroot config options for Xenomai:

#
# Real-Time
#
BR2_PACKAGE_XENOMAI_COBALT_ARCH_SUPPORTS=y
BR2_PACKAGE_XENOMAI=y
# BR2_PACKAGE_XENOMAI_LATEST_VERSION is not set
# BR2_PACKAGE_XENOMAI_CUSTOM_VERSION is not set
# BR2_PACKAGE_XENOMAI_CUSTOM_TARBALL is not set
BR2_PACKAGE_XENOMAI_CUSTOM_GIT=y
BR2_PACKAGE_XENOMAI_REPOSITORY="https://gitlab.denx.de/Xenomai/xenomai.git"
BR2_PACKAGE_XENOMAI_VERSION="stable/v3.1.x"
# BR2_PACKAGE_XENOMAI_MERCURY is not set
BR2_PACKAGE_XENOMAI_COBALT=y
BR2_PACKAGE_XENOMAI_ENABLE_SMP=y
# BR2_PACKAGE_XENOMAI_ENABLE_REGISTRY is not set
BR2_PACKAGE_XENOMAI_ADDITIONAL_CONF_OPTS=""
BR2_PACKAGE_XENOMAI_TESTSUITE=y
# BR2_PACKAGE_XENOMAI_RTCAN is not set
# BR2_PACKAGE_XENOMAI_ANALOGY is not set

#
# Skin selection
#
BR2_PACKAGE_XENOMAI_NATIVE_SKIN=y
BR2_PACKAGE_XENOMAI_POSIX_SKIN=y
# BR2_PACKAGE_XENOMAI_PSOS_SKIN is not set
# BR2_PACKAGE_XENOMAI_RTAI_SKIN is not set
# BR2_PACKAGE_XENOMAI_UITRON_SKIN is not set
# BR2_PACKAGE_XENOMAI_VRTX_SKIN is not set
# BR2_PACKAGE_XENOMAI_VXWORKS_SKIN is not set


My Linux config options for I-PIPE are:

CONFIG_LOCALVERSION="-IPIPE"
CONFIG_HAVE_IPIPE_SUPPORT=y
CONFIG_IPIPE=y
CONFIG_IPIPE_CORE=y
CONFIG_IPIPE_WANT_PTE_PINNING=y
CONFIG_IPIPE_CORE_APIREV=2
CONFIG_IPIPE_TARGET_APIREV=2
CONFIG_IPIPE_DEBUG=y
CONFIG_IPIPE_DEBUG_CONTEXT=y
CONFIG_IPIPE_DEBUG_INTERNAL=y

Please let me know if you have any ideas what is wrong. Maybe I need
to do more, or alter these options.

Steve Pavao
YCRDI
