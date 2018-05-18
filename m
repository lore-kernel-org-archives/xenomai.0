From: "Pham, Phong" <phamp@ddc-web.com>
Date: Fri, 18 May 2018 03:34:37 +0000
Message-ID: <C2EC5BA46D13CD44B5915A8FEEB4C44E9BF9E3A2@DDCEXCH.ddc-ny.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] 2 potential udd drivers fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>


Hi,

Currently, a user space driver write() API does not clear the number of interrupts occurred since the last read() API.  Instead it disable interrupt unless a UDD_RTIOC_IRQEN request comes in to enable interrupt.  The fact that ioctl() does support these requests makes write(UDD_RTIOC_IRQEN/anything) a redundant and inappropriate API.  Code change is to set both event  count and context->event_count to 0.

The second issue is the event ur->pulse needs to be cleared in udd_read_rt() because a select() on the file descriptor will return immediately as a result of a previous select() call when both select() invocation is on the same file descriptor even when the read() is sandwiched in between the select() calls while no interrupt occurs for the second select() call.

Below are the suggested code fixes for both issues.  I am using 4.9.51 Linux kernel with patch: ipipe-core-4.9.51-powerpc-3.

Phong.

PS: If you cannot see the image , enclosed is the file with fix and the original file.
[cid:image002.png@01D3EE17.938016A0]
Phong.


Notice: This e-mail and any files transmitted with it may contain Data Device Corporation's and its subsidiaries privileged and proprietary information. It is intended solely for the use of the individual or entity to whom it is addressed. If you are not the named recipient of this transmission, any disclosure, copying, distribution or reliance on the contents of this message is prohibited. If you received this e-mail in error, please destroy it and any attached files and notify me immediately.

Click Here<http://www.ddc-web.com/Profile/EmailPrivacy.aspx> to view our privacy statement.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image002.png
Type: image/png
Size: 166033 bytes
Desc: image002.png
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180518/c3d5d660/attachment.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: udd.c.orig
Type: application/octet-stream
Size: 17134 bytes
Desc: udd.c.orig
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180518/c3d5d660/attachment.obj>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: udd.c
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180518/c3d5d660/attachment.c>
