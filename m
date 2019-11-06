Subject: Re: segmentation error when a task ends
References: <86e02eb5015e1b4754b8dbe367e62497.squirrel@mail.ige-grenoble.fr>
 <64bfd5ea-6509-f4c9-ec7b-c79fb7619767@xenomai.org>
 <b9873e80d75b24e63dd423288ecca54b.squirrel@mail.ige-grenoble.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <996f4ac9-17f7-0dd7-9582-72fa47b96e73@siemens.com>
Date: Wed, 6 Nov 2019 10:28:44 +0100
MIME-Version: 1.0
In-Reply-To: <b9873e80d75b24e63dd423288ecca54b.squirrel@mail.ige-grenoble.fr>
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

On 06.11.19 10:18, Davy via Xenomai wrote:
> 
> Hi,
> 
> Thanks for patching the shared sessions. It works.
> 
> Now I have another segmentation error that appears when a task ends or is
> deleted :
> 
> 
> 
> RT_TASK task;
> void foo(){
> 	int i = 3;
> 	while(i--){
> 		printf("Hello !\n");
> 		rt_task_sleep(1000000000);
> 	}
> 	return;
> }
> int main(int argc, char *argv[]){
> 	int n;
>   	if (mlockall( MCL_CURRENT | MCL_FUTURE )!=0)
>     		return 1;
> 	if ((n=rt_task_spawn( &task, NULL, 0, 99, T_JOINABLE, &foo, NULL))!=0){
>     		rt_printf("rt_task_spawn error %d\n",n);
>     		return 1;
>   	}
> 	printf("Join task\n");
>   	rt_task_join(&task);
> 	return EXIT_SUCCESS;
> }
> 
> 
> $ sudo ./foo
> Hello !
> Join task
> Hello !
> Hello !
> Erreur de segmentation
> 

Works find here. Could you use a debugger to find out where the
exception is thrown?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

