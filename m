Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Feb 2006 11:13:02 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A1C3B49@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-core] vxworks-skin taskSpawn
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

I am using xenomai-2.1-rc2 and try to create a task via the vxWorks skin =
function taskSpawn. As I have read that uvm and vxWorks exclude each =
other, I just inserted the xeno_uvm module (not the xeno_vxworks.o =
module ). No problems so far. When I start my application nothing =
happens (no errormessages ...), the application seems to hang. Debugging =
printf=B4s show that the function taskSpawn never returns and the task =
to be spawned (there is no evidence that she is running) never produces =
any debug output.
This happens with both vxworks skin examples koan.c and satch.c.
Xenomai native skin works, satch and latency are running.
Does anybody have any idea/recomendation about this behavior ?

Thank you in advance !
Roderik

