MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 21 Jul 2017 12:16:23 -0700
Message-ID: <CA+K1mPEVur-XvBqKXo5f+sPdajeGUxfLWfMXAygNBOUaFdbupw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] non-blocking IDDP (xenomai 2.6.4)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all --

I am using the realtime-realtime IPC mechanism with

socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_IDDP)

I have a server process that opens a socket and periodically checks if
anything came in from a client (a separate process on the same machine),
which may or may not be running.  If a client is running, the server
successfully receives the packet from the client; but if no client is
running, the server's call to recvfrom() blocks forever.

I'm confused among the various ways of making connections non-blocking -- I
have tried the following:

 . According to the linux manpage for socket(), this should work:
   s = socket(...,type|SOCK_NONBLOCK,...)
   but with AF_RTIPC,SOCK_DGRAM socket() throws error "Address family not
supported by protocol"

 . fcntl:
   int flags = fcntl(s,F_GETFL,0);
   fcntl(s, F_SETFL, flags | O_NONBLOCK);
   However, the first call to fcntl throws an error, "Bad file descriptor"
(the file descriptor returned from socket() is 896, which is unusual).

 . setsockopt:
   I have seen some examples on the internet (with other socket types) of
calling:
   setsockopt(s,level,SO_NONBLOCK,&one,sizeof(int))
   however, I think this is non-standard -- I cannot find a definition of
SO_NONBLOCK on my linux 3.4.6/xenomai 2.6.4 machine.

Can anyone tell me how to make recvfrom non-blocking on an IDDP socket?

Thanks!
csmith
