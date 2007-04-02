Message-ID: <34a7ae040704020130s42f81ae5r7699c1d5afb805b8@domain.hid>
Date: Mon, 2 Apr 2007 10:30:34 +0200
From: "Paolo Teti" <paolo.teti@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Adeos-main] stange reacquire_kernel_lock call
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Dear all.

This is my first Aedos download, use and study.

Looking at the "adeos-ipipe-2.6.20-i386-1.7-03.patch" content I have
notice this piece of code:

int ipipe_reenter_root (struct task_struct *prev, int policy, int prio)
+{
+	finish_task_switch(this_rq(), prev);
+	if (reacquire_kernel_lock(current) < 0)
+		;

Why? This should be a simple reacquire_kernel_lock(current) without "if",
if I'm not wrong.

Pao

