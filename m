Message-ID: <4566DB9B.5010702@domain.hid>
Date: Fri, 24 Nov 2006 12:46:35 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] What is permanent memory (rt_task_shadow)
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

The documentation for rt_task_shadow says:

   task The address of a task descriptor Xenomai will use to store the
        task-related data. This descriptor must always be valid while
        the task is active therefore it must be allocated in permanent
        memory.

Is it correct to assume that it is OK to the following:

   void func() {
     RT_TASK task;
     int err;

     err = rt_task_shadow(&task, ...);
     ...  Realtime activities ...
     if (err == 0) {
       rt_task_delete(&task);
     }
   }

Regards

Anders Blomdell

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

