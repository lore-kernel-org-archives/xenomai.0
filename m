MIME-Version: 1.0
In-Reply-To: <74BA8E0B069CA64E8F62901CD1E66D50089C7DB3@TOSBLRMBX02.TOSHIBA-TSIP.COM>
References: <74BA8E0B069CA64E8F62901CD1E66D50089C7DB3@TOSBLRMBX02.TOSHIBA-TSIP.COM>
Date: Mon, 19 Jan 2015 11:52:47 +0530
Message-ID: <CA+HFbxAGWHR_JdXpG7FHwxbGsQD3nzu3u_+etTn5ymjGZP3i9A@mail.gmail.com>
From: satya patel <satya087@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] needs help
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I am trying to compile linux-10.32+ipipe-10.32  with xenomai 3 while
compilation I am getting below warnings after enabling
CONFIG_IPIPE_ARM_KUSER_TSC.





WARNING: arch/arm/kernel/built-in.o(.text+0x8988): Section mismatch in
reference from the function __ipipe_tsc_register() to the variable
.init.text:__ipipe_tsc_area_start

The function __ipipe_tsc_register() references

the variable __init __ipipe_tsc_area_start.

This is often because __ipipe_tsc_register lacks a __init

annotation or the

annotation of __ipipe_tsc_area_start is wrong.



Please let me know what might be reason for this warning.



Regards

satya
