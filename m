Message-ID: <51BE2859.8000307@gmail.com>
Date: Sun, 16 Jun 2013 23:04:25 +0200
From: Manuel Huber <manuel.h87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] rtdm: minimal patch for sys_rtdm_recvmsg
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello!

I plan to add a minor change to RTnet which allows to get reception
timestamps through recvmsg:

SO_TIMESTAMPNS patch:
http://sourceforge.net/mailarchive/forum.php?thread_name=3D51BAB330.70500%4=
0web.de&forum_name=3Drtnet-developers =

<http://sourceforge.net/mailarchive/forum.php?thread_name=3D51BAB330.70500%=
40web.de&forum_name=3Drtnet-developers>

Current implementation (of RTDM) in RTAI and Xenomai doesn't fix the
msg_control and msg_controllen field in struct msghdr. I believe, it
should be done similar to the linux kernel:

1. User specifies how much space has been allocated for control messages
    - msg_control is set to starting address of buffer
    - msg_controllen is set to the size of the buffer
2. User calls recvmsg
3. Control messages are tried to be inserted by some kernel code
4. msg_control is set to the next free byte, msg_controllen is updated to
    the actual space left in the buffer.
5. Before copying the struct to the user, msg_control has to be reset to
    the actual starting address and msg_controllen has to be set to the
    number of bytes written to the control message buffer rather than the
    space left.
6. Back to user space.

Current implementation could cause problems: Control messages are
currently not used but the msg_controllen field inidicates that control
messages have been written to the buffer; I'm not sure that this is a
violation of some standard, but at least it's different from the linux
kernel implementation!

The patch has been tested on 3.5.7 kernel and is based on SHA
69f6cb5ec287afff5ab197528d9eb1177f6de6d6
(http://git.xenomai.org/xenomai-jki.git) and should work as expected.


Best Regards

Manuel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Xenomai-0001-rtdm-Fix-msghdr-struct-cmsg-in-sys_rtdm_recvmsg.patch
Type: text/x-patch
Size: 1722 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130616/18f43ac=
0/attachment.bin>
