From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-help] Blocking reads from pipes
Date: Thu, 17 Nov 2005 19:21:42 +0900
References: <OF53595BAB.2AA49C4A-ONC12570BA.0035EF11-C12570BA.0036F2D4@domain.hid>
	<437B2D05.6070003@domain.hid> <437C5119.4060100@domain.hid>
In-Reply-To: <437C5119.4060100@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3mFfDsFVVCb+LiK"
Message-Id: <200511171921.43221.rlenglet@domain.hid>
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

--Boundary-00=_3mFfDsFVVCb+LiK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> One posix thread blocked reading from a pipe (using posix
> open/read) won't unblock when you close the file handle from
> another thread.

Yes, it does!

Compile the two attached source files:
$ gcc -o read read.c
$ gcc -o close close.c

Create the named pipe:
$ mkfifo testfifo

In two different terminals, run "read", which will block in 
read(), then "close".

You will remark that the blocking read call is unblocked when the 
other process closes its descriptor.


As a conclusion, the behaviour that you observed with Xenomai 
pipes seems consistent with that of Linux' named pipes, except 
that in Linux read() returns 0, and not an error code as you 
observed with Xenomai.

-- 
Romain Lenglet

--Boundary-00=_3mFfDsFVVCb+LiK
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="close.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="close.c"

#include <stdio.h>
#include <fcntl.h>

#define SIZE 1024

int
main (int argc, char **argv)
{
  int desc;
  int nread;
  char buf[SIZE];
  desc = open ("./testfifo", O_WRONLY);
  if (desc == -1)
    {
      perror (argv[0]);
      return 1;
    }
  close (desc);
  return 0;
}

--Boundary-00=_3mFfDsFVVCb+LiK
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="read.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="read.c"

#include <stdio.h>
#include <fcntl.h>

#define SIZE 1024

int
main (int argc, char **argv)
{
  int desc;
  int nread;
  char buf[SIZE];
  desc = open ("./testfifo", O_RDONLY);
  if (desc == -1)
    {
      perror (argv[0]);
      return 1;
    }
  while ((nread = read (desc, buf, SIZE)) > 0)
    {
      buf[nread] = 0;
      printf ("child received \"%s\" (%d)\n", buf, nread);
    }
  if (nread == 0)
    printf ("child received 0 bytes!\n");
  if (nread == -1)
    perror (argv[0]);
  close (desc);
  return 0;
}

--Boundary-00=_3mFfDsFVVCb+LiK--

