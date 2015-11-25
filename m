Message-ID: <trinity-1831e513-92b7-4257-8f4e-a09952d12ad0-1448472034310@3capp-webde-bap53>
From: JK.Behnke@web.de
Date: Wed, 25 Nov 2015 18:20:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] how to force task switch to primary mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

   Hello,

   an rtdm driver that I use requires the rt_dev_open call to be executed
   in primary mode.
   With xenomai 2.4.2 it was possible to switch to primary mode using
   rt_task_set_mode(0, T_PRIMARY, NULL);

   Now I use xenomai 2.6.3, but I can't find the T_PRIMARY flag.
   Is there an other alternative to force the task to switch to primary
   mode?

   Would I have to change the rtdm driver, so xenomai performs the mode
   switch automatically?

   Thanks in advance for any hint.
   Jochen
