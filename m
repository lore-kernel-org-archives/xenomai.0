From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-help] rt_misc_get_io_region()
Date: Tue, 12 Dec 2006 20:16:19 +0100
References: <457E5C81.3060006@domain.hid>
In-Reply-To: <457E5C81.3060006@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612122016.19683.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
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

Am Dienstag, 12. Dezember 2006 08:38 schrieb Niklaus Burren:
> We want to write a Xenomai application that can access the
> GPIO pins of our ARM-Prozessor (PXA-270). To get the memory
> region I found the function rt_misc_get_io_region(). Unfortunately
> there is no discription of this function in the API documentation.
> Does this function work like request_mem_region()?
>
> After the call of the rt_misc_get_io_region() fuction it is also
> necessary to call the ioremap() function?
>
> Please can you give me a little example, how you can map and access
> memory in Xenomai?
I don't think that mapping memory very different for RT tasks. 

Here are the snippets from my code which I used (today!) to turn on and off 
LEDs connected to the GPIO-pins of my PPC405 based board.

#include <sys/mman.h>

#define MAP_SIZE 4096UL
void  *mapDirectIoRegister(char *addr, int nSize)
{
    void *map_base;
    off_t target = ((unsigned int) addr) & ~MAP_MASK;
    int fd;

    if((fd = open("/dev/mem", O_RDWR | O_SYNC)) == -1) {
        printf("/dev/mem could not be opened.\n");
        exit(1);
    }

  // Map one page
    map_base = mmap((void *)target, nSize, PROT_READ | PROT_WRITE, MAP_SHARED,
		 fd, target);
   <.. error handling>
   return map_base;
}
static uint32 *ledRegister;

<init proc>
    ledRegister = (uint32 *)mapDirectIoRegister((char *)GPIO_OR, 4);
    ledRegister[1] = 0x7ffe0000; /* Three State Control  (GPIO_TCR) */

void   sysLedSet(uint8 value)
{
    ledRegister[0] =  ((uint32) value)) << 23;
}

>
> I think that is a topic that is interessting for a lot of people.
>
> Regards
>
> Niklaus Burren
Best regards from another Swiss Chlaus.

-- 
Niklaus Giger
Wieshoschet 6
CH-8753 Mollis

