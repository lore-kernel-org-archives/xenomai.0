References: <CA+K1mPEVur-XvBqKXo5f+sPdajeGUxfLWfMXAygNBOUaFdbupw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fbe1dec6-cf9e-fa65-ec2d-f37798b9ffbd@xenomai.org>
Date: Sat, 22 Jul 2017 10:34:15 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPEVur-XvBqKXo5f+sPdajeGUxfLWfMXAygNBOUaFdbupw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] non-blocking IDDP (xenomai 2.6.4)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, xenomai@xenomai.org

On 07/21/2017 09:16 PM, C Smith wrote:
> Hi all --
> 
> I am using the realtime-realtime IPC mechanism with
> 
> socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_IDDP)
> 
> I have a server process that opens a socket and periodically checks if
> anything came in from a client (a separate process on the same machine),
> which may or may not be running.  If a client is running, the server
> successfully receives the packet from the client; but if no client is
> running, the server's call to recvfrom() blocks forever.
> 
> I'm confused among the various ways of making connections non-blocking -- I
> have tried the following:
> 
>  . According to the linux manpage for socket(), this should work:
>    s = socket(...,type|SOCK_NONBLOCK,...)
>    but with AF_RTIPC,SOCK_DGRAM socket() throws error "Address family not
> supported by protocol"

SOCK_NONBLOCK, and more generally overloading the socket type argument
is Linux-specific, not part of the POSIX standard. This is a case where
Xenomai stayed on the standard side of the universe.

> 
>  . fcntl:
>    int flags = fcntl(s,F_GETFL,0);
>    fcntl(s, F_SETFL, flags | O_NONBLOCK);
>    However, the first call to fcntl throws an error, "Bad file descriptor"
> (the file descriptor returned from socket() is 896, which is unusual).
> 

Xenomai 2.x does not implement fcntl, hence the EBADF received from the
standard kernel. Xenomai 3 does, so O_NONBLOCK can be passed to switch
the fildes to async mode there.

>  . setsockopt:
>    I have seen some examples on the internet (with other socket types) of
> calling:
>    setsockopt(s,level,SO_NONBLOCK,&one,sizeof(int))
>    however, I think this is non-standard -- I cannot find a definition of
> SO_NONBLOCK on my linux 3.4.6/xenomai 2.6.4 machine.
> 
> Can anyone tell me how to make recvfrom non-blocking on an IDDP socket?
> 

MSG_DONTWAIT can be passed in the flags argument to recvfrom/recvmsg.
Still not POSIX compliant AFAIK, but in that case Xenomai decided that
complying with Linux was better.

-- 
Philippe.

