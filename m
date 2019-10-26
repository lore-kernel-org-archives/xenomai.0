Subject: Re: problem with sessions in xenomai 3.1
References: <86e02eb5015e1b4754b8dbe367e62497.squirrel@mail.ige-grenoble.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <64bfd5ea-6509-f4c9-ec7b-c79fb7619767@xenomai.org>
Date: Sat, 26 Oct 2019 11:12:47 +0200
MIME-Version: 1.0
In-Reply-To: <86e02eb5015e1b4754b8dbe367e62497.squirrel@mail.ige-grenoble.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: davy.regneau@univ-grenoble-alpes.fr, xenomai@xenomai.org

On 10/24/19 10:41 AM, Davy via Xenomai wrote:
> Hi,
> 
> Shared sessions do not seem to work with Xenomai 3.1.
> I made this simple code to test it :
> 
> 
> RT_TASK task;
> 
> void foo(){
> 	while(1){
> 		printf("Hello !\n");
> 		rt_task_sleep(2000000000);
> 	}
> }
> 
> int main(int argc, char *argv[]){
> 	int n;
>   	if (mlockall( MCL_CURRENT | MCL_FUTURE )!=0)
>     		return 1;
> 	if ((n=rt_task_spawn( &task, NULL, 0, 99, T_JOINABLE, &foo, NULL))!=0){
>     		rt_printf("rt_task_spawn error %d\n",n);
>     		return 1;
>   	}
>   	rt_task_join(&task);
> }
> 
> 
> When I try to start 2 instance of this program with the same session
> label, the second give me a segmentaion fault:
> $ sudo ./foo --session=s
> Erreur de segmentation
> 
> And this error appears in the kernel logs:
> foo[11885]: segfault at 3387c25020 ip 00007fee025a73f9 sp 00007ffe2611cbd8
> error 4 in libcopperplate.so.0.0.0[7fee0259c000+11000]
> Code: 00 48 89 f8 48 03 47 18 74 51 4c 8b 4e 20 eb 17 90 44 89 c6 49 89 fa
> 83 c6 01 4c 03 54 f0 08 4c 89 d6 74 33 48 89 f0 4c 89 ce <48> 2b 70 20 45
> 31 c0 48 85 f6 41 0f 9f c0 48 c1 ee 3f 41 29 f0 75
> 
> 
> I tested it with the kernel 4.19.66 patched with xenomai 3.1-rc1 and the
> kernel 4.19.75 with the next branch and observed the same issue.
> 
> I also tried kernel 4.14.134 with xenomai 3.0.9 and it works. So I will
> stay in this version for the moment.
> 
> 
> My build :
> $ /usr/xenomai/bin/xeno-config --info
> Xenomai version: Xenomai/cobalt v3.1-rc2
> Linux XportNew 4.19.75-xenomai-3.1 #2 SMP PREEMPT Wed Oct 23 14:34:21 CEST
> 2019 x86_64 GNU/Linux
> Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-4.19.75-xenomai-3.1
> root=/dev/mapper/isw_bdaaiafbje_Volume11 ro dmraid=true quiet splash nopat
> crashkernel=384M-:128M
> I-pipe release #7 detected
> Cobalt core 3.1-rc2 detected
> Compiler: gcc version 4.9.2 (Debian 4.9.2-10+deb8u1)
> Build args: --with-core=cobalt --enable-smp --enable-pshared
> 

Confirmed. Issue is with the AVL support in pshared mode.

-- 
Philippe.

