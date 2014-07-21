From: "Botev, Roumen" <roumen.botev@brooks.com>
Date: Mon, 21 Jul 2014 14:50:58 -0400
Message-ID: <19C66D276CD97349B3ED15358BC387930904DECABF@Mailprodapp3.brooks.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Latency Test Results (xeno-test) on Xilinx Zynq XC702
 Board with Xenomai 2.6.3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello, All,

I am running Xenomai's out of the box battery of tests (xeno-test) on a Xilinx Zynq XC702 evaluation board.

I am new to Xenomai and I am wondering if these results look good to people having more experience in running Xenomai on a Cortex-A9 hardware. In particular, I had higher expectations of the average and worst case latency numbers - I was expecting < 10 usec worst latency for the highest priority user mode task. Here is the summary of the latency test (the full output of the test is attached to this message):

RTT|  00:15:04  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
. . . . . . . . . .
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|      3.675|     14.049|     35.913|       0|     0|    00:15:04/00:15:04

Any comments and/or insights are appreciated.

Best regards,

Roumen




_____________________________________________________________________
This email message, including any attachments, may contain confidential and
proprietary information for the sole use of the intended recipient.  If you are
not the intended recipient, you are hereby notified that any use, copying or
dissemination of this message is strictly prohibited.  If you received this
message in error, please notify Brooks Automation, Inc. immediately by reply
email or by calling Brooks US Headquarters at +1 978-262-2400. Then delete this
message from your system, without making any copy or distribution.  Thank you.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: LatencyTest-Zynq XC702 - pw22.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140721/40c5b922/attachment.txt>
