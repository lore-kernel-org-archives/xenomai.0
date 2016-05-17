From: Sagi Maimon <SMaimon@advaoptical.com>
Date: Tue, 17 May 2016 12:43:04 +0000
Message-ID: <84fc0b75032a447285250327e4e843fb@advaoptical.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] understanding /proc/xenomai/stat
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
Can someone explain the fileds in /proc/xenomai/stat?

To be more specific, I get this output :
  0  0      0          16722526   0     00500080   70.2  ROOT/0
  1  0      0          1          0     00500080   99.9  ROOT/1
  0  0      0          9248781    0     00000082    6.7  rtnet-stack
  [.....]
  0  2190   1          8280188    1     00300186   10.0  PtpHandlerTask
  [.....]

I can see that my xenomai code occupies about 30% CPU, the Linux occupies about 4%

What is the connection between xenomai and linux? Does it means that my code total CPU usage is 34%?

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
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160517/9a7e32ed/attachment.jpg>
