Message-ID: <54F01C44.9090000@ebus.com>
Date: Thu, 26 Feb 2015 23:27:00 -0800
From: Doug Brunner <dbrunner@ebus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Detecting closure of non-RT end of XDDP from userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

I have a need for an RT task that communicates with Linux tasks through
XDDP to tell when the Linux process has closed /dev/rtpN. In this case the
RT task is acting as a server of sorts from which Linux processes retrieve
data, and if an ill-behaved Linux process dies, the RT task needs to clean
up its connection state in order to not flood the hapless Linux process
that connects next with all the data that built up in the XDDP buffers. I
would rather avoid implementing a heartbeat mechanism (RT task watches for
periodic "I'm alive" signal from Linux process), because of the many
moving parts this would introduce.

It looks like the information is there - xnpipe_state::status (please
forgive my C++ scoping operator :)) has a bit indicating whether the Linux
side is connected, XNPIPE_USER_CONN. I was thinking of adding a function
xnpipe_get_status, which retrieves the status word:

int xnpipe_get_status(int minor, unsigned long *out);

The XDDP getsockopt() can then return this information to userspace,
mirroring how Linux sockets behave (if I understand correctly):

int err;
getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, sizeof(err));
if(err == 0) {
    /* socket is connected on Linux end */
}
else if(err == EPIPE) {
    /* socket is not connected on Linux end*/
}

One other possibility would be to add a socket option that, when set,
causes sendmsg() and recvmsg() to fail with EPIPE if the Linux end of the
pipe is not connected.

Does either/both of these seem like a good idea?

-- 
    Doug Brunner


