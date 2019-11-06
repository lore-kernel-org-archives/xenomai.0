Message-ID: <b9873e80d75b24e63dd423288ecca54b.squirrel@mail.ige-grenoble.fr>
In-Reply-To: <64bfd5ea-6509-f4c9-ec7b-c79fb7619767@xenomai.org>
References: <86e02eb5015e1b4754b8dbe367e62497.squirrel@mail.ige-grenoble.fr>
 <64bfd5ea-6509-f4c9-ec7b-c79fb7619767@xenomai.org>
Date: Wed, 6 Nov 2019 10:18:38 +0100
Subject: segmentation error when a task ends
From: davy.regneau@univ-grenoble-alpes.fr
Reply-To: davy.regneau@univ-grenoble-alpes.fr
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Hi,

Thanks for patching the shared sessions. It works.

Now I have another segmentation error that appears when a task ends or is
deleted :



RT_TASK task;
void foo(){
	int i = 3;
	while(i--){
		printf("Hello !\n");
		rt_task_sleep(1000000000);
	}
	return;
}
int main(int argc, char *argv[]){
	int n;
  	if (mlockall( MCL_CURRENT | MCL_FUTURE )!=0)
    		return 1;
	if ((n=rt_task_spawn( &task, NULL, 0, 99, T_JOINABLE, &foo, NULL))!=0){
    		rt_printf("rt_task_spawn error %d\n",n);
    		return 1;
  	}
	printf("Join task\n");
  	rt_task_join(&task);
	return EXIT_SUCCESS;
}


$ sudo ./foo
Hello !
Join task
Hello !
Hello !
Erreur de segmentation



regards,
Davy




