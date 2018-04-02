From: Sagi Maimon <SMaimon@advaoptical.com>
Date: Mon, 2 Apr 2018 12:56:39 +0000
Message-ID: <024cb4c6850d4e8fa626c8f43b66feb4@advaoptical.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Unrecoverable FP Unavailable Exception 801
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,
I am working with: Powerpc e300 SOC.
I am using: xenomai-2.6.4 version

I am experiencing this exception on my Linux :
Unrecoverable FP Unavailable Exception 801 at c0003858
Oops: Unrecoverable FP Unavailable Exception, sig: 6 [#1]

This happens during "alignment exception" (600)

I found this link:
https://www.mail-archive.com/search?l=xenomai@xenomai.org&q=subject:%22Re%5C%3A+%5C%5BXenomai%5C%5D+FPU+problems+in+Xenomai+2.4.x%22&o=newest&f=1

As I understand heavy use of FPU by Linux application with the xenomai can Couse this problem.
I have built a Linux application that causes many "alignment exceptions", but I don't get any Unrecoverable FP Unavailable Exceptions.

Does anyone familiar with this error?
Have this problem fixed in recent xenomai/ipipe versions?
Where can I find a list of fixes made in any xenomai/ipipe version?

Thanks,


Sagi Maimon
Manager R&D Software Oscilloquartz SA.
ADVA Optical Networking
Phone: +972 9 775 0124
Mobile: +972 54 5662632
e-mail: SMaimon@advaoptical.com<mailto:SMaimon@advaoptical.com>
[ADVA_OSA_Logo]
www.oscilloquartz.com<http://www.oscilloquartz.com/>
www.advaoptical.com<http://www.advaoptical.com/>




-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.jpg
Type: image/jpeg
Size: 4482 bytes
Desc: image001.jpg
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180402/8864aee2/attachment.jpg>
