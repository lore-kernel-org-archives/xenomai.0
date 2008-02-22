From: jwl <william.jing@domain.hid>
Content-Type: text/plain
Date: Fri, 22 Feb 2008 21:49:58 +0800
Message-Id: <1203688198.3228.1.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Error while executioning xeno-test
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

Hello,
        
        I have to install xenomai2.3.0 on a PPC architecture board.
        I patched linux2.6.19.2 with adeos-ipipe-2.6.19-ppc-1.5-02.patch
        and
        built an Ramdisk with buildroot and ELDK.
        
        The kernel boot correctly. when I run /usr/xenomai/bin/xeno-test
        I met this error:
        
        ------------------
        /usr/xenomai/bin/xeno-load: line 239: /usr/xenomai/bin/latency:
        No such file or directory
       ------------------
        
        But latency exists and has the correct permissions.
        
        By the way I didn`t change anything in the kernel
        configuration(Real-time sub-system -->)
        
        Does anyone know why this happend?
        
        Best Regards
        William Jing


