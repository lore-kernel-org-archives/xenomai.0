MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
Date: Tue, 4 Oct 2011 11:42:24 +0200
Message-ID: <CAAXf6LW-HePfMj4F86s-dFoztWN5NLsGm9TxqpHN-EwxEdtiFA@mail.gmail.com>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] xenomai-forge [psos] t_start segmentation fault when
	args == NULL
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi,

In the xenomai-forge psos library, t_start() does not allow a NULL
args pointer, while I think this is allowed in PSOS.
The below code changes fix the problem.
(Note that I realize this mail is not formatted as a proper patch; if
you prefer patches for these small changes, let me know).

Best regards,
Thomas

diff --git a/lib/psos/task.c b/lib/psos/task.c
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -335,10 +335,17 @@ u_long t_start(u_long tid,
                return ret;

        task->args.entry = entry;
-       task->args.arg0 = args[0];
-       task->args.arg1 = args[1];
-       task->args.arg2 = args[2];
-       task->args.arg3 = args[3];
+       if (args) {
+               task->args.arg0 = args[0];
+               task->args.arg1 = args[1];
+               task->args.arg2 = args[2];
+               task->args.arg3 = args[3];
+       } else {
+               task->args.arg0 = 0;
+               task->args.arg1 = 0;
+               task->args.arg2 = 0;
+               task->args.arg3 = 0;
+       }
        task->mode = mode;
        threadobj_start(&task->thobj);
        put_psos_task(task);

