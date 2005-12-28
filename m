Message-ID: <20051228002247.61091.qmail@domain.hid>
Date: Wed, 28 Dec 2005 01:22:47 +0100 (CET)
From: Patrice Congo <congo_p@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] rt_task_spawn how to
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

Hi all,

is it possible to spawn a task from another rt task? 
The following code tries but the spawner task get
blocked:
<code>
#include <string.h>
#include <stdio.h>

#include <native/task.h>
//#include <general_macros.h>

#define STACK_SIZE 8192

RT_TASK spawner;
RT_TASK spawnee;
void spawner_work(void* c);
void spawnee_work(void* c);

void spawner_work(void* c)
{
	printf("\nspawner\n");
	//SWITCH_TASK_TO_SECONDARY_MODE();
	int
ret=rt_task_spawn(&spawnee,"spawnee",STACK_SIZE,50,0,spawnee_work,NULL);
	printf("IN SPAWNER WORK: ret=%d
%s\n",ret,strerror(ret));
}

void spawnee_work(void* c)
{
	printf("I am spawnee");	
}

int main(int argc, char *argv[])
{
	int ret=
	
rt_task_spawn(&spawner,"spawner",STACK_SIZE,50,0,spawner_work,NULL);
	printf("\nIN MAIN:ret=%d %s\n",ret,strerror(-ret));
	getchar();
	return 0;
}

</code>

The resulting output is:
<output>
spawner

IN MAIN:ret=0 Success

</output>
Thie means the resulting the task "spawner" starts but
is blocked at rt_task_spawn. 
switching context explicitely to primary or secondary
does not help too.
 
do you see some mistakes? can you help?

thanks in advance, patrice


	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

