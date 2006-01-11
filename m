Message-ID: <43C50BA1.7020908@domain.hid>
Date: Wed, 11 Jan 2006 13:44:01 +0000
From: "S. ancelot" <sancelot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] newbie heap usage problem
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
I tried to make a programming sample using heap .
The heap seems to be created regarding registry in proc, but then the  
program seg faults


Here is my program

#include <sys/mman.h>
#include <xenomai/native/heap.h>
#include <stdio.h>

RT_HEAP *m;
int x;

int main()
{
  mlockall(MCL_CURRENT|MCL_FUTURE);
  x = rt_heap_create(m,"toto",100,H_SHARED);
  rt_heap_delete(m);
  return 0;

}

Best Regards
S@

