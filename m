Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Jul 2006 14:27:02 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A3F9354@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] do memory functions switch to secondary mode ?
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

Does any of the memory functions like :
memcopy,
memset,
bzero,

:
:

cause Xenomai to switch to secondary mode ?
I am asking as I have a high priority task, which mesures its
periodicity (set to 1ms).
This task is using just rt_-functions and memcpy.
When in low priority tasks memory intensively is used (memset,
rt_heap_alloc, rt_heap_create, NFS-transfers in Linux threads), the
cycle time of the high priority task inreases to nearly twice the time
it has been set up (2ms++; at least 1 time, as I just measure maxima).

Is this possible, or am I doing something wrong ?

Tanks a lot
Roderik

