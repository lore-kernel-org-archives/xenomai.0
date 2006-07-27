MIME-Version: 1.0
Date: Thu, 27 Jul 2006 09:23:52 -0700
From: "Nathaniel J Villaume" <villaume@domain.hid>
Message-Id: <1154017432-24969.00057.00869-smmsdV2.1.4@domain.hid>
In-Reply-To: <200607271001.k6RA19sN018076@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai-help] patch: native/task.h
Reply-To: Nathaniel.J.Villaume@domain.hid
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

Hi, 

I include two more patches here:
1) info_mcb_changed_native_task.h.diff: 
   only changed documentation level of RT_TASK_INFO and RT_TASK_MCB
2) all_changed_native_task.h.diff: 
   changed the file to show all the documented bits (including
RT_TASK

The reasoon is that maybe the internals of RT_TASK don't need to
be exposed. 

HTH,
-Nate



