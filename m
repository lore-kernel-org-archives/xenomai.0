Date: Mon, 1 Sep 2008 22:15:44 -0700 (PDT)
From: Yasser Kashfi <yasser_kashfi@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <971398.39540.qm@domain.hid>
Subject: [Xenomai-core] RT_HEAP Problem
Reply-To: yasser_kashfi@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi
I have a problem with rt_heap; I write a simple program:
############################
#include <sys/mman.h>
#include <native/heap.h>

RT_HEAP M_HEAP;
int main(void) {
	int ret;
	int * tmp;
	
	/* no memory-swapping for this programm */
	mlockall(MCL_CURRENT | MCL_FUTURE);
	
	ret = rt_heap_create(&M_HEAP, "M_HEAP", 5 * 1024 * 1024 , 0);
	if (ret) {
		fprintf(stderr, "fail to create heap, code %d\n", ret);
		return ret;
	}

	sleep(10);

	ret = rt_heap_delete(&M_HEAP);
	if (ret) {
		fprintf(stderr, "fail to delete heap, code %d\n", ret);
		return;
	}
	
	return 0;

}
#######################
this program previously worked on another PC. but now when I execute it on the new PC, It cause the kernel panic ( Unable to handle null pointer reference ...). same kernel is run on two PC, and not seems any difference.  but now I print memory status (/proc/meminfo). a huge difference is found! 
in first pc ( that program worked ) total vmalloc = totol memory = 510 M and highmem = 0, but on second pc ( that kernel panic ) total vmalloc = 119M but total memory = 1 G and highmem = 122.
have everyone any idea? 

I glade to see your comments.


      


