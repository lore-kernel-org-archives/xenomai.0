MIME-Version: 1.0
Date: Mon, 18 May 2009 14:56:01 +0100
Message-ID: <abaf774b0905180656y4eddca23h6241c9dc031a3ba4@domain.hid>
From: Steve <sbxenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] select(2) generates EFAULT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

First, thank you for the help on my previous query.

I am still working on porting a c++ application from RTAI to Xenomai,
and have encountered a problem with sockets, specifically the select
function.

When Xenomai is not being used the code runs as expected.  Once the
Xenomai headers, compile options, etc, are used the select function
fails with the error EFAULT.  I have reproduced the error (works
without Xenomai, EFAULTs with Xenomai) using the following program:

#include <stdio.h>
#include <arpa/inet.h>
#include <errno.h>

int handleError(char *msg, int err);

int main(void)
{
   int sfd;
   struct sockaddr_in sai;
   fd_set SockSet;
   struct timeval tv;
   tv.tv_sec = 2;
   tv.tv_usec = 0;

   sai.sin_family = AF_INET;
   sai.sin_port = htons(1025);
   sai.sin_addr.s_addr = htonl(INADDR_ANY);

   if((sfd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
   { return handleError("creation error", errno); }

   if(bind(sfd, (struct sockaddr*)&sai, sizeof(sai)) == -1)
   { return handleError("bind error", errno); }

   if(listen(sfd, 5) == -1)
   { return handleError("listen error", errno); }

   FD_ZERO(&SockSet);
   FD_SET(sfd, &SockSet);

   if(select(sfd+1, &SockSet, 0, 0, &tv) == -1)
   { return handleError("select error", errno); }

   printf("success\n");

   return 0;
}

I am using Xenomai 2.4.6.1 on a vanilla 2.6.24.6 Linux kernel, and
running on Ubuntu 8.04.

Once again, any thoughts would be much appreciated.

Steve

