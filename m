Message-ID: <511C9E21.5010608@gmail.com>
Date: Thu, 14 Feb 2013 09:19:45 +0100
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>
	<50F3DD9A.9050306@gmail.com> <5117AD5A.1080504@xenomai.org>
	<OF7193B3EB.20F44A56-ON85257B11.006195D9-85257B11.0062A0F5@aanddtech.com>
	<511BD801.7060304@gmail.com>
	<OF7BC2A1E9.4D41277B-ON85257B11.00662217-85257B11.006671E8@aanddtech.com>
In-Reply-To: <OF7BC2A1E9.4D41277B-ON85257B11.00662217-85257B11.006671E8@aanddtech.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mfornero@aanddtech.com
Cc: Xenomai@xenomai.org

On 13.02.2013 19:38, mfornero@aanddtech.com wrote:
> Stefan Roese <stefan.roese@gmail.com> wrote on 02/13/2013 01:14:25 PM:
> =

>> Thanks for this update. This solves the twd issue (boot hangup) which
>> seems to be related to a defconfig misconfiguration.
>>
>> BTW: Did you also add the Xilinx GPIO driver changes to your git
>> repository I made to support GPIO interrupts? If not I'll send the
>> patches again to the list tomorrow.
>>
>> Thanks,
>> Stefan
> =

> Hi Stefan,
> =

> No, I didn't grab your GPIO changes-- just modified my defconfig to get
> rid of the twd issues.

Okay. Attached the GPIO driver changes for completeness. The first one
introduces IRQ domain support so that the interrupts can be selected via
DT and the 2nd patch adds the i-pipe irq supports.

Hope this helps.

Thanks,
Stefan




-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0013-gpio-zynq-Add-interrupt-domain-support-to-xilinxps-G.patch
Type: text/x-patch
Size: 5725 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130214/799c41f=
2/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0014-gpio-ipipe-Iron-Xilinx-Zynq-GPIO-interrupt-handler.patch
Type: text/x-patch
Size: 1264 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130214/799c41f=
2/attachment-0001.bin>
