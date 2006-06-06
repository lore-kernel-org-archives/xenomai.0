Message-ID: <44855B98.6070406@domain.hid>
Date: Tue, 06 Jun 2006 12:40:24 +0200
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rt_task_wait_period returning -ETIMEDOUT
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

rt_task_wait_period() is spuriously returning -ETIMEDOUT.

(spuriously = maybe once every two hours with period = 500us)

I'm using the trunk code and that error code is not mentioned in the 
rt_task_wait_period documentation.

Any clues?

Nacho.

