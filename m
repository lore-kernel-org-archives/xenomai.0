Date: Tue, 13 Aug 2013 12:01:02 +0200 (CEST)
From: jeanmicheltaprest@free.fr
Message-ID: <732137476.102328119.1376388062696.JavaMail.root@zimbra14-e2.priv.proxad.net>
In-Reply-To: <1297089258.102322105.1376387294632.JavaMail.root@zimbra14-e2.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai: fatal: Hardened thread xxxx running in Linux
	domain?!
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

hello,

I use a Linux kernel 2.6.29.6 patched with Xenomai 2.5.2.

Very scarcely, i got the following message "Xenomai: fatal: Hardened thread taskFuncInjectionMigration[3516] running in Linux domain?!" and Linux freezes.

It happens when i turn the current Linux task into a native Xenomai task via rt_task_shadow, in the following code snippet.

extern RT_TASK rtTaskFuncInjectionMigration;

void foncInjectionMigration(char* TypeMode)
{
int InjMigration, modeInjectionMigration, err;

	sscanf(TypeMode, "%d %d", &InjMigration, &modeInjectionMigration);

	mlockall(MCL_CURRENT|MCL_FUTURE);

	AN_PRINTF("Cree une tache Xeno non temps reel dans le contexte de la tache Linux !\n");
	err = rt_task_shadow(&rtTaskFuncInjectionMigration, "taskFuncInjectionMigration", 10, 0);
	if(err) {
		AN_PRINTF("rt_task_shadow ? (%s)\n", strerror(err));

	}

	foncsInjectionMigration[InjMigration](modeInjectionMigration);

	munlockall();

}

foncInjectionMigration is called from funcInjectionMigration, which is a son process resulting from a Linux fork.

Any help or idea about that issue would be enjoyed.

Thanks in advance

JmT


