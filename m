MIME-Version: 1.0
Date: Thu, 28 Aug 2008 09:00:12 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <48B50BD5.9060500@domain.hid>
References: <48B50BD5.9060500@domain.hid>
Message-ID: <4d4027a12fd43a961a981373ebb275ea@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] =?utf-8?q?_Re=3A__Problem_with_tcb=2Ehandle_and_ta?=
 =?utf-8?q?skDesc=2Etd=5Ftid?=
Reply-To: matthieu.connaulte_xenomai@domain.hid
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

I tested the patch. TaskInfoGet works. It gives me a taskDesc.td_tid
different from tid given by taskNameToId, but I don't known if there is a=
ny
relation.
I try to know if my task is suspended, but I always have the result 0 fro=
m
taskIsSuspended(tid) while my task has been initiated but not activated. =
So
I would like to know if a taskInit turn the task in suspended state ? If
so, what can be my error ?

Matthieu



