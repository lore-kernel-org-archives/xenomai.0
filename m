MIME-Version: 1.0
Date: Sun, 28 May 2006 17:01:54 -0700
From: "Nathaniel J Villaume" <villaume@domain.hid>
Message-Id: <1148860914-13365.00015.03228-smmsdV2.1.4@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai-help] rt_heap_delete in asynchronous context
Reply-To: Nathaniel.J.Villaume@domain.hid
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

Hi, 

I have a simple user-space program (see below) that tries to
create a heap. If the heap already exists, then the program tries
to delete it. I have no other threads binding to the heap.

I can create, but not delete the heap. The error returned is
-EPERM. According to the API manual, this means the call occurred
in an asynchronous context. What does this mean, exactly? How
should I delete this heap? 

Any advice?

BTW, superb job on the documentation, it's made my learning curve
easy/straight-forward. 

Thanks,

Nate
/*************************************************/
/*! @file
  @brief 
  File shows how to allocate heap memory from user-space 
 */
#include "native/heap.h"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

RT_HEAP heap;
const char hp_name[]="heap1";
size_t hp_size = 500000;
RT_HEAP_INFO hp_info;

/*Map error codes to human-readable strings*/
void xeno_error_lookup(const char* msg, int err);

int
main( void )
{
  int err = 0;
  err = rt_heap_create( &heap, hp_name, hp_size, H_SHARED);
  if (err)
  {
    printf("Couldn't create the heap\n");
    if (-EEXIST == err)
    { 
      printf("Deleting heap....\n");
      err = rt_heap_delete( &heap);
      if (err)
      {
        xeno_error_lookup("Couldn't delete heap.", err);
      }
    }
    exit(err);
  }
  return err;
}

void xeno_error_lookup(const char* msg, int err)
{
  char* pc=0;
  switch (err)
  {
    case -EINVAL:
      pc = "EINVAL"; 
      break;
    case -EIDRM:
      pc = "EIDRM"; 
      break;
    case -EPERM:
      pc = "EPERM"; 
      break;
  }
  printf("%s: %d => %s\n", msg, err, pc);
}



