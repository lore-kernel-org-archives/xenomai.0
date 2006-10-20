Date: Fri, 20 Oct 2006 14:50:22 -0600
From: Sunny Bhuller <sbhuller@domain.hid>
Message-id: <20c1b3220c1b7f.20c1b7f20c1b32@domain.hid>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7bit
Content-disposition: inline
Subject: [Xenomai-help] rt_queue_read switch to secondary mode
Reply-To: sbhuller@domain.hid
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

Hello,
  I am new to xenomai and was having a problem with the rt_queue_read call.  I am creating a new RT_TASK from my main program with:

rt_task_create(&task, NULL, 0 /* default stack size */, 5 /* priority */, T_FPU | T_JOINABLE);

Once the task has started I switch it to primary mode with:

rt_task_set_mode(0, T_PRIMARY | T_WARNSW, NULL);

Now if I call the rt_queue_read I catch the signal that specifies the system has switched to secondary mode.  Is there something fundamentally wrong with what I am doing?  I can post a more detailed explanation if required, thanks!

-- Sunny



