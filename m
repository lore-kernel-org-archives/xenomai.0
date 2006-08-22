Message-ID: <b647ffbd0608220635n32ed409fpd236160abcfc93f6@domain.hid>
Date: Tue, 22 Aug 2006 15:35:08 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <b647ffbd0608220147r225dcd07of8c6952ad27b788b@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_48026_23800386.1156253708575"
References: <b647ffbd0608212353u13a450f4w16069329cea3966a@domain.hid>
	<44EAB53C.1020705@domain.hid>
	<b647ffbd0608220147r225dcd07of8c6952ad27b788b@domain.hid>
Subject: [Xenomai-core] Re: [patch, minor] irq proc output in intr.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_48026_23800386.1156253708575
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

errr...  xnintr_irq_proc() for shared-irq case is also broken indeed.
xnintr_shirq_lock(shirq) should not be used there as a preemption may take
place and another thread may happilly call xnintr_detach() ->
xnintr_shirq_detach() -> possible [SMP: deadlock, UP: crash].

Can't believe the person who has writen this buggy code was me :o) Well,
it's probably a time for some refactoring.


-- 
Best regards,
Dmitry Adamushko

------=_Part_48026_23800386.1156253708575
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>errr...&nbsp; xnintr_irq_proc() for shared-irq case is also broken
indeed. xnintr_shirq_lock(shirq) should not be used there as a
preemption may take place and another thread may happilly call
xnintr_detach() -&gt; xnintr_shirq_detach() -&gt; possible [SMP:
deadlock, UP: crash].<br>
<br>
Can't believe the person who has writen this buggy code was me :o) Well, it's probably a time for some refactoring.<br>
<br>
<br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>

------=_Part_48026_23800386.1156253708575--

