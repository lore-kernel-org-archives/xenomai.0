Message-ID: <20051228004108.2353.qmail@domain.hid>
Date: Wed, 28 Dec 2005 01:41:08 +0100 (CET)
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

is it posible to spawn a  task from another rt task?
The following code tries to, but does not succeed:
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

the resulting output is:
<output>
spawner

IN MAIN:ret=0 Success

</output>
This means that the task "spawner" starts but get
blocked at rt_task_spwan call.

Switching context explicitely to secondary or to
primary does not help too.

can you help?

best, patrice


	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

