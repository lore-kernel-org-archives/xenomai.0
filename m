Subject: Re: every millicsecond interrupt in xenomai domain on a am355x board
 can cause something wrong?
References: <6a75de9a.bb14.1675e7e151a.Coremail.liang_1911@163.com>
 <934350e0-912b-4090-e4ba-e9b130d1e1f2@xenomai.org>
 <955d187.1042f.16765819578.Coremail.liang_1911@163.com>
 <29ea1621.1e55.1676dbe7a00.Coremail.liang_1911@163.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <889b8735-6c75-fd3a-ef82-616bdd4b74a4@xenomai.org>
Date: Sun, 2 Dec 2018 11:00:44 +0100
MIME-Version: 1.0
In-Reply-To: <29ea1621.1e55.1676dbe7a00.Coremail.liang_1911@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5qKB5p2D?= <liang_1911@163.com>
Cc: xenomai@xenomai.org

On 12/2/18 8:07 AM, 梁权 wrote:
> To simplify the problem， i do a test without QT like the following program:
> #define MALLOC_SIZE 8*1024*1024
> int main()
> {
> int err;
> char *addr=(char *)0;
> time_t now;
> struct tm *timenow;
> time(&now);
> timenow = localtime(&now);
> printf("%s\n", asctime(timenow));
> addr = (char *)malloc(MALLOC_SIZE);
> if (addr)
> printf("malloc ok\n");
> do
> {
> if (addr){
> memset(addr, 0x12, MALLOC_SIZE/2);
>                         memset(addr + MALLOC_SIZE/2, 0x34, MALLOC_SIZE/2);
> }
> usleep(1000);
> }while(1);
> return 0;
> }
> After i enable the interrupt for several minutes,  the error occur:
> root@am335x-evm:~/tmp# ./testMemset

Ok, thanks for investing time in creating this test snippet. I'll divert
some cycles in a few days to look into this.

-- 
Philippe.

