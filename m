From: Laurent LEQUIEVRE <laurent.lequievre@gmail.com>
Message-ID: <576D453F.4090208@gmail.com>
Date: Fri, 24 Jun 2016 16:35:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] socket XDDP recvfrom timeout ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Laurent LEQUIEVRE <laurent.lequievre@univ-bpclermont.fr>

Hello,

I try to use the socket XDDP with the posix skin to communicate from RT 
thread to non RT thread.

To get a non blocked 'recvfrom', I added the flag 'MSG_DONTWAIT', and 
it's work fine.

But how to setup a timeout for this function ?

I tried to set the flag 'SO_RCVTIEMO' by using 2 methods :

struct timeval tv;
tv.tv_sec=nb seconds
tv.tv_usec=nb micro seconds
setsockopt(socket_id,SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)); --> 
doesn't work, blocked !

timeout (in nano seonds)
ioctl(socket_id, SO_RCVTIMEO, &timeout);  --> doesn't work, blocked !


Thanks for your help,

Laurent LEQUIEVRE




