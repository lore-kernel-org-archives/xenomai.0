From: Don Newbold <d.o.newbold@gmail.com>
Subject: driver make files and target architecture size
Message-ID: <ba52d8a1-4012-dbd9-6d34-e10d0237cd35@gmail.com>
Date: Mon, 11 Feb 2019 22:25:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

This is my first post, so please excuse my shortcomings.

I've been writing and maintaining Linux drivers for over 15 years, and 
am now being tasked with Xenomai support.

1. When I look at the driver make files included with the latest Xenomai 
download they look totally foreign. Is the existing Linux driver module 
makefile format usable or must another format be generated?

2. I'm familiar with building drivers to support 32-bit vs 64-bit 
targets. I see that Xenomai has in the past had x64 support, but I now 
only see x86. Please clarify the current x86 vs x64 support.

Thanks,

Don


