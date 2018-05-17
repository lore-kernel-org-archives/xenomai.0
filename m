From: Libin Zhao <libin.zhao@envisioncn.com>
Date: Thu, 17 May 2018 12:23:57 +0000
Message-ID: <BJBPR01MB13202D191F08293D461E0B2E5910@BJBPR01MB132.CHNPR01.prod.partner.outlook.cn>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xddp and socket: Address family not supported by
 protocol
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

         Now,I install Xenomai-3.3 In Ubuntu 3.18.20,

         The latency test and cyclictest run good in my environment like that
[cid:image001.png@01D3EE1C.F980D020]

And execute the cmd :dmesg | grep -I xenomai,result like below:
[cid:image002.png@01D3EE1C.F980D020]

But when I run the demo test  iddp-label , the result is error ,the error message below:
socket: Address family not supported by protocol

So ,how can I make it right, can you help me ?

Thanks very much!


BR
tony




???(????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????,?????????????????????
This email message (including any attachments) is confidential and may be legally privileged. If you have received it by mistake, please notify the sender by return email and delete this message from your system. Any unauthorized use or dissemination of this message in whole or in part is strictly prohibited. Envision Energy Limited and all its subsidiaries shall not be liable for the improper or incomplete transmission of the information contained in this email nor for any delay in its receipt or damage to your system. Envision Energy Limited does not guarantee the integrity of this email message, nor that this email message is free of viruses, interceptions, or interference.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.png
Type: image/png
Size: 16729 bytes
Desc: image001.png
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180517/c086829d/attachment.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image002.png
Type: image/png
Size: 12365 bytes
Desc: image002.png
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180517/c086829d/attachment-0001.png>
