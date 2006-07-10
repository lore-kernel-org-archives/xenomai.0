Message-ID: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
Date: Mon, 10 Jul 2006 14:16:33 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_93540_9557343.1152512193197"
Subject: [Xenomai-help] Sychronize between Linux and Xenomai domain
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_93540_9557343.1152512193197
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Xenomai provides synchronize objects like semaphore and mutex and related
APIs, e.g: rt_sem_p(), rt_sem_v().
I think they can only synchonze between Xenomai tasks (e.g, tasks created
with rt_task_create()).

Is there any way to synchonize between a "normal" Linux task and a Xenomai
task?
Is there way to synchronize between Linux and Xenomai domain in Kernel
space? (e.g, a Linux driver and a Xenomai driver)?

Thanks,

-Yi

------=_Part_93540_9557343.1152512193197
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>Xenomai provides synchronize objects like semaphore and mutex and related APIs, e.g: rt_sem_p(), rt_sem_v(). <br>I think they can only synchonze between Xenomai tasks (e.g, tasks created with rt_task_create()). 
<br><br>Is there any way to synchonize between a &quot;normal&quot; Linux task and a Xenomai task? <br>Is there way to synchronize between Linux and Xenomai domain in Kernel space? (e.g, a Linux driver and a Xenomai driver)?
<br><br>Thanks,<br><br>-Yi<br>

------=_Part_93540_9557343.1152512193197--

